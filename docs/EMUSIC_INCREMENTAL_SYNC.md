# EMusic incremental sync

Estado: implementado como flujo principal para mutaciones posteriores al
bootstrap cloud. El snapshot completo queda reservado para migracion inicial,
restauracion y compatibilidad con clientes antiguos.

## Autoridad y almacenamiento

- Joss Red autentica y emite el JWT.
- EMusic es la autoridad de los datos musicales en modo cloud.
- SQLite (`estrella_music.sqlite3`) conserva entidades, versiones, tombstones
  locales y la outbox durable.
- Hive se importa una sola vez dentro de una transaccion SQLite, se verifica y
  se retira conservando un ZIP de recuperacion.
- La UI, preferencias, caches y sincronizacion leen exclusivamente SQLite.

## Escritura online

1. La UI refleja el cambio de manera optimista.
2. SQLite guarda la entidad y su registro de outbox en una sola transaccion.
3. Flutter envia `POST /api/sync/changes`.
4. EMusic aplica el cambio a su tabla de dominio.
5. EMusic crea el registro versionado en `sync_change_log` y el tombstone en
   `music_record_versions` cuando es un delete.
6. La respuesta incluye `accepted_change_ids` y `server_version`.
7. Flutter elimina solamente los IDs confirmados de la outbox.

Si no hay conexion, los pasos 3-7 se reintentan. La UI y las descargas siguen
funcionando desde el almacenamiento local.

## Push

```http
POST /api/sync/changes
Authorization: Bearer <joss-red-jwt>
Content-Type: application/json
```

```json
{
  "device_id": "device-123",
  "changes": [
    {
      "client_change_id": "uuid",
      "entity_type": "favorite",
      "entity_id": "track-1",
      "operation": "upsert",
      "base_version": 18,
      "payload": {"videoId": "track-1", "title": "Song"}
    }
  ]
}
```

Respuesta:

```json
{
  "status": "success",
  "applied": 1,
  "accepted_change_ids": ["uuid"],
  "server_version": 19
}
```

Tipos aplicados actualmente:

- `favorite`
- `recent_play`
- `album`
- `artist`
- `playlist`
- `playlist_track`
- `setting`
- `download`

Los cambios rapidos sobre la misma entidad se compactan en SQLite. Por ejemplo,
like -> unlike antes de sincronizar produce un solo `delete`.

## Pull

```http
GET /api/sync/changes?since_version=19
Authorization: Bearer <joss-red-jwt>
```

Flutter aplica los cambios dentro de SQLite y notifica a las pantallas mediante
listeners del almacén local. No se limpian colecciones completas.

## Borrados

Un borrado se transmite con `operation=delete`. EMusic elimina la fila activa
de dominio y conserva el tombstone/version en `music_record_versions` y el
evento en `sync_change_log`. Otros dispositivos reciben ese delete mediante el
pull incremental.

`favorites: []` y otros arreglos vacios del endpoint snapshot de compatibilidad
ya no borran la coleccion remota. Ese endpoint hace upsert por identificador;
los borrados solo se expresan mediante tombstones incrementales.

## Migracion Hive -> SQLite

Al iniciar una version nueva:

1. Se crea el esquema SQLite con WAL, foreign keys y busy timeout.
2. Se respaldan y leen todas las cajas legacy: datos musicales, preferencias,
   cache, letras, sesion y colas.
3. Playlist y canciones se normalizan como entidades separadas.
4. Todo se inserta dentro de `BEGIN IMMEDIATE` / `COMMIT`.
5. Se valida conteo y checksum antes del commit.
6. Se guarda `legacy_hive_to_sqlite_v1=complete` y se eliminan los archivos
   originales solamente después de verificar SQLite.
7. Si algo falla, se ejecuta `ROLLBACK`; Hive y el backup permanecen intactos.

La dependencia `hive` existe durante la version de transicion exclusivamente
para ejecutar este importador. Ningun flujo normal lee o escribe Hive.

## Orden de despliegue

1. Desplegar EMusic con la aplicacion real de `/api/sync/changes`.
2. Verificar rutas y migraciones.
3. Publicar Flutter con SQLite/outbox.
4. Observar rechazos, reintentos y diferencias de version.
5. Retirar el snapshot cotidiano solo cuando no queden clientes antiguos.
