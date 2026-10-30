# Caso de estudio: automatización de atención por WhatsApp

**Resumen.** Este repositorio presenta una implementación reproducible para automatizar atención al cliente por WhatsApp en negocios locales: recibe eventos, conserva contexto conversacional, procesa texto, audio e imágenes, y deriva conversaciones a una persona cuando corresponde. El valor demostrable está en la integración operativa de componentes, no en una afirmación no verificada de resultados comerciales.

- Repositorio: [Monoga2025/whatsapp-ai-agent-es](https://github.com/Monoga2025/whatsapp-ai-agent-es)
- Licencia: [MIT](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/LICENSE)
- Alcance verificable: artefactos, configuración y documentación públicos del repositorio.

## Problema que aborda

Los negocios que atienden por WhatsApp reciben mensajes fragmentados y multimodales, y necesitan responder con el contexto del cliente sin perder la posibilidad de intervención humana. El repositorio propone una solución autocontenida para ese flujo, enfocada en pequeñas empresas latinoamericanas y documentación en español.

No se presentan aquí métricas de reducción de tiempos, conversiones, clientes activos ni impacto financiero: no hay evidencia pública suficiente para atribuirlos.

## Arquitectura de la solución

```text
WhatsApp
  → Evolution API
  → webhook de n8n
  → filtro y normalización de eventos
  → Redis: buffer, memoria y pausa por escalamiento
  → modelo de IA: texto / transcripción / visión
  → Evolution API: respuesta al cliente o aviso al encargado

PostgreSQL conserva el estado operativo del stack.
```

La arquitectura se puede levantar mediante Docker Compose con n8n, Evolution API, Redis y PostgreSQL. [Ver composición del stack](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/docker-compose.yml).

## Componentes y decisiones observables

| Componente | Responsabilidad | Evidencia |
|---|---|---|
| Evolution API | Conexión de WhatsApp y entrega de eventos/mensajes | [README del agente](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/README.md) |
| n8n | Orquestación declarativa del flujo de atención | [Workflow principal](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/workflows/atencion-cliente-whatsapp-ia.json) |
| Redis | Agrupación temporal de mensajes, memoria por cliente y pausa de bot tras escalamiento | [Workflow principal](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/workflows/atencion-cliente-whatsapp-ia.json) |
| Modelo de IA | Respuesta conversacional; transcripción de audio y análisis de imágenes según la documentación | [README del agente](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/README.md) |
| PostgreSQL | Persistencia del stack de automatización | [Docker Compose](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/docker-compose.yml) |
| Pack de automatizaciones | Recordatorios, reseñas, cobranza, reactivación y campañas | [README principal](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/README.md) |

### Flujo de una conversación

1. El webhook recibe eventos `messages.upsert` de Evolution API.
2. El workflow descarta mensajes propios, grupos y estados, y normaliza el payload.
3. Para texto, audio e imágenes, prepara un contexto común antes de invocar el agente.
4. Redis agrupa mensajes consecutivos para evitar respuestas fragmentadas y conserva memoria conversacional.
5. El agente genera una respuesta usando la configuración del negocio.
6. Si identifica una solicitud de persona, una queja o una intención de compra, el flujo pausa el bot para ese chat y avisa al responsable.

Las notas y nodos del workflow documentan estas etapas; la documentación del repositorio declara un workflow principal de 36 nodos. [Inspeccionar el artefacto](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/workflows/atencion-cliente-whatsapp-ia.json).

## Fallos, límites y guardrails incluidos

### Guardrails documentados

- Filtrado de mensajes propios, grupos y estados para reducir activaciones no deseadas.
- Buffer de Redis para consolidar mensajes rápidos antes de responder.
- Pausa temporal por chat y aviso al encargado cuando hay escalamiento humano.
- Uso recomendado para mensajes entrantes o para clientes con consentimiento; el README advierte contra mensajería masiva en frío.
- Instrucciones para respaldar volúmenes persistentes y revisar el uso de HTTPS en producción.

### Limitaciones técnicas y operativas

- Evolution API opera sobre una integración no oficial de WhatsApp; el propio README advierte riesgo de bloqueo y recomienda considerar WhatsApp Cloud API para alto volumen.
- La evidencia revisada describe el flujo, pero no prueba ejecución en producción, pruebas automatizadas, disponibilidad, recuperación ante fallos ni observabilidad.
- La adaptación de prompts y configuración del negocio vive en nodos de n8n; cada despliegue requiere una revisión cuidadosa de credenciales, datos comerciales y políticas.
- La documentación declara capacidades de texto, audio e imágenes, pero este caso no afirma métricas de precisión ni cobertura de escenarios límite.

## Evidencia para revisión

- [README principal: alcance y pack de automatizaciones](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/README.md)
- [README del agente: instalación, comportamiento y límites](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/README.md)
- [Workflow principal de n8n](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/workflows/atencion-cliente-whatsapp-ia.json)
- [Workflow de configuración del webhook](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/workflows/configurar-webhook-evolution.json)
- [Docker Compose del stack](https://github.com/Monoga2025/whatsapp-ai-agent-es/blob/master/agente-atencion-cliente/docker-compose.yml)
- [Commit de incorporación pública](https://github.com/Monoga2025/whatsapp-ai-agent-es/commit/26e04063b281f154962065190721fc167b2f74d4)

## Checklist de hardening antes de presentarlo

- [ ] Sustituir etiquetas `latest` de n8n y Evolution API por versiones concretas y documentar el proceso de actualización.
- [ ] Usar HTTPS, cookies seguras y un proxy inverso para servicios expuestos; la configuración actual está orientada a arranque local.
- [ ] Gestionar claves con secretos de despliegue, nunca con valores de ejemplo reutilizados ni credenciales dentro de workflows exportados.
- [ ] Restringir el acceso a n8n, Evolution API, PostgreSQL y Redis mediante red, autenticación y mínimos privilegios.
- [ ] Autenticar o verificar los webhooks entrantes antes de procesar su payload.
- [ ] Definir retención, borrado y respaldo para mensajes, transcripciones, imágenes y memoria conversacional.
- [ ] Añadir observabilidad: alertas de fallos de workflow, trazas por conversación, límites de coste y métricas de escalamiento.
- [ ] Probar casos de error: duplicados, reintentos, audio/imagen no procesables, Redis no disponible, proveedor de IA no disponible y escalamiento concurrente.
- [ ] Confirmar cumplimiento de consentimiento, opt-out y políticas de WhatsApp para el caso de uso concreto.
- [ ] Preparar una demo con datos ficticios y un video corto que recorra texto, audio, imagen y escalamiento humano.

## Preguntas pendientes antes de atribuir impacto o contribución

1. ¿Cuál fue la contribución personal exacta de la persona que presentará este caso: arquitectura, workflows, infraestructura, prompts, documentación, pruebas u operación?
2. ¿El flujo se desplegó y se usó fuera de un entorno local? Si sí, ¿qué evidencia se puede compartir sin revelar datos de clientes?
3. ¿Qué resultados medibles existen —por ejemplo, tasa de escalamiento, tiempo de primera respuesta, tasa de error o disponibilidad— y en qué periodo se midieron?
4. ¿Qué decisiones fueron validadas con usuarios o negocios reales, y cuáles permanecen como diseño o prototipo?
5. ¿Qué proveedor/modelo de IA y qué controles de coste se usaron en cada entorno?

## Próximo paso

Completar las preguntas pendientes y el checklist de hardening. Después, convertir esta evidencia en una demo reproducible y una narrativa de contribución personal verificable.