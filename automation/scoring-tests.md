# Pruebas de puntuación de oportunidades

## Alcance y fuente de datos

Estas pruebas cubren `automation/opportunity-scoring.json` con **30 oportunidades ficticias**. El workflow lee exclusivamente de `career.opportunities`: `vacancy_summary`, `requirement_evidence` y `requirements_verified_at`, además de los campos de oportunidad ya definidos. No usa datos de candidato, credenciales, correo, mensajes ni IA generativa.

Un registro solo llega a score si tiene: resumen factual de 20–4.000 caracteres sin HTML, al menos una evidencia fechada y verificable, fecha global de verificación y empresa/cargo/canal. La ausencia o invalidez de cualquiera falla cerrado antes de calcular dimensiones.

## Convenciones

**B (registro completo):** resumen factual verificable, URL canónica pública, empresa/cargo, `requirements_verified_at` ISO y evidencia con `{requirement, evidence_url, verified_at}`. En los casos con evidencia **directa** hay dos enlaces fechados; con evidencia **parcial** hay uno. El vector es `[rol, stack, evidencia, modalidad, senioridad, inglés, empresa]`.

- Stack: workflow/n8n 5, API/webhook 5, LLM/RAG/agentes 4, Postgres/Supabase 4, TypeScript/Node/JavaScript 4, CRM/WhatsApp/interfaces 3.
- Evidencia: dos enlaces válidos 15; uno válido 8; ausente/inválida = filtro obligatorio.
- Modalidad: viable 15; híbrida/desconocida 8. Senioridad: junior/associate/intern/contractor 10; mid 5. Inglés: B1/B2/intermedio 5; requisito de inglés a validar 2; no mencionado/rígido 0.
- Empresa/oportunidad: dos evidencias válidas 5; una 2. Los puntos se derivan solo de los campos persistidos.

## Matriz de 30 registros ficticios

| ID | Resumen / evidencia relevante | Vector esperado | Score | Ruta esperada | Cobertura |
|---|---|---:|---:|---|---|
| F01 | B; AI Automation Engineer; n8n, API, LLM, PostgreSQL, TypeScript, CRM; 2 evidencias; remoto; junior; B2. | [25,25,15,15,10,5,5] | 100 | research | Máximo. |
| F02 | B; Integration Engineer; API/webhooks, PostgreSQL, TypeScript; 2 evidencias; contractor; mid; B2. | [25,18,15,15,5,5,5] | 88 | research | Integración. |
| F03 | B; Automation Engineer; API, LLM, Node, CRM; 1 evidencia; remoto; mid; inglés a validar. | [25,16,8,15,5,2,2] | 73 | research | Evidencia parcial. |
| F04 | B; Implementation Specialist; n8n, API, Supabase; 2 evidencias; contractor; mid; inglés rígido. | [25,14,15,15,5,0,5] | 79 | research | Inglés 0. |
| F05 | B; AI Automation Engineer; workflow, API, Node; 1 evidencia; remoto; junior; B1. | [25,14,8,15,10,5,2] | 79 | research | Stack intermedio. |
| F06 | B; Automation Specialist; API/webhook, Postgres, CRM; 2 evidencias; contractor; junior; inglés no mencionado. | [25,12,15,15,10,0,5] | 82 | research | Inglés desconocido. |
| F07 | B; Workflow Automation Engineer; workflow, API, LLM, Supabase; 1 evidencia; híbrido; junior; inglés a validar. | [25,18,8,8,10,2,2] | 73 | research | Modalidad ambigua. |
| F08 | B; AI Integration Developer; stack completo; 2 evidencias; remoto; junior; B2. | [20,25,15,15,10,5,5] | 95 | research | Rol sustancial. |
| F09 | B; AI Automation Engineer; workflow; 2 evidencias; remoto; junior; B2. | [25,5,15,15,10,5,5] | 80 | research | Encaje/evidencia. |
| F10 | B; Integration Engineer; API, LLM, Postgres, TypeScript, CRM; 1 evidencia; contractor; junior; B2. | [25,20,8,15,10,5,2] | 85 | research | Sin segundo enlace. |
| F11 | B; Automation Engineer; workflow, LLM, TypeScript; 1 evidencia; remoto; mid; inglés a validar. | [25,13,8,15,5,2,2] | 70 | research | Límite 70. |
| F12 | B; Business Systems Lead; workflow, API, LLM, Postgres, TypeScript; 2 evidencias; remoto; junior; inglés a validar. | [0,22,15,15,10,2,5] | 69 | human_review | Límite 69. |
| F13 | B; Automation Engineer; API; 1 evidencia; remoto; mid; inglés no mencionado. | [25,5,8,15,5,0,2] | 60 | human_review | Encaje parcial. |
| F14 | B; Integration Coordinator; workflow y API; 2 evidencias; contractor; senioridad/inglés desconocidos. | [20,10,15,15,0,0,5] | 65 | human_review | Senioridad sin hecho. |
| F15 | B; Automation Engineer; API/webhook; 1 evidencia; híbrido; mid; inglés a validar. | [25,5,8,8,5,2,2] | 55 | human_review | Límite 55. |
| F16 | B; Implementation Coordinator; workflow, LLM, TypeScript; 1 evidencia; desconocido; mid; inglés a validar. | [20,13,8,8,5,2,2] | 58 | human_review | Modalidad desconocida. |
| F17 | B; Operations Developer; workflow; 2 evidencias; contractor; junior; inglés rígido. | [10,5,15,15,10,0,5] | 60 | human_review | Rol periférico. |
| F18 | B; AI Automation Engineer; API; 1 evidencia; desconocido; mid; inglés a validar. | [25,5,8,8,5,2,2] | 55 | human_review | Requiere aclaración. |
| F19 | B; Integration Coordinator; workflow; 1 evidencia; contractor; mid; inglés no mencionado. | [20,5,8,15,5,0,2] | 55 | human_review | Pocas coincidencias. |
| F20 | B; Business Systems Analyst; workflow; 2 evidencias; remoto; junior; B2. | [0,5,15,15,10,5,5] | 55 | human_review | Sin rol objetivo. |
| F21 | B; Operations Developer; workflow, API, Supabase; 1 evidencia; remoto; mid; inglés no mencionado. | [10,14,8,15,5,0,2] | 54 | discard | Límite 54. |
| F22 | B; Operations Developer; workflow, LLM, TypeScript; 1 evidencia; remoto; mid; inglés no mencionado. | [10,13,8,15,5,0,2] | 53 | discard | Bajo umbral. |
| F23 | B; Implementation Coordinator; sin stack; 1 evidencia; remoto; senioridad/inglés desconocidos. | [20,0,8,15,0,0,2] | 45 | discard | Sin responsabilidades. |
| F24 | B; Operations Developer; sin stack; 2 evidencias; contractor; senioridad/inglés desconocidos. | [10,0,15,15,0,0,5] | 45 | discard | Rol periférico débil. |
| F25 | B; Implementation Coordinator; workflow; 1 evidencia; híbrido; senioridad/inglés desconocidos. | [20,5,8,8,0,0,2] | 43 | discard | Información insuficiente. |
| F26 | B; AI Automation Engineer; workflow; 1 evidencia; desconocido; senioridad/inglés desconocidos. | [25,5,8,8,0,0,2] | 48 | discard | Score bajo. |
| F27 | Empresa/cargo/canal válidos, pero `vacancy_summary=''`; no debe calcular vector. | — | 0 | discard | Ausencia de resumen falla cerrado. |
| F28 | Resumen válido, pero `requirement_evidence=[]` o URL/fecha inválida; no debe calcular vector. | — | 0 | discard | Ausencia/invalidez de evidencia falla cerrado. |
| F29 | AI Automation Engineer, resumen nuevo con 2 evidencias a `2026-09-06T12:00:00Z`; captura posterior trae evidencia más vieja. | [25,25,15,15,10,5,5] | 100 | research | El score usa la evidencia nueva preservada. |
| F30 | Integration Engineer con 1 evidencia fechada; verificar el JSONB persistido después de la ruta. | [25,5,8,15,5,2,2] | 62 | human_review | Breakdown auditable. |

## Pruebas de persistencia y auditoría

### P01 — Datos ausentes fallan cerrado

1. Cargar F27 y F28 por separado.
2. Comprobar `hard_filter_failed=true`, `decision=discard`, `total=0` y que `motivo` contiene respectivamente `requirements_summary_no_verificable` o `evidencia_de_requisitos_ausente_o_invalida`.
3. Confirmar que `career.upsert_opportunity_score` recibe el breakdown cero, de modo que incluso el descarte queda auditable.

### P02 — Evidencia vieja no sobreescribe la nueva

1. Persistir F29 con `requirements_verified_at=2026-09-06T12:00:00Z`, resumen nuevo y dos evidencias nuevas.
2. Reingestar la misma oportunidad con resumen/evidencia completos pero `requirements_verified_at=2026-09-05T12:00:00Z`.
3. Consultar `career.opportunities`: `vacancy_summary`, `requirement_evidence` y `requirements_verified_at` deben conservar los valores del 6 de septiembre.
4. Ejecutar scoring y verificar que el breakdown tiene `evidencia_disponible.points=15` y `scored_at` posterior a la evidencia vigente. La operación de score usa `career.upsert_opportunity_score($1, $2::jsonb, $3)` con parámetros.

### P03 — Breakdown durable e idempotente

1. Ejecutar F30 dos veces con el mismo `opportunity_id`, JSONB y `scored_at`.
2. Consultar la fila: `score_breakdown` debe ser objeto JSONB, `score_updated_at` debe igualar `scored_at`, y ambos intentos deben devolver el mismo contenido.
3. Verificar las claves auditables requeridas: `problema_rol`, `stack_responsabilidades`, `evidencia_disponible`, `modalidad_elegibilidad`, `seniority_aprendizaje`, `ingles_colaboracion`, `empresa_oportunidad`, `total`, `decision`, `motivo`, `scored_at`.
4. Confirmar que el score no contiene datos de candidato ni notas privadas.

## Procedimiento de verificación

1. Importar el JSON sin activarlo. Debe seguir `active=false`, sin credenciales configuradas, correo, mensajería, IA generativa ni creación de candidaturas.
2. Ejecutar F01–F26 en modo manual con fixtures persistidos y comprobar vector, total y ruta.
3. Ejecutar F27–F28 antes de la rama de score; comprobar descarte con breakdown cero. Ejecutar P02 y P03 en una transacción que termine con `ROLLBACK`.
4. Validar límites: F11 `70 → research`, F12 `69 → human_review`, F15/F18/F19/F20 `55 → human_review`, F21 `54 → discard`.
5. Confirmar que el nodo de persistencia llama una sola vez a `career.upsert_opportunity_score` con placeholders y conserva el workflow sin activar.
