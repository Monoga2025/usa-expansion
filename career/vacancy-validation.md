# Validación inicial de la rúbrica con 10 vacantes

**Fecha de consulta:** 2026-09-05  
**Propósito:** probar que la rúbrica distingue oportunidades compatibles de vacantes inviables. **No es una lista de postulaciones activas.** El estado, ubicación y requisitos se deben volver a verificar en la fuente original inmediatamente antes de aplicar.

## Resultado

La rúbrica funciona como filtro: 3 muestras merecen investigación posterior, 1 requiere revisión humana y 6 se descartan por ubicación, autorización o seniority. Esto confirma que buscar por título solamente produciría mucho ruido.

| # | Vacante y fuente | Evidencia relevante observada | Score / decisión | Motivo |
|---:|---|---|---|---|
| 1 | [AI Automation Engineer — Pyyne](https://jobs.ashbyhq.com/Pyyne/11176bae-e8bf-4163-9f07-949941f80c84) | Consultoría de IA aplicada; LLMs en workflows de negocio; oficina sudamericana. | 70 — Revisar | Buen rol, pero la fuente visible menciona Brasil/Argentina/Portugal; confirmar si Colombia es elegible. |
| 2 | [AI & Automation Engineer — CSG](https://csgi.wd5.myworkdayjobs.com/CSGCareers/job/Brazil-Remote/AI---Automation-Engineer_31095) | Remoto Colombia/Brasil/México; agentes, RAG, APIs y componentes reutilizables. | 60 — Revisar | Encaje técnico y geográfico alto; la exigencia publicada de 3–5 años necesita contraste con experiencia demostrable. |
| 3 | [AI Automation Specialist — Pavago](https://mx.indeed.com/viewjob?jk=075b2240b9078762) | Remoto LATAM; n8n/Make/Zapier, LLM APIs, APIs/webhooks, documentación y mejora de procesos. | 85 — Investigar | Es el mejor encaje del muestreo para AI Automation Engineer. Confirmar vigencia y condiciones de contratación antes de personalizar. |
| 4 | [AI Automation Engineer / n8n & AI Agent Developer — Synergy Effect](https://community.n8n.io/t/hiring-ai-automation-engineer-n8n-ai-agent-developer/294904) | Contractor remoto y n8n, APIs, agentes y automatización de procesos. | Descartar por vigencia | La fuente devolvió 404 al validar; nunca perseguir enlaces caídos sin confirmar una publicación oficial actual. |
| 5 | [Technical Implementation Specialist — Rocket Pilots](https://co.computrabajo.com/ofertas-de-trabajo/oferta-de-trabajo-de-technical-implementation-specialist-us-based-company-en-bogota-dc-2F22635B63D2DD7761373E686DCF3405) | Remoto LATAM; implementación, IA y coordinación técnica. | Descartar | Exige 3+ años y experiencia específica en SEO, GA4, Ads y WordPress; no es el primer objetivo del perfil. |
| 6 | [AI Integration Engineer — LaSalle Network](https://www.dice.com/job-detail/e3967243-99d8-4119-a081-39198f3c12fe) | Agentes e integraciones de IA en producción. | Descartar | Contrato W-2 y viajes presenciales periódicos; la elegibilidad desde Colombia no está demostrada. |
| 7 | [Automation Engineer V — Avalara](https://careers.avalara.com/careers-home/jobs/16829?lang=en-us) | n8n, agentes y automatización de negocio. | Descartar | El empleo remoto se limita a Estados Unidos y el nivel V implica seniority alto. |
| 8 | [IT Systems & Automation Engineer — n8n](https://jobs.ashbyhq.com/n8n/5afbde12-defb-457d-a21e-584347141436) | Empresa objetivo y automatización real. | Descartar | La lista de ubicaciones remotas publicada es Europa/Reino Unido, no Colombia/LATAM. |
| 9 | [AI Integration Engineer — Degird](https://degird.com/careers/ai-integration-engineer) | TypeScript, PostgreSQL, Docker, APIs de IA y buenas prácticas de evaluación. | Descartar | Requiere trabajar legalmente en Bangladesh y 3+ años. Sirve como mapa de brechas, no como candidatura. |
| 10 | [AI + Integration Engineer — Incorporan](https://www.dice.com/job-detail/d1f168a1-2957-4691-901b-dc82580c5924) | APIs, JSON e integración con IA. | Descartar | Exige visa independiente específica, 5+ años, Azure Integration Services y EDI/BizTalk. |

## Ajustes validados

1. **Mantener los filtros obligatorios antes del score.** Seis de diez vacantes parecen atractivas por título/stack, pero son inviables por geografía, autorización o seniority.
2. **No convertir un match de herramientas en un match laboral.** n8n, APIs y agentes no compensan una restricción de ubicación o cinco años de especialización enterprise.
3. **Separar “investigar” de “aplicar”.** Una fuente agregadora, publicación antigua o enlace caído nunca debe disparar un mensaje automatizado.

## Próximo experimento

Recolectar 30 oportunidades desde máximo tres fuentes, aplicar la rúbrica y verificar manualmente los primeros 10 scores. Para cada oportunidad que llegue a `Investigar`, guardar URL original, fecha/hora de consulta, modalidad, requisito de ubicación y evidencia del encaje.
