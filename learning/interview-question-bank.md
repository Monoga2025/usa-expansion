# Banco de preguntas para entrevistas: AI Automation, AI Integration e Implementation

**Uso:** practicar respuestas habladas de 90–120 segundos sin IA. Las preguntas y respuestas modelo están en inglés porque simulan la entrevista; el análisis y la rúbrica están en español.

## Método de respuesta

Usar esta estructura, sin memorizar un libreto: **contexto → acción propia → decisión técnica → resultado/evidencia → aprendizaje**. Si falta información, decir qué validarías antes de decidir. Nunca inventar métricas ni impacto.

## Banco de preguntas

### 1. Presentación e impacto

**Question:** “Tell me about yourself and why you are interested in AI automation or integration work.”

**Model answer:** “I build practical automations that connect business workflows with reliable systems. I am especially interested in work where an integration removes repetitive manual steps while keeping clear ownership, observability, and human approval for high-impact actions. In a recent project, I focused on mapping the workflow first, then defining the API contract and failure paths before implementation. I am looking for a role where I can combine hands-on delivery with clear communication to technical and non-technical stakeholders.”

**Qué evalúa:** claridad, foco de rol, criterio de negocio y comunicación.

### 2. Diseño de una integración

**Question:** “How would you design an integration between a CRM and an AI service that summarizes customer calls?”

**Model answer:** “First, I would clarify the trigger, data classification, expected latency, and who can see the summary. A webhook can notify our service when a call is ready. The service would verify the webhook signature, fetch only the required data through OAuth-scoped access, send it to the AI provider, validate the structured response, and write the summary back to the CRM. I would use an idempotency key because webhook deliveries can be retried. I would also add correlation IDs, retries with backoff for transient failures, a dead-letter path, and human review for sensitive or low-confidence summaries.”

**Qué evalúa:** arquitectura end-to-end, seguridad, idempotencia y operación.

### 3. HTTP y REST

**Question:** “What is the difference between PUT and PATCH, and when would you use each?”

**Model answer:** “PUT usually replaces the full representation at a known resource URL and should be idempotent. PATCH applies a partial change, so its behavior depends on the patch format and implementation. I would use PUT when the client owns and sends the complete resource representation, and PATCH when only a few fields need to change. In both cases I would validate authorization, input schema, and concurrency rules, for example with a version field or ETag.”

**Qué evalúa:** semántica HTTP y manejo de concurrencia.

### 4. JSON y contratos

**Question:** “How do you make sure JSON data from an external API is safe to use?”

**Model answer:** “I treat external JSON as untrusted input. I validate it against a schema at the boundary, check required fields and types, reject or quarantine malformed payloads, and log a safe summary with a correlation ID. TypeScript types are useful during development, but they do not validate runtime data by themselves. I also version the contract when breaking changes are possible.”

**Qué evalúa:** validación en runtime y límites de TypeScript.

### 5. Webhooks y duplicados

**Question:** “A webhook provider retries the same event three times. How do you prevent duplicate side effects?”

**Model answer:** “I verify the provider signature and store a stable event ID in a database table with a unique constraint before performing the side effect. If the same ID arrives again, I return a successful acknowledgment without repeating the work. For longer tasks, I persist the processing state and use an idempotency key with the downstream service too. I would not rely only on in-memory state because retries can reach different instances.”

**Qué evalúa:** idempotencia durable, Postgres y sistemas distribuidos.

### 6. OAuth y JWT

**Question:** “What is the relationship between OAuth and JWT?”

**Model answer:** “OAuth is an authorization framework: it defines how a client obtains delegated access. JWT is a token format that can be used for an access token, but OAuth does not require JWTs. When validating a JWT, I verify the signature using the expected key, issuer, audience, expiration, and relevant claims. I never trust a decoded token just because it is readable.”

**Qué evalúa:** precisión conceptual y seguridad.

### 7. SQL / PostgreSQL

**Question:** “How would you investigate a slow PostgreSQL query used by an automation?”

**Model answer:** “I would reproduce the query with realistic parameters and inspect its execution plan with EXPLAIN ANALYZE. I would check selectivity, join order, missing indexes, and whether the query is reading more columns or rows than necessary. I would add an index only after confirming it matches the query pattern and consider write costs. I would keep the query parameterized, measure again, and monitor the result in production.”

**Qué evalúa:** diagnóstico basado en evidencia, rendimiento y seguridad.

### 8. Git y entrega segura

**Question:** “You discover a bug after merging your feature. What do you do?”

**Model answer:** “I first assess user impact and stop or contain the unsafe behavior if necessary. I inspect the deployed revision and logs, create a focused fix branch, add a regression test when possible, and keep the fix separate from unrelated refactors. If the fastest safe option is a revert, I use git revert so history remains clear. Then I communicate the impact, mitigation, and follow-up actions.”

**Qué evalúa:** operación, Git y responsabilidad.

### 9. JavaScript / TypeScript y `async`/`await`

**Question:** “When would you use Promise.all, and what is a common risk?”

**Model answer:** “I use Promise.all for independent operations that can run concurrently and where all results are required. A common risk is that one rejection causes the whole promise to reject while other operations may still be running. For independent best-effort tasks, Promise.allSettled can be more appropriate. I also control concurrency rather than launching an unbounded number of requests.”

**Qué evalúa:** concurrencia, errores y límites de proveedor.

### 10. Manejo de errores

**Question:** “How do you decide whether to retry an API failure?”

**Model answer:** “I classify the failure first. Network timeouts, 429 responses, and some 5xx errors can be transient, so I retry with exponential backoff, jitter, a cap, and observability. Validation errors and most 4xx responses are usually permanent and should go to a corrective path instead. I make retries idempotent, record the attempt count, and alert when a workflow reaches a dead-letter queue.”

**Qué evalúa:** criterio operativo y resiliencia.

### 11. Docker básico

**Question:** “How would you make a small integration service reproducible for another developer?”

**Model answer:** “I would create a Dockerfile that pins the runtime and installs dependencies deterministically. With docker compose, I would define the service and Postgres, use environment variables for non-secret configuration, and keep secrets outside the image and repository. I would expose only required ports, mount a named volume for database persistence, and document the single command to start the stack.”

**Qué evalúa:** reproducibilidad y manejo básico de secretos.

### 12. Implementación con stakeholders

**Question:** “A stakeholder asks for an automation to send messages automatically, but the inputs are incomplete. How do you proceed?”

**Model answer:** “I would not automate irreversible outbound actions from incomplete inputs. I would map the decision points, define required fields and validation rules, and propose a staged rollout: draft generation, human approval, then controlled sending with audit logs. I would explain the risk in business terms, agree on success and stop criteria, and test with a small sample before scaling.”

**Qué evalúa:** criterio de producto, seguridad y gestión de expectativas.

## Rúbrica de simulación (por pregunta, 0–20)

| Dimensión | 0 | 2 | 4 |
|---|---|---|---|
| Exactitud técnica | Incorrecta o ausente | Parcial; confunde conceptos | Correcta y aplica al caso |
| Estructura | Divaga o no concluye | Tiene idea central, pero desordenada | Contexto, decisión, resultado y aprendizaje claros |
| Inglés laboral | Incomprensible o dependiente de lectura | Entendible con errores que distraen | Claro, profesional y adaptable |
| Criterio operativo | Ignora seguridad, errores o impacto | Menciona un riesgo sin mitigación | Considera validación, observabilidad y trade-offs |
| Evidencia / honestidad | Inventa resultados | Ejemplo vago | Explicita evidencia disponible o qué verificaría |

**Interpretación:** 0–8 = repetir fundamentos; 9–13 = consolidar estructura; 14–17 = practicar follow-ups; 18–20 = variar el escenario y aumentar presión de tiempo.

## Protocolo de repetición a 48 horas

1. Elegir tres preguntas con menor puntaje y conservar el audio/respuesta original.
2. Repetirlas a las 48 h con un caso equivalente pero distinto (otro proveedor, fallo o stakeholder), sin guion ni IA.
3. Registrar puntaje por dimensión, duración y un cambio técnico específico respecto al intento anterior.
4. Pedir un follow-up por pregunta: “What could fail?”, “How would you measure success?” o “What trade-off would you make?”
5. Si el total no sube o una dimensión baja, volver a estudiar el fundamento y hacer una tercera repetición 48 h después.

## Evidencia a guardar por simulación

- Fecha, pregunta, rol objetivo y condición de práctica.
- Audio/video y respuesta escrita o transcripción breve.
- Puntaje 0–20 con justificación de cada dimensión.
- Follow-up recibido y respuesta; errores factuales corregidos.
- Enlace a un artefacto real si se cita un proyecto (repo, demo, ADR, ticket o log anonimizado).
- Comparación entre intento inicial y repetición a 48 h, más la próxima acción.

## Hoja de registro

| Fecha | Pregunta | Puntaje /20 | Principal brecha | Repetición 48 h | Evidencia |
|---|---|---:|---|---|---|
| Pendiente | — | — | — | — | — |

## Regla de calidad

Una buena respuesta no es una lista de buzzwords. Debe mostrar que entendés el problema, elegís una solución proporcional, anticipás fallos y sabés comprobar si funcionó.

