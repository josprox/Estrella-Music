# Enlaces compartidos de canciones

## Contrato

Las URLs públicas son:

```text
https://emusic.joss.red/share/song/{sourceId}
https://emusic.joss.red/share/album/{sourceId}
https://emusic.joss.red/share/playlist/{sourceId}
https://emusic.joss.red/share/artist/{sourceId}
```

Los identificadores corresponden al `sourceId` del elemento musical en eMusic.

## Flujo

1. Android e iOS intentan abrir la URL HTTPS directamente en Estrella Music.
2. Para una canción, la app consulta sus datos y muestra acciones para
   reproducir, añadir a la cola o añadir a una playlist.
3. Para álbumes, playlists y artistas, la app abre directamente la pantalla
   correspondiente, como si el usuario hubiese seleccionado el elemento dentro
   de Estrella Music.
4. Si el sistema no entrega el enlace a la app, EMusic intenta el protocolo
   `estrellamusic://share/{tipo}/{sourceId}` para instalaciones de escritorio
   y como respaldo móvil.
5. Si la app no está instalada, la página cambia a la URL equivalente de
   un destino web compatible según el tipo compartido.

La redirección del servidor no compite con Android App Links ni con iOS
Universal Links: el sistema operativo decide si abre la app antes de solicitar
la página HTTP. El temporizador de la página solo es un respaldo para los
sistemas que utilizan el protocolo personalizado.

## Configuración de producción

### Android

`https://emusic.joss.red/.well-known/assetlinks.json` debe responder sin
redirecciones y contener:

- `package_name`: `com.josprox.emusic`
- La huella SHA-256 del certificado con el que se firma la versión publicada.

Para probar builds debug también debe registrarse el package y certificado de
debug correspondientes.

Prueba:

```powershell
adb shell am start -a android.intent.action.VIEW -d "https://emusic.joss.red/share/song/dQw4w9WgXcQ"
adb shell am start -a android.intent.action.VIEW -d "https://emusic.joss.red/share/album/OLAK5uy_example"
adb shell am start -a android.intent.action.VIEW -d "https://emusic.joss.red/share/playlist/PL_example"
adb shell am start -a android.intent.action.VIEW -d "https://emusic.joss.red/share/artist/UC_example"
```

### iOS

Configurar `APPLE_TEAM_ID` en el entorno de EMusic con el Team ID de la cuenta
Apple que firma `com.josprox.emusic`. El endpoint:

```text
https://emusic.joss.red/.well-known/apple-app-site-association
```

debe responder directamente con `application/json`, sin extensión y sin
redirecciones. Si `APPLE_TEAM_ID` está vacío, el documento se mantiene válido
pero no asocia ninguna aplicación.

La capacidad Associated Domains está declarada en
`ios/Runner/Runner.entitlements` como `applinks:emusic.joss.red`.

### Windows

El instalador Inno Setup registra el protocolo `estrellamusic`. Es necesario
reinstalar una compilación generada con el script actualizado para crear la
clave de registro. El runner reenvía enlaces nuevos a la instancia que ya esté
abierta.

Prueba:

```powershell
Start-Process "estrellamusic://share/song/dQw4w9WgXcQ"
Start-Process "estrellamusic://share/album/OLAK5uy_example"
Start-Process "estrellamusic://share/playlist/PL_example"
Start-Process "estrellamusic://share/artist/UC_example"
```

## Streaming en Flutter web

El navegador sí hace las solicitudes desde la IP del visitante, pero eso no
significa que pueda reutilizar de forma fiable el extractor nativo actual.
El upstream puede bloquear por CORS las solicitudes de resolución o del CDN; un
service worker tampoco puede saltarse CORS. Además, las URLs de audio firmadas
caducan y dependen de lógica interna del upstream que puede cambiar.

Arquitectura recomendada:

- EMusic conserva identificadores y metadata, no actúa como proxy del audio.
- Android, iOS y escritorio mantienen el resolvedor local actual.
- Flutter web usa un adaptador específico basado en el reproductor embebido
  oficial del proveedor/IFrame. La reproducción y el tráfico salen del navegador
  del usuario.
- La capa del player expone la misma interfaz (`play`, `pause`, `seek`,
  posición y estado), pero selecciona la implementación con `kIsWeb`.

Si se exige un reproductor de audio completamente personalizado en web, la
alternativa técnica sería resolver URLs en el cliente o servidor y reproducir
el CDN directamente. No es una base estable: sigue expuesta a CORS, URLs
expirables, cambios de firma y a las condiciones de uso del proveedor. Por eso el
IFrame es la opción segura para la primera versión web.
