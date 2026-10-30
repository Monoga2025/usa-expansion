# Rutina semanal de 15 horas: inglés laboral y fundamentos

**Estado:** plan de práctica. La existencia de esta rutina no prueba que se haya ejecutado ni completa la Tarea 6.

## Propósito

Convertir la línea base y el banco de entrevistas en práctica deliberada para roles de **AI Automation**, **AI Integration** e **Implementation**. La rutina requiere respuestas sin IA, evidencia verificable y una revisión semanal para no confundir tiempo invertido con progreso.

## Regla de operación

- Reservar cinco bloques de **3 horas** (15 horas semanales). Mover un bloque es válido; eliminarlo sin reprogramarlo no lo es.
- Antes de empezar, elegir un objetivo observable: explicar un concepto, producir un artefacto mínimo o responder una pregunta concreta.
- Durante las respuestas habladas no usar IA, traductor ni guion. Se puede consultar documentación oficial solo en el bloque de estudio, no en la simulación.
- Registrar la evidencia al terminar cada bloque en `learning/progress-log.md`.
- Ninguna puntuación se completa por memoria: debe apuntar a audio/video, texto, código, query o diagrama real.

## Calendario semanal

| Día | Duración | Sesiones concretas | Salida / evidencia |
|---|---:|---|---|
| Lunes | 3 h | 75 min inglés: presentación, explicación de proyecto y frases para aclarar requisitos. 90 min fundamentos: HTTP/REST + JSON, con request/response anotado y payload validado. 15 min registrar evidencia. | Audio sin guion; un request/response; JSON válido e inválido corregido; enlace en el log. |
| Martes | 3 h | 90 min fundamentos: webhooks + OAuth/JWT (firma, idempotencia, scopes y validación). 60 min **Simulación A**: 2 preguntas del banco + 1 follow-up por pregunta. 30 min puntuar y registrar. | Diagrama del flujo; lista de validaciones; audio/video de simulación; rúbrica 0–20 por pregunta. |
| Miércoles | 3 h | 90 min inglés: escuchar una explicación técnica, extraer cinco hechos y reformularla oralmente. 90 min fundamentos: SQL/PostgreSQL + Git, con `JOIN`, `EXPLAIN ANALYZE` teórico y secuencia de resolución de conflicto. | URL y notas; audio de reformulación; SQL parametrizado; secuencia Git escrita. |
| Jueves | 3 h | 90 min fundamentos: JavaScript/TypeScript + `async`/`await`, errores, retries y observabilidad. 60 min **Simulación B**: repetir a 48 h una pregunta débil de Simulación A con escenario distinto, más una pregunta nueva o follow-up. 30 min comparar y registrar. | Función tipada async; decisión de retry/backoff; audio/video; comparación A/B a 48 h. |
| Viernes | 3 h | 60 min inglés escrito: email de estado sobre una integración bloqueada. 60 min Docker básico + integración: `Dockerfile`/Compose conceptual, variables, puertos, volumen y secretos. 60 min **revisión de viernes**. | Email; comandos o diagrama Docker; revisión semanal y plan de la semana siguiente. |

**Total:** inglés laboral 3 h 45 min; fundamentos y práctica técnica 7 h; dos simulaciones 2 h; registro y revisión 2 h 15 min = **15 h**.

## Temas y rotación

La primera semana usa el calendario anterior. A partir de la segunda, mantener la estructura y rotar el foco según las tres brechas con peor evidencia:

1. **Seguridad e integración:** HTTP/REST, JSON, webhooks, OAuth/JWT.
2. **Datos y entrega:** SQL/PostgreSQL, Git, Docker.
3. **Implementación y operación:** JavaScript/TypeScript, `async`/`await`, manejo de errores y observabilidad.
4. Volver al carril 1 y elevar dificultad: caso real, follow-ups, trade-offs y explicación en inglés.

Si se completa la línea base, el resultado guía la rotación; si está pendiente, no suponer una brecha. Rotar los tres carriles en orden hasta contar con evidencia.

## Dos simulaciones por semana

### Simulación A — martes

- Seleccionar dos preguntas de `learning/interview-question-bank.md` de carriles distintos.
- Responder 90–120 segundos por pregunta, sin guion, seguido de un follow-up.
- Puntuar con la rúbrica 0–20 y capturar un error factual o de comunicación por respuesta.

### Simulación B — jueves (repetición a 48 h)

- Repetir al menos una pregunta débil de Simulación A con escenario equivalente pero diferente.
- Añadir una pregunta nueva o un segundo follow-up para mantener dos respuestas completas.
- Comparar claridad, exactitud técnica, estructura, inglés laboral y criterio operativo. Marcar solo `mejoró`, `igual` o `empeoró` con evidencia.

## Revisión de viernes (60 min)

1. Comprobar que cada bloque tuvo evidencia y que los enlaces abren.
2. Contar horas planificadas, realizadas y reprogramadas; no sumar horas no registradas.
3. Identificar tres brechas a partir de la rúbrica, errores repetidos o artefactos incompletos.
4. Elegir una sola mejora por brecha para la semana siguiente.
5. Programar la repetición a 48 h de cada respuesta débil.
6. Registrar si hubo una interrupción, su causa y la reprogramación concreta; no convertirla en resultado personal.

## Evidencia mínima por semana

- 2 audios/videos de simulación y 1 repetición comparada a 48 h.
- 1 presentación o explicación técnica en inglés y 1 email operativo en inglés.
- 1 artefacto por cada carril de fundamentos trabajado: payload/diagrama, SQL/Git, función async/estrategia de errores o Docker.
- Rúbricas, tiempo real, enlaces y próxima acción en el log.

## Primera semana: ajuste a la línea base

Si todavía no existe una ejecución del diagnóstico de `learning/baseline.md`, usar los primeros 100 minutos disponibles de la semana para hacerlo bajo sus condiciones. Registrar el bloque como `diagnóstico pendiente de puntuar` hasta que haya evidencia y rúbrica. El resto de la rutina sigue siendo una propuesta; no se debe declarar la Tarea 6 completada por preparar los documentos.
