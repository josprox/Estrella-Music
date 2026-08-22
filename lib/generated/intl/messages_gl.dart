// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a gl locale. All the
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
  String get localeName => 'gl';

  static String m0(songTitle) => "Descargando: ${songTitle}";

  static String m1(count) => "Álbums: ${count}";

  static String m2(count) => "Artistas: ${count}";

  static String m3(count) => "Favoritos: ${count}";

  static String m4(count) => "Listas de reprodución: ${count}";

  static String m5(count) => "Cancións: ${count}";

  static String m6(source) => "A migración completouse desde ${source}.";

  static String m7(error) => "Produciuse un erro ao rexenerar: ${error}";

  static String m8(title) => "Similar a ${title}";

  static String m9(current) => "Paso ${current} de 3";

  static String m10(count) => "${count} cambios comprometidos.";

  static String m11(count) => "${count} cambios sincronizados.";

  static String m12(statusCode) =>
      "Non se puideron buscar usuarios (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Crear unha nova listaxe",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Canalizada"),
    "about": MessageLookupByLibrary.simpleMessage("Respecto de"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Engadir 5 minutos"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Engadir cancións á listaxe",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Engadir á biblioteca",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("Engadir á listaxe"),
    "album": MessageLookupByLibrary.simpleMessage("Álbum"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Álbum engadido en favoritos!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Álbum eliminado de favoritos!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Álbums"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Segundo os teus gustos",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Todos os campos son obrigatorios",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Non probado: Seleccionar a cuadrícula despois de descargar máis de 60 arquivos pode consumir unha gran cantidade de memoria e provocar que o teléfono ou a aplicación se pechen. Procede baixo o teu propio risco.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Respecto da aplicación"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artista engadido en favoritos!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artista eliminado de favoritos!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Descripción non dispoñible!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistas"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Segundo os teus gustos",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Códec de audio"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Código de autenticación",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Introduce un código válido de 6 díxitos ou inicia sesión de novo.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Introduce o código de 6 díxitos da túa aplicación de autenticación. Este acceso caduca en 5 minutos.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Autenticación de dous factores",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Comproba e continúa",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar os meus datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Traemos o inicio de sesión, o rexistro e a recuperación do contrasinal do proxecto anterior, adaptado para esta aplicación de música.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "A túa sesión vive nun almacenamento seguro e validase co mesmo backend que xa estabas usando.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "O ficheiro .env debe configurarse para conectar o backend de autenticación.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Rexístrate"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Enviar correo",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirme o contrasinal",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico ou contrasinal incorrectos.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Introduce un correo electrónico válido.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Falta o backend de autenticación para configurarse no ficheiro .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "A túa conta aínda non está verificada.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Non foi posible completar a operación.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Nome de pila"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Esquecín o meu contrasinal",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Enviarémosche as instrucións ao correo electrónico da túa conta.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nome@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Apelido"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Iniciouse con éxito",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Non foi posible enviar o correo electrónico.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico enviado.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Non se puido crear a conta.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "A conta creouse correctamente.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Benvido a Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Benvido a Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Descargar cancións favoritas automáticamente",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Descargar cancións automáticamente cando se engaden a favoritos",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Abrir reprodutor automáticamente",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Habilitar/deshabilitar a apertura automática de pantalla completa do reprodutor ó escoller unha canción",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Volver"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "bases de datos atopadas",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Reproducir música de fondo",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Activar/desactivar a reprodución de música en segundo plano (pódese acceder á aplicación desde a bandexa do sistema cando se executa en segundo plano)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Facer copia de seguridade"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Facer copia de seguridade dos datos da aplicación",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridade en proceso...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridade gardada correctamente!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridade das Preferencias e Listas",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Garda todas as preferencias, listaxes e datos de identificación nunha copia de seguridade",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Necesitas unha sesión activa...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Reinicie a aplicación",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Carga copia de seguranza agora",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Queres facer unha copia de seguridade?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Eliminouse a copia de seguranza.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Aínda non hai copias de seguranza...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Copia de seguranza restablecida. Reinicie a aplicación.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Seleccione o cartafol para a copia de seguridade",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Escolle que datos queres facer unha copia de seguranza",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Copia de seguranza cargada correctamente.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Baseado na última interacción",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Taxa de bits"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista negra de reprodución",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Restablecemento correcto!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("por"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Caché do contido da pantalla de inicio",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Se esta opción está activada, a pantalla de inicio cargará inmediatamente",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cancións en caché"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Gardar cancións en caché durante a reprodución para ocasións futuras ou sen conexión. Esta acción consumirá espacio adicional no teu dispositivo",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "En caché/Sen conexión",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Cancelar temporizador",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Temporizador cancelado",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Limpar caché de imaxes",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Caché de imaxes limpado correctamente",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Pincha aquí para limpar miniaturas/imaxes cacheadas. (No recomendado salvo que queiras refrescar as imaxes cacheadas)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Pechar"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Pechar aplicación"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Atopouse a biblioteca na nube.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Atopouse unha biblioteca na nube. Este dispositivo descargarao sen sobreescribilo.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "O modo nube está listo. Este dispositivo funcionará como caché sen conexión.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión de forma segura usando a túa conta Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Accede ás túas listas de reprodución, favoritos e historial desde calquera dispositivo (Windows, Android, etc.) ao instante.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Sincronización intelixente: traballa sen conexión e carga os cambios automaticamente cando recuperas Internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Activa a sincronización na nube",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronización en tempo real con Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo nube (recomendado)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodución colaborativa",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Selecciona os amigos que poderán ver e editar esta lista de reprodución:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Colaboradores actualizados correctamente.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Listaxes da comunidade",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Contido"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPOX. Licenza GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Crear e engadir"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Instancia personalizada",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Por favor selecciona Instancia personalizada",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Descubrimento diario",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Escuro"),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Eliminar de descargas",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Eliminado correctamente das descargas!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Desenvolvido e mantido por Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Deshabilitar as animacións das transicións",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Activa esta opción para desactivar as animacións de transición das pestanas",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Deshabilitado"),
    "discover": MessageLookupByLibrary.simpleMessage("Descubrir"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Descartar"),
    "done": MessageLookupByLibrary.simpleMessage("Listo"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Non amosar esta información de novo",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "atopáronse arquivos descargados",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Descargar"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Descargar cancións do álbum",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "A canción escollida non se pode descargar debido a unha restrición do servidor. Por favor, téntao de novo",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "A descarga fracasou debido a un erro de rede ou de transmisión. Por favor, téntao de novo",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Ubicación das descargas",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Mantén as túas descargas de música activas en segundo plano.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "descargas de música",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Preparando as túas descargas...",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Descargando música",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Descargar lista de reprodución",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Descargar o formato do arquivo",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Escolle o formato do arquivo de descarga. \"Opus\" proporcionará a mellor calidade",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Descargas"),
    "duration": MessageLookupByLibrary.simpleMessage("Duración"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinámico"),
    "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Listaxe baleira!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barra de navegación inferior",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Cambiar á barra de navegación inferior",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Habilitar accións deslizables",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Habilitar accións deslizables co título das cancións",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Habilitado"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Fin da canción"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Engade cancións do álbum á cola",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Engadir todo á cola"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Engadir esta canción á cola",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Engade cancións á cola",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episodios"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ecualizador"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Abrir o ecualizador do sistema",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Produciuse un erro!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Produciuse un erro"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("Erro ao xogar:"),
    "export": MessageLookupByLibrary.simpleMessage("Exportar"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportar arquivos descargados",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Clica aquí para exportar o arquivo descargado do diretorio da aplicación a un diretorio externo",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Erro exportando listaxe",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Erro no formato dos datos do listaxe",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Permiso denegado ao exportar",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Espazo de almacenamento insuficiente",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Arquivos descargados correctamente",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("Exportar listaxe"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reprodución como CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Non se pode importar aquí",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reprodución a JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Este formato pódese importar",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportar música a Youtube",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Empuxará a túa lista de reprodución (cancións < 50) á cola actual, non esquezas engadila á lista de reprodución/gardala despois de abrila en YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Ubicación do arquivo exportado",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportando..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportando listaxe…",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoritas"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Listaxes destacadas",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Arquivo non atopado"),
    "follow": MessageLookupByLibrary.simpleMessage("Continuar"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("seguido"),
    "following": MessageLookupByLibrary.simpleMessage("Seguindo"),
    "for1": MessageLookupByLibrary.simpleMessage("para"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "favoritos esquecidos",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Amigo"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Aceptouse a solicitude de amizade",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Solicitude de amizade enviada",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Amigos"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para buscar amigos.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "A amizade eliminada",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Álbum"),
    "genericError": MessageLookupByLibrary.simpleMessage("Erro"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Electrónica"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latín"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Xestos"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Ver código fonte en GitHub.\nSe che gusta este proxecto, non esquezas darlle unha ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Ir ó álbum"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Clica aquí para ir á páxina de descarga",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Ola mundo"),
    "high": MessageLookupByLibrary.simpleMessage("Alto"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "Dirección URL a instancia canalizada",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Inicio"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Reconto de contidos",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Selecciona o número de contido na pantalla de inicio. Menos resultados resultan nunha carga máis rápida",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Identificador"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorar a optimización da batería",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Se tes problemas coas notificacións ou a reprodución detense pola optimización do sistema, por favor activa esta opción",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Erro importando listaxe",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Erro gardando na base de datos",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Non se puido acceder ao arquivo seleccionado",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Formato de arquivo non válido",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Nota: As listaxes grandes poden tardar máis en importarse",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("Importar listaxe"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Escolle un arquivo JSON dunha listaxe exportada previamente para importar",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importado"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importado de Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodución importada",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importando listaxe…",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Directorio de almacenamento interno",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Incluír cancións descargadas",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Información non dispoñible",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Estrutura de arquivo de lista de reprodución non válida",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Resposta do servidor non válida.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "A sesión non contén un token válido.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elementos"),
    "keepListening": MessageLookupByLibrary.simpleMessage("segue escoitando"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Manter a pantalla acesa mentres se reproduce",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Se está activado, a pantalla do dispositivo manterase acesa mentres se reproduce música",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Seleccionar idioma da aplicación",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Último lanzamento"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Última versión dispoñible",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Comecemos..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Álbums na biblioteca"),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Artistas na biblioteca",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Listaxes na biblioteca",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Cancións na biblioteca"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodución da biblioteca",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Claro"),
    "link": MessageLookupByLibrary.simpleMessage("Vincular"),
    "linkAlert": MessageLookupByLibrary.simpleMessage(
      "Vinculado correctamente!",
    ),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "A ligazón copiouse no portapapeis",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Ligazón con canalización para as listaxes",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Escoita agora"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Escoitando o medio ambiente...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Non se puido cargar a información de actualización",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Funciona sen necesidade de iniciar sesión.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Toda a túa biblioteca permanece estrictamente neste ordenador.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Nota: non hai copias de seguridade manuais na nube. Se perde o dispositivo ou desinstala a aplicación, os seus datos non se poderán recuperar.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Use só neste dispositivo",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Privacidade absoluta no teu dispositivo",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Modo local"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Volume (dB)"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalización do volume",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Establece o mesmo nivel de volume para todas as cancións (Experimental) (Non funcionará coas cancións descargadas na versión anterior (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Baixo"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Letras"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Letra non dispoñible!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Xestionar colaboradores (amigos)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Asegúrate de que a música soa o suficientemente alta preto do micrófono.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Álbum migrado"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Biblioteca migrada",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodución migrada",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Xa hai unha migración en curso.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analizando a biblioteca local...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Comprobando se EMusic Cloud xa ten unha biblioteca...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migración completada.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Creando unha copia de seguranza local antes de conectar a nube...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Fallou a migración. Non se modificaron os teus datos locais.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión en Joss Red antes de migrar.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Preparando a migración en EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud non puido iniciar a migración.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Non se puideron cargar todos os datos. Mantemos o teu apoio local.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Cargando listas de reprodución, favoritos e historial...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud non puido validar a migración.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verificando a integridade en EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Selecciona o ficheiro e importa",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Seleccione song.db ou unha copia de seguridade .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "A migración completouse correctamente.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutos"),
    "misc": MessageLookupByLibrary.simpleMessage("Varios"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "A canción máis escoitada",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Música e reprodución",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Recoñecemento musical",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Erro na rede! Comproba a túa conexión.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Vaites, erro de conexión!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nova versión dispoñible!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplicación Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Entendido"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronización 100 % con Joss Red, listas de reprodución con amigos e moito máis. Toca para ver as novidades.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music evolucionou!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Para engadir amigos, aceptar solicitudes ou xestionar o teu perfil de seguranza, utiliza Joss Red nas súas plataformas oficiais:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Amigos e xestión de contas:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Crea listas de reprodución cos teus amigos! Cando crees unha lista de reprodución, selecciona a caixa de verificación Colaborativa e escolle os teus amigos para editar xuntos.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Listas de reprodución colaborativas",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "As túas listas de reprodución e favoritos agora gárdanse e sincronízanse na nube automaticamente coa túa conta principal de Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integración total con Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Xa non precisa facer clic nos botóns de sincronización manual; O novo motor encárgase de subir e baixar automaticamente.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sincronización transparente",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Non"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Sen favoritas!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Non tes amigos engadidos en Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Non tes ningunha listaxe de reprodución na biblioteca!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Non se puido atopar ningunha canción no audio gravado",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Sen coincidencias"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Non hai cancións sen conexión!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Non hai cancións nesta colección",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Non se atoparon coincidencias para",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Non autenticado"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Non é unha canción/vídeo musical!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Non é unha ligazón válida!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Abrir en"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Erro na operación",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contrasinal"),
    "password_text": MessageLookupByLibrary.simpleMessage("Contrasinal"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "permiso denegado",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music necesita estes permisos para xestionar a túa música e ofrecer todas as funcións de reprodución.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Permisos para comezar",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Concede os permisos necesarios",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Úsase só cando decide identificar unha canción que está a tocar ao seu redor.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Micrófono",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Mostra os controis de reprodución, o progreso da descarga e avisos importantes das aplicacións.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Notificacións",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Configuración",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Os tres permisos son necesarios para continuar. Podes cambialos máis tarde na configuración do sistema.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Permítelle reproducir música, gardar descargas, exportar listas de reprodución e preparar actualizacións.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Música e almacenamento",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalización"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodución canalizada",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe canalizada sincronizada!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Plano"),
    "play": MessageLookupByLibrary.simpleMessage("Reproducir"),
    "playNext": MessageLookupByLibrary.simpleMessage("Reproducir deseguido"),
    "playNow": MessageLookupByLibrary.simpleMessage("Xoga agora"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Velocidade de reprodución",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Interface de usuario"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Selecciona a interface de usuario",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Xogando:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "REPRODUCINDO DESDE O ÁLBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "REPRODUCINDO DESDE O ARTISTA",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "REPRODUCINDO DESDE A LISTAXE",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "REPRODUCINDO DESDE A SELECCIÓN",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Lista de reprodución"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe en lista negra!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe en favoritos!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe eliminada de favoritos!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Colaboradores da lista de reprodución",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe creada!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe creada e canción engadida!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Listaxe exportado con éxito a",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Listaxe importada con éxito",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Listaxe eliminada!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Renomeado con éxito!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Listaxes"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Vindeiro"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Pistas populares"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Procesando arquivos...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Procesando o audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Perfís"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Repetir cola"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "O modo de repetición da cola non se pode desactivar cando o modo aleatorio está activado.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "O modo de repetición da cola non se pode activar no modo radio.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A cola non se pode mesturar cando o modo aleatorio está activado",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A cola non se pode reordenar cando o modo aleatorio está activado",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Selección rápida"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Selección rápida"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio non dispoñible para este artista!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Radio aleatoria"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Selección aleatoria",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Reordenar listaxe",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Reordenar cancións",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Ler máis"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Buscas recentes"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Reproducidas recentemente",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Recomendamos activar o Modo Cloud para unha experiencia similar a Spotify: sincronización en tempo real entre todos os teus dispositivos e copia de seguridade automática sen que teñas que facer nada.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Recomendado"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Recomendado"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Eliminar da caché",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Eliminar da biblioteca",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Eliminar da biblioteca",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Eliminar da listaxe",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Eliminar da cola"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Eliminar múltiples cancións",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Eliminar listaxe"),
    "rename": MessageLookupByLibrary.simpleMessage("Renomear"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("Renomear listaxe"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproducido por"),
    "reset": MessageLookupByLibrary.simpleMessage("Restablecer"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restablecer configuración predeterminada",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Restablecer datos de fábrica da aplicación (Reinicio necesario)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "A configuración foi restablecida ós valores predeterminados. Por favor, reinicia a aplicación",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Restablecemento das listas negras",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Restablecer todas as listaxes na lista negra",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Reiniciar aplicación"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restablecer datos da aplicación",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurar a última sesión de reprodución",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaurar automáticamente a última sesión de reprodución ó iniciar a aplicación",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Restaurado correctamente!\nOs cambios aplicaranse ó reiniciar",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Restaurar Preferencias e Listas",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restaura todas as preferencias, datos de identificación e listaxes desde unha de copia de seguridade. Sobreescribe todas as configuracións actuais",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Seleccione o ficheiro de copia de seguridade",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Restaurando..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultados"),
    "retry": MessageLookupByLibrary.simpleMessage("Téntao de novo!"),
    "save": MessageLookupByLibrary.simpleMessage("Manteña"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Gardado"),
    "scanning": MessageLookupByLibrary.simpleMessage("Escaneando..."),
    "search": MessageLookupByLibrary.simpleMessage("Procurar"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Cancións, Listaxe, Álbum ou Artista",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Busca na biblioteca",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Resultados da busca"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Buscas recentes",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Elixe todo"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Selecciona Instancia de autenticación",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Por favor selecciona Instancia de autenticación!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Escolle arquivo"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Elixe cancións"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Non se atopou o ficheiro seleccionado.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "A túa sesión caducou. Inicia sesión de novo.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Configurar o contido recomendado",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Axustes"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Sobre Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versión, proxecto de código aberto e GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Conta e sincronización",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Modo nube, copias de seguridade, lista de amigos e migracións.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Animacións de tema, linguaxe e interface.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridade na nube",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Carga, restaura e xestiona...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Carga unha copia de seguranza .hmb da aplicación ao servidor e, se é necesario, restaura calquera das copias de seguridade gardadas.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Descubra filtros, integración con Piped e cachés.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Descargas e almacenamento",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Formatos de audio, cartafoles e descargas automáticas.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Xeral"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Escolle, migra ou revisa o estado de sincronización con Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo local / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Pechar sesión"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importar listas de reprodución, cancións...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migra desde Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("meus amigos"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Xestiona os teus amigos de Joss Red directamente.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Calidade de transmisión, normalización, silencios e batería.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Rexenera o teu ID de YouTube Music se o contido de Discover non se carga.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Actualizar ID (ID de visitante)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Erro"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Non se puido xerar un novo identificador. Téntao de novo máis tarde.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identificador actualizado",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Xerouse correctamente un novo ID de visitante.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Compartir álbum"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Compartir lista de reprodución",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Compartir esta canción"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Buscando coincidencias na base de datos de Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Aleatorio"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Mesturar cola"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Sinxelos"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Omitir silencio"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Os silencios serán omitidos durante a reprodución",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "O temporizador activouse con éxito",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Temporizador"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Canción engadida á listaxe!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "A canción xa existe!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Canción sen conexión xa na caché",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Canción engadida á cola!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Canción atopada!"),
    "songInfo": MessageLookupByLibrary.simpleMessage(
      "Información respecto da canción",
    ),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "A canción non se pode reproducir debido a unha restrición do servidor!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("ton da canción"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Eliminada de"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Eliminado da cola!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Non podes eliminar a canción en reprodución",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Cancións"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Cancións importadas de Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Ordenar ascendente/descendente",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Ordenar por data"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Ordenar por duración",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Ordenar por nome"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Velocidade e Pitch"),
    "standard": MessageLookupByLibrary.simpleMessage("Estándar"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Acender a radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Abrir ao iniciar"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Escolle primeiro a sección que estrea Estrella Music",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Estado"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Deter a música cando se elimina a pestana",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "A reprodución da música deterase cando se elimine a aplicación da barra de tarefas",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Calidade de transmisión",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Calidade de transmisión de música",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("subscritores"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Pasa o dedo para explorar as opcións",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Modo nube activado. Descarga da biblioteca existente.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Modo nube activado. Biblioteca migrada.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Modo nube activo",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Modo nube activo. Sincronización pendente.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Produciuse un erro ao descargar a sincronización.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Descargando cambios de EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Biblioteca sincronizada.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Biblioteca actualizada.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Hai novos cambios locais. Cargaranse antes da descarga.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Os teus datos só se conservan neste dispositivo.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Modo local activo",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Sen conexión. Os cambios están pendentes.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Sen conexión. Os cambios gardáronse para tentalo de novo.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sincroniza cancións da lista de reprodución",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic non confirmou todos os cambios. Volveranse a probar.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Non se puido levantar. Retentarase máis tarde.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Cambios cargados correctamente.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Cambios cargados correctamente (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Non se puido cargar usando WS. Retentarase máis tarde.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Cargando cambios en EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sincronizado"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "A sincronización da letra non está dispoñible!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Predeterminado"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Tema"),
    "title": MessageLookupByLibrary.simpleMessage("Título"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Principais vídeos musicais",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Vídeos musicais populares",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Tendencias"),
    "unLink": MessageLookupByLibrary.simpleMessage("Desvincular"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Desvinculado correctamente!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Canción sen título"),
    "upNext": MessageLookupByLibrary.simpleMessage("Deseguido"),
    "updateApp": MessageLookupByLibrary.simpleMessage(
      "Aplicación de actualización",
    ),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL detectada. Fai clic para reproducir o contido asociado",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Usuario bloqueado"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "A resposta non contén unha lista de usuarios.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Usuario desbloqueado",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Usuario"),
    "video": MessageLookupByLibrary.simpleMessage("Vídeo"),
    "videos": MessageLookupByLibrary.simpleMessage("Vídeos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Ver todo"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Ver artista"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Modernizamos a nosa plataforma. Desactivouse o sistema antigo de carga de copias de seguranza manuais. Agora tes dúas formas claras de xestionar a túa biblioteca de música.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Escolle como queres experimentar Estrella Music a partir de agora.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "A túa música, ao teu xeito",
    ),
  };
}
