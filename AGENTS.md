# AGENTS.md

Guia operativa para agentes y desarrolladores que trabajen en Estrella Music / EMusic.

## Jerarquia real del proyecto

Este repositorio combina tres piezas que no deben confundirse:

1. **Flutter en la raiz**: es la app principal por defecto y la experiencia real del usuario.
2. **Joss Red / JosSecurity**: es el servicio principal de identidad, cuenta, backups, amigos y permisos.
3. **`EMusic/`**: es un backend Joss secundario, especializado en sincronizacion musical/cloud.

La migracion tipo Spotify debe respetar esa separacion. EMusic no reemplaza a Joss Red; lo complementa.

## Servicio principal: Joss Red

La fuente principal de usuarios, autenticacion, sesiones, tokens, perfil, backups, amigos y permisos vive en:

```text
C:\Users\joss\Documents\proyectos\Joss-language\ejemplos\Joss-Red-JosSecurity
```

Antes de tocar auth, usuarios, perfiles, backups, amigos, middleware o permisos, revisar ese proyecto.

Joss Red ya contiene:

- Registro e inicio de sesion.
- Verificacion de cuenta.
- Recuperacion y reseteo de contrasena.
- Perfil, actualizacion de perfil y password.
- Refresh/logout/delete de cuenta.
- Middleware JWT `auth_api`.
- Backups ligados a `user_token`.
- `friendships`, solicitudes, bloqueos y busqueda de usuarios.
- Rutas de soporte, apps, middleware system y servicios compartidos.
- Proxy actual de Estrella Music para audio Flask.

## Rol de EMusic

`EMusic/` debe tratarse como un servicio secundario del dominio musical.

Responsabilidades correctas de EMusic:

- Biblioteca musical cloud.
- Playlists del usuario.
- Favoritos.
- Historial de reproduccion.
- Albums y artistas guardados.
- Settings musicales.
- Descargas autorizadas y metadata de offline.
- Estado de sincronizacion.
- Cola/cambios pendientes sincronizables.
- Playlists publicas del dominio musical.
- Co-listening y funciones musicales especializadas.
- Migracion legacy de datos musicales cuando aplique.

EMusic no debe:

- Registrar usuarios.
- Iniciar sesion.
- Refrescar tokens.
- Borrar cuentas.
- Administrar perfiles.
- Duplicar endpoints de amigos.
- Duplicar endpoints de backups generales.

EMusic debe recibir el JWT emitido por Joss Red y usar `Auth::id()` / `Auth::user()` solo como identidad ya autenticada.

## App Flutter

La app Flutter de la raiz es la app por defecto. Cualquier cambio debe preservar el modo local actual.

Flujo esperado:

1. Flutter puede operar en modo local sin cuenta.
2. Si el usuario elige cloud, Flutter autentica contra Joss Red.
3. Flutter guarda el JWT/token.
4. Flutter llama a EMusic solo para endpoints musicales protegidos.
5. EMusic aisla datos por `Auth::id()`.
6. Si no hay conexion, Flutter mantiene cache/offline y cola de cambios.
7. Al volver internet, Flutter sincroniza con EMusic.

## Migration target: modo Spotify

Objetivo del modo cloud:

- Joss Red = identidad y cuenta.
- EMusic = fuente principal musical en servidor.
- Flutter = cache inteligente, reproductor local y experiencia offline.

El usuario debe poder elegir:

- "Mantener mis datos solo en este dispositivo".
- "Migrar a Joss Red y sincronizar mi musica".

Reglas de migracion:

- Nunca borrar Hive/local antes de validar backup y subida.
- Crear respaldo local antes de migrar.
- Subir por lotes.
- Validar conteos y checksums/versions.
- Activar cloud solo despues de confirmar integridad.
- Mantener descargas offline como archivos locales; el servidor guarda autorizacion/metadata, no rutas locales absolutas.

## Endpoints que NO deben duplicarse en EMusic

Estos pertenecen a Joss Red:

- `/api/register`
- `/api/login`
- `/api/password/email`
- `/api/password/reset`
- `/api/profile`
- `/api/profile/update`
- `/api/profile/password`
- `/api/refresh`
- `/api/logout`
- `/api/delete`
- `/api/friends`
- `/api/friends/*`
- `/api/backup/*`
- `/api/listfiles`

## Endpoints actuales esperados en EMusic

EMusic debe enfocarse en rutas de musica:

- `/api/sync/pull`
- `/api/sync/push`
- `/api/sync/status`
- `/api/sync/push-collaborative`
- `/api/playlists/public`
- `/api/co-listening-ws`

Endpoints a agregar para iniciar migracion Spotify:

- `POST /api/music/migration/start`
- `POST /api/music/migration/chunk`
- `POST /api/music/migration/complete`
- `POST /api/music/migration/cancel`
- `GET /api/music/migration/status`
- `POST /api/sync/changes`
- `GET /api/sync/changes?since_version=...`
- `POST /api/sync/resolve-conflict`
- `POST /api/devices/link`
- `GET /api/devices`
- `POST /api/downloads/authorize`
- `GET /api/downloads`

Si se necesita una ruta social o de cuenta, primero revisar si ya existe en Joss Red.

## Joss actual

El lenguaje Joss cambio desde que se creo EMusic. No usar APIs obsoletas sin verificar.

Notas confirmadas:

- `GranMySQL` ya no debe usarse en codigo nuevo de EMusic.
- Usar `GranDB`.
- El CLI actual incluye `joss make:controller`, `joss make:model`, `joss make:migration`, `joss migrate`, `joss server start` y `joss help`.
- Joss carga recursivamente archivos `.joss` dentro de `app/`, por lo que `app/services/*.joss` es valido.
- El CSS de EMusic se genera desde `assets/css/app.scss`; no editar `public/css/app.css` manualmente porque hotreload lo reemplaza.
- El compilador SCSS de Joss no soporta bien anidacion Sass compleja; preferir CSS plano con variables SCSS.

## Antes de modificar

1. Revisar codigo real, no asumir desde README.
2. Revisar Joss Red si el cambio toca usuarios, auth, backups, amigos o permisos.
3. Revisar Flutter si el cambio toca UX, modo local/offline o sincronizacion.
4. Mantener EMusic como servicio secundario.
5. No romper el modo local actual de Flutter.
6. No duplicar responsabilidades de Joss Red.
7. Documentar cambios de API y migraciones.
8. Validar con `joss server start` cuando se toque Joss/SCSS.

## Entrega de traducciones

- Cada vez que se agregue, modifique o elimine una traduccion, se debe entregar tambien un archivo JSON con las claves afectadas y sus valores en espanol, para que el programador pueda realizar la traduccion masiva al resto de idiomas.
- El JSON debe contener solo los cambios de traduccion de la entrega actual, conservar exactamente las mismas claves usadas por la aplicacion y ser un JSON valido en UTF-8.
- Guardar el archivo dentro de `docs/translations/` con un nombre descriptivo terminado en `_es.json`.

## Herramientas de desarrollo
- Utilizar siempre que sea posible el servidor `dart-mcp-server` (e.g. `analyze_files`, `pub`, `lsp`, `dtd`) para consultas, análisis estático y ayuda con el código Dart/Flutter.


