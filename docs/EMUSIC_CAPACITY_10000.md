# eMusic: control de trafico para 10 000 usuarios

## Resultado de la auditoria

El cuello de botella no era solamente la descarga. La aplicacion generaba
trafico aun sin actividad del usuario:

- `SyncService` ejecutaba un ciclo cada 2 minutos. En una cuenta sin cambios
  hacia `status` y luego `changes`; con 10 000 clientes son aproximadamente
  167 solicitudes HTTP por segundo de carga base.
- El buzon de notificaciones de escritorio consultaba cada 15 segundos. Si los
  10 000 clientes fueran de escritorio serian aproximadamente 667 solicitudes
  por segundo.
- Cada reanudacion hacia un pull de notificaciones, un registro FCM y un pull de
  sync, aunque acabaran de ejecutarse.
- Los WebSocket reconectaban con los mismos tiempos exactos. Tras un despliegue
  todos los clientes podian reconectar a la vez.
- El catalogo repetia inmediatamente cualquier peticion fallida, incluyendo
  respuestas 502 causadas por saturacion.
- Home restauraba su cache, pero aun asi consultaba nuevamente la red y volvia
  a calcular recomendaciones.
- El pull incremental no tenia limite de filas y el push calculaba la siguiente
  version mediante una consulta por cada cambio.

## Politica implementada

- Sync es dirigido por eventos. El WebSocket anuncia cambios remotos y la
  outbox local dispara pushes. Ya no existe un pull periodico cada 2 minutos.
- Al autenticarse o recuperarse el WebSocket se ejecuta un pull incremental,
  necesario para cubrir eventos perdidos mientras no habia conexion.
- La reanudacion de la app solo consulta sync si no hubo intento o sync exitoso
  durante los ultimos 15 minutos.
- No se hace una peticion `status` antes de pull/push. La operacion necesaria es
  tambien la prueba de conectividad.
- Los reintentos de push y WebSocket tienen backoff con jitter. Esto distribuye
  las reconexiones despues de una caida.
- FCM solo vuelve a registrar el dispositivo cuando cambia token, permiso o
  cuenta, o como renovacion semanal.
- En movil el buzon durable se verifica al iniciar y como maximo cada 6 horas
  al reanudar; la entrega normal usa FCM.
- El fallback de escritorio consulta con un intervalo aleatorio de 10 a 20
  minutos y se detiene en background. Para tiempo real debe reemplazarse por un
  canal push de Joss Red.
- Home y sus recomendaciones se persisten durante 30 minutos. Pull-to-refresh
  y cambio de perfil siguen forzando una actualizacion explicita.
- Una peticion fallida de catalogo no se duplica automaticamente.
- Los cambios de sync se entregan en paginas de 500 y el cliente las aplica por
  pagina. Un batch de push obtiene una sola vez su version inicial.
- La biblioteca se solicita como un snapshot unico. No se conserva una copia
  grande por usuario en el `Cache` nativo de Joss, cuyo vencimiento es lazy.
- Playback y descarga conservan su URL firmada por perfil, pista, formato y
  proposito hasta poco antes de expirar. El servidor solo vuelve a intervenir
  cuando la URL expira o el origen responde 401/403/410.

En estado estable, sync pasa de unas 167 solicitudes HTTP por segundo a cero
polling HTTP. Permanecen los frames ping del WebSocket (aproximadamente 222 por
segundo con 10 000 conexiones y un intervalo de 45 segundos), que son mucho mas
pequenos y no consultan la base de datos. El fallback de notificaciones de
escritorio baja a unas 11 solicitudes por segundo si los 10 000 clientes estan
activos, distribuidas mediante jitter.

## Requisitos antes de afirmar capacidad para 10 000 usuarios

Estos cambios evitan la tormenta creada por la aplicacion, pero no sustituyen
una prueba de carga. Antes de produccion se requiere:

1. Probar rampas de 100, 1 000, 5 000 y 10 000 conexiones, separando HTTP,
   WebSocket, catalogo, resolucion de playback y sync.
2. Crear y verificar indices de base de datos, como minimo para:
   `sync_change_log(user_id, sync_version)`,
   `sync_change_log(user_id, client_change_id)`,
   `music_record_versions(user_id, entity_type, entity_id)` y las identidades
   `(user_id, *_id)` de favoritos, recientes, albums, artistas y playlists.
3. Configurar rate limits distintos por endpoint en el proxy. Catalogo y
   resolucion necesitan limites por usuario y por IP, respuesta 429 con
   `Retry-After`, limite de concurrencia y circuit breaker hacia el upstream.
4. Ejecutar varias instancias de eMusic detras de un balanceador. WebSocket,
   pub/sub, sesiones, locks y cualquier cache compartida deben residir en
   Redis u otro servicio comun; el `Cache` en proceso no coordina replicas.
5. Mantener el audio y artwork fuera del proceso Joss. Las URLs firmadas deben
   ir del cliente al origen/CDN; el backend no debe transportar los bytes.
6. Medir por endpoint RPS, latencia p50/p95/p99, errores, requests activas,
   conexiones WebSocket, consultas SQL, memoria, CPU y llamadas al upstream.
7. Aplicar limites de tamano y paginacion a toda lista; trabajos pesados deben
   ir a colas con idempotencia, no permanecer dentro de una solicitud HTTP.

El WebSocket debe comunicar invalidaciones o cambios pequenos. No conviene
enviar por el socket todo Home o el catalogo: esos datos siguen siendo HTTP,
cacheables y paginados. Esta separacion evita conexiones gigantes y facilita
CDN, ETag y cache compartida en una fase posterior.
