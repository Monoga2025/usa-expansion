# Plantilla de caso de estudio verificable

> **Usar solo después de registrar un proyecto real en `project-inventory.md`.** Esta plantilla no autoriza a inventar un proyecto, cliente, alcance, métrica ni contribución. Todo campo sin prueba queda como `PENDIENTE` o se elimina de la versión pública.

## Ruta rápida

1. Copiá la plantilla por un proyecto inventariado y enlazá su evidencia.
2. Completá primero hechos verificables, arquitectura y contribución personal.
3. Aplicá la revisión de confidencialidad antes de publicar una demo, captura o enlace.

---

# Caso de estudio: [PENDIENTE: nombre real o anonimizado autorizado]

**Estado:** borrador / revisión de evidencia / aprobado para publicación / no publicable  
**Proyecto inventariado:** [PENDIENTE: ID y enlace a `project-inventory.md`]  
**Rol principal:** [PENDIENTE: Rol A, B o C]  
**Fecha de revisión:** [PENDIENTE]  
**Nivel de confidencialidad:** público / anonimizado / interno / no publicable

## Resumen en 30 segundos

**Problema:** [PENDIENTE: proceso, usuario y dolor verificable].  
**Solución:** [PENDIENTE: flujo y componentes reales].  
**Mi contribución:** [PENDIENTE: acciones propias comprobables].  
**Resultado:** [PENDIENTE: métrica, test, feedback o limitación con fuente].

## Adaptación por rol objetivo

| Rol | Qué debe quedar demostrado | Evidencia de este caso | Estado |
|---|---|---|---|
| A — AI Automation Engineer | Automatización de un flujo, integraciones, trazabilidad, errores e impacto de negocio | [PENDIENTE] | pendiente |
| B — AI / Automation Developer | Código/API/webhook, datos, validación o autenticación cuando aplique, pruebas y explicación técnica | [PENDIENTE] | pendiente |
| C — Implementation / Automation Specialist | Descubrimiento del proceso, configuración, adopción, documentación y comunicación con usuarios/clientes | [PENDIENTE] | pendiente |

## Contexto, problema y alcance

- **Usuario o equipo afectado:** [PENDIENTE]
- **Proceso inicial:** [PENDIENTE]
- **Problema y consecuencia observable:** [PENDIENTE]
- **Objetivo acordado:** [PENDIENTE]
- **Alcance entregado:** [PENDIENTE]
- **No incluido / limitaciones conocidas:** [PENDIENTE]

## Evidencia verificable

| Hecho que se quiere comunicar | Tipo de evidencia | Enlace/ubicación | Fecha | Estado | Apto para mostrar |
|---|---|---|---|---|---|
| [PENDIENTE] | repo, commit, test, video, captura, ticket, métrica aprobada o feedback | [PENDIENTE] | [PENDIENTE] | pendiente | sí/no |

> No publicar un porcentaje, ahorro, volumen, nombre de cliente o captura que no tenga evidencia y autorización explícitas.

## Arquitectura y decisiones

### Flujo de punta a punta

```text
[Disparador real pendiente] → [Validación/autenticación pendiente] → [Orquestación pendiente]
→ [Datos o sistema externo pendiente] → [Resultado para usuario pendiente]
→ [Registro, alerta o recuperación pendiente]
```

| Elemento | Implementación real | Motivo/decisión | Evidencia | Pendiente |
|---|---|---|---|---|
| Disparador | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Integraciones/API | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Datos/estado | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Seguridad | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Errores y recuperación | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Observabilidad | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |

### Restricciones y trade-offs

- **Restricción técnica:** [PENDIENTE]
- **Restricción de negocio/tiempo:** [PENDIENTE]
- **Trade-off elegido y por qué:** [PENDIENTE]
- **Riesgo que quedó abierto:** [PENDIENTE]

## Contribución personal

| Área | Lo que hice personalmente | Lo que hizo el equipo/terceros | Evidencia |
|---|---|---|---|
| Descubrimiento/diseño | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Implementación/configuración | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Pruebas/depuración | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |
| Documentación/entrega | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] |

## Resultados y verificación

| Resultado esperado | Línea base | Resultado observado | Fuente | Estado |
|---|---|---|---|---|
| [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | [PENDIENTE] | pendiente |

**Resultado no cuantificable o no disponible:** [PENDIENTE: decirlo claramente; no inferir una métrica].

## Revisión de confidencialidad

| Riesgo | ¿Existe? | Acción antes de publicar | Estado |
|---|---|---|---|
| Datos personales, credenciales, tokens o secretos | [PENDIENTE] | Eliminar/redactar y rotar secretos expuestos | pendiente |
| Datos de cliente, conversaciones o métricas privadas | [PENDIENTE] | Anonimizar y obtener autorización escrita si corresponde | pendiente |
| Repositorio, URL o infraestructura privada | [PENDIENTE] | Usar diagrama/demostración aislada o no publicar | pendiente |
| Atribución engañosa del trabajo propio | [PENDIENTE] | Separar contribución personal y del equipo | pendiente |
| Licencias, marcas o material de terceros | [PENDIENTE] | Verificar permiso o reemplazar el material | pendiente |

## Guion de demo de 60–90 segundos

| Tiempo | Lo que se muestra | Lo que se dice | Prueba/precaución |
|---|---|---|---|
| 0–10 s | Problema o flujo inicial, sin datos sensibles | “Este caso aborda [PENDIENTE: problema verificable].” | Mostrar solo datos autorizados |
| 10–25 s | Arquitectura o punto de entrada | “El flujo inicia en [PENDIENTE] y valida [PENDIENTE].” | Diagrama o entorno aislado |
| 25–50 s | Ejecución principal e integración | “Implementé [PENDIENTE: contribución propia] para conectar [PENDIENTE].” | No revelar tokens/URL privadas |
| 50–70 s | Manejo de error, trazabilidad o decisión | “Cuando [PENDIENTE], el sistema [PENDIENTE].” | Mostrar evidencia reproducible |
| 70–90 s | Resultado y aprendizaje | “La evidencia disponible muestra [PENDIENTE]; la limitación pendiente es [PENDIENTE].” | No afirmar resultados sin fuente |

**Plan B si la demo en vivo falla:** [PENDIENTE: video grabado con datos sintéticos, diagrama autorizado o detener la demo].

## Checklist antes de publicar

- [ ] El proyecto existe y aparece en el inventario.
- [ ] Cada afirmación relevante tiene evidencia enlazada o está marcada como pendiente.
- [ ] La contribución personal está separada de la del equipo y de herramientas de IA.
- [ ] Arquitectura, restricciones, errores y trade-offs se pueden explicar sin inventar detalles.
- [ ] Resultados tienen fuente o se presentan como no disponibles.
- [ ] Se revisaron confidencialidad, secretos, PII, permisos y autorización.
- [ ] El demo dura entre 60 y 90 segundos al ensayarlo.
- [ ] Se eligió una adaptación por rol; las demás no se afirman si no hay evidencia.

## Próximo paso

Completar únicamente los campos respaldados por evidencia real y pasar la ficha por una revisión manual de confidencialidad antes de usarla en CV, portfolio o entrevista.
