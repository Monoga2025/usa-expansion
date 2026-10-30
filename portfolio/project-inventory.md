# Inventario de proyectos reales

> **Propósito:** registrar evidencia verificable de proyectos que ya existen y elegir, sin inventar experiencia, cuáles podrían convertirse en casos de estudio para **AI Automation Engineer**, **AI / Automation Developer** e **Implementation / Automation Specialist**.
>
> **Estado:** selección inicial basada en auditoría de repositorios GitHub el 2026-09-06. No implica atribuirse automáticamente cada línea de código, métrica o resultado: la contribución personal se confirma antes de publicar.

## Selección para portfolio

### Caso principal 1 — WhatsApp AI Agent

| Campo | Registro |
|---|---|
| Estado de evidencia | `verificada` en repositorio público; requiere hardening antes de promoción pública fuerte |
| Repositorio | [Monoga2025/whatsapp-ai-agent-es](https://github.com/Monoga2025/whatsapp-ai-agent-es) |
| Rol objetivo | Principalmente **AI Automation Engineer**; también Implementation / Automation Specialist |
| Evidencia técnica | n8n, Evolution API, Redis, PostgreSQL, Docker, webhook, procesamiento de texto/audio/imagen, memoria, escalamiento humano y workflows comerciales |
| Por qué fue elegido | Es la demostración pública más directa de automatización de IA aplicada a un proceso de atención y operaciones. |
| Restricción de publicación | No afirmar resultados o contribución individual sin confirmación. Antes de usarlo como referencia principal: fijar versiones de imágenes, corregir configuración de cookie segura y agregar demo/screenshot verificable. |

### Caso principal 2 — MARAL OS

| Campo | Registro |
|---|---|
| Estado de evidencia | `verificada` en repositorio público; requiere hardening antes de cualquier afirmación de producción o demo externa |
| Repositorio | [Monoga2025/maral-os](https://github.com/Monoga2025/maral-os) |
| Rol objetivo | Principalmente **Implementation / Automation Specialist**; también AI / Automation Developer |
| Evidencia técnica | React/TypeScript/Vite, Node.js/Express/TypeScript/Prisma, PostgreSQL 16 y Docker; CRM, cotizaciones, pedidos, producción, inventario, compras, cartera y reportes; integración de WhatsApp/OpenRouter para asistir cotizaciones. |
| Por qué fue elegido | Complementa WhatsApp AI Agent con una implementación operativa empresarial pública: integra procesos de negocio y una capa de IA auxiliar con revisión humana. |
| Restricción de publicación | No afirmar autoría, resultados ni uso productivo sin confirmación. Antes de mostrarlo: eliminar valores de respaldo de credenciales/JWT, rotar secretos potencialmente reutilizados, restringir servicios expuestos, retirar o controlar accesos demo y usar solo datos sintéticos. |

### Caso complementario privado — Universidad OS

| Campo | Registro |
|---|---|
| Estado de evidencia | `verificada` mediante inspección GitHub; repositorio privado, por lo que la presentación debe ser sanitizada |
| Repositorio | Monoga2025/universidad-os (privado) |
| Rol objetivo | Principalmente **AI / Automation Developer**; también AI Integration Engineer |
| Evidencia técnica | Next.js 15, Supabase Auth, pruebas/typecheck, contenedores y asistente académico Python con Telegram/OpenAI, autorización de chat privado y materiales verificados |
| Uso | Caso complementario para entrevistas o portfolio anonimizado; no reemplaza los dos casos públicos prioritarios. |
| Restricción de publicación | No publicar código, nombres, materiales, usuarios ni configuración privada. Crear caso de estudio anonimizado, diagrama y demo con datos ficticios. |

### Proyecto de apoyo — E-bike Glendale

| Campo | Registro |
|---|---|
| Estado de evidencia | `verificada` en repositorio privado; usar solo como respaldo para roles de integración/implementación |
| Repositorio | Monoga2025/e-bikeglendale (privado) |
| Evidencia técnica | Next.js, Stripe Checkout, Supabase, webhooks firmados, idempotencia, control de inventario y rate limiting |
| Uso | Prueba de fiabilidad en integraciones y manejo de fallos; no es uno de los dos casos principales porque el componente de IA no es central. |

### Exclusiones de portfolio por ahora

- `Tutor-Dinamica`: no mostrar hasta revocar/rotar la credencial expuesta, limpiar historial y reemplazarla por configuración de entorno.
- `silvia-trabajo`: no mostrar hasta retirar datos personales/credenciales, rotarlas y revisar consentimiento del flujo de mensajería.
- `workout-cool`: aprendizaje derivado de un proyecto atribuido a terceros; no presentarlo como trabajo original.

## Ruta rápida

1. Añadí una ficha por cada proyecto real con enlace, repositorio, documento o demo accesible.
2. Marcá cada afirmación como `verificada`, `pendiente` o `no publicable` y adjuntá su evidencia.
3. Priorizá solo fichas que puedan explicar problema, arquitectura, contribución y resultado sin revelar información confidencial.

## Reglas de registro

- No crear una ficha para una idea, tutorial sin adaptación propia ni proyecto que no pueda demostrarse.
- No afirmar métricas, clientes, tecnologías, responsabilidades ni resultados sin una fuente concreta.
- Si hubo trabajo en equipo, distinguir con precisión la contribución personal de la del equipo.
- Usar solo enlaces/artefactos cuyo acceso esté autorizado; nunca pegar credenciales, datos personales, datos de clientes ni URL privadas.
- Una ficha `pendiente` sirve para investigar evidencia; no sirve aún como portfolio público.

## Criterio de priorización

| Dimensión | Pregunta de verificación | Estado esperado |
|---|---|---|
| Evidencia | ¿Hay repo, commit, demo, captura, documento o test que pruebe lo afirmado? | Verificada |
| Problema | ¿Se puede describir el proceso/usuario y su dolor sin inventar contexto? | Verificada |
| Contribución | ¿Se puede separar el trabajo propio y su evidencia? | Verificada |
| Arquitectura | ¿Se puede explicar flujo, datos, integraciones, fallos y decisiones? | Verificada |
| Resultado | ¿Existe una métrica, test, feedback o limitación documentada? | Verificada o pendiente explícita |
| Confidencialidad | ¿Se puede publicar de forma segura o con una versión anonimizada? | Aprobada |
| Rol objetivo | ¿El caso evidencia al menos un rol A, B o C? | Marcado |

**Selección vigente:** los dos casos prioritarios son WhatsApp AI Agent y MARAL OS: ambos son públicos y cubren automatización de IA e implementación operativa. Universidad OS se conserva como caso complementario privado/sanitizado. La atribución personal y los resultados siguen pendientes de confirmación.

## Ficha de proyecto — copiar por cada proyecto real

### [PENDIENTE: ID corto] — [PENDIENTE: nombre real o nombre anonimizado autorizado]

| Campo | Registro |
|---|---|
| Estado de evidencia | `pendiente` / `verificada` / `no publicable` |
| Tipo | [PENDIENTE: proyecto personal, laboral autorizado, académico, freelance, contribución open source] |
| Periodo | [PENDIENTE: mes/año de inicio y cierre o “en curso”] |
| Enlace verificable | [PENDIENTE: repositorio, commit, URL pública, video, documento o “no publicable”] |
| Acceso autorizado | [PENDIENTE: sí/no; quién autorizó y qué se puede mostrar] |
| Rol A: AI Automation Engineer | [PENDIENTE: encaje / evidencia] |
| Rol B: AI / Automation Developer | [PENDIENTE: encaje / evidencia] |
| Rol C: Implementation / Automation Specialist | [PENDIENTE: encaje / evidencia] |

#### Problema y contexto

- **Usuario/proceso afectado:** [PENDIENTE]
- **Situación inicial verificable:** [PENDIENTE]
- **Objetivo del proyecto:** [PENDIENTE]
- **Alcance y no alcance:** [PENDIENTE]

#### Evidencia disponible

| Afirmación que podría usarse | Evidencia concreta | Ubicación/enlace | Estado | Restricción de publicación |
|---|---|---|---|---|
| [PENDIENTE] | [PENDIENTE: commit, prueba, captura, ticket, video, dato aprobado] | [PENDIENTE] | pendiente | [PENDIENTE] |

#### Arquitectura y restricciones

- **Flujo de punta a punta:** [PENDIENTE]
- **Componentes/integraciones reales:** [PENDIENTE]
- **Datos, autenticación y permisos:** [PENDIENTE]
- **Errores, observabilidad y recuperación:** [PENDIENTE]
- **Restricciones técnicas, de tiempo o negocio:** [PENDIENTE]
- **Decisiones y trade-offs demostrables:** [PENDIENTE]

#### Contribución personal y resultados

- **Lo que hice personalmente:** [PENDIENTE]
- **Lo que hizo otra persona/equipo/herramienta:** [PENDIENTE]
- **Resultado verificable:** [PENDIENTE: métrica con fuente, test, feedback o limitación honesta]
- **Qué no se puede afirmar todavía:** [PENDIENTE]

#### Decisión de portfolio

- [ ] Evidencia mínima revisada.
- [ ] Riesgo de confidencialidad revisado.
- [ ] Puede adaptarse al menos a un rol objetivo.
- [ ] Tiene demo reproducible o guion honesto alternativo.
- [ ] Aprobado para convertir con `case-study-template.md`.

## Backlog de evidencia

| Proyecto real | Falta para ser caso de estudio | Responsable | Fecha objetivo | Estado |
|---|---|---|---|---|
| [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | pendiente |

