# MARAL OS — Caso de implementación empresarial con IA auxiliar

**Posicionamiento recomendado:** caso de implementación de software operativo para empresas. Demuestra que el trabajo no se limita a una interfaz: conecta CRM, inventario, compras, producción, cartera, reportes y atención comercial en una misma plataforma. La IA y WhatsApp son capacidades auxiliares integradas al flujo de negocio, no el núcleo del caso.

**Repositorio:** [Monoga2025/maral-os](https://github.com/Monoga2025/maral-os)

> **Límite de evidencia:** este borrador documenta únicamente lo verificable en el repositorio público. No atribuye autoría individual, resultados comerciales, clientes activos, disponibilidad productiva ni métricas. Esos datos requieren confirmación antes de publicarse.

## Por qué es un buen caso de portfolio

Un recruiter para roles de implementación, automatización o full-stack puede revisar una plataforma empresarial completa con procesos conectados. El valor demostrable no es “un ERP” como etiqueta: es la integración de módulos operativos, persistencia de datos, autenticación, despliegue en contenedores y una capa de atención comercial asistida por IA.

| Señal | Evidencia verificada |
|---|---|
| Problema operativo | La plataforma concentra CRM, cotizaciones, pedidos, producción, inventario, compras, cartera y reportes. |
| Arquitectura full-stack | Frontend React/TypeScript/Vite; backend Node.js/Express/TypeScript/Prisma; PostgreSQL 16. |
| Operación desplegable | Docker Compose organiza frontend, backend, PostgreSQL, volúmenes persistentes y health check de base de datos. |
| IA auxiliar | La ruta de WhatsApp integra Evolution API y OpenRouter; puede proponer respuestas y extraer información de cotización desde conversaciones. |
| Control humano | Cuando no hay cliente o productos coincidentes, el flujo devuelve casos para revisión manual en lugar de crear automáticamente una cotización. |

## Arquitectura y alcance verificados

### Plataforma empresarial

El README enumera los siguientes módulos:

- Dashboard con indicadores.
- CRM y gestión de clientes.
- Cotizaciones con generación de PDF.
- Pedidos en vista kanban y tabla.
- Producción en tres fases.
- Inventario con alertas de stock mínimo.
- Compras y proveedores.
- Crédito y cartera.
- Catálogo de productos.
- Reportes y exportación.

La estructura declarada separa `frontend/`, `backend/`, el esquema/migraciones de Prisma y la configuración de contenedores. Esto permite presentar el caso como integración de procesos empresariales, no como un demo aislado.

### Automatización e IA auxiliares

La ruta de WhatsApp usa configuración por variables de entorno para Evolution API y OpenRouter. La evidencia revisada muestra:

- Registro y actualización de chats y mensajes.
- Generación de sugerencias de respuesta basadas en historial reciente.
- Clasificación de leads y flujos de notificación/campaña.
- Extracción de ítems, dirección y notas para preparar una cotización.
- Búsqueda de cliente y productos; si no hay coincidencias suficientes, el flujo informa que se requiere revisión manual.
- Creación de cotización únicamente cuando se encuentran los elementos necesarios.

**Mensaje de portfolio correcto:** “Integración de atención comercial por WhatsApp e IA para asistir la preparación de cotizaciones dentro de una plataforma empresarial.”  
**Mensaje que no debe usarse sin evidencia adicional:** “Agente autónomo que vende” o “ERP productivo con resultados medidos”.

## Guion de demo con datos sintéticos

**Objetivo:** mostrar una cadena de valor concreta en 4–6 minutos sin revelar datos de clientes, conversaciones reales, precios confidenciales ni credenciales.

1. Iniciar una instancia aislada con una base de datos de demostración y usuarios ficticios.
2. Crear un cliente ficticio y dos productos de catálogo sintéticos.
3. Mostrar una alerta de inventario o el estado inicial de una cotización.
4. Simular una conversación de WhatsApp con una solicitud de producto.
5. Mostrar la sugerencia asistida por IA y la extracción de ítems.
6. Confirmar visualmente la revisión humana de datos no coincidentes.
7. Generar una cotización en borrador y navegar al pedido/producción relacionado.
8. Cerrar mostrando el panel y el vínculo entre la operación comercial y los módulos de back-office.

### Criterios para una demo segura

- Usar nombres, teléfonos, direcciones, mensajes y productos ficticios.
- Sustituir cualquier conversación importada por fixtures sanitizados.
- No mostrar tokens, archivos de entorno, URLs privadas ni datos de contacto reales.
- Mantener el paso de aprobación humana visible antes de que una cotización quede lista.

## Hardening requerido antes de presentarlo como producción

La configuración de Docker contiene valores de respaldo para credenciales de base de datos y secreto de autenticación. No deben usarse en un entorno accesible ni mantenerse como valores reutilizables.

Checklist de endurecimiento:

- [ ] Eliminar valores de respaldo para secretos y exigir configuración por entorno.
- [ ] Rotar secretos si cualquiera de esos valores pudo desplegarse o reutilizarse.
- [ ] Revisar y retirar las credenciales de demostración del README público, o reemplazarlas por un flujo temporal y controlado.
- [ ] Restringir la exposición de PostgreSQL y backend a la red necesaria.
- [ ] Separar los datos de demo de cualquier dato operacional.
- [ ] Añadir controles de autorización y auditoría específicos para flujos de WhatsApp, importaciones y cotizaciones asistidas por IA.
- [ ] Validar que los mensajes, archivos y campos extraídos por IA no permitan crear datos incorrectos sin revisión humana.

## Preguntas que deben responderse antes de convertirlo en caso público

1. ¿Cuál fue la contribución personal concreta en arquitectura, backend, frontend, integración de WhatsApp, despliegue y pruebas?
2. ¿Hubo autorización para mencionar a la organización y usar capturas, aun cuando los datos estén anonimizados?
3. ¿Qué problema operativo existía antes y qué comportamiento observable mejoró?
4. ¿Qué métricas o resultados se pueden afirmar con evidencia (por ejemplo, tiempo de preparación de cotización, errores evitados o adopción)?
5. ¿Qué componentes se ejecutaron realmente y cuáles permanecen como funcionalidades en desarrollo?
6. ¿Qué controles de privacidad, acceso y conservación de mensajes se acordaron para la integración de WhatsApp?

## Material verificable

- [README y módulos declarados](https://github.com/Monoga2025/maral-os/blob/master/README.md)
- [Integración de WhatsApp e IA](https://github.com/Monoga2025/maral-os/blob/master/backend/src/routes/whatsapp.ts)
- [Orquestación de servicios con Docker Compose](https://github.com/Monoga2025/maral-os/blob/master/docker-compose.yml)

## Próximo paso

Confirmar atribución, autorización y resultados; después, grabar la demo sintética y decidir si este caso sustituye a un caso privado como pieza principal del portfolio.
