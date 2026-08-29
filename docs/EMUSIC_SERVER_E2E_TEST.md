# Prueba E2E del servidor eMusic

`scripts/test_emusic_server.py` prueba el flujo real sin depender de Flutter:

1. obtiene o recibe un JWT de Joss Red;
2. valida capabilities del provider;
3. carga Home y sigue sus continuaciones;
4. busca `8 AM Nicki Nicole`;
5. abre el album vinculado y comprueba la pista equivalente;
6. solicita playback a eMusic;
7. descarga 512 KiB reales del stream y valida su tipo de contenido.

El script usa solamente la biblioteca estandar de Python. Lee `JOSSRED`,
`JOSSRED_API` y `EMUSICWEB` desde `.env`, pero no imprime ni persiste tokens o
contrasenas.

## Ejecucion interactiva

```powershell
python scripts\test_emusic_server.py --email usuario@ejemplo.com
```

La contrasena se solicita de forma oculta. Tambien puede utilizarse un JWT ya
emitido sin iniciar sesion nuevamente:

```powershell
$env:EMUSIC_JWT = "JWT_TEMPORAL"
python scripts\test_emusic_server.py
```

Para pasar el contexto tecnico de playback:

```powershell
$env:EMUSIC_CLIENT_IP = "IP_DEL_CLIENTE"
$env:EMUSIC_VISITOR_DATA = "VISITOR_DATA"
$env:EMUSIC_PO_TOKEN = "PO_TOKEN"
python scripts\test_emusic_server.py
```

`VISIONOS` sigue siendo el cliente principal del orquestador. La salida de la
prueba muestra `clientUsed` para saber si eMusic tuvo que usar IOS o ANDROID.
Un PO token se envia tanto en `X-YouTube-Po-Token` como en
`serviceIntegrityDimensions.poToken`; debe corresponder al cliente y al
contenido para el que fue generado.

Antes de solicitar el player, eMusic obtiene el contexto público de la página
del video y añade el `signatureTimestamp` y visitor data usados por el cliente
VISIONOS. Si la aplicación ya envió `visitorData`, se conserva ese valor. Este
paso replica la secuencia de `YoutubeApiClient.visionos` que utilizaba la app
antes de mover la resolución de streams al servidor.

La opcion `--play` reproduce la muestra con `ffplay` cuando esta herramienta
esta instalada. Sin esa opcion, la lectura HTTP real del stream sigue siendo
obligatoria y la prueba falla ante 401, 403, contenido no multimedia o una
muestra truncada.

## Interpretacion de errores

- `LOGIN_REQUIRED`: YouTube rechazo todos los clientes desde la IP de salida
  del servidor o falta un PO token compatible.
- `El stream devolvio HTTP 403`: la URL se resolvio, pero el GVS rechazo el
  contexto, IP o PO token.
- album sin pista equivalente: el browse ID no corresponde a la cancion. Se
  comparan primero IDs y despues titulo/artista porque YouTube puede asignar un
  video ID distinto al audio incluido en el album.
