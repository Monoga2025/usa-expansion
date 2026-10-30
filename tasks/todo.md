# Tareas: Sistema personal para conseguir empleo internacional

## Tarea 1: Definir roles objetivo y reglas de calificación

**Descripción:** Convertir los tres posicionamientos propuestos en perfiles de búsqueda concretos y en una definición operativa de “buena oportunidad”.

**Estado:** Completada — roles y rúbrica contrastados con 10 vacantes reales; el detalle está en `career/vacancy-validation.md`.

**Criterios de aceptación:**
- [x] Cada rol incluye títulos equivalentes, responsabilidades, tecnologías, seniority, ubicación y restricciones.
- [x] Existe una regla de descarte y una puntuación de 0–100 con umbral inicial de 70.
- [x] Se documentan no objetivos para evitar vacantes que no aprovechen automatización/IA.

**Verificación:**
- [x] Evaluar 10 vacantes reales y obtener decisiones consistentes.
- [x] Revisión manual: explicar por qué cada vacante entra o sale en menos de 60 segundos.

**Dependencias:** Ninguna

**Archivos probables:**
- `career/target-roles.md`
- `career/qualification-rubric.md`

**Alcance estimado:** Pequeño (2 archivos)

## Tarea 2: Crear el tablero del embudo y la línea base

**Descripción:** Definir la fuente única de verdad para oportunidades, postulaciones, respuestas, entrevistas, pruebas técnicas y ofertas.

**Estado:** Completada — esquema, dashboard de línea base y prueba reproducible con 10 capturas ficticias conciliadas.

**Criterios de aceptación:**
- [x] Cada registro conserva fuente, empresa, rol, país, fecha, score, CV, mensaje y estado.
- [x] El tablero calcula conversiones entre etapas y tiempo hasta respuesta.
- [x] Se registra una línea base inicial, aunque todos los valores sean cero.

**Verificación:**
- [x] Cargar 10 registros de prueba y validar los cálculos manualmente.
- [x] Confirmar que una oportunidad duplicada puede identificarse.

**Dependencias:** Tarea 1

**Archivos probables:**
- `career/funnel-schema.md`
- `career/weekly-dashboard.csv`

**Alcance estimado:** Pequeño (2 archivos)

## Tarea 3: Diagnosticar inglés laboral y fundamentos técnicos

**Descripción:** Medir la capacidad actual para explicar proyectos, resolver preguntas de entrevista y comunicar errores sin asistencia de IA.

**Criterios de aceptación:**
- [ ] Grabar una explicación de proyecto de 5 minutos y una explicación de bug de 3 minutos en inglés.
- [ ] Completar un diagnóstico sobre HTTP/REST, JSON, webhooks, OAuth/JWT, SQL, Git, TypeScript, asincronía, errores y Docker.
- [ ] Priorizar las cinco brechas que más afectan entrevistas.

**Verificación:**
- [ ] Conservar grabaciones, respuestas y rúbrica con fecha.
- [ ] Repetir una muestra de preguntas 48 horas después sin apuntes.

**Dependencias:** Tarea 1

**Archivos probables:**
- `learning/baseline.md`
- `learning/interview-question-bank.md`

**Alcance estimado:** Pequeño (2 archivos)

## Checkpoint: Base lista
- [ ] Tareas 1–3 completas
- [ ] Roles, métricas y brechas prioritarias revisados por la persona candidata

## Tarea 4: Producir tres CV enfocados

**Descripción:** Crear un CV base y tres variantes orientadas a AI Automation Engineer, AI/Automation Developer e Implementation/Automation Specialist.

**Criterios de aceptación:**
- [ ] Cada versión prioriza logros y tecnologías relevantes para su rol.
- [ ] Cada afirmación importante tiene evidencia verificable en portfolio o experiencia.
- [ ] Los documentos son legibles por ATS y caben en una extensión razonable para el perfil.

**Verificación:**
- [ ] Comparar cada CV contra 5 vacantes de su segmento.
- [ ] Exportar y revisar visualmente los PDF finales.

**Dependencias:** Tareas 1 y 3

**Archivos probables:**
- `cv/ai-automation-engineer.md`
- `cv/ai-automation-developer.md`
- `cv/implementation-automation-specialist.md`

**Alcance estimado:** Mediano (3 archivos)

## Tarea 5: Crear dos casos de estudio y demos breves

**Descripción:** Convertir proyectos existentes en evidencia de negocio y técnica que pueda enlazarse desde CV, mensajes y entrevistas.

**Estado:** En curso — los casos prioritarios son WhatsApp AI Agent y MARAL OS, ambos públicos; Universidad OS se conserva como caso complementario privado/sanitizado. Existen borradores evidence-first y guiones de demo. Falta confirmar contribución personal/resultados, completar hardening (incluido MARAL) y grabar demos con datos sintéticos.

**Criterios de aceptación:**
- [ ] Cada caso explica problema, restricciones, arquitectura, contribución personal y resultado.
- [ ] Cada demo dura 60–90 segundos y muestra un flujo relevante de punta a punta.
- [ ] Cada caso incluye una explicación técnica preparada sin depender de IA.

**Verificación:**
- [ ] Una persona externa puede entender el valor del proyecto en menos de 2 minutos.
- [ ] Todos los enlaces abren sin permisos especiales ni datos sensibles.

**Dependencias:** Tareas 1 y 3

**Archivos probables:**
- `portfolio/case-study-1.md`
- `portfolio/case-study-2.md`
- `portfolio/case-study-maral-os.md`
- `portfolio/demo-scripts.md`

**Alcance estimado:** Mediano (3 archivos)

## Tarea 6: Ejecutar las rutinas de inglés y fundamentos técnicos

**Descripción:** Establecer una rutina repetible orientada a entrevistas, reuniones, explicación de bugs y defensa de decisiones técnicas.

**Estado:** Preparada — rutina y registro creados; falta ejecución personal y evidencia de dos semanas.

**Criterios de aceptación:**
- [ ] El calendario reserva cinco sesiones de inglés y tres de fundamentos por semana.
- [ ] Cada semana incluye una entrevista simulada y una explicación de proyecto sin IA.
- [ ] Se registra evidencia y una mejora concreta por semana.

**Verificación:**
- [ ] Completar dos semanas consecutivas con al menos 80 % de adherencia.
- [ ] Repetir el diagnóstico de la Tarea 3 y comparar resultados.

**Dependencias:** Tarea 3

**Archivos probables:**
- `learning/weekly-routine.md`
- `learning/progress-log.md`

**Alcance estimado:** Pequeño (2 archivos)

## Checkpoint: Listo para aplicar
- [ ] Tareas 4–6 completas
- [ ] Tres CV y dos demos listos para compartir
- [ ] Explicación de proyecto y bug comprensible sin asistencia de IA

## Tarea 7: Capturar y deduplicar oportunidades

**Descripción:** Crear el primer tramo del pipeline para reunir oportunidades legítimas y normalizarlas antes de cualquier generación de mensajes.

**Estado:** Preparada — MVP importable, esquema y contrato creados; falta configurar fuentes/credenciales autorizadas y ejecutar el lote real de validación.

**Criterios de aceptación:**
- [ ] Se conectan inicialmente no más de tres fuentes prioritarias.
- [ ] Los registros se normalizan al esquema de la Tarea 2.
- [ ] La deduplicación evita procesar dos veces la misma vacante.

**Verificación:**
- [ ] Procesar 30 oportunidades de prueba sin pérdida de campos obligatorios.
- [ ] Verificar manualmente duplicados y errores de fuente.

**Dependencias:** Tareas 1 y 2

**Archivos probables:**
- `automation/opportunity-ingestion.json`
- `automation/source-contract.md`
- `db/opportunity-schema.sql`

**Alcance estimado:** Mediano (3 archivos)

## Tarea 8: Puntuar y filtrar oportunidades

**Descripción:** Implementar la rúbrica de calificación para descartar incompatibilidades y priorizar oportunidades con encaje real.

**Estado:** Preparada — workflow inactivo y matriz de 30 pruebas ficticias listos; falta ejecutar P01–P03 contra una base de prueba transaccional antes de activarlo.

**Criterios de aceptación:**
- [ ] El score explica sus factores y no es una decisión opaca del modelo.
- [ ] Las restricciones duras — ubicación, permiso, seniority y modalidad — se evalúan antes del score.
- [ ] Solo las oportunidades con score mínimo pasan a investigación.

**Verificación:**
- [ ] Comparar el sistema con la evaluación manual de 30 vacantes.
- [ ] Investigar cualquier desacuerdo material antes de activar el filtro.

**Dependencias:** Tareas 1 y 7

**Archivos probables:**
- `automation/opportunity-scoring.json`
- `automation/scoring-tests.md`

**Alcance estimado:** Pequeño (2 archivos)

## Tarea 9: Investigar, personalizar y seleccionar CV

**Descripción:** Generar un paquete de candidatura trazable: hechos sobre empresa/rol, mensaje personalizado, CV recomendado y evidencia pertinente.

**Criterios de aceptación:**
- [ ] Cada personalización usa hechos con fuente y evita inventar experiencia.
- [ ] La selección de CV se basa en el posicionamiento de la Tarea 1.
- [ ] El borrador incluye evidencia relevante, no una plantilla genérica disfrazada.

**Verificación:**
- [ ] Revisar 20 paquetes y medir errores factuales, repeticiones y selección incorrecta.
- [ ] Cero afirmaciones sin soporte sobre la persona candidata o la empresa.

**Dependencias:** Tareas 4, 5 y 8

**Archivos probables:**
- `automation/company-research.json`
- `automation/application-draft.json`
- `automation/cv-routing.md`

**Alcance estimado:** Mediano (3 archivos)

## Tarea 10: Aprobar, registrar y programar seguimiento

**Descripción:** Añadir un control humano obligatorio, registrar el resultado y crear seguimientos prudentes sin duplicar contactos.

**Criterios de aceptación:**
- [ ] Ningún mensaje se envía sin acción explícita de aprobar.
- [ ] El envío actualiza el embudo y conserva una copia del paquete aprobado.
- [ ] El seguimiento se cancela ante respuesta, rebote, rechazo o exclusión voluntaria.

**Verificación:**
- [ ] Probar aprobar, rechazar, editar y cancelar con datos de prueba.
- [ ] Validar límites, errores y comportamiento idempotente antes del piloto real.

**Dependencias:** Tareas 2 y 9

**Archivos probables:**
- `automation/review-and-send.json`
- `automation/follow-up.json`
- `automation/operations-runbook.md`

**Alcance estimado:** Mediano (3 archivos)

## Checkpoint: Pipeline seguro
- [ ] Tareas 7–10 completas
- [ ] Prueba integral con datos no sensibles superada
- [ ] Reglas de privacidad, entregabilidad y detención documentadas

## Tarea 11: Ejecutar un piloto de 50 postulaciones y optimizar conversiones

**Descripción:** Validar el sistema a bajo volumen, medir resultados y decidir qué variable mejorar antes de escalar.

**Criterios de aceptación:**
- [ ] Completar 50 postulaciones calificadas a un ritmo de 5–10 por día.
- [ ] Registrar respuestas, entrevistas, rebotes, errores y tiempo invertido.
- [ ] Elegir una sola hipótesis de mejora basada en el mayor cuello de botella.

**Verificación:**
- [ ] Conciliar los 50 envíos con el tablero y los registros del proveedor.
- [ ] Producir una revisión escrita con decisión: escalar, corregir o detener.

**Dependencias:** Tareas 4, 5, 6 y 10

**Archivos probables:**
- `career/pilot-report.md`
- `career/experiment-log.md`

**Alcance estimado:** Pequeño (2 archivos)

## Tarea 12: Validar Work & Travel 2027 y construir su calendario de decisión

**Descripción:** Separar la aspiración de los requisitos reales y producir un plan con elegibilidad, patrocinador, costos, fechas y riesgos.

**Estado:** Completada de forma condicionada — la investigación y el calendario están listos; la elegibilidad personal, fechas 2027, sponsor, cupos y cotizaciones siguen pendientes de fuentes vigentes.

**Criterios de aceptación:**
- [x] Requisitos base validados con fuentes oficiales; las fechas 2027 no publicadas quedan marcadas como pendientes.
- [x] Existe un presupuesto con escenarios y fecha límite de decisión.
- [x] El plan no asume que Work & Travel garantiza empleo posterior o migración.

**Verificación:**
- [x] Conservar enlaces, fecha de consulta y contactos oficiales.
- [x] Revisar que cada supuesto crítico tenga evidencia o esté marcado como desconocido.

**Dependencias:** Ninguna

**Archivos probables:**
- `work-and-travel/2027-decision.md`
- `work-and-travel/2027-budget.csv`

**Alcance estimado:** Pequeño (2 archivos)

## Checkpoint: Ciclo completo
- [ ] Tareas 1–12 completas
- [ ] Dos ciclos de revisión del embudo ejecutados
- [ ] Próximo ciclo de 12 semanas aprobado antes de ampliar automatización o volumen

