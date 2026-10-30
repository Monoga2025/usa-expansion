# Caso de estudio — Plataforma de aprendizaje con asistente conectado

**Estado:** borrador evidence-first; **no apto para publicación directa**.  
**Proyecto:** `Monoga2025/universidad-os` (repositorio privado, rama `master`).  
**Rol objetivo:** AI Automation Engineer / AI Integration / Implementation.  
**Revisión de evidencia:** 2026-09-06.  
**Regla de publicación:** no atribuir autoría, usuarios, adopción ni resultados hasta confirmar evidencia y autorización.

## Resumen verificable

La interfaz se presenta como un espacio de aprendizaje personal orientado a estudiar con evidencia. El repositorio contiene una aplicación web Next.js con autenticación Supabase y un asistente de Telegram empaquetado junto al servicio web. La evidencia confirma los componentes y controles descritos abajo; **no confirma** quién lo usó, qué parte implementó la persona candidata ni qué resultado produjo.

## Problema y alcance

| Aspecto | Evidencia disponible | Límite de la afirmación |
|---|---|---|
| Intención del producto | La pantalla inicial propone estudiar de forma deliberada y demostrar aprendizaje sin ayuda. | Describe el producto; no prueba un problema de usuario ni impacto. |
| Acceso a un espacio privado | La pantalla de acceso permite registro/inicio de sesión con Supabase. | No se verificó un entorno desplegado ni cuentas reales. |
| Acompañamiento conectado | El paquete Python declara integración con Telegram y OpenAI; el bot maneja tareas, recordatorios y entrega de materiales. | No se verificó ejecución real, calidad del modelo ni entrega a usuarios. |

**Fuera de alcance de este borrador:** métricas, testimonios, volumen de automatizaciones, datos académicos, efectividad pedagógica, propiedad intelectual y contribución individual.

## Arquitectura observable

```text
Navegador
  → Next.js / React
  → autenticación Supabase
  → dashboard y flujo de estudio
  → puente de archivos persistentes
  → asistente Python para Telegram + proveedor de IA
```

| Componente | Implementación observada | Decisión/propósito verificable |
|---|---|---|
| Web | Next.js 15, React 19, TypeScript; scripts de build, test y typecheck declarados. | Provee el espacio de acceso y aprendizaje. |
| Identidad | Cliente Supabase con inicio de sesión y registro por correo/contraseña. | Redirige al dashboard después de autenticación satisfactoria. |
| Asistente | Paquete Python `jarvis-telegram` con dependencias OpenAI y python-telegram-bot. | Expone un proceso separado para asistir por Telegram. |
| Autorización del bot | Decorador que exige chat privado y una identidad activa/enlazada antes de ejecutar handlers. | Evita aceptar comandos desde chats no autorizados según el código inspeccionado. |
| Despliegue | Docker multi-stage; el entrypoint inicia Next.js y Jarvis como usuario no privilegiado y prepara directorios con permisos restringidos. | Empaqueta ambos procesos en una sola unidad de despliegue. |

## Evidencia enlazada

> Todos los enlaces de esta tabla son **referencias internas** a un repositorio privado. No deben incluirse en la versión pública.

| Afirmación | Evidencia | Qué permite afirmar |
|---|---|---|
| El repositorio es privado y su commit disponible fue creado el 2026-09-03. | [Repositorio](https://github.com/Monoga2025/universidad-os) · [commit](https://github.com/Monoga2025/universidad-os/commit/3de6bdf48e686fce4543925c09e02fb098b9466f) | Estado de visibilidad y referencia temporal, no historial de contribución. |
| La web declara build, `vitest` y `tsc --noEmit`, además de Supabase. | [package.json](https://github.com/Monoga2025/universidad-os/blob/master/package.json) | Capacidades declaradas; no prueba que los comandos hayan pasado. |
| El formulario usa `signInWithPassword` y `signUp` de Supabase. | [auth-form.tsx](https://github.com/Monoga2025/universidad-os/blob/master/app/login/auth-form.tsx) | Flujo de autenticación implementado en el cliente. |
| La web comunica una experiencia de aprendizaje personal basada en evidencia. | [page.tsx](https://github.com/Monoga2025/universidad-os/blob/master/app/page.tsx) | Posicionamiento de producto, no impacto probado. |
| Jarvis declara OpenAI, Telegram y dependencias de prueba. | [pyproject.toml](https://github.com/Monoga2025/universidad-os/blob/master/deployment/jarvis/pyproject.toml) | Integraciones y configuración de pruebas declaradas. |
| El bot rechaza chat no privado e identidad no enlazada. | [bot.py](https://github.com/Monoga2025/universidad-os/blob/master/deployment/jarvis/src/jarvis/bot.py) | Control de autorización observado en el código. |
| El contenedor construye web y asistente, usa usuario no privilegiado y prepara almacenamiento con permisos. | [Dockerfile](https://github.com/Monoga2025/universidad-os/blob/master/Dockerfile) · [entrypoint](https://github.com/Monoga2025/universidad-os/blob/master/deployment/railway/entrypoint.sh) | Diseño de empaquetado/despliegue, no una operación productiva confirmada. |

## Privacidad, autorización y publicación

### Controles observados

- El acceso web usa autenticación Supabase.
- El bot exige un chat privado y una identidad enlazada antes de procesar acciones protegidas.
- El despliegue crea rutas persistentes para materiales, procesamiento, entrega, fallos y reportes con permisos restringidos, y ejecuta procesos como usuario no privilegiado.

### Límites y riesgos abiertos

- No se verificaron reglas de base de datos, configuración real de Supabase, secretos, retención de archivos ni permisos de infraestructura.
- No se ejecutaron pruebas ni build; el repositorio solo declara esos comandos.
- El material académico, conversaciones de Telegram, nombres de institución, rutas, URLs y cualquier identificador de cuenta pueden ser confidenciales.
- El repositorio es privado; publicar sus URLs, su código o capturas sin revisión puede revelar datos internos.

### Plan de anonimización para una versión pública

1. **Renombrar el caso** como “Plataforma de aprendizaje con asistente conectado”; no usar nombre de institución, curso, persona ni cuenta.
2. **Reemplazar** toda captura, archivo, conversación y material académico por datos sintéticos creados para la demo.
3. **Ocultar** URLs privadas, identificadores de Telegram/Supabase, rutas de infraestructura, nombres de buckets, dominios, tokens, variables de entorno y rutas locales.
4. **Usar un diagrama propio** de componentes y fragmentos mínimos previamente revisados, en lugar de enlazar al repositorio privado.
5. **Obtener autorización escrita** antes de mencionar organización, datos, resultados o material de terceros.
6. **Separar autoría:** describir únicamente contribuciones personales confirmadas y atribuir el resto a “equipo/terceros” o dejarlo pendiente.

## Limitaciones de presentación

- No hay README público ni demo pública verificable.
- El único commit observable es “initial Universidad OS platform”; no permite inferir autoría por archivo ni evolución del trabajo.
- No hay evidencia revisada de usuarios, implementación en producción, disponibilidad, resultados de aprendizaje, reducción de trabajo manual o satisfacción.
- El caso debe presentarse como **arquitectura e integración observada**, no como resultado comercial o académico probado.

## Preguntas pendientes antes de afirmar contribución o resultados

### Contribución personal

- ¿Qué decisiones de arquitectura, código, integración o despliegue realizó personalmente la persona candidata?
- ¿Qué partes fueron creadas por colaboradores, plantillas, servicios administrados o herramientas de IA?
- ¿Existe un PR, commit firmado, ticket, documento de diseño o revisión que permita atribuir cada contribución?

### Resultado y operación

- ¿Había usuarios reales y con qué autorización se utilizaron datos o materiales?
- ¿Qué prueba reproducible confirma el flujo web → autenticación → dashboard → bot?
- ¿Se ejecutaron `npm test`, `npm run typecheck` y las pruebas Python? ¿Dónde están los resultados?
- ¿Qué incidencia, línea base o resultado observable se puede citar con una fuente autorizada?
- ¿Qué política cubre consentimiento, retención y eliminación de conversaciones y materiales?

## Guion seguro de demo (60–90 segundos)

1. Mostrar un diagrama anonimizado: web, autenticación, asistente y almacenamiento.
2. Explicar que la aplicación combina un espacio de aprendizaje con un asistente de Telegram; aclarar que se trata de una arquitectura observada.
3. Mostrar únicamente una sesión sintética: login ficticio, material ficticio y una interacción de bot sin datos personales.
4. Señalar el control de chat privado/identidad enlazada y los límites no verificados.
5. Cerrar con una afirmación acotada: “Puedo explicar el flujo técnico visible en el repositorio; la autoría y los resultados siguen pendientes de validación.”

## Checklist de publicación

- [ ] Contribución personal confirmada por evidencia.
- [ ] Pruebas/build ejecutados y resultados registrados, si se van a afirmar.
- [ ] Datos, secretos, URLs y material académico eliminados o sustituidos.
- [ ] Autorización escrita para cualquier marca, cliente, institución o resultado.
- [ ] Demo sintética revisada.
- [ ] Versión pública sin enlaces al repositorio privado.

