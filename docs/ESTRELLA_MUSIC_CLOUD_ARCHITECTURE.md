# Estrella Music / EMusic Cloud Architecture

Fecha de actualizacion: 2026-07-09

Este documento define la arquitectura para iniciar la migracion de Estrella Music hacia un modelo tipo Spotify, manteniendo compatibilidad con el modo local actual.

## 1. Decision principal

Estrella Music debe operar con dos modos:

- **Modo local**: SQLite local es la fuente de verdad. No requiere cuenta.
- **Modo cloud**: Joss Red autentica al usuario, EMusic guarda la biblioteca musical en servidor y Flutter funciona como cache inteligente/offline.

La regla central es:

```text
Joss Red = identidad, cuenta, perfil, backups generales, amigos y permisos.
EMusic = datos musicales cloud y sincronizacion.
Flutter = app principal, cache local, reproduccion y experiencia offline.
```

## 2. Proyectos involucrados

### Flutter

Ruta:

```text
C:\Users\joss\Documents\proyectos\Estrella-Music-v2
```

Es la app principal por defecto. Usa SQLite para biblioteca, favoritos,
historial, playlists, downloads, settings, cache y estado de sincronizacion.

### EMusic

Ruta:

```text
C:\Users\joss\Documents\proyectos\Estrella-Music-v2\EMusic
```

Es un backend Joss secundario. Debe enfocarse en el dominio musical. No debe duplicar login ni perfil.

### Joss Red / JosSecurity

Ruta:

```text
C:\Users\joss\Documents\proyectos\Joss-language\ejemplos\Joss-Red-JosSecurity
```

Es el servicio principal del ecosistema. Ya contiene auth, JWT, perfil, backups, amigos, apps, middleware system y servicios compartidos.

## 3. Estado actual de EMusic

EMusic ya expone rutas musicales protegidas:

- `GET /api/sync/pull`
- `POST /api/sync/push`
- `GET /api/sync/status`
- `POST /api/sync/push-collaborative`
- `GET /api/playlists/public`
- `WS /api/co-listening-ws`

EMusic ya no debe exponer auth propia. Las rutas de login/register/profile/logout/refresh/delete pertenecen a Joss Red.

Componentes actuales:

- `api.joss`: rutas musicales protegidas con `auth_api`.
- `SyncController.joss`: endpoints de sync.
- `SocialController.joss`: playlists publicas musicales.
- `SyncDataService.joss`: persistencia/formateo de snapshots.
- `LegacyMigrationService.joss`: migracion de backups musicales antiguos.
- Modelos cloud: `UserPlaylist`, `UserSetting`, `UserDownload`, `SyncChangeLog`, `LinkedDevice`.
- ORM actual: `GranDB`.

## 4. Estado actual de Flutter

La app usa SQLite como fuente local. Los nombres historicos de las colecciones
se conservan como nombres logicos dentro de `local_store_entries`.

Cajas/datos relevantes:

- `AppPrefs`: settings, tema, idioma, calidad, visitor id, flags de sync.
- `LIBFAV`: favoritos.
- `LIBRP`: historial.
- `LibraryPlaylists`: metadata de playlists.
- Cajas por `playlistId`: tracks de cada playlist.
- `LibraryAlbums`, `LibraryArtists`.
- `SongDownloads`, `SongsCache`, `SongsUrlCache`.
- `homeScreenData`, `prevSessionData`.

Las mutaciones pasan por `SqliteStore` y la capa de sincronizacion observa sus
eventos para crear cambios incrementales durables.

## 5. Modelo objetivo tipo Spotify

### Modo local

- No requiere login.
- SQLite es fuente de verdad.
- La app funciona como ahora.
- No hay push/pull automatico.
- El usuario puede cambiar a cloud despues.

### Modo cloud

- Joss Red emite JWT.
- Flutter envia el JWT a EMusic.
- EMusic es fuente principal de biblioteca musical.
- Flutter conserva cache local para performance/offline.
- Descargas son locales; EMusic guarda autorizacion, estado y metadata.
- Cambios offline se guardan en una cola durable.
- Al volver internet, Flutter hace push de cambios pendientes y pull incremental.

## 6. Flujo de usuario para migracion

1. Pantalla de eleccion:
   - "Mantener mis datos solo en este dispositivo".
   - "Migrar a Joss Red y sincronizar mi musica".
2. Explicacion clara:
   - Local = solo este dispositivo.
   - Cloud = biblioteca sincronizada con Joss Red/EMusic.
3. Si elige cloud, verificar sesion con Joss Red.
4. Crear respaldo local `.hmb`.
5. Analizar datos locales:
   - playlists
   - favoritos
   - historial
   - albums
   - artistas
   - settings
   - descargas
6. Crear sesion de migracion en EMusic.
7. Subir datos por chunks.
8. Validar conteos/checksums/versiones.
9. Activar `emusicDataMode=cloud`.
10. Ejecutar pull inicial.
11. Mantener modo offline con cache y descargas.
12. Si falla, conservar backup y volver a modo local.

Mensajes recomendados:

- "Tus datos pueden quedarse solo en este dispositivo o sincronizarse con Joss Red."
- "Creando un respaldo local antes de migrar."
- "Revisando tu biblioteca para evitar duplicados."
- "Subiendo playlists, favoritos e historial."
- "Verificando que todo este completo en EMusic Cloud."
- "Modo cloud activado. Este dispositivo funcionara como cache inteligente."
- "Sin conexion. Puedes escuchar tus descargas; sincronizaremos cambios despues."
- "No se perdieron datos. Conservamos tu respaldo local y puedes reintentar."

## 7. API objetivo de EMusic

### Actual

```text
GET  /api/sync/pull
POST /api/sync/push
GET  /api/sync/status
POST /api/sync/push-collaborative
GET  /api/playlists/public
WS   /api/co-listening-ws
```

### Primera migracion Spotify

```text
POST /api/music/migration/start
POST /api/music/migration/chunk
POST /api/music/migration/complete
POST /api/music/migration/cancel
GET  /api/music/migration/status
```

### Sync incremental

```text
POST /api/sync/changes
GET  /api/sync/changes?since_version=...
POST /api/sync/resolve-conflict
GET  /api/sync/logs
```

### Dispositivos y offline

```text
POST   /api/devices/link
GET    /api/devices
DELETE /api/devices/{id}
POST   /api/downloads/authorize
GET    /api/downloads
POST   /api/downloads/revoke
```

## 8. Tablas necesarias en EMusic

Mantener o crear:

- `user_playlists`
- `user_favorites`
- `user_recent_plays`
- `user_albums`
- `user_artists`
- `user_settings`
- `user_downloads`
- `linked_devices`
- `sync_change_log`
- `user_legacy_migrations`

Agregar para migracion robusta:

- `music_migrations`
  - `id`
  - `user_id`
  - `device_id`
  - `status`
  - `started_at`
  - `completed_at`
  - `error_message`
  - `local_backup_hash`
  - `expected_counts_json`
  - `received_counts_json`
- `pending_sync_batches`
  - `id`
  - `user_id`
  - `device_id`
  - `batch_id`
  - `status`
  - `payload_hash`
  - `created_at`
- `music_record_versions`
  - `id`
  - `user_id`
  - `entity_type`
  - `entity_id`
  - `version`
  - `updated_at`
  - `deleted_at`

## 9. Contrato de datos recomendado

Cada entidad sincronizable debe tener:

- `entity_type`
- `entity_id`
- `user_id`
- `device_id`
- `version`
- `updated_at`
- `deleted`
- `payload`
- `payload_hash`

Tipos iniciales:

- `playlist`
- `playlist_track`
- `favorite`
- `recent_play`
- `album`
- `artist`
- `setting`
- `download_authorization`

## 10. Conflictos

Reglas iniciales:

- Settings: last-write-wins por clave.
- Favoritos: merge por `track_id`; delete gana si es mas reciente.
- Historial: append/merge por `track_id` + timestamp.
- Playlists: version por playlist; si hay cambios simultaneos, crear conflicto resoluble.
- Descargas: servidor autoriza; dispositivo decide archivo/ruta local.

No borrar registros inmediatamente. Usar tombstones (`deleted_at`) para que otros dispositivos puedan sincronizar eliminaciones.

## 11. Integracion Flutter

Capas a crear o reforzar:

- `SqliteStore`: preferencias, cache y colecciones locales compatibles.
- `MusicSqliteService`: entidades musicales normalizadas, versiones y outbox.
- `CloudMusicApi`: cliente HTTP hacia EMusic.
- `JossRedAuthApi`: cliente HTTP hacia Joss Red.
- `SyncCoordinator`: decide push/pull/retry.
- `PendingChangeQueue`: cola durable de cambios offline.
- `MigrationCoordinator`: backup, analisis, chunks, validacion.
- `DownloadEntitlementService`: autorizaciones de descarga.

Flags/local prefs:

- `emusicDataMode`: `local` o `cloud`.
- `cloudMigrationStatus`.
- `lastSyncVersion`.
- `lastSuccessfulSyncAt`.
- `hasPendingSync`.
- `linkedDeviceId`.

UI necesaria:

- Pantalla de eleccion local/cloud.
- Pantalla de login Joss Red si elige cloud.
- Pantalla de backup previo.
- Progreso de migracion.
- Estado de sync en settings/biblioteca.
- Indicador offline.
- Boton reintentar sync.
- Pantalla/log simple de errores de migracion.

## 12. Plan de implementacion

### Etapa 1: Preparar contratos

- Documentar payloads.
- Agregar migraciones EMusic para `music_migrations`, batches y versions.
- Agregar endpoints de migracion.
- No cambiar el modo local.

### Etapa 2: Migracion inicial por snapshot

- Flutter crea backup local.
- Flutter calcula conteos.
- Flutter sube chunks.
- EMusic valida conteos.
- Flutter activa modo cloud despues de confirmacion.

### Etapa 3: Sync basica

- Push de playlists, favoritos, historial, settings.
- Pull despues del push.
- Indicadores de pendiente/sin conexion.

### Etapa 4: Cola offline

- Crear `PendingSyncChange`.
- Encolar mutaciones locales.
- Reintentar con backoff.
- Persistir estado de cada cambio.

### Etapa 5: Incremental y conflictos

- Versionar registros.
- Pull por `since_version`.
- Tombstones.
- Resolver conflictos de playlists.

### Etapa 6: Dispositivos y descargas

- Vincular dispositivo.
- Autorizar descargas.
- Mostrar dispositivos vinculados.
- Revocar autorizaciones.

### Etapa 7: Produccion

- Rotar secretos.
- Quitar secretos reales de repo.
- CORS por dominios.
- Rate limiting.
- Validar ownership en cada endpoint.
- Logs sin tokens ni payloads completos.
- Observabilidad de sync/migracion.

## 13. Comandos utiles

Joss Red:

```bash
cd C:\Users\joss\Documents\proyectos\Joss-language\ejemplos\Joss-Red-JosSecurity
joss server start
```

EMusic:

```bash
cd C:\Users\joss\Documents\proyectos\Estrella-Music-v2\EMusic
joss migrate
joss server start
```

Flutter:

```bash
cd C:\Users\joss\Documents\proyectos\Estrella-Music-v2
flutter pub get
flutter analyze
flutter test
flutter run
```

## 14. Riesgos

- Duplicar auth en EMusic: evitar; Joss Red es autoridad.
- Perdida de datos por snapshot completo: backup local y validacion previa.
- Sobrescritura multi-dispositivo: versiones y tombstones.
- Descargas no portables: guardar solo metadata/autorizacion cloud.
- Mutaciones fuera de repositorios: terminar de centralizarlas progresivamente.
- Secretos en repos: rotar y sacar de versionado.
- Migraciones pesadas en request: mover a jobs o proceso controlado.

## 15. Criterio para empezar

La primera implementacion debe enfocarse en:

1. No romper modo local.
2. Usar login/token de Joss Red.
3. Crear migracion inicial segura hacia EMusic.
4. Sincronizar playlists, favoritos, historial y settings.
5. Dejar descargas como offline local con autorizacion cloud.

## 16. Garantias de consistencia del snapshot de compatibilidad

Mientras termina la adopcion de `/api/sync/changes`, el endpoint de snapshot
`POST /api/sync/push` debe cumplir estas reglas obligatorias:

- Cada push captura los IDs de cola pendientes al iniciar. Solo esos IDs pueden
  confirmarse cuando responde el servidor.
- Una mutacion creada durante un push conserva `hasPendingSync=true` y provoca
  otro push; una respuesta anterior nunca puede limpiar cambios posteriores.
- Un pull no puede aplicarse mientras haya cambios pendientes ni mientras una
  mutacion local este escribiendo en SQLite.
- Favoritos y canciones de playlists se registran en SQLite/outbox dentro de la
  misma seccion critica y notifican a la UI mediante listeners SQLite.
- El endpoint snapshot heredado hace merge/upsert por identificador. Un arreglo
  vacio nunca borra una coleccion remota; los deletes usan tombstones.
- EMusic responde a HTTP y WebSocket con `summary`, incluyendo los conteos
  persistidos de `playlists`, `favorites`, `recent_plays`, `albums`, `artists` y
  `downloads`.
- Flutter solo confirma el lote si cada conteo de `summary` coincide con el
  snapshot enviado. Una respuesta sin resumen o con conteos distintos queda
  pendiente para reintento.

Estas garantias evitan perdida de likes o canciones durante la etapa de
compatibilidad. El objetivo definitivo sigue siendo el contrato incremental de
las secciones 9 y 12, con cambios por entidad, versiones y tombstones.

## 17. Implementacion incremental y SQLite

Desde 2026-07-12 el flujo principal posterior al bootstrap usa:

- `MusicSqliteService` con entidades normalizadas, versiones y outbox durable.
- Migracion transaccional `legacy_hive_to_sqlite_v1`, con backup, conteo y
  checksum antes de retirar los archivos Hive.
- Compactacion de mutaciones repetidas por entidad.
- `POST /api/sync/changes` con confirmacion explicita de `change_id`.
- `GET /api/sync/changes?since_version=...` para pull incremental.
- Aplicacion real de favoritos, playlists, canciones, historial, albums,
  artistas, settings y descargas en EMusic.
- Tombstones/versiones en `music_record_versions` y eventos en
  `sync_change_log`.

El snapshot completo se conserva para bootstrap, migracion, restauracion y
clientes antiguos. Su push de compatibilidad es no destructivo y no debe
utilizarse para cada like o cambio de playlist.

Contrato y operacion: `docs/EMUSIC_INCREMENTAL_SYNC.md`.

## 18. Corte definitivo del almacenamiento local

Desde 2026-07-12 ningun controller, widget o servicio de ejecucion normal usa
Hive. `SqliteStore` implementa las colecciones locales sobre
`estrella_local.sqlite3`; `MusicSqliteService` mantiene el modelo musical
normalizado y la outbox en `estrella_music.sqlite3`.

En una instalacion actualizada:

1. Si SQLite ya tiene `legacy_hive_to_sqlite_v1`, la app abre SQLite sin cargar
   Hive.
2. Si el marcador no existe y hay archivos `.hive`, se crea un ZIP local de
   recuperacion.
3. Se importan claves y valores dentro de `BEGIN IMMEDIATE`.
4. Se comparan conteo y checksum leyendo nuevamente desde SQLite.
5. Solo despues del `COMMIT` se eliminan los `.hive` y locks originales.
6. El backup legacy permanece en `legacy_hive_backups`.

La dependencia `hive` queda temporalmente solo para leer instalaciones antiguas.
`hive_flutter` ya no forma parte de la app. Cuando la version de transicion haya
cumplido su ventana de soporte, el importador y la dependencia restante pueden
retirarse.

## 19. WebSocket y tiempo real

Desde Joss 3.6.3, EMusic usa callbacks con contexto lexico, `onClose` y canales
nativos con limpieza automatica.

### Sincronizacion

1. Flutter abre `/api/sync-ws`.
2. Envia `auth` con JWT de Joss Red y `device_id`.
3. EMusic suscribe la conexion al canal privado del usuario.
4. Los cambios HTTP o WebSocket publican `sync_update` con
   `origin_device_id`.
5. El dispositivo de origen ignora su propio aviso; los demas ejecutan pull.

El push snapshot por WebSocket conserva el contrato no destructivo: hace
merge/upsert y nunca borra una coleccion porque el arreglo recibido este vacio.

### Co-listening

- Cada conexion tiene un canal directo y cada sala un canal compartido.
- `onClose` elimina al invitado o cierra la sala si se desconecta el host.
- Los clientes reciben `guest_left`, `room_closed`, `left_room` y `sync_ack`
  ademas de los eventos historicos.
- `CO_LISTENING_REQUIRE_AUTH=true` exige JWT de Joss Red. Si no se define, el
  servidor conserva temporalmente el modo anonimo para clientes antiguos.

### Operacion

```env
WS_MAX_MESSAGE_BYTES="8388608"
WS_IDLE_TIMEOUT_SECONDS="120"
WS_PING_INTERVAL_SECONDS="30"
CO_LISTENING_REQUIRE_AUTH="true"
```

El runtime envia ping, renueva el deadline con pong, limita mensajes y aisla
panicos de callbacks. Los canales son locales al proceso: usar una sola replica
para co-listening, o sticky sessions junto con un backplane pub/sub externo.
