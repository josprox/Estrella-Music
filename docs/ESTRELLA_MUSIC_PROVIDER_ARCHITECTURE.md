# Estrella Music provider architecture

Estado: arquitectura principal desde 2026-08-25.

## 1. Auditoria del sistema anterior

### Reproduccion y resolucion de URLs

`MyAudioHandler` recibia un `MediaItem`, consultaba descargas/caches y, si no
existia un archivo local, llamaba a `getStreamInfo`. Esa funcion ejecutaba
`StreamProvider.fetch` mediante un extractor remoto. `Downloader` repetia la
misma resolucion. Por tanto, el player y las descargas conocian el identificador
remoto y la forma de obtener sus URLs.

EMusic ya incluia `OrchestratorService`, con una lista de clientes, fallback
VISIONOS/IOS y soporte historico para `clientIp`, `visitorData` y `poToken`.
Flutter no necesitaba conocer esos datos. La API publica del orquestador incluso
aceptaba valores proporcionados por el cliente.

### Catalogo, Home y busqueda

`MusicServices` era un cliente de catálogo remoto completo dentro de Flutter. Creaba
visitor IDs, cabeceras y contexto, enviaba solicitudes `browse`, `search`,
`next` y `player`, y delegaba parsing a `HomeService`, `SearchService`,
`ArtistService`, `PlaylistAlbumService`, `PodcastService` y `TrackService`.

Los controladores de Home, Search, Album, Artist, Playlist, Library y Player,
ademas de varios widgets y el manejador de enlaces, obtenian directamente
`MusicServices` mediante GetX. La UI dependia por tanto de un proveedor online
concreto y Home intentaba cargar red incluso cuando existian secciones locales.

### Caratulas y letras

Las caratulas procedian de URLs del catalogo, caches SQLite, thumbnails de
descargas o tags escritos al archivo. Las letras combinaban servicios online,
cache `lyrics` y el browse ID devuelto por el catalogo. No existia un contrato
que declarara si el origen activo soportaba artwork o lyrics.

### Biblioteca y estado

SQLite exponia cajas logicas compatibles con Hive:

- `LIBFAV`: favoritos.
- `LIBRP`: historial.
- `LibraryPlaylists` y cajas por playlist.
- `LibraryAlbums`, `LibraryArtists`.
- `SongsCache`, `SongDownloads`, `SongsUrlCache`.
- `homeScreenData`, `prevSessionData`, `AppPrefs`.

Los controllers GetX leian y escribian esas cajas globales. Las entidades solo
tenian IDs de origen como `videoId` o `browseId`; no identificaban proveedor ni
perfil, de modo que dos fuentes podian colisionar.

### Autenticacion y datos de cuenta

`AuthService` ya utilizaba correctamente Joss Red para login, registro,
refresh, perfil y logout. Joss Red tambien es propietario de backups, amigos y
cuenta. EMusic conservaba controladores web antiguos de auth, aunque su API
musical protegida ya utilizaba `auth_api` y `Auth::id()`.

`AuthGate` tenia una excepcion: una eleccion inicial permitia abrir `Home` sin
sesion en modo local. Esto contradecia el requisito de login global obligatorio.

### Sincronizacion

`SyncService` observaba las cajas musicales globales y decidia si enviar cambios
con `emusicDataMode == cloud`. La autorizacion dependia de un flag, no de perfil,
provider, capabilities y confianza. `CloudSyncManager` podia migrar la biblioteca
local completa al activar cloud. Las descargas ya estaban excluidas de snapshots
y outbox, una garantia que se conserva.

## 2. Arquitectura resultante

```text
Joss Red Authentication / Account
                 |
          Estrella Music
                 |
          ProfileManager
                 |
      MusicProviderManager
          /             \
 LocalMusicProvider   EMusicProvider
        |                  |
 local files          protected eMusic API
                           |
                 catalog / artwork / playback
```

La cuenta es global. El perfil es un contexto musical independiente. Un
provider implementa el origen musical. La UI consume `MusicCatalogService`, una
fachada neutral sobre el provider del perfil activo.

## 3. Contrato MusicProvider

`MusicProvider` expone operaciones tipadas para search, tracks, albums, artists,
artwork, lyrics y playback. Cada instancia se inicializa con
`MusicProviderContext`, que contiene `profileId` y settings del perfil.

`ProviderCapabilities` declara soporte real. Las pantallas y servicios consultan
capabilities; no comparan clases ni usan `isOnline` para seleccionar un origen.

Toda entidad utiliza `MusicIdentity`:

```text
providerId / profileId / sourceId
```

Su representación `namespacedId` es estable y evita colisiones entre providers
y entre dos perfiles del mismo provider.

## 4. LocalMusicProvider

El provider `estrella.local`:

- recorre las carpetas configuradas por el perfil;
- reconoce MP3, M4A, AAC, FLAC, OGG, OPUS, WAV y WEBM;
- lee titulo, artista, album, duracion, genero, año y track con `audiotags`;
- construye albums y artistas locales;
- usa artwork embebido o sidecars JPG/PNG;
- carga letras `.lrc` o `.txt` junto al audio;
- busca en titulo, artista y album;
- entrega un `PlaybackSource.localFile`.

No declara sync. Puede funcionar sin EMusic y sin red despues de que Joss Red
haya validado o restaurado la sesion global.

## 5. EMusicProvider y API eMusic

`joss.emusic` recibe el JWT mediante una dependencia privada creada solo para
este provider autorizado. Consume `/api/music/provider/*` y nunca expone el
token a providers comunitarios. El contexto técnico de playback (`clientIp`,
`visitorData`, `poToken`) se obtiene y transporta dentro de `EMusicProvider`;
no forma parte del contrato genérico ni llega a la UI.

EMusic publica capabilities, search, tracks, albums, artists, artwork y
playback. La biblioteca guardada se mantiene aislada por `Auth::id()`. El
endpoint protegido `GET /api/music/provider/library` entrega tracks, albums,
artists y playlists en un solo snapshot consistente. `EMusicProvider`
coalesce las lecturas simultaneas y conserva ese snapshot brevemente por
perfil; las vistas no deben volver a consultar endpoints separados durante el
mismo arranque.

catalogo de descubrimiento (Home, Quick Picks, sugerencias, busqueda,
continuaciones, albums, artistas y contenido relacionado) usa el contrato
opcional `MusicDiscoveryProvider`. `EMusicProvider` envia solamente las
operaciones permitidas `browse`, `search`, `next` y
`music/get_search_suggestions` a `POST /api/music/provider/catalog`; Flutter
da forma a la respuesta, pero no contacta directamente con el upstream.

La receta de resolucion se obtiene de `OrchestratorService` y se reutiliza por
una ventana corta. Las fuentes firmadas se cachean por perfil, track, formato y
proposito hasta poco antes de su expiracion. Este cache es local, persiste entre
reinicios en el namespace del perfil y nunca se sincroniza. Las solicitudes
concurrentes para la misma fuente comparten un unico Future. El endpoint acepta
`clientIp`, `visitorData` y `poToken` exclusivamente desde el provider
autorizado.

## 6. Playback

```text
MediaItem
   -> MusicCatalogService.resolvePlayback
   -> active MusicProvider.getPlayback
   -> PlaybackSource
   -> AudioHandler / just_audio
```

`PlaybackSource` distingue archivo local, stream autorizado, playback externo y
embebido. `AudioHandler` conserva cache y descargas locales, pero no resuelve
el upstream ni selecciona clientes. `Downloader` solo acepta un stream autorizado
devuelto por el provider; un archivo local no se vuelve a descargar. Los
workers transfieren audio directamente desde la fuente firmada y comparten una
sola consulta de receta al orquestador, por lo que la concurrencia no multiplica
peticiones a eMusic. Un archivo incompleto se conserva como `.part` y el
siguiente intento pide solamente el rango restante; si el origen ignora
`Range`, se reinicia esa transferencia de forma controlada para evitar
corrupcion.

## 7. Perfiles y persistencia

`ProfileManager` gestiona CRUD, perfil activo, persistencia, lifecycle y
fallback. `MusicProviderManager` gestiona registro, factories, instancias,
capabilities, trust y lifecycle de providers. La relacion es un provider a N
perfiles.

Siempre existe `local-default`. No se puede eliminar. `activeMusicProfileId` se
persiste globalmente. Un provider ausente o fallido deja el perfil y sus datos
intactos, lo marca no disponible y activa el fallback local durante startup.

Las cajas musicales se resuelven como:

```text
profiles__{profileId}__{logicalBoxName}
```

Esto aisla favoritos, playlists, historial, caches, letras, cola y sesion de
playback. Los perfiles locales y el estado global usan Hive. Los perfiles
eMusic y el outbox autorizado usan SQLite. `SongDownloads` se separa por
perfil, permanece siempre local y nunca entra en snapshots u outbox. Una copia
de compatibilidad SQLite -> Hive nunca elimina el origen.

Al cambiar de perfil se guarda la sesion de playback anterior, se detiene y
limpia la cola incompatible, se activa la instancia del nuevo provider, cambia
el namespace, restaura su sesion y refresca Home/biblioteca. No se requiere
reiniciar la app.

## 8. Autenticacion

El unico flujo de entrada es:

```text
Splash / updates -> restore Joss Red session -> Login/Register -> App
```

No existe acceso invitado ni eleccion "sin cuenta". Una sesion cacheada valida
permite uso offline. Logout borra tokens, cambia el observable de autenticacion
y `AuthGate` vuelve a `MusicAuthScreen`.

La autenticacion no activa sync. Un usuario autenticado puede mantener activo
un perfil local sin enviar datos musicales.

## 9. Sync y aislamiento de confianza

La autorizacion efectiva es:

```text
active Profile
  -> registered Provider instance
  -> capabilities.sync
  -> ProviderTrust.jossRedAuthorized
```

Solo entonces `SyncService.isCloudMode` es verdadero. El account key de SQLite
incluye cuenta y `profileId`; los flags de pending/last-sync tambien llevan
namespace de perfil. Las subscripciones a cajas se vuelven a enlazar al cambiar
de perfil.

`ProviderTrust.community` niega Joss Red sync aunque el provider anuncie
`sync=true`. El contrato generico no contiene AuthService, AccountService,
tokens, backups, amigos ni clientes internos.

La integracion directa con Piped fue retirada junto con sus pantallas de enlace
y sincronizacion. Si se recupera en el futuro debera hacerlo como un provider
comunitario registrado, con credenciales propias y sin acceso a Joss Red.

## 10. Ownership

- Joss Red: autenticacion, sesion, perfil de cuenta, backups generales, amigos,
  permisos y datos personales.
- EMusic: biblioteca cloud, catalogo eMusic, playlists publicas musicales,
  sync, co-listening y orquestacion de playback online.
- Flutter: perfiles, cache, biblioteca local, archivos, descargas, cola y
  reproduccion offline.
- Community provider: solo su instancia, settings y credenciales propias; sin
  acceso implicito a Joss Red.

## 11. Extender con un provider

1. Implementar `MusicProvider` con modelos neutrales.
2. Declarar capabilities reales.
3. Registrar una factory con ID estable y trust `community`, salvo decision
   explicita del propietario de Joss Red.
4. No importar servicios Joss Red en el provider.
5. No introducir branches por provider en widgets.
6. Añadir tests de mapping, errores, lifecycle y playback.

## 12. API protegida de eMusic

Las rutas `GET /api/music/provider/capabilities`, `library`, `search`, `tracks`, `albums`,
`artists`, `artwork/{id}`, `POST /api/music/provider/catalog` y
`POST /api/music/provider/playback` viven dentro de `auth_api`. Las rutas
antiguas del orquestador tambien quedaron protegidas. La app Flutter solo
consume el facade neutral; únicamente `EMusicProvider` puede enviar IP,
visitor data y PoToken a los endpoints protegidos.

EMusic es un repositorio Git anidado dentro del workspace Flutter. Sus cambios
se validan y versionan en ese repositorio, no en el indice Git del repositorio
raiz.

## 13. Trafico y capacidad

Sync usa WebSocket como senal de invalidacion y la outbox como disparador de
escrituras; no hace polling HTTP cuando no existen cambios. Home,
recomendaciones, biblioteca y fuentes firmadas tienen caches con scopes y TTL
explicitos. Los reintentos usan backoff con jitter y nunca se duplica de forma
inmediata una peticion de catalogo fallida.

El analisis de carga, las cifras antes/despues y los requisitos operativos para
10 000 usuarios estan documentados en `docs/EMUSIC_CAPACITY_10000.md`.
