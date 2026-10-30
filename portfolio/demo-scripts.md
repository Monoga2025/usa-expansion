# Guiones de demo de portfolio

Dos demos de 60–90 segundos diseñadas para mostrar integración, seguridad y criterio de implementación sin revelar credenciales, conversaciones, datos académicos ni información de clientes.

## Reglas de seguridad para ambas demos

- Usar una cuenta, negocio, conversación, curso y datos creados exclusivamente para la demo.
- Ocultar variables de entorno, tokens, QR, números telefónicos, URLs privadas, paneles de proveedor y logs.
- No afirmar adopción, resultados comerciales, propiedad intelectual de terceros ni despliegue en producción sin confirmación personal previa.
- Si una pantalla no está disponible en un entorno seguro, usar una captura o grabación local con datos sintéticos y aclararlo verbalmente.

---

# 1. WhatsApp AI Agent (ES)

**Duración objetivo:** 75 segundos  
**Mensaje central:** Automatización conversacional para negocios locales que combina orquestación, memoria temporal y escalamiento humano.

## Hechos verificables en el repositorio

- El repositorio documenta un stack con Evolution API, n8n, Redis, PostgreSQL y Docker.
- El flujo principal de n8n tiene 36 nodos y contempla texto, notas de voz e imágenes.
- Redis se usa para agrupar mensajes, conservar memoria por cliente y pausar el bot tras un escalamiento.
- La configuración del negocio se concentra en un nodo y el repositorio incluye cinco automatizaciones adicionales para negocios locales.
- La documentación indica un buffer de 12 segundos, memoria de 20 interacciones con TTL de 48 horas y pausa humana configurable de 60 minutos.

## Afirmaciones que requieren confirmación personal

Confirmar antes de decirlas en cámara:

- “Lo implementé de punta a punta para un cliente real.”
- “Está actualmente operando en producción.”
- “Redujo tiempos de respuesta, aumentó ventas o evitó citas perdidas.”
- “Cumple los requisitos de una cuenta o proveedor específico de WhatsApp.”
- “Escala a determinado volumen o número de negocios.”

## Guion

| Tiempo | Narración | Mostrar con datos ficticios |
|---|---|---|
| 0–10 s | “Este es un agente de atención por WhatsApp para negocios locales. El objetivo no es responder por responder: es consolidar mensajes, mantener contexto y derivar a una persona cuando corresponde.” | Título de la demo y diagrama simplificado: WhatsApp → Evolution API → n8n → Redis/IA → respuesta. |
| 10–25 s | “El stack está orquestado con n8n, Evolution API, Redis, PostgreSQL y Docker. El flujo central contempla texto, voz e imágenes; Redis aporta el buffer de mensajes y memoria temporal.” | Workflow de n8n con credenciales ocultas; usar etiquetas ficticias como “Café Aurora”. No mostrar QR, URL ni conexiones reales. |
| 25–42 s | “Acá simulo tres mensajes seguidos de un cliente: ‘Hola’, ‘quiero cotizar’ y ‘para mañana’. En lugar de enviar tres respuestas, el buffer los agrupa y el agente responde una sola vez con el contexto completo.” | Chat simulado con “Cliente Demo”; luego una única respuesta de ejemplo. No usar números reales. |
| 42–58 s | “Cuando aparece una intención de compra, una queja o un pedido explícito de hablar con una persona, el flujo notifica al encargado y pausa la automatización para esa conversación.” | Rama de escalamiento en n8n y una notificación ficticia a “Equipo Demo”. Mostrar el estado “pausado” sin identificar a nadie. |
| 58–75 s | “La configuración del negocio está centralizada para reutilizar el flujo sin reescribir la lógica. Además, el repositorio incluye recordatorios, reseñas, cobranza, reactivación y campañas con IA.” | Nodo de configuración con valores falsos y listado de los cinco workflows. Cierre con arquitectura, no con métricas no verificadas. |

## Qué no mostrar

- Archivo .env, credenciales de IA, tokens de Evolution API, claves de n8n, Redis o PostgreSQL.
- QR, número de WhatsApp, mensajes, fotos o audios de personas reales.
- Paneles de producción, webhooks públicos o información de un cliente.
- Envíos masivos o mensajes sin consentimiento.

---

# 2. Universidad OS

**Duración objetivo:** 85 segundos  
**Mensaje central:** Plataforma académica con flujos de estudio, sincronización de datos y una pasarela de IA con controles explícitos.

## Hechos verificables en el repositorio

- Es una aplicación privada basada en Next.js, React, TypeScript y Supabase.
- Incluye áreas de dashboard, cursos, estudio, progreso, tutor, conexión TEMA y emparejamiento con Telegram.
- Tiene pruebas Vitest de dominio, integración y extremo a extremo.
- La pasarela de IA exige un token Bearer, fija el modelo, limita tamaño de solicitud/respuesta y timeout, y restringe las herramientas disponibles.
- Las migraciones de Supabase implementan publicación atómica de snapshots de datos académicos y reservan su ejecución para service_role.

## Afirmaciones que requieren confirmación personal

Confirmar antes de decirlas en cámara:

- “La plataforma está integrada con una institución o sistema académico real.”
- “Sincroniza datos reales de estudiantes, cursos, calificaciones o archivos.”
- “Fue usada por una cantidad determinada de usuarios.”
- “La IA mejora resultados académicos o automatiza una tarea institucional en producción.”
- “Cumple requisitos legales, institucionales o de privacidad de una universidad.”

## Guion

| Tiempo | Narración | Mostrar con datos ficticios |
|---|---|---|
| 0–12 s | “Universidad OS organiza el ciclo de estudio: cursos, objetivos, progreso, documentos y tutoría. La demo usa información sintética para mostrar el flujo sin exponer datos académicos.” | Dashboard de “Estudiante Demo” con materias ficticias: “Álgebra”, “Sistemas” y “Proyecto”. |
| 12–28 s | “Parto de un curso de ejemplo. El sistema presenta actividades y material, y el estudiante puede convertir esa información en un plan de estudio y una sesión de tutoría.” | Curso ficticio, dos actividades inventadas y un documento de ejemplo creado para la grabación. No conectarse a TEMA real. |
| 28–48 s | “El tutor no expone una clave de proveedor al navegador. La pasarela de IA requiere autenticación, valida el contenido, fija el modelo y limita tamaño, herramientas y tiempo de respuesta.” | Diagrama: interfaz → gateway autenticado → IA. Mostrar fragmentos o tarjetas de controles, nunca encabezados Authorization, tokens ni variables de entorno. |
| 48–66 s | “También se modela la sincronización como una publicación atómica: el snapshot se valida y se publica como una unidad, para evitar que la interfaz mezcle datos viejos y nuevos.” | Animación o pantalla ficticia: “capturar → validar → publicar”. Usar contadores inventados, no cursos ni calificaciones reales. |
| 66–85 s | “La calidad no depende solo de la interfaz: el repositorio incluye pruebas de dominio, integración y extremo a extremo. Eso permite verificar contratos de la pasarela de IA, progreso y sincronización.” | Árbol de pruebas o resultados pregrabados del entorno demo, sin rutas locales, nombres de usuario ni salida que contenga secretos. Cierre: “datos sintéticos, controles explícitos, flujos verificables”. |

## Qué no mostrar

- Información de una institución, TEMA, Telegram, correos, matrículas, calificaciones o archivos reales.
- Tokens de conexión, credenciales de Supabase, claves de IA o cabeceras Bearer.
- Pantallas de administración, almacenamiento, logs, migraciones con datos ni terminales con variables de entorno.
- Resultados de pruebas que no hayan sido ejecutadas en el entorno mostrado.

---

# Checklist de grabación

## Antes de grabar

- [ ] Crear un perfil, negocio, conversación, cursos, actividades y documentos ficticios.
- [ ] Verificar que no haya secretos en pantalla, historial del portapapeles, URL, pestañas, notificaciones ni logs.
- [ ] Desactivar sincronizaciones, notificaciones y conexiones a cuentas reales.
- [ ] Preparar capturas o datos de respaldo para cada paso dependiente de un servicio externo.
- [ ] Validar personalmente cada afirmación marcada como “requiere confirmación”.

## Durante la grabación

- [ ] Decir primero el problema y después el flujo técnico.
- [ ] Mantener cada demo entre 60 y 90 segundos.
- [ ] Mostrar una sola historia de usuario ficticia por demo.
- [ ] Nombrar los controles de seguridad sin revelar su configuración.
- [ ] Evitar métricas, clientes, usuarios y afirmaciones de producción no confirmadas.

## Antes de publicar

- [ ] Revisar el video a velocidad normal y cuadro a cuadro para detectar datos sensibles.
- [ ] Confirmar permisos para usar cualquier marca, interfaz o material externo.
- [ ] Añadir una nota visible: “Demo con datos ficticios”.
- [ ] Publicar únicamente la versión sin secretos ni información personal.

