# Línea base: inglés laboral y fundamentos técnicos

**Estado:** pendiente de completar por la persona. Este documento define la medición; no contiene resultados asumidos.

## Objetivo

Medir la capacidad inicial para entrevistar en inglés y explicar, sin apoyo de IA, los fundamentos usados en roles de **AI Automation**, **AI Integration** e **Implementation**. La línea base permite priorizar práctica y comparar el avance semanal.

## Cómo ejecutar el diagnóstico

- Duración total: **100 minutos**; usar temporizador y no IA, traductor ni notas preparadas salvo el enunciado.
- Grabar los ejercicios hablados en audio/video y guardar las respuestas escritas como texto plano o Markdown.
- Marcar cada ítem `pendiente`, `completado` o `repetir`; nunca inferir un puntaje sin evidencia.
- Una segunda persona puede puntuar con la rúbrica. Si no hay evaluador, autoevaluar con evidencia concreta (minuto, enlace al archivo, error detectado).

## Diagnóstico de inglés laboral (40 puntos)

| Bloque | Tiempo | Consigna | Evidencia | Puntos |
|---|---:|---|---|---:|
| Presentación | 3 min | Presentarse en inglés: rol objetivo, experiencia relevante, un proyecto, tipo de impacto buscado. | Audio/video sin guion. | 0–8 |
| Explicación técnica | 5 min | Explicar en inglés el flujo: trigger → API → transformación → persistencia → alertas/errores. | Audio/video; incluir un ejemplo de fallo. | 0–8 |
| Preguntas de seguimiento | 5 min | Responder cinco follow-ups: trade-offs, seguridad, idempotencia, debugging y métricas. | Audio/video. | 0–8 |
| Escritura operativa | 12 min | Redactar un email de actualización para un stakeholder sobre una integración bloqueada: impacto, diagnóstico, plan, ETA condicionada y pregunta necesaria. | Archivo `.md` o `.txt`. | 0–8 |
| Comprensión y reformulación | 15 min | Escuchar una explicación técnica en inglés elegida por la persona, anotar cinco hechos y reformular oralmente el problema y la decisión. | URL/fuente, notas y audio/video. | 0–8 |

### Rúbrica de inglés por bloque

| Puntaje | Criterio observable |
|---:|---|
| 0 | No responde o el mensaje no se entiende. |
| 1–2 | Frases aisladas; omite datos críticos o depende de traducción/notas. |
| 3–4 | Comunica la idea básica, pero hay ambigüedad, errores frecuentes o respuesta incompleta. |
| 5–6 | Respuesta clara y ordenada; vocabulario laboral suficiente; algunos errores no bloquean el sentido. |
| 7–8 | Respuesta precisa, autónoma y adaptable; usa ejemplos, confirma supuestos y maneja follow-ups. |

### Interpretación del resultado de inglés

| Total | Lectura | Siguiente foco |
|---:|---|---|
| 0–15 | Base por construir | Presentación, vocabulario de trabajo y frases de clarificación. |
| 16–24 | Funcional inicial | Respuestas estructuradas y explicación de proyectos. |
| 25–32 | Entrevistable con práctica | Fluidez bajo presión, follow-ups y escritura concisa. |
| 33–40 | Fuerte para entrevistas | Precisión, negociación de alcance y storytelling técnico. |

> El rango describe desempeño en esta prueba, no un certificado de nivel ni una predicción de contratación.

## Diagnóstico técnico (60 puntos)

Para cada dominio: responder oralmente durante 2–3 minutos, escribir un ejemplo mínimo y describir un error frecuente. Puntuar 0–5 por criterio: **concepto**, **ejemplo correcto** y **diagnóstico de error**. Máximo: 15 por dominio; se evalúan cuatro dominios completos por sesión y se rota hasta cubrir todos los temas.

| Dominio | Qué debe poder explicar y demostrar | Evidencia mínima |
|---|---|---|
| HTTP / REST | Método, URL, headers, body, códigos 2xx/4xx/5xx, recursos, paginación; por qué `POST` no debe repetirse sin protección. | Un request/response anotado y decisión de status code. |
| JSON | Objetos, arrays, strings/números/booleanos/null, validación de schema y serialización. | Payload válido y corrección de uno inválido. |
| Webhooks | Evento saliente, endpoint receptor, firma, verificación, reintentos, timeout e idempotencia. | Pseudoflujo de recepción segura. |
| OAuth / JWT | OAuth para autorización delegada; access/refresh token; JWT firmado, claims, expiración y validación. | Diagrama breve y lista de validaciones del servidor. |
| SQL / PostgreSQL | `SELECT`, `JOIN`, filtros, índices, transacciones, constraints y consultas parametrizadas. | Consulta con join y explicación de índice/constraint. |
| Git | `status`, `add`, `commit`, ramas, `pull`, `rebase`/merge, conflicto, `diff`, revertir sin borrar historia. | Secuencia de comandos para resolver un conflicto. |
| JavaScript / TypeScript | Tipos, interfaces, nullability, funciones, módulos y diferencias de tiempo de compilación/ejecución. | Función tipada con validación de entrada. |
| `async`/`await` | Promesas, concurrencia con `Promise.all`, errores con `try/catch`, timeout/cancelación y no bloquear flujos. | Función async con manejo de error y resultado parcial. |
| Errores y observabilidad | Clasificar error transitorio/permanente, logs estructurados, correlation ID, reintentos con backoff y alertas. | Registro de incidente y estrategia de retry. |
| Docker básico | Imagen vs. contenedor, `Dockerfile`, puertos, variables de entorno, volúmenes, `docker compose` y secretos. | Comandos para levantar una API y Postgres local. |

### Puntuación técnica

- **0–19:** priorizar fundamentos, ejemplos reproducibles y vocabulario técnico.
- **20–39:** practicar integración end-to-end y debugging guiado.
- **40–50:** practicar trade-offs, seguridad y explicaciones bajo tiempo.
- **51–60:** practicar diseño de casos reales y liderazgo de implementación.

Registrar el total solo cuando estén evaluados los diez dominios (máximo 150 puntos brutos) y normalizarlo a 60: `puntaje_técnico = puntos_obtenidos / 150 × 60`.

## Registro de resultados

Completar al ejecutar; dejar en blanco lo no evaluado.

| Fecha | Inglés /40 | Técnico /60 | Total /100 | Tres brechas | Próxima repetición |
|---|---:|---:|---:|---|---|
| Pendiente | — | — | — | — | — |

## Protocolo de repetición a 48 horas

1. Elegir las **tres respuestas con menor puntaje** o `repetir`.
2. A las 48 h, responder las mismas competencias con un escenario distinto, sin guion ni IA.
3. Comparar contra la evidencia anterior: claridad, precisión técnica, estructura, tiempo y errores.
4. Marcar `mejoró`, `igual` o `empeoró`; anotar una causa verificable, no una impresión general.
5. Si no mejora, descomponer la respuesta en: concepto → ejemplo → error/mitigación y practicar de nuevo 48 h después.
6. Si mejora dos veces consecutivas, mover el tema a práctica semanal de mantenimiento y rotar al siguiente punto débil.

## Evidencia que se debe guardar

- Fecha, duración, contexto y condición: `sin IA`, `sin guion` o materiales permitidos.
- Audio/video original de cada respuesta oral y transcripción breve si existe.
- Respuesta escrita, payloads JSON, SQL, pseudocódigo y diagramas usados.
- Rúbrica por bloque/dominio, puntaje, justificación y persona evaluadora si aplica.
- Enlaces a repositorios, commits, logs anonimizados o ejercicios Docker reproducibles.
- Comparación de la repetición a 48 h y acción concreta para la próxima sesión.

## Criterio de salida para entrevistas

La línea base está lista para usarse cuando exista evidencia de una ejecución completa, los tres puntos débiles estén priorizados y haya una fecha de repetición. No exige un puntaje mínimo: el propósito inicial es medir con honestidad y convertir brechas en práctica.
