# Esquema del embudo laboral y tablero semanal

> **Propósito:** una única fuente de verdad para oportunidades, candidaturas y sus resultados. El tablero semanal se deriva de estos registros; no se edita para corregir el historial.
>
> **Alcance del piloto:** AI Automation Engineer, AI / Automation Developer e Implementation / Automation Specialist, únicamente en modalidades remotas compatibles con Colombia/LATAM o contractor internacional.

## Reglas de operación

1. Cada captura recibe un `capture_id`; tras deduplicar, cada vacante canónica recibe un `opportunity_id` antes de cualquier investigación, borrador o contacto.
2. No se borra una fila: una oportunidad no viable conserva `estado_oportunidad = descartada` y el motivo. Esto preserva la línea base y evita volver a trabajarla.
3. Una candidatura solo puede crearse para una oportunidad `calificada` o `en_revision`, con `aprobacion_humana = si`. El envío autónomo no está permitido.
4. Todo cambio relevante después de enviar se registra como un evento. Los eventos son aditivos; el estado actual se calcula desde el evento más reciente por candidatura.
5. Usar fechas ISO `AAAA-MM-DD`, hora en UTC cuando exista, y valores controlados exactamente como aparecen abajo.
6. No guardar documentos de identidad, dirección, teléfono, salario personal, credenciales, notas médicas ni conversaciones completas. Los ejemplos deben ser ficticios.

## Identificadores y deduplicación

| Entidad | Identificador | Regla |
|---|---|---|
| Oportunidad | `OPP-AAAA-####` | Consecutivo estable; nunca se reutiliza. |
| Candidatura | `APP-AAAA-####` | Una fila por intento aprobado; referencia un `opportunity_id`. |
| Evento | `EVT-AAAA-####` | Una fila por respuesta, entrevista, prueba, oferta o cierre; referencia un `application_id`. |

Antes de crear una oportunidad, buscar primero por `url_canonica` y luego por `clave_dedupe` activa. La misma vacante publicada en varias bolsas se conserva como una sola oportunidad y se anexan las URLs secundarias en `fuentes_alternas`.

**Clave de deduplicación (Google Sheets):**

```text
=LOWER(REGEXREPLACE(TRIM(empresa)&"|"&TRIM(titulo_normalizado)&"|"&TRIM(ubicacion_normalizada);"[^a-z0-9|]";""))
```

- `url_canonica`: eliminar parámetros de seguimiento y preferir la URL de la empresa o ATS.
- Si cambia materialmente el cargo, ubicación o requisición, crear una nueva oportunidad y vincularla mediante `opportunity_relacionada_id`.
- Si una coincidencia es incierta, marcar `posible_duplicado = si`; una persona decide `fusionada` o `distinta` antes de postular.

## Hoja `Capturas` — entrada y auditoría de deduplicación

Una fila representa una aparición de una vacante en una fuente. `Capturas` conserva el volumen de entrada; `Oportunidades` conserva solo la vacante canónica sobre la que se decide.

| Campo | Tipo / valores permitidos | Uso |
|---|---|---|
| `capture_id` | texto, único (`CAP-AAAA-####`) | Clave primaria de la aparición. |
| `fecha_captura` | fecha ISO | Fecha de entrada al embudo. |
| `fuente` | texto | Sitio o referencia de origen. |
| `url_capturada` | URL | URL tal como se encontró. |
| `empresa`, `titulo_publicado`, `ubicacion_normalizada` | texto | Datos usados para normalizar. |
| `clave_dedupe` | fórmula | Clave normalizada de empresa, título y ubicación. |
| `resultado_dedupe` | `nueva`, `fusionada`, `posible_duplicado`, `distinta` | Decisión de deduplicación. |
| `opportunity_id_canonica` | texto existente | Referencia a la fila canónica de `Oportunidades`. |
| `capture_id_duplicada_de` | texto o vacío | Obligatorio si `resultado_dedupe = fusionada`. |
| `revisor_dedupe` | texto | Persona que confirma la decisión. |
## Hoja `Oportunidades` — fuente de verdad de vacantes

Una fila representa una vacante única, aunque aparezca en más de una fuente.

| Campo | Tipo / valores permitidos | Uso |
|---|---|---|
| `opportunity_id` | texto, único | Clave primaria. |
| `fecha_captura` | fecha ISO | Inicio de la trazabilidad. |
| `empresa` | texto | Empresa verificable. |
| `dominio_empresa` | texto | Ayuda a deduplicar. |
| `titulo_publicado` | texto | Título tal como aparece. |
| `titulo_normalizado` | texto | Título comparable con roles objetivo. |
| `rol_objetivo` | `AI Automation Engineer`, `AI / Automation Developer`, `Implementation / Automation Specialist` | Posicionamiento elegido. |
| `ubicacion_normalizada` | texto | País/zona y remoto si aplica. |
| `modalidad` | `remoto_colombia_latam`, `contractor_internacional`, `hibrido`, `presencial`, `desconocido` | Filtro de elegibilidad. |
| `url_canonica` | URL | Enlace principal verificable. |
| `fuente_principal` | texto | Sitio o referencia de origen. |
| `fuentes_alternas` | texto | URLs o nombres separados por ` | `. |
| `clave_dedupe` | fórmula | Clave descrita arriba. |
| `posible_duplicado` | `si`, `no` | Requiere revisión si es `si`. |
| `opportunity_relacionada_id` | texto o vacío | Vacante similar pero distinta. |
| `score_problema_rol` | número 0–25 | Rúbrica existente. |
| `score_stack_responsabilidades` | número 0–25 | Rúbrica existente. |
| `score_evidencia` | número 0–15 | Rúbrica existente. |
| `score_modalidad_elegibilidad` | número 0–15 | Rúbrica existente. |
| `score_seniority_aprendizaje` | número 0–10 | Rúbrica existente. |
| `score_ingles_colaboracion` | número 0–5 | Rúbrica existente. |
| `score_empresa_oportunidad` | número 0–5 | Rúbrica existente. |
| `score_total` | fórmula 0–100 | Suma de los siete componentes. |
| `filtro_obligatorio` | `aprobado`, `fallido` | Si falla, no se personaliza ni aplica. |
| `motivo_filtro_o_descarte` | texto o vacío | Obligatorio si el filtro falla o se descarta. |
| `estado_oportunidad` | `capturada`, `calificada`, `en_revision`, `descartada`, `cerrada` | Estado operativo. |
| `revisor` | texto | Persona que calificó. |
| `fecha_revision` | fecha ISO o vacío | Auditoría de decisión. |
| `notas_factuales` | texto breve | Hechos, no suposiciones. |

**Fórmulas:**

```text
score_total = score_problema_rol + score_stack_responsabilidades + score_evidencia + score_modalidad_elegibilidad + score_seniority_aprendizaje + score_ingles_colaboracion + score_empresa_oportunidad

accion_recomendada = SI(filtro_obligatorio="fallido";"descartar";SI(score_total>=70;"investigar";SI(score_total>=55;"revision_humana";"no_personalizar")))
```

La calificación sigue exactamente los filtros y rangos de `career/qualification-rubric.md`: 70–100 se investiga, 55–69 requiere revisión humana y 0–54 no justifica personalización.

## Hoja `Candidaturas` — fuente de verdad de envíos

Una fila representa un intento de candidatura; puede haber más de una por oportunidad solo si la anterior se cerró y el motivo de reintento queda documentado.

| Campo | Tipo / valores permitidos | Uso |
|---|---|---|
| `application_id` | texto, único | Clave primaria. |
| `opportunity_id` | texto existente | Clave foránea a `Oportunidades`. |
| `version_intento` | entero desde 1 | Previene reenvíos invisibles. |
| `canal` | `ats`, `email_individual`, `referido`, `linkedin`, `web_empresa`, `otro_legitimo` | Canal de envío. |
| `cv_version` | texto | CV usado; nunca inventar experiencia. |
| `portfolio_evidencia` | URL o identificador | Demo/caso pertinente. |
| `mensaje_version` | texto o identificador | Borrador personalizado. |
| `aprobacion_humana` | `si`, `no` | Debe ser `si` antes de enviar. |
| `aprobado_por` | texto o vacío | Responsable de la aprobación. |
| `fecha_aprobacion` | fecha ISO o vacío | Auditoría. |
| `fecha_envio` | fecha ISO o vacío | Inicio de métricas de postulación. |
| `estado_candidatura` | `borrador`, `aprobada`, `enviada`, `seguimiento_pendiente`, `respondida`, `entrevista`, `prueba`, `oferta`, `rechazada`, `retirada`, `cerrada_sin_respuesta` | Estado actual calculado o validado contra eventos. |
| `fecha_primera_respuesta` | fórmula o fecha ISO | Primer evento `respuesta` de esta candidatura. |
| `dias_hasta_primera_respuesta` | fórmula, número o vacío | `fecha_primera_respuesta - fecha_envio`; vacío si aún no hay respuesta. |
| `fecha_primera_entrevista` | fórmula o fecha ISO | Primer evento `entrevista_*` de esta candidatura. |
| `fecha_primera_entrevista_tecnica` | fórmula o fecha ISO | Primer evento `entrevista_tecnica` de esta candidatura. |
| `fecha_primera_prueba` | fórmula o fecha ISO | Primer evento `prueba` de esta candidatura. |
| `fecha_primera_oferta` | fórmula o fecha ISO | Primer evento `oferta` de esta candidatura. |
| `tiene_entrevista` | fórmula 0/1 | 1 si existe al menos un evento `entrevista_*`. |
| `tiene_entrevista_tecnica` | fórmula 0/1 | 1 si existe un evento `entrevista_tecnica`. |
| `tiene_prueba` | fórmula 0/1 | 1 si existe un evento `prueba`. |
| `tiene_oferta` | fórmula 0/1 | 1 si existe un evento `oferta`. |
| `proximo_seguimiento` | fecha ISO o vacío | Nunca programar si se pidió no contactar. |
| `resultado_cierre` | `sin_respuesta`, `rechazo`, `retirada`, `oferta_rechazada`, `oferta_aceptada`, `otro`, vacío | Resultado final. |
| `motivo_reintento` | texto o vacío | Obligatorio si `version_intento > 1`. |

**Reglas de integridad:**

- `fecha_envio` solo existe con `aprobacion_humana = si`, `aprobado_por` y `fecha_aprobacion` completos.
- `application_id` y `opportunity_id` deben existir antes de registrar un evento.
- Fórmulas de apoyo en `Candidaturas` (Google Sheets/Excel en español; sustituir `[@application_id]` por la celda de la fila si no se usan tablas):

```text
fecha_primera_respuesta = SI.ERROR(MIN.SI.CONJUNTO(Eventos!fecha_evento;Eventos!application_id;[@application_id];Eventos!tipo_evento;"respuesta");"")
dias_hasta_primera_respuesta = SI([@fecha_primera_respuesta]="";"";[@fecha_primera_respuesta]-[@fecha_envio])
fecha_primera_entrevista = SI.ERROR(MIN.SI.CONJUNTO(Eventos!fecha_evento;Eventos!application_id;[@application_id];Eventos!tipo_evento;"entrevista_*");"")
fecha_primera_entrevista_tecnica = SI.ERROR(MIN.SI.CONJUNTO(Eventos!fecha_evento;Eventos!application_id;[@application_id];Eventos!tipo_evento;"entrevista_tecnica");"")
fecha_primera_prueba = SI.ERROR(MIN.SI.CONJUNTO(Eventos!fecha_evento;Eventos!application_id;[@application_id];Eventos!tipo_evento;"prueba");"")
fecha_primera_oferta = SI.ERROR(MIN.SI.CONJUNTO(Eventos!fecha_evento;Eventos!application_id;[@application_id];Eventos!tipo_evento;"oferta");"")
tiene_entrevista = SI(CONTAR.SI.CONJUNTO(Eventos!application_id;[@application_id];Eventos!tipo_evento;"entrevista_*")>0;1;0)
tiene_entrevista_tecnica = SI(CONTAR.SI.CONJUNTO(Eventos!application_id;[@application_id];Eventos!tipo_evento;"entrevista_tecnica")>0;1;0)
tiene_prueba = SI(CONTAR.SI.CONJUNTO(Eventos!application_id;[@application_id];Eventos!tipo_evento;"prueba")>0;1;0)
tiene_oferta = SI(CONTAR.SI.CONJUNTO(Eventos!application_id;[@application_id];Eventos!tipo_evento;"oferta")>0;1;0)
```
- `estado_candidatura = enviada` no prueba respuesta; solo los eventos de tipo `respuesta`, `entrevista`, `prueba` u `oferta` lo hacen.

## Hoja `Eventos` — respuestas y selección

Una fila representa un hecho fechado. Un mismo proceso puede tener varias entrevistas o pruebas.

| Campo | Tipo / valores permitidos | Uso |
|---|---|---|
| `event_id` | texto, único | Clave primaria. |
| `application_id` | texto existente | Clave foránea a `Candidaturas`. |
| `fecha_evento` | fecha ISO | Fecha del hecho o recepción. |
| `tipo_evento` | `respuesta`, `entrevista_inicial`, `entrevista_tecnica`, `entrevista_final`, `prueba`, `oferta`, `rechazo`, `seguimiento`, `retiro`, `cierre_sin_respuesta` | Etapa observable. |
| `resultado_evento` | `positivo`, `negativo`, `pendiente`, `completado`, `aceptado`, `rechazado`, `no_aplica` | Resultado, si se conoce. |
| `siguiente_accion` | texto breve | Acción concreta y legítima. |
| `fecha_siguiente_accion` | fecha ISO o vacío | Control de seguimiento. |
| `detalle_no_sensible` | texto breve | Ej.: “llamada de 30 min confirmada”; sin transcripciones ni datos privados. |

**Prioridad de estado desde eventos:** `oferta` > `prueba` > `entrevista_final` > `entrevista_tecnica` > `entrevista_inicial` > `respuesta` > `rechazo`/`retiro`/`cierre_sin_respuesta`. Si el último evento es un cierre negativo, prevalece el cierre.

## Hoja `Tablero semanal` — métricas derivadas

El archivo `career/weekly-dashboard.csv` registra una fila cerrada por semana. Su clave es `semana_inicio` (lunes ISO). Las cifras se calculan desde `Capturas`, `Oportunidades`, `Candidaturas` y `Eventos` con fechas dentro de `[semana_inicio, semana_inicio + 6]`; no se estiman manualmente.

| Métrica | Fórmula explícita | Lectura |
|---|---|---|
| `oportunidades_capturadas` | `CONTAR.SI.CONJUNTO(Capturas!fecha_captura;">="&inicio;Capturas!fecha_captura;"<="&fin)` | Flujo bruto de entradas. |
| `oportunidades_unicas` | `CONTAR.SI.CONJUNTO(Oportunidades!fecha_captura;">="&inicio;Oportunidades!fecha_captura;"<="&fin)` | Vacantes canónicas tras deduplicar. |
| `duplicados_fusionados` | `CONTAR.SI.CONJUNTO(Capturas!fecha_captura;">="&inicio;Capturas!fecha_captura;"<="&fin;Capturas!resultado_dedupe;"fusionada")` | Entradas evitadas como trabajo duplicado. |
| `oportunidades_calificadas` | `CONTAR.SI.CONJUNTO(Oportunidades!fecha_revision;">="&inicio;Oportunidades!fecha_revision;"<="&fin;Oportunidades!filtro_obligatorio;"aprobado";Oportunidades!score_total;">=55")` | Oportunidades que merecen revisión o acción. |
| `aplicaciones_aprobadas` | `CONTAR.SI.CONJUNTO(Candidaturas!fecha_aprobacion;">="&inicio;Candidaturas!fecha_aprobacion;"<="&fin;Candidaturas!aprobacion_humana;"si")` | Control de aprobación humana. |
| `aplicaciones_enviadas` | `CONTAR.SI.CONJUNTO(Candidaturas!fecha_envio;">="&inicio;Candidaturas!fecha_envio;"<="&fin)` | Envios reales, no borradores. |
| `respuestas` | `CONTAR.SI.CONJUNTO(Candidaturas!fecha_primera_respuesta;">="&inicio;Candidaturas!fecha_primera_respuesta;"<="&fin)` | Candidaturas con respuesta; una candidatura cuenta una vez. |
| `entrevistas` | `SUMAR.SI.CONJUNTO(Candidaturas!tiene_entrevista;Candidaturas!fecha_primera_entrevista;">="&inicio;Candidaturas!fecha_primera_entrevista;"<="&fin)` | Candidaturas con al menos una entrevista; evita contar dos rondas como dos conversiones. |
| `entrevistas_tecnicas` | `SUMAR.SI.CONJUNTO(Candidaturas!tiene_entrevista_tecnica;Candidaturas!fecha_primera_entrevista_tecnica;">="&inicio;Candidaturas!fecha_primera_entrevista_tecnica;"<="&fin)` | Candidaturas que llegaron a entrevista técnica. |
| `pruebas` | `SUMAR.SI.CONJUNTO(Candidaturas!tiene_prueba;Candidaturas!fecha_primera_prueba;">="&inicio;Candidaturas!fecha_primera_prueba;"<="&fin)` | Candidaturas que llegaron a prueba. |
| `ofertas` | `SUMAR.SI.CONJUNTO(Candidaturas!tiene_oferta;Candidaturas!fecha_primera_oferta;">="&inicio;Candidaturas!fecha_primera_oferta;"<="&fin)` | Candidaturas con oferta recibida. |
| `mediana_dias_hasta_respuesta` | `MEDIANA(FILTRAR(Candidaturas!dias_hasta_primera_respuesta;Candidaturas!fecha_primera_respuesta>=inicio;Candidaturas!fecha_primera_respuesta<=fin))` | Velocidad típica de respuesta; mostrar `N/D` si no hay respuestas. |
| `tasa_calificacion` | `SI.ERROR(oportunidades_calificadas/oportunidades_unicas;0)` | Calidad de las oportunidades canónicas y targeting. |
| `tasa_envio` | `SI.ERROR(aplicaciones_enviadas/oportunidades_calificadas;0)` | Capacidad de conversión aprobada. |
| `tasa_respuesta` | `SI.ERROR(respuestas/aplicaciones_enviadas;0)` | Relevancia de targeting y mensaje. |
| `tasa_entrevista` | `SI.ERROR(entrevistas/aplicaciones_enviadas;0)` | Conversión a conversación. |
| `tasa_tecnica` | `SI.ERROR(entrevistas_tecnicas/entrevistas;0)` | Avance técnico. |
| `tasa_prueba` | `SI.ERROR(pruebas/entrevistas;0)` | Avance tras entrevistas. |
| `tasa_oferta` | `SI.ERROR(ofertas/aplicaciones_enviadas;0)` | Conversión final. |
| `seguimientos_vencidos` | `CONTAR.SI.CONJUNTO(Candidaturas!proximo_seguimiento;"<"&HOY();Candidaturas!proximo_seguimiento;"<>")` excluyendo estados de cierre | Riesgo operativo a resolver. |

> Las tasas se muestran como porcentaje con una decimal. Para evitar doble conteo, cada métrica de eventos cuenta `application_id` único cuando se analiza conversión acumulada; las cuentas semanales de actividad pueden contar eventos individuales.

## Línea base y revisión

- **Semana 0:** registrar ceros y el tiempo invertido. Es la línea base, no una falla.
- **Piloto:** 5–10 postulaciones de alta calidad por día, siempre con aprobación humana.
- **Viernes:** actualizar el tablero, revisar duplicados, seguimientos vencidos, motivos de descarte y tasas.
- **Cada 50 envíos:** modificar una sola variable (CV, targeting, mensaje o portfolio) y anotarla en `experimento_activo`; no atribuir mejoras a varias variables a la vez.
- Si se acumulan 50 aplicaciones calificadas sin entrevistas, pausar escalado y revisar CV, evidencia, targeting y mensaje antes de otros 50 envíos.
## Prueba reproducible — 10 capturas ficticias

Usar esta prueba antes de cargar datos reales. Todas las empresas, URLs y personas son ficticias; las URLs son identificadores de ejemplo, no enlaces operativos. Las 10 filas de `Capturas` generan 9 oportunidades canónicas porque `CAP-TST-010` se fusiona con `CAP-TST-001`.

### Capturas de prueba

| capture_id | fecha_captura | fuente | empresa | titulo_publicado | ubicacion_normalizada | clave_dedupe | resultado_dedupe | opportunity_id_canonica | capture_id_duplicada_de |
|---|---|---|---|---|---|---|---|---|---|
| CAP-TST-001 | 2026-09-28 | Bolsa A | Nube Ejemplo | AI Automation Engineer | remoto_latam | nubeejemplo\|aiautomationengineer\|remotolatam | nueva | OPP-TST-001 | |
| CAP-TST-002 | 2026-09-28 | Bolsa A | Flujo Ficticio | Automation Developer | remoto_colombia | flujoficticio\|automationdeveloper\|remotocolombia | nueva | OPP-TST-002 | |
| CAP-TST-003 | 2026-09-28 | Referido de prueba | Prisma Demo | Implementation Specialist | remoto_latam | prismademo\|implementationspecialist\|remotolatam | nueva | OPP-TST-003 | |
| CAP-TST-004 | 2026-09-28 | Bolsa B | Vector Ilustrativo | AI Integration Engineer | contractor_internacional | vectorilustrativo\|aiintegrationengineer\|contractorinternacional | nueva | OPP-TST-004 | |
| CAP-TST-005 | 2026-09-28 | Web de ejemplo | Cobre Sandbox | Automation Engineer | remoto_latam | cobresandbox\|automationengineer\|remotolatam | nueva | OPP-TST-005 | |
| CAP-TST-006 | 2026-09-28 | Bolsa B | Lumen Prueba | AI Developer | remoto_latam | lumenprueba\|aideveloper\|remotolatam | nueva | OPP-TST-006 | |
| CAP-TST-007 | 2026-09-28 | Web de ejemplo | Norte Simulado | Senior ML Researcher | presencial | nortesimulado\|seniormlresearcher\|presencial | nueva | OPP-TST-007 | |
| CAP-TST-008 | 2026-09-28 | Bolsa A | Delta Didáctica | Technical Implementation Specialist | remoto_colombia | deltadidactica\|technicalimplementationspecialist\|remotocolombia | nueva | OPP-TST-008 | |
| CAP-TST-009 | 2026-09-28 | Bolsa B | Atlas Muestra | AI Automation Specialist | contractor_internacional | atlasmuestra\|aiautomationspecialist\|contractorinternacional | nueva | OPP-TST-009 | |
| CAP-TST-010 | 2026-09-28 | Bolsa B | Nube Ejemplo | AI Automation Engineer | remoto_latam | nubeejemplo\|aiautomationengineer\|remotolatam | fusionada | OPP-TST-001 | CAP-TST-001 |

### Oportunidades, candidaturas y eventos de prueba

| opportunity_id | score_total | filtro_obligatorio | estado_oportunidad | resultado esperado |
|---|---:|---|---|---|
| OPP-TST-001 | 82 | aprobado | calificada | aplica |
| OPP-TST-002 | 76 | aprobado | calificada | aplica |
| OPP-TST-003 | 65 | aprobado | en_revision | aplica tras revisión |
| OPP-TST-004 | 72 | aprobado | calificada | aplica |
| OPP-TST-005 | 58 | aprobado | en_revision | no enviada en esta prueba |
| OPP-TST-006 | 48 | aprobado | descartada | no personalizar |
| OPP-TST-007 | 0 | fallido | descartada | no aplicar |
| OPP-TST-008 | 80 | aprobado | calificada | aplica |
| OPP-TST-009 | 61 | aprobado | en_revision | no enviada en esta prueba |

| application_id | opportunity_id | aprobacion_humana | fecha_envio | fecha_primera_respuesta | dias_hasta_primera_respuesta |
|---|---|---|---|---|---:|
| APP-TST-001 | OPP-TST-001 | si | 2026-09-29 | 2026-10-01 | 2 |
| APP-TST-002 | OPP-TST-002 | si | 2026-09-29 | 2026-10-02 | 3 |
| APP-TST-003 | OPP-TST-003 | si | 2026-09-29 | 2026-10-03 | 4 |
| APP-TST-004 | OPP-TST-004 | si | 2026-09-29 | | |
| APP-TST-005 | OPP-TST-008 | si | 2026-09-29 | | |

| event_id | application_id | fecha_evento | tipo_evento | resultado_evento |
|---|---|---|---|---|
| EVT-TST-001 | APP-TST-001 | 2026-10-01 | respuesta | positivo |
| EVT-TST-002 | APP-TST-001 | 2026-10-02 | entrevista_inicial | positivo |
| EVT-TST-003 | APP-TST-001 | 2026-10-03 | entrevista_tecnica | positivo |
| EVT-TST-004 | APP-TST-001 | 2026-10-04 | prueba | completado |
| EVT-TST-005 | APP-TST-001 | 2026-10-04 | oferta | pendiente |
| EVT-TST-006 | APP-TST-002 | 2026-10-02 | respuesta | negativo |
| EVT-TST-007 | APP-TST-003 | 2026-10-03 | respuesta | positivo |
| EVT-TST-008 | APP-TST-003 | 2026-10-04 | entrevista_inicial | positivo |

### Conciliación manual esperada

Para la semana `2026-09-28` a `2026-10-04`, comparar el tablero con esta aritmética antes de confiar en automatizaciones:

| Métrica | Cálculo manual | Resultado esperado |
|---|---|---:|
| Oportunidades capturadas | 10 filas `CAP-TST-*` | 10 |
| Duplicados fusionados | `CAP-TST-010` → `CAP-TST-001` | 1 |
| Oportunidades únicas | 10 − 1 | 9 |
| Oportunidades calificadas | OPP 001, 002, 003, 004, 005, 008, 009 | 7 |
| Aplicaciones aprobadas y enviadas | APP 001 a 005 | 5 |
| Respuestas | APP 001, 002 y 003 | 3 |
| Entrevistas | APP 001 y 003; la ronda técnica de APP 001 no duplica el proceso | 2 |
| Entrevistas técnicas | APP 001 | 1 |
| Pruebas | APP 001 | 1 |
| Ofertas | APP 001 | 1 |
| Mediana hasta primera respuesta | mediana(2, 3, 4) | 3 días |
| Tasa de calificación | 7 / 9 | 77.8 % |
| Tasa de envío | 5 / 7 | 71.4 % |
| Tasa de respuesta | 3 / 5 | 60.0 % |
| Tasa de entrevista | 2 / 5 | 40.0 % |
| Tasa técnica | 1 / 2 | 50.0 % |
| Tasa de prueba | 1 / 2 | 50.0 % |
| Tasa de oferta | 1 / 5 | 20.0 % |

Si cualquier resultado difiere, revisar primero la clave de deduplicación, después el vínculo `application_id` de los eventos y por último las fechas de corte. No corregir el tablero a mano.