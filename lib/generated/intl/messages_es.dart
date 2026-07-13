// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m6(count) => "Álbumes: ${count}";

  static String m7(count) => "Artistas: ${count}";

  static String m8(count) => "Favoritos: ${count}";

  static String m9(count) => "Playlists: ${count}";

  static String m10(count) => "Canciones: ${count}";

  static String m11(source) => "Migración completada desde ${source}.";

  static String m0(error) => "Ocurrió un error al regenerar: ${error}";

  static String m1(title) => "Similar a ${title}";

  static String m2(current) => "Paso ${current} de 3";

  static String m3(count) => "${count} cambios confirmados.";

  static String m4(count) => "${count} cambios sincronizados.";

  static String m5(statusCode) => "No se pudo buscar usuarios (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Crear nueva lista de reproducción",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Añadir 5 minutos"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Añadir canciones a la lista de reproducción",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Añadir a la biblioteca",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Añadir a la lista de reproducción",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Álbum"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "¡Álbum añadido a marcadores!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "¡Marcador de álbum eliminado!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Álbumes"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Todos los campos son obligatorios",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "No probado: Al seleccionar la casilla de verificación después de descargar más de 60 archivos, el proceso puede consumir una gran cantidad de memoria y podría causar que el teléfono o la aplicación se bloqueen. Procede bajo tu propio riesgo.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Información de la aplicación",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "¡Artista añadido a marcadores!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "¡Marcador de artista eliminado!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "¡Descripción no disponible!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistas"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("Según tus gustos"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Códec de audio"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar mis datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Trajimos el login, registro y recuperación de contraseña del proyecto anterior, adaptados para esta app musical.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Tu sesión vive en almacenamiento seguro y se valida con el mismo backend que ya usabas.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Falta configurar el archivo .env para conectar el backend de autenticación.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Registrarme"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Enviar correo",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Correo o contraseña incorrectos.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Ingresa un correo válido.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Falta configurar el backend de autenticación en el archivo .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Tu cuenta aún no está verificada.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "No fue posible completar la operación.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Nombre de pila"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Olvidé mi contraseña",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Te enviaremos las instrucciones al correo de tu cuenta.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage(
      "nombre@correo.com",
    ),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Apellido"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Sesión iniciada correctamente",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "No fue posible enviar el correo.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Correo enviado.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "No fue posible crear la cuenta.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Cuenta creada correctamente.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Bienvenidos a Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Bienvenidos a Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Descarga automática de canciones favoritas",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Descargar automáticamente las canciones favoritas cuando se añaden a favoritos",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Abrir automáticamente pantalla del reproductor",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Activar/desactivar la apertura automática del reproductor a pantalla completa al seleccionar una canción a reproducir",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Volver"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "bases de datos encontradas",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Reproducción de música en segundo plano",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Activar/Desactivar la reproducción de música en segundo plano (Se puede acceder a la aplicación desde la bandeja del sistema cuando la aplicación se ejecuta en segundo plano)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Copia de seguridad"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridad de los datos de la aplicación",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridad en progreso...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "¡Copia de seguridad guardada con éxito!",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Guarda todos los ajustes, listas de reproducción y datos de inicio de sesión en un archivo de copia de seguridad",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Necesitas una sesión activa...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage("Reiniciar app"),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Subir backup ahora",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "¿Quieres realizar una copia de seguridad?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Backup eliminado.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Todavía no hay backups...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Backup restaurado. Reinicia la app.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecciona la carpeta para el backup",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Elija qué datos respaldar",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Backup subido correctamente.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Basado en la última interacción",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Tasa de bits"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista negra de listas de reproducción",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "¡Restablecido con éxito!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("por"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Almacenar datos de contenido de la pantalla de inicio",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Activar el almacenamiento de datos de contenido de la pantalla de inicio, la pantalla de inicio se cargará instantáneamente si esta opción está activada",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Almacenar canciones en caché",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Almacenar canciones en caché mientras se reproducen para una reproducción futura/sin conexión, ocupará espacio adicional en tu dispositivo",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Caché/Sin conexión",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Cancelar temporizador",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Temporizador de apagado cancelado",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Borrar caché de imágenes",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Caché de imágenes borrada con éxito",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Haz clic aquí para borrar las miniaturas/imágenes en caché. (No se recomienda a menos que quieras actualizar los datos de las imágenes en caché)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Cerrar aplicación"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Biblioteca cloud encontrada.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Se encontró una biblioteca cloud. Este dispositivo la descargará sin sobrescribirla.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "El modo cloud está listo. Este dispositivo funcionará como caché offline.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión de forma segura usando tu cuenta de Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Accede a tus playlists, favoritos e historial desde cualquier dispositivo (Windows, Android, etc.) al instante.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Sincronización inteligente: trabaja sin conexión y sube los cambios automáticamente al recuperar internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Activar sincronización Cloud",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronización en tiempo real con Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo Cloud (Recomendado)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Playlist colaborativa",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Selecciona los amigos que podrán ver y editar esta playlist:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Colaboradores actualizados correctamente.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproducción de la comunidad",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Contenido"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. Licencia GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Crear y añadir"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Instancia personalizada",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Por favor, selecciona una instancia personalizada",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Descubrimiento diario",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Eliminar de las descargas",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "¡Eliminado correctamente de las descargas!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Desarrollado y Mantenido por Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Desactivar animación de transición",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Activar esta opción para desactivar la animación de transición de pestañas",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Desactivado"),
    "discover": MessageLookupByLibrary.simpleMessage("Descubrir"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Descartar"),
    "done": MessageLookupByLibrary.simpleMessage("Listo"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "No volver a mostrar esta información",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "archivos descargados encontrados",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Descargar"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Descargar canciones del álbum",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "La canción solicitada no se puede descargar debido a restricciones del servidor. Puedes intentarlo de nuevo",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "¡La descarga ha fallado debido a un error de red/transmisión! Por favor, inténtalo de nuevo",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Ubicación de descarga",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Descargar lista de reproducción",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Formato de archivo de descarga",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Seleccionar el formato de archivo de descarga. \"Opus\" proporcionará la mejor calidad",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Descargas"),
    "duration": MessageLookupByLibrary.simpleMessage("Duración"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinámico"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción vacía!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barra de navegación inferior",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Cambiar a la barra de navegación inferior",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Activar acciones deslizables",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Activar acciones deslizables en el mosaico de la canción",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activado"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Fin de esta canción",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Añadir canciones del álbum a la cola",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Añadir todo a la cola"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Añadir esta canción a la cola",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Añadir canciones a la cola",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episodios"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ecualizador"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Abrir el ecualizador del sistema",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "¡Ha ocurrido algún error!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Ocurrió un error"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Error al reproducir:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportar"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportar archivos descargados",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Haz clic aquí para exportar los archivos descargados del directorio de la aplicación al directorio externo",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Error al exportar la lista de reproducción",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Error al formatear los datos de la lista de reproducción",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Permiso denegado al exportar",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Espacio de almacenamiento insuficiente",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Archivos exportados con éxito",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reproducción",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reproducción como CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "No se puede importar aquí",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reproducción a JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Este formato puede ser importado",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportar a Youtube music",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Empujará tu lista de reproducción (canciones < 50) a la cola actual, no olvides añadirla a la lista de reproducción/guardar después de abrirla en YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Ubicación de exportación de archivos descargados",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportando..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportando lista de reproducción...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoritos"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproducción destacadas",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Archivo no encontrado",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Seguir"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("Seguidos"),
    "following": MessageLookupByLibrary.simpleMessage("Siguiendo"),
    "for1": MessageLookupByLibrary.simpleMessage("para"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "Favoritos olvidados",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Amigo"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Solicitud de amistad aceptada",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Solicitud de amistad enviada",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Amigos"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para buscar amigos.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Amistad eliminada",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Álbum"),
    "genericError": MessageLookupByLibrary.simpleMessage("Error"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Electrónica"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("Hip Hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latín"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesto"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Ver el código fuente de GitHub \nsi te gusta este proyecto, ¡no olvides darle una ⭐!",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Ir al álbum"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Haz clic aquí para ir a la página de descarga",
    ),
    "high": MessageLookupByLibrary.simpleMessage("Alta"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL de la API a la instancia de Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Inicio"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Recuento de contenido de inicio",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Selecciona el número de contenidos iniciales de la pantalla de inicio (aprox.). Menos resultados cargan más rápido",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorar optimización de batería",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Si tienes problemas con las notificaciones o la reproducción se detiene por la optimización del sistema, activa esta opción",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Error al importar la lista de reproducción",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Error al guardar en la base de datos",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "No se ha podido acceder al archivo seleccionado",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Formato de archivo no válido",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Nota: Las listas de reproducción grandes pueden tardar más en importarse",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importar lista de reproducción",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Seleccione un archivo JSON de lista de reproducción previamente exportado para importarlo",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importado"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importado desde Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de reproducción importada",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importando lista de reproducción...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Directorio de almacenamiento interno",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Incluir archivos de canciones descargadas",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Información no disponible",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Estructura de archivo de lista de reproducción no válida",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Respuesta inválida del servidor.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "La sesión no contiene un token válido.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elementos"),
    "keepListening": MessageLookupByLibrary.simpleMessage("Sigue escuchando"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Mantener la pantalla encendida mientras se reproduce",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Si está activado, la pantalla del dispositivo permanecerá despierta mientras se reproduce música",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Establecer el idioma de la aplicación",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Último lanzamiento"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Última Versión Disponible",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Empecemos.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage(
      "Álbumes de la biblioteca",
    ),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Artistas de la biblioteca",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproducción de la biblioteca",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage(
      "Canciones de la biblioteca",
    ),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Playlist de la biblioteca",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Claro"),
    "link": MessageLookupByLibrary.simpleMessage("Vínculo"),
    "linkAlert": MessageLookupByLibrary.simpleMessage(
      "¡Vinculado correctamente!",
    ),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link copiado al portapapeles",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Vincular con Piped para listas de reproducción",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Escuchar ahora"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Escuchando el entorno...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar la información de la actualización",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Funciona sin necesidad de iniciar sesión.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Toda tu biblioteca se queda estrictamente en este equipo.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Nota: Sin respaldos manuales en la nube. Si pierdes tu dispositivo o desinstalas la app, tus datos no se podrán recuperar.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Usar solo en este dispositivo",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Privacidad absoluta en tu dispositivo",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Modo Local"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("SonoridadDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalización de sonoridad",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Establece el mismo nivel de sonoridad para todas las canciones (Experimental) (No funcionará en canciones descargadas en versiones anteriores (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Baja"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Letras"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "¡Letras no disponibles!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Gestionar colaboradores (amigos)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Asegúrate de que la música suene con suficiente volumen cerca de tu micrófono.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Álbum migrado"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Biblioteca migrada",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Playlist migrada",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Ya hay una migración en progreso.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analizando la biblioteca local...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Revisando si EMusic Cloud ya tiene una biblioteca...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migración completada.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Creando un respaldo local antes de conectar cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "La migración falló. Tus datos locales no fueron modificados.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión en Joss Red antes de migrar.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Preparando la migración en EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud no pudo iniciar la migración.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "No se pudieron subir todos los datos. Conservamos tu respaldo local.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Subiendo playlists, favoritos e historial...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud no pudo validar la migración.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verificando la integridad en EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Seleccionar archivo e importar",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecciona song.db o un backup .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migración completada correctamente.",
    ),
    "migration_summary_albums": m6,
    "migration_summary_artists": m7,
    "migration_summary_favorites": m8,
    "migration_summary_playlists": m9,
    "migration_summary_songs": m10,
    "migration_summary_start": m11,
    "minutes": MessageLookupByLibrary.simpleMessage("minutos"),
    "misc": MessageLookupByLibrary.simpleMessage("Varios"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "La canción más escuchada",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Música y reproducción",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Reconocimiento de Música",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "¡Error de red! Comprueba tu conexión a Internet.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "¡Vaya, error de red!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "¡Nueva versión disponible!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red App (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Entendido"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronización 100% con Joss Red, playlists con amigos y mucho más. Toca para ver lo nuevo.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "¡Estrella Music ha evolucionado!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Para añadir amigos, aceptar solicitudes o gestionar tu perfil de seguridad, por favor utiliza Joss Red en sus plataformas oficiales:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Gestión de Amigos y Cuenta:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Novedades de Estrella Music",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "¡Crea listas de reproducción con tus amigos! Al crear una playlist, selecciona la casilla de Colaborativa y elige a tus amigos para que editen juntos.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Playlists Colaborativas",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Tus playlists y favoritos ahora se guardan y sincronizan en la nube automáticamente con tu cuenta principal de Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integración Total con Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Ya no necesitas dar clics a botones de sincronización manual; el nuevo motor se encarga de subir y bajar cambios automáticamente.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sincronización Transparente",
    ),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("¡No hay marcadores!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "No tienes amigos agregados en Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "¡No tienes ninguna lista de reproducción en la biblioteca!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "No se pudo encontrar ninguna canción en el audio registrado",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Sin Coincidencias"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "¡No hay canciones sin conexión!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "No hay canciones en esta colección",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "No se encontraron coincidencias para",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("No autenticado"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "¡No es una canción/video musical!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "¡No es un enlace válido!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Abrir en"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Operación fallida",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "password_text": MessageLookupByLibrary.simpleMessage("Password"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permiso denegado",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalización"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Playlist de Piped",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción de Piped sincronizada!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Simple"),
    "play": MessageLookupByLibrary.simpleMessage("Reproducir"),
    "playNext": MessageLookupByLibrary.simpleMessage("Reproducir siguiente"),
    "playNow": MessageLookupByLibrary.simpleMessage("Reproducir Ahora"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Velocidad de reproducción",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("IU del reproductor"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Seleccionar la interfaz de usuario del reproductor",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Reproduciendo:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "REPRODUCIENDO DESDE ÁLBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "REPRODUCIENDO DESDE ARTISTA",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "REPRODUCIENDO DESDE LISTA DE REPRODUCCIÓN",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "REPRODUCIENDO DESDE SELECCIÓN",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Lista de reproducción"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción en lista negra!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción añadida a marcadores!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "¡Marcador de lista de reproducción eliminado!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Colaboradores de la playlist",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción creada!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción creada y canción añadida!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Lista de reproducción exportada con éxito a",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Lista de reproducción importada correctamente",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "¡Lista de reproducción eliminada!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "¡Renombrado con éxito!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Listas de reproducción"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Próximamente"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Pistas populares"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Procesando archivos...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Procesando el audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Perfiles"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Bucle de cola"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "El modo de bucle de cola no se puede desactivar cuando el modo aleatorio está activado.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "El modo de bucle de cola no se puede activar en el modo de radio.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "El modo aleatorio está activado. No se puede mezclar la cola manualmente.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "La cola no se puede reordenar cuando el modo aleatorio está activado",
    ),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Selecciones rápidas"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "¡Radio no disponible para este artista!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Radio aleatorio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Selección aleatoria",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Reordenar lista de reproducción",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Reordenar canciones",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Leer más"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Búsquedas recientes",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Reproducido recientemente",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Te recomendamos activar el Modo Cloud para una experiencia Spotify-like: sincronización en tiempo real entre todos tus dispositivos y respaldo automático sin que tengas que hacer nada.",
    ),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Recomendados"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Eliminar de las canciones de la biblioteca",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Eliminar de la biblioteca",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Eliminar de la lista de reproducción",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Eliminar de la cola",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Eliminar varias canciones",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Eliminar lista de reproducción",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Renombrar"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Renombrar lista de reproducción",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproducida por"),
    "reset": MessageLookupByLibrary.simpleMessage("Restablecer"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restaurar ajustes predeterminados",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Restablecer los ajustes de la aplicación a los predeterminados (Requiere reinicio)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Se ha completado el restablecimiento de los ajustes a los predeterminados, por favor reinicia la aplicación",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Restablecer listas de reproducción en lista negra",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Restablecer todas las listas de reproducción de Piped en lista negra",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Reiniciar aplicación"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restaurar datos de la aplicación",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurar la última sesión de reproducción",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaurar automáticamente la última sesión de reproducción al iniciar la aplicación",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "¡Restaurado con éxito!\nLos cambios se aplican al reiniciar",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restaura todos los ajustes, datos de inicio de sesión y listas de reproducción desde un archivo de copia de seguridad. Sobrescribe todos los datos actuales",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecciona el archivo de backup",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Restaurando..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultados"),
    "retry": MessageLookupByLibrary.simpleMessage("¡Reintentar!"),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "scanning": MessageLookupByLibrary.simpleMessage("Escaneando..."),
    "search": MessageLookupByLibrary.simpleMessage("Buscar"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Canciones, listas de reproducción, álbumes o artistas",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Buscar en Biblioteca",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Resultados de búsqueda"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Búsquedas recientes",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Seleccionar todo"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Seleccionar instancia de autenticación",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "¡Por favor, selecciona la instancia de autenticación!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Seleccionar Archivo"),
    "selectSongs": MessageLookupByLibrary.simpleMessage(
      "Seleccionar canciones",
    ),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "No se encontró el archivo seleccionado.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Tu sesión expiró. Vuelve a iniciar sesión.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Establecer contenido de descubrimiento",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Acerca de Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versión, proyecto de código abierto y GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Cuenta y Sincronización",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Modo cloud, backups, lista de amigos y migraciones.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Tema, idioma y animaciones de la interfaz.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Backup en la nube",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Sube, restaura y administra...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Sube un respaldo .hmb de la app al servidor y, si lo necesitas, restaura cualquiera de los backups guardados.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Filtros de descubrir, integración con Piped y cachés.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Descargas y Almacenamiento",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Formatos de audio, carpetas y descargas automáticas.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("General"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Elige, migra o revisa el estado de sincronizacion con Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo local / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Cerrar sesion"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importa playlists, canciones...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrar desde Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("Mis amigos"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Gestiona tus amigos de Joss Red directamente.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Calidad de streaming, normalización, silencios y batería.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Regenera el identificador de YouTube Music si el contenido de Descubrir no carga.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Refrescar identificador (Visitor ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Error"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "No se pudo generar un nuevo identificador. Inténtalo más tarde.",
    ),
    "settings_visitor_exception": m0,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identificador actualizado",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Se generó un nuevo Visitor ID con éxito.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Compartir álbum"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Compartir lista de reproducción",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Compartir esta canción"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Buscando coincidencias en la base de datos de Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Aleatorio"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Mezclar cola"),
    "similarToTitle": m1,
    "singles": MessageLookupByLibrary.simpleMessage("Sencillos"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Saltar silencio"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Se saltará el silencio en la reproducción de música",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Tu temporizador de apagado está configurado",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage(
      "Temporizador de apagado",
    ),
    "slide_indicator": m2,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "¡Canción añadida a la lista de reproducción!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "¡La canción ya existe!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "La canción ya está en la caché",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "¡Canción añadida a la cola!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("¡Canción Encontrada!"),
    "songInfo": MessageLookupByLibrary.simpleMessage(
      "Información de la canción",
    ),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "¡La canción no se puede reproducir debido a restricciones del servidor!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("Tono de la canción"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Eliminado de"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "¡Eliminado de la cola!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "No puedes eliminar la canción que se está reproduciendo actualmente",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Canciones"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Canciones importadas desde Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Ordenar ascendente/descendente",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Ordenar por fecha"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Ordenar por duración",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Ordenar por nombre"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Velocidad y Tono"),
    "standard": MessageLookupByLibrary.simpleMessage("Estándar"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Iniciar radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Abrir al iniciar"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Elige la sección que Estrella Music abre primero",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Estado"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Detener música al cerrar la aplicación",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "La reproducción de música se detendrá cuando la aplicación se cierre desde el administrador de tareas",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Calidad de transmisión",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Calidad de la transmisión de música",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("suscriptores"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Desliza para explorar las opciones",
    ),
    "syncChangesConfirmed": m3,
    "syncChangesSynced": m4,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Modo cloud activado. Descargando la biblioteca existente.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Modo cloud activado. Biblioteca migrada.",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Modo cloud activo. Sincronización pendiente.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo descargar la sincronización.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Descargando cambios de EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Biblioteca sincronizada.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Biblioteca al día.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Hay cambios locales nuevos. Se subirán antes de descargar.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Tus datos se mantienen solo en este dispositivo.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Modo local activo",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Sin conexión. Los cambios quedan pendientes.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Sin conexión. Cambios guardados para reintento.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sincronizar canciones de la lista de reproducción",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic no confirmó todos los cambios. Se reintentarán.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "No se pudo subir. Se reintentará después.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Cambios subidos correctamente.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Cambios subidos correctamente (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "No se pudo subir mediante WS. Se reintentará después.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Subiendo cambios a EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sincronizado"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "¡Letras sincronizadas no disponibles!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Predeterminado del sistema",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Modo de tema"),
    "title": MessageLookupByLibrary.simpleMessage("Título"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Mejores videos musicales",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Tendencias"),
    "unLink": MessageLookupByLibrary.simpleMessage("Desvincular"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "¡Desvinculado con éxito!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Canción sin título"),
    "upNext": MessageLookupByLibrary.simpleMessage("A continuación"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Actualizar Aplicación"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL detectada haz clic en ella para abrir/reproducir el contenido asociado",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Usuario bloqueado"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "La respuesta no contiene una lista de usuarios.",
    ),
    "userSearchFailed": m5,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Usuario desbloqueado",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Vídeos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Ver todo"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Ver Artista"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Hemos modernizado nuestra plataforma. El antiguo sistema de subir respaldos manuales ha sido desactivado. Ahora cuentas con dos modos claros para gestionar tu biblioteca musical.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Elige cómo quieres experimentar Estrella Music de ahora en adelante.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Tu música, a tu manera",
    ),
  };
}
