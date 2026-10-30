-- MVP de captura segura de oportunidades.
-- PostgreSQL 14+ / Supabase Postgres. No almacena datos de candidatos ni credenciales.

create extension if not exists pgcrypto;
create schema if not exists career;

create table if not exists career.source_registry (
  source_key text primary key,
  display_name text not null,
  source_kind text not null check (source_kind in ('api', 'rss', 'export', 'manual', 'test')),
  base_url text not null check (base_url ~ '^https?://[^[:space:]]+$'),
  is_active boolean not null default false,
  is_test boolean not null default false,
  created_at timestamptz not null default now(),
  check (source_key ~ '^[a-z][a-z0-9_]{2,63}$')
);

create table if not exists career.opportunities (
  opportunity_id uuid primary key default gen_random_uuid(),
  dedupe_key text not null unique check (dedupe_key ~ '^[0-9a-f]{64}$'),
  canonical_url text not null unique check (canonical_url ~ '^https?://[^#[:space:]]+$'),
  company_name text not null check (length(trim(company_name)) between 1 and 200),
  title text not null check (length(trim(title)) between 1 and 200),
  country_code char(2) not null check (country_code ~ '^[A-Z]{2}$'),
  location text not null default '' check (length(location) <= 200),
  modality text not null check (modality in ('remoto_colombia_latam', 'contractor_internacional', 'hibrido', 'presencial', 'desconocido')),
  posted_at date,
  vacancy_summary text not null default '' check (length(trim(vacancy_summary)) = 0 or length(trim(vacancy_summary)) between 20 and 4000),
  requirement_evidence jsonb not null default '[]'::jsonb check (jsonb_typeof(requirement_evidence) = 'array' and jsonb_array_length(requirement_evidence) <= 20),
  requirements_verified_at timestamptz,
  score_breakdown jsonb not null default '{}'::jsonb check (jsonb_typeof(score_breakdown) = 'object'),
  score_updated_at timestamptz,
  first_seen_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  primary_source_key text not null references career.source_registry(source_key),
  check (last_seen_at >= first_seen_at)
);

create table if not exists career.capture_events (
  capture_event_id uuid primary key default gen_random_uuid(),
  source_key text not null references career.source_registry(source_key),
  source_reference text not null check (length(trim(source_reference)) between 1 and 200),
  opportunity_id uuid not null references career.opportunities(opportunity_id) on delete restrict,
  canonical_url text not null check (canonical_url ~ '^https?://[^#[:space:]]+$'),
  captured_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  unique (source_key, source_reference),
  check (last_seen_at >= captured_at)
);

create table if not exists career.review_queue (
  review_queue_id uuid primary key default gen_random_uuid(),
  opportunity_id uuid not null unique references career.opportunities(opportunity_id) on delete restrict,
  review_state text not null default 'pending' check (review_state in ('pending', 'in_review', 'qualified', 'discarded')),
  priority smallint not null default 0 check (priority between 0 and 100),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  reviewed_at timestamptz,
  check ((review_state in ('pending', 'in_review') and reviewed_at is null) or (review_state in ('qualified', 'discarded') and reviewed_at is not null))
);


-- Migración idempotente para instalaciones creadas antes de evidencia y score.
alter table career.opportunities
  add column if not exists vacancy_summary text not null default '',
  add column if not exists requirement_evidence jsonb not null default '[]'::jsonb,
  add column if not exists requirements_verified_at timestamptz,
  add column if not exists score_breakdown jsonb not null default '{}'::jsonb,
  add column if not exists score_updated_at timestamptz;

do $migration$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'opportunities_vacancy_summary_check' and conrelid = 'career.opportunities'::regclass
  ) then
    alter table career.opportunities add constraint opportunities_vacancy_summary_check
      check (length(trim(vacancy_summary)) = 0 or length(trim(vacancy_summary)) between 20 and 4000);
  end if;
  if not exists (
    select 1 from pg_constraint where conname = 'opportunities_requirement_evidence_check' and conrelid = 'career.opportunities'::regclass
  ) then
    alter table career.opportunities add constraint opportunities_requirement_evidence_check
      check (jsonb_typeof(requirement_evidence) = 'array' and jsonb_array_length(requirement_evidence) <= 20);
  end if;
  if not exists (
    select 1 from pg_constraint where conname = 'opportunities_score_breakdown_check' and conrelid = 'career.opportunities'::regclass
  ) then
    alter table career.opportunities add constraint opportunities_score_breakdown_check
      check (jsonb_typeof(score_breakdown) = 'object');
  end if;
end;
$migration$;

create index if not exists opportunities_score_breakdown_gin_idx
  on career.opportunities using gin (score_breakdown);

create index if not exists opportunities_review_lookup_idx
  on career.opportunities (last_seen_at desc, country_code, modality);
create index if not exists capture_events_opportunity_idx
  on career.capture_events (opportunity_id, last_seen_at desc);
create index if not exists review_queue_pending_idx
  on career.review_queue (priority desc, created_at asc)
  where review_state = 'pending';

create or replace function career.normalize_dedupe_text(input_text text)
returns text
language sql
immutable
strict
as $$
  select regexp_replace(lower(trim(input_text)), '\\s+', ' ', 'g')
$$;

create or replace function career.ingest_opportunity_capture(
  p_source_key text,
  p_source_reference text,
  p_canonical_url text,
  p_company_name text,
  p_title text,
  p_country_code text,
  p_location text,
  p_modality text,
  p_dedupe_basis text,
  p_posted_at date,
  p_vacancy_summary text,
  p_requirement_evidence jsonb,
  p_requirements_verified_at timestamptz
)
returns table (
  opportunity_id uuid,
  created boolean,
  dedupe_key text,
  review_state text
)
language plpgsql
security invoker
set search_path = career, public
as $$
declare
  v_source_is_active boolean;
  v_opportunity_id uuid;
  v_created boolean := false;
  v_dedupe_key text;
  v_review_state text;
begin
  select is_active
    into v_source_is_active
    from career.source_registry
   where source_key = p_source_key;

  if coalesce(v_source_is_active, false) is not true then
    raise exception 'Fuente no registrada o inactiva: %', p_source_key using errcode = '23514';
  end if;

  if p_canonical_url !~ '^https?://[^#[:space:]]+$' then
    raise exception 'canonical_url debe ser HTTP(S) y no contener fragmento: %', p_canonical_url using errcode = '22023';
  end if;

  if p_country_code !~ '^[A-Z]{2}$' then
    raise exception 'country_code inválido: %', p_country_code using errcode = '22023';
  end if;

  if p_modality not in ('remoto_colombia_latam', 'contractor_internacional', 'hibrido', 'presencial', 'desconocido') then
    raise exception 'modalidad inválida: %', p_modality using errcode = '22023';
  end if;
  if length(trim(coalesce(p_vacancy_summary, ''))) not between 20 and 4000 or p_vacancy_summary ~ '<[^>]+>' then
    raise exception 'vacancy_summary debe ser texto verificable de 20 a 4000 caracteres, sin HTML' using errcode = '22023';
  end if;

  if p_requirements_verified_at is null or jsonb_typeof(p_requirement_evidence) <> 'array' then
    raise exception 'requirement_evidence debe ser un arreglo y requirements_verified_at es obligatorio' using errcode = '22023';
  end if;

  if jsonb_array_length(p_requirement_evidence) not between 1 and 20
     or exists (
       select 1
       from jsonb_array_elements(p_requirement_evidence) as evidence(item)
       where jsonb_typeof(evidence.item) <> 'object'
          or not (evidence.item ? 'requirement' and evidence.item ? 'evidence_url' and evidence.item ? 'verified_at')
          or length(trim(coalesce(evidence.item ->> 'requirement', ''))) not between 1 and 500
          or coalesce(evidence.item ->> 'evidence_url', '') !~ '^https?://[^#[:space:]]+$'
     ) then
    raise exception 'requirement_evidence inválido o sin enlaces verificables' using errcode = '22023';
  end if;

  v_dedupe_key := encode(digest(career.normalize_dedupe_text(p_dedupe_basis), 'sha256'), 'hex');

  select o.opportunity_id
    into v_opportunity_id
    from career.opportunities o
   where o.dedupe_key = v_dedupe_key
      or o.canonical_url = p_canonical_url
   order by o.first_seen_at asc
   limit 1
   for update;

  if v_opportunity_id is null then
    insert into career.opportunities (
      dedupe_key, canonical_url, company_name, title, country_code, location, modality, posted_at, vacancy_summary, requirement_evidence, requirements_verified_at, primary_source_key
    ) values (
      v_dedupe_key, p_canonical_url, trim(p_company_name), trim(p_title), p_country_code,
      coalesce(trim(p_location), ''), p_modality, p_posted_at, trim(p_vacancy_summary), p_requirement_evidence, p_requirements_verified_at, p_source_key
    ) returning opportunities.opportunity_id into v_opportunity_id;
    v_created := true;
  else
    update career.opportunities
       set last_seen_at = now(),
           posted_at = coalesce(p_posted_at, opportunities.posted_at),
           vacancy_summary = case when opportunities.requirements_verified_at is null or p_requirements_verified_at >= opportunities.requirements_verified_at then trim(p_vacancy_summary) else opportunities.vacancy_summary end,
           requirement_evidence = case when opportunities.requirements_verified_at is null or p_requirements_verified_at >= opportunities.requirements_verified_at then p_requirement_evidence else opportunities.requirement_evidence end,
           requirements_verified_at = greatest(opportunities.requirements_verified_at, p_requirements_verified_at)
     where opportunities.opportunity_id = v_opportunity_id;
  end if;

  insert into career.capture_events (
    source_key, source_reference, opportunity_id, canonical_url
  ) values (
    p_source_key, trim(p_source_reference), v_opportunity_id, p_canonical_url
  ) on conflict (source_key, source_reference) do update
       set opportunity_id = excluded.opportunity_id,
           canonical_url = excluded.canonical_url,
           last_seen_at = now();

  insert into career.review_queue (opportunity_id)
  values (v_opportunity_id)
  on conflict (opportunity_id) do update
     set updated_at = now()
  returning review_queue.review_state into v_review_state;

  return query
  select v_opportunity_id, v_created, v_dedupe_key, v_review_state;
end;
$$;


create or replace function career.upsert_opportunity_score(
  p_opportunity_id uuid,
  p_score_breakdown jsonb,
  p_scored_at timestamptz
)
returns table (
  opportunity_id uuid,
  score_breakdown jsonb,
  score_updated_at timestamptz
)
language plpgsql
security invoker
set search_path = career, public
as $score$
begin
  if p_scored_at is null or jsonb_typeof(p_score_breakdown) <> 'object' then
    raise exception 'score_breakdown debe ser un objeto JSONB y scored_at es obligatorio' using errcode = '22023';
  end if;

  update career.opportunities
     set score_breakdown = p_score_breakdown,
         score_updated_at = p_scored_at
   where opportunities.opportunity_id = p_opportunity_id
  returning opportunities.opportunity_id, opportunities.score_breakdown, opportunities.score_updated_at
       into opportunity_id, score_breakdown, score_updated_at;

  if not found then
    raise exception 'Oportunidad inexistente: %', p_opportunity_id using errcode = '23503';
  end if;

  return next;
end;
$score$;

-- Fuentes seguras por defecto: placeholders inactivos y fixture exclusivamente ficticio.
insert into career.source_registry (source_key, display_name, source_kind, base_url, is_active, is_test)
values
  ('source_1_placeholder', 'SOURCE_1_PLACEHOLDER', 'manual', 'https://replace.example.invalid', false, false),
  ('source_2_placeholder', 'SOURCE_2_PLACEHOLDER', 'manual', 'https://replace.example.invalid', false, false),
  ('source_3_placeholder', 'SOURCE_3_PLACEHOLDER', 'manual', 'https://replace.example.invalid', false, false),
  ('test_fixture', 'Datos ficticios de prueba', 'test', 'https://jobs.example.invalid', true, true)
on conflict (source_key) do nothing;

-- Prueba reproducible de idempotencia y deduplicación. Ejecutar manualmente y finalizar con ROLLBACK.
-- begin;
-- select * from career.ingest_opportunity_capture(
--   'test_fixture', 'fixture-001', 'https://jobs.example.invalid/nube/ai-automation-engineer',
--   'Nube Ejemplo', 'AI Automation Engineer', 'CO', 'Remoto Colombia',
--   'remoto_colombia_latam', 'nube ejemplo|ai automation engineer|co|remoto colombia latam', '2026-09-28',
--   'Vacante ficticia de automatización con APIs y evidencia pública de requisitos.',
--   '[{"requirement": "APIs y automatización", "evidence_url": "https://jobs.example.invalid/requisitos/apis", "verified_at": "2026-09-28T12:00:00Z"}]'::jsonb,
--   '2026-09-28T12:00:00Z'
-- );
-- select * from career.ingest_opportunity_capture(
--   'test_fixture', 'fixture-002', 'https://jobs.example.invalid/nube/ai-automation-engineer',
--   'Nube Ejemplo', 'AI Automation Engineer', 'CO', 'Remoto Colombia',
--   'remoto_colombia_latam', 'nube ejemplo|ai automation engineer|co|remoto colombia latam', '2026-09-28',
--   'Vacante ficticia de automatización con APIs y evidencia pública de requisitos.',
--   '[{"requirement": "APIs y automatización", "evidence_url": "https://jobs.example.invalid/requisitos/apis", "verified_at": "2026-09-28T12:00:00Z"}]'::jsonb,
--   '2026-09-28T12:00:00Z'
-- );
-- select count(*) as oportunidades_unicas from career.opportunities where company_name = 'Nube Ejemplo';
-- select count(*) as capturas_unicas from career.capture_events where source_key = 'test_fixture' and source_reference in ('fixture-001', 'fixture-002');
-- rollback;