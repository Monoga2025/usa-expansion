# Contrato de fuentes para captura de oportunidades

> Este contrato alimenta `automation/opportunity-ingestion.json` y `db/opportunity-schema.sql`. Es un capturador de vacantes, no un sistema de contacto: no redacta ni envía correos, no crea candidaturas y deja toda oportunidad en revisión humana.

## Límites y seguridad

- Máximo **tres fuentes activas** por ejecución. Antes de activar una, verificar que su API, RSS, exportación o uso manual permitido respete sus términos.
- Usar canales legítimos: API pública/autorizada, feed RSS, exportación autorizada o carga manual del usuario. No automatizar login, CAPTCHA, scraping prohibido ni eludir límites.
- El workflow queda `active: false` al importarse. Configurar autenticación del webhook, una credencial Postgres/Supabase de mínimo privilegio y las fuentes aprobadas antes de activarlo.
- Nunca incluir en el payload nombres de candidatos, correos, teléfonos, CV, mensajes, credenciales, cookies, tokens, texto de conversaciones ni datos de contacto individuales.
- Cualquier dato inválido, fuente no aprobada o lote vacío falla cerrado: no persiste ni encola nada.

## Registro de fuente

Cada fuente se registra en `career.source_registry` con una clave técnica estable, un tipo y una URL base. Las tres claves iniciales son placeholders deliberados:

| Clave | Uso permitido | Estado inicial |
|---|---|---|
| `source_1_placeholder` | Reemplazar por una fuente aprobada | Inactiva |
| `source_2_placeholder` | Reemplazar por una fuente aprobada | Inactiva |
| `source_3_placeholder` | Reemplazar por una fuente aprobada | Inactiva |

No activar una fuente sin asignar un nombre real verificable, tipo (`api`, `rss`, `export` o `manual`) y URL base. La automatización no decide legitimidad por sí sola.

## Contrato de entrada del webhook

`POST /webhook/career-opportunity-ingest` acepta únicamente un objeto JSON con este formato:

```json
{
  "test_mode": false,
  "source_records": [
    {
      "source_name": "source_1_placeholder",
      "source_reference": "job-12345",
      "job_url": "https://jobs.example.org/openings/automation-engineer?utm_source=feed",
      "company": "Empresa Ejemplo",
      "title": "AI Automation Engineer",
      "country_code": "CO",
      "location": "Remoto Colombia",
      "modality": "remoto_colombia_latam",
      "posted_at": "2026-09-28",
      "vacancy_summary": "Vacante verificable de automatización y APIs; no incluye datos de contacto.",
      "requirement_evidence": [{
        "requirement": "Experiencia con APIs y automatización",
        "evidence_url": "https://jobs.example.org/openings/automation-engineer#requirements",
        "verified_at": "2026-09-28T12:00:00Z"
      }],
      "verified_at": "2026-09-28T12:00:00Z"
    }
  ]
}
```

| Campo | Requisito | Persistencia |
|---|---|---|
| `test_mode` | Booleano; `true` solo genera vista previa | No persiste. |
| `source_records` | Arreglo no vacío con máximo tres `source_name` distintos | Cada fila se valida. |
| `source_name` | Fuente registrada y activa; usar la clave técnica en minúsculas | `source_registry.source_key`. |
| `source_reference` | ID público y estable de la vacante en la fuente | Idempotencia por fuente. |
| `job_url` | URL HTTP(S) pública de la vacante | Se normaliza a `canonical_url`. |
| `company` | Empresa del anuncio, no persona de contacto | `opportunities.company_name`. |
| `title` | Título de la vacante | `opportunities.title`. |
| `country_code` | ISO-3166 alpha-2 | `opportunities.country_code`. |
| `location` | Ubicación laboral breve, opcional | `opportunities.location`. |
| `modality` | `remoto_colombia_latam`, `contractor_internacional`, `hibrido`, `presencial` o `desconocido` | `opportunities.modality`. |
| `posted_at` | Fecha ISO opcional de publicación | `opportunities.posted_at`. |
| `vacancy_summary` | Texto factual de 20–4.000 caracteres, sin HTML ni datos de contacto | `opportunities.vacancy_summary`. |
| `requirement_evidence` | Arreglo de 1–20 objetos `{requirement, evidence_url, verified_at}` con URL HTTP(S) | `opportunities.requirement_evidence` (JSONB). |
| `verified_at` | Fecha/hora ISO de la verificación del anuncio | `opportunities.requirements_verified_at`. |

No se acepta HTML, adjuntos, descripciones sin fuente, datos de contacto ni campos libres adicionales. `vacancy_summary` es un resumen factual verificable, no una copia completa del anuncio. La decisión de score y descarte corresponde a la Tarea 8, no a esta ingesta.

## Normalización y deduplicación

1. Recortar espacios y colapsar espacios internos en empresa, título y ubicación.
2. Convertir `country_code` a mayúsculas y validar dos letras.
3. Construir `canonical_url`: URL HTTP(S), host en minúsculas, fragmento eliminado, barras repetidas reducidas y parámetros de seguimiento (`utm_*`, `ref`, `source`, `trk`, `tracking`, `fbclid`, `gclid`) eliminados. La ruta y parámetros no rastreadores se conservan.
4. Construir `dedupe_basis` con `empresa_normalizada|titulo_normalizado|country_code|modalidad_normalizada`. La base de datos la convierte a SHA-256 y la guarda como `dedupe_key`.
5. Buscar por `dedupe_key` **o** `canonical_url`. Si ya existe, actualizar solo `last_seen_at` y registrar el nuevo `capture_event`; no crear otra oportunidad ni otra fila de revisión.
6. Crear o mantener una única fila `review_queue` con estado `pending`. Solo un humano puede calificar, descartar, personalizar o aprobar una candidatura.

La estrategia tolera que una misma vacante tenga URLs de bolsa distintas: la clave semántica gana. Si una coincidencia requiere criterio (por ejemplo, mismo cargo pero requisición distinta), no alterar la clave manualmente; marcarla para revisión en una tarea posterior.

## Persistencia idempotente

El nodo Postgres llama una sola función parametrizada:

```sql
SELECT * FROM career.ingest_opportunity_capture($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12::jsonb, $13);
```

La función bloquea la oportunidad coincidente, inserta o actualiza la captura con la restricción única `(source_key, source_reference)`, mantiene una sola entrada en `review_queue` y devuelve su estado. El workflow no concatena datos dentro de SQL: debe conservar la consulta parametrizada al configurar la versión instalada del nodo Postgres.


## Evidencia y score durable

La ingesta persiste de forma idempotente el resumen verificable, la evidencia de requisitos y `requirements_verified_at`: repetir el mismo payload conserva una sola oportunidad, una sola fila de revisión y la misma evidencia JSONB. Una captura posterior puede reemplazar esos tres campos únicamente con una versión completa, validada y más reciente del anuncio; no concatena arreglos ni duplica enlaces.

`score_breakdown` es un objeto JSONB durable de la oportunidad y empieza como `{}`. La ingesta **no** lo calcula ni acepta score desde fuentes. La Tarea 8 debe llamar de forma parametrizada:

```sql
SELECT * FROM career.upsert_opportunity_score($1, $2::jsonb, $3);
```

El objeto debe conservar el desglose de la rúbrica: `problema_rol` (0–25), `stack_responsabilidades` (0–25), `evidencia_disponible` (0–15), `modalidad_elegibilidad` (0–15), `seniority_aprendizaje` (0–10), `ingles_colaboracion` (0–5), `empresa_oportunidad` (0–5), `total` (0–100), `decision`, `motivo` y `scored_at`. No se permiten datos de la persona candidata ni notas privadas. Con el mismo `opportunity_id`, JSON y `scored_at`, la operación es idempotente.
## Modo de prueba

La ejecución manual genera cuatro vacantes ficticias: tres canónicas y una repetida con parámetros de seguimiento distintos. El flujo normaliza las dos URLs de **Nube Ejemplo** a la misma URL y `dedupe_basis`, pero no escribe en Postgres: devuelve `persistence = skipped_test_mode` y `review_state = pending_preview`.

Para verificar la persistencia real sin dejar datos de prueba, ejecutar el bloque de prueba transaccional incluido al final de `db/opportunity-schema.sql` y finalizar con `ROLLBACK`.

## Lista de revisión

La salida solo contiene `opportunity_id`, `created`, `dedupe_key` y `review_state` en producción, o los campos normalizados y `pending_preview` en prueba. Ninguna rama se conecta a SMTP, Gmail, HTTP de envío, CRM de contacto ni creación de candidaturas.