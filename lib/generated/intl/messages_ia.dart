// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ia locale. All the
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
  String get localeName => 'ia';

  static String m0(songTitle) => "Letöltés: ${songTitle}";

  static String m1(count) => "Albumok: ${count}";

  static String m2(count) => "Előadók: ${count}";

  static String m3(count) => "Kedvencek: ${count}";

  static String m4(count) => "Lejátszási listák: ${count}";

  static String m5(count) => "Dalok: ${count}";

  static String m6(source) => "Az áttelepítés befejeződött innen: ${source}.";

  static String m7(error) => "Hiba történt a regenerálás során: ${error}";

  static String m8(title) => "Hasonló ehhez: ${title}";

  static String m9(current) => "3. ${current}. lépés";

  static String m10(count) => "${count} változtatások végrehajtva.";

  static String m11(count) => "${count} szinkronizált változtatások.";

  static String m12(statusCode) =>
      "Nem sikerült felhasználókat keresni (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Crear un nove lista de reproduction",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("A proposito de"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Adder 5 minutas"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Adder cantos al lista de reproduction",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Hozzáadás a könyvtárhoz",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Adder al lista de reproduction",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album marcate!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcator de album removite!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albumes"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Tote le campos es requirite",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(""),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Information del application",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artista marcate!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcator de artista removite!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Description non disponibile!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistas"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Codec de audio"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Hitelesítési kód"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Adjon meg egy érvényes 6 számjegyű kódot, vagy jelentkezzen be újra.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Írja be a hatjegyű kódot a hitelesítő alkalmazásból. Ez a hozzáférés 5 perc múlva lejár.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Kéttényezős hitelesítés",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Ellenőrizze és folytassa",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Hozzájárulok adataim felhasználásához...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "A bejelentkezést, a regisztrációt és a jelszó-helyreállítást az előző projektből hoztuk, ehhez a zenei alkalmazáshoz igazítva.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "A munkamenet biztonságos tárhelyen él, és ugyanazzal a háttérprogrammal van érvényesítve, amelyet már használt.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Az .env fájlt be kell állítani a hitelesítési háttérrendszer csatlakoztatásához.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Jelentkezzen be"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Regisztráció"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Levél küldése",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Erősítse meg a jelszót",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Hibás e-mail cím vagy jelszó.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Adjon meg egy érvényes e-mail-címet.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Hiányzik a hitelesítési háttérprogram konfigurálása az .env fájlban.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Fiókja még nincs igazolva.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "A műveletet nem lehetett befejezni.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Keresztnév"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Elfelejtettem a jelszavamat",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Az utasításokat elküldjük a fiókod e-mail címére.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("név@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Vezetéknév"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Sikeres bejelentkezés",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Az e-mailt nem lehetett elküldeni.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-mail elküldve.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "A fiók nem hozható létre.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "A fiók sikeresen létrehozva.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Üdvözöljük az Estrella Music oldalán",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Üdvözöljük az Estrella Music oldalán",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Kedvenc dalok automatikus letöltése",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "A kedvenc dalok automatikus letöltése, ha hozzáadja a kedvencekhez",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "A lejátszó képernyőjének automatikus megnyitása",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "A lejátszó teljes képernyőre való automatikus megnyitásának be-/kikapcsolása a lejátszandó dal kiválasztásakor",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Vissza"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "bases de datos trovate",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Reproducer musica in fundo",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Activar/Disactivar le reproduction de musica in fundo (Le application pote esser accessate ab la barra de systema quando ille es executante in secunde fundo)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Copia de securitate"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Copia de securitate de datos del application",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Copia de securitate in progresso...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Copia de securitate salveguardate con successo!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Copia de securitate del parametros e listas de reproduction",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Salveguarda tote le parametros, listas de reproduction e datos de initio de session in un file de copia de securitate",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Aktív foglalkozásra van szüksége...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Indítsa újra az alkalmazást",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Töltse fel most a biztonsági másolatot",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Szeretnél biztonsági másolatot készíteni?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Biztonsági másolat törölve.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Még nincsenek biztonsági mentések...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "A biztonsági mentés visszaállítva. Indítsa újra az alkalmazást.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a mappát a biztonsági mentéshez",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Válassza ki, milyen adatokról szeretne biztonsági másolatot készíteni",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "A biztonsági másolat megfelelően feltöltve.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Basate in le ultime interaction",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Taxa de bits"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista feketelista",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Reinitialisate con successo!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("per"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Cache del datos de contento del schermo de initio",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Activar le cache del datos de contento del schermo de initio, ille schermo cargara immediatemente si iste option es activate",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cantos in cache"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Immagazinar le cantos in cache pro reproductiones futur e foras de linea, illo usara spatio additional in tu apparato",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "In cache/Foras de linea",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancellar"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Cancellar temporisator",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Temporisator de somno cancellate",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Rader le cache de imagines",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Imagines del cache delite con successo",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Clicca hic pro rader miniaturas e imagines in cache. (Non recommentate a minus que tu vole actualisar le datos de imagine in cache)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Clauder"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Clauder le application"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Felhőkönyvtár található.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Felhőkönyvtár található. Ez az eszköz felülírás nélkül tölti le.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "A felhő mód készen áll. Ez az eszköz offline gyorsítótárként fog működni.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Jelentkezzen be biztonságosan Joss Red fiókjával.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Bármilyen eszközről (Windows, Android stb.) azonnal elérheti lejátszási listáit, kedvenceit és előzményeit.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Intelligens szinkronizálás: Dolgozzon offline módban, és az internet helyreállítása után automatikusan töltse fel a módosításokat.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktiválja a felhőszinkronizálást",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Valós idejű szinkronizálás Joss Red-el",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage("Felhő mód (ajánlott)"),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Együttműködési lejátszási lista",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Válassza ki azokat az ismerősöket, akik láthatják és szerkeszthetik ezt a lejátszási listát:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Az együttműködők megfelelően frissítve.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproduction del communitate",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Contento"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL licenc v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Crear e adder"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Instantia personalisate",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Selige un instantia personalisate",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Napi felfedezés"),
    "dark": MessageLookupByLibrary.simpleMessage("Obscur"),
    "delete": MessageLookupByLibrary.simpleMessage("Törölje"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Remover ab le discargamentos",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Removite con successo ab le discargamentos!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Joss Estrada (JOSPROX) fejlesztette és karbantartotta",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Disactivar animation de transition",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Activa iste option pro disactivar le animation de transition de scheda",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Disactivate"),
    "discover": MessageLookupByLibrary.simpleMessage("Discoperir"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Dimitter"),
    "done": MessageLookupByLibrary.simpleMessage("Kész"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Non monstrar iste information novemente",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "files discargate trovate",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Discargar"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok letöltése az albumról",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Le canto requestate non pote discargar se a causa de un restriction de servitor. Tu pote retentar lo",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Falleva le discargamento a causa de un error de rete! Tenta de novo",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Location de discargamento",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Aktívan tartja a zeneletöltéseket a háttérben.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "zeneletöltések",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Letöltések előkészítése…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Zene letöltése",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista letöltése",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Formato de file de discarga",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Selige le formato del file de discarga. \"Opus\" fornira le melior qualitate",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Discargamentos"),
    "duration": MessageLookupByLibrary.simpleMessage("Duration"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamic"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction vacue!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barra de navigation basse",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Cambiar al barra de navigation basse",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Activar le acciones glissabile",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Csúsztatási műveletek aktiválása a dalcsempén",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activate"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Fin de iste canto"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Adja hozzá az album dalait a sorhoz",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Mitter toto in le cauda",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Mitter iste canto in le cauda",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok hozzáadása a sorhoz",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Epizódok"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalisator"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Aperir le equalisator de systema",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Ocurreva alcun error!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Hiba történt"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Hiba lejátszás közben:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportar"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportar files discargate",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Clicca hic pro exportar files discargate ab directorio inApp a directorio externe",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Hiba a lejátszási lista exportálása során",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Hiba a lejátszási lista adatainak formázásakor",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Az exportálás során megtagadták az engedélyt",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Nincs elegendő tárhely",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Files exportate con successo",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista exportálása",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista exportálása CSV formátumban",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ide nem lehet importálni",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista exportálása JSON-ba",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ez a formátum importálható",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportálás Youtube zenébe",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "A lejátszási listát (50 alatti dalok) az aktuális sorba tolja, ne felejtse el hozzáadni a lejátszási listához / elmenteni, miután megnyitotta az YtMusicban",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Location de exportation de file discargate",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("In exportation..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista exportálása...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoritos"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproduction eminente",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "A fájl nem található",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Kövesd"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("követte"),
    "following": MessageLookupByLibrary.simpleMessage("Követve"),
    "for1": MessageLookupByLibrary.simpleMessage("pro"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "elfelejtett kedvencek",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Barát"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Ismerős felkérés elfogadva",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Ismerős felkérés elküldve",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Barátok"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Jelentkezzen be, hogy barátokat találjon.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "A barátság eltávolítva",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Hiba"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronika"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip-hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesztus"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Vider le codice fonte in GitHub\nSi te place iste project, non oblida de dar un ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Vader al album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Clicca hic pro vader al pagina de discargamentos",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Helló világ"),
    "high": MessageLookupByLibrary.simpleMessage("Alte"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL de API al instantia de Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Initio"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Computo de contentos",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Selige le numero de contentos del schermo de initio (approx.). Minus resultatos carga plus rapide",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorar le optimisation del batteria",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Si tu ha problemas de notificationes o de reproduction stoppate per le optimisation de batteria, activa iste option",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Hiba a lejátszási lista importálásakor",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Hiba az adatbázisba mentéskor",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "A kiválasztott fájlhoz nem lehetett hozzáférni",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Érvénytelen fájlformátum",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Megjegyzés: A nagy lejátszási listák importálása tovább tarthat",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista importálása",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Válasszon ki egy korábban exportált lejátszási lista JSON-fájlt az importáláshoz",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importált"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlinból importálva",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importált lejátszási lista",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista importálása...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Belső tárolási könyvtár",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Includer cantos discargate",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Információ nem áll rendelkezésre",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Érvénytelen lejátszási lista fájlszerkezet",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Érvénytelen szerver válasz.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "A munkamenet nem tartalmaz érvényes tokent.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elementos"),
    "keepListening": MessageLookupByLibrary.simpleMessage("hallgass tovább"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Mantenir le schermo accendite durante le reproduction",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Si activate, le schermo del dispositivo remanera accendite durante le reproduction del musica",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Lingua"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Definir le lingua del application",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Legújabb kiadás"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Elérhető legújabb verzió",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Que nos comencia..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage(
      "Albumes del bibliotheca",
    ),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Artistas del bibliotheca",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Listas de reproduction del bibliotheca",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Cantos del bibliotheca"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotheca"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Library Playlist",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Clar"),
    "link": MessageLookupByLibrary.simpleMessage("Ligamine"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Ligate con successo!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link a vágólapra másolva",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Ligamine con piped pro listas de reproduction",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Figyelj most"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "A környezetre figyelve...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült betölteni a frissítési információkat",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Bejelentkezés nélkül működik.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "A teljes könyvtára szigorúan ezen a számítógépen marad.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Megjegyzés: Nincs manuális felhőalapú biztonsági mentés. Ha elveszíti eszközét vagy eltávolítja az alkalmazást, az adatok nem állíthatók vissza.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Csak ezen a készüléken használja",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Abszolút adatvédelem az eszközön",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Helyi mód"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisation del volumine",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Define le mesme nivello de volumine pro tote le cantos (Experimental) (Non functionara con le cantos discargate sur le versiones previe (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Basse"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Levelek"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Parolas de canto non disponibile!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Együttműködők (barátok) kezelése",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Győződjön meg arról, hogy a zene elég hangosan szól a mikrofon közelében.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Áttelepített album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Áttelepített könyvtár",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Áttelepített lejátszási lista",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Már folyamatban van a migráció.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "A helyi könyvtár elemzése...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Annak ellenőrzése, hogy az EMusic Cloud rendelkezik-e már könyvtárral...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "A migráció befejeződött.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Helyi biztonsági mentés létrehozása a felhő csatlakoztatása előtt...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "A migráció nem sikerült. A helyi adatait nem módosították.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "A migráció előtt jelentkezzen be a Joss Red szolgáltatásba.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "A migráció előkészítése az EMusic Cloudban...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "Az EMusic Cloud nem tudta elindítani az áttelepítést.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Nem lehetett minden adatot feltölteni. Megtartjuk helyi támogatását.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listák, kedvencek és előzmények feltöltése...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "Az EMusic Cloud nem tudta ellenőrizni az áttelepítést.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Az integritás ellenőrzése az EMusic Cloudban...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a fájlt és importálja",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a song.db fájlt vagy a backup .backup fájlt",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Az áttelepítés sikeresen befejeződött.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutas"),
    "misc": MessageLookupByLibrary.simpleMessage("Különféle"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "A legtöbbet hallgatott dal",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musica e reproduction",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("Zene felismerés"),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Error de rete! Verifica tu connection.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Oh, un error de rete!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nove version disponibile!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red App (Play Áruház)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Megértve"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100%-os szinkronizálás Joss Red-el, lejátszási listák a barátokkal és még sok más. Koppintson az újdonságok megtekintéséhez.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Az Estrella Music fejlődött!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Barátok hozzáadásához, kérések elfogadásához vagy biztonsági profiljának kezeléséhez használja a Joss Red szolgáltatást a hivatalos platformjain:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Barátok és fiókkezelés:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Zenei hírek",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Hozz létre lejátszási listákat barátaiddal! Lejátszási lista létrehozásakor jelölje be az Együttműködés jelölőnégyzetet, és válassza ki barátait, akiket együtt szeretne szerkeszteni.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Együttműködő lejátszási listák",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listáit és kedvenceit a rendszer most menti, és automatikusan szinkronizálja a felhőben a fő Joss Red-fiókjával.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Teljes integráció Joss Red-el",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Többé nem kell a kézi szinkronizálás gombjaira kattintania; Az új motor felelős az automatikus fel-le váltásért.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Átlátszó szinkronizálás",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Nem"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Necun marcatores!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Nincsenek hozzáadott barátaid a Joss Red-en.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tu non ha necun lista de reproduction lib!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Nem található dal a rögzített hanganyagban",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Nincs egyezés"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Non il ha cantos foras de linea!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Ebben a gyűjteményben nincsenek dalok",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Nulle correspondentia trovate pro",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Nem hitelesített",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Non es un canto/video musical!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Non es un ligamine valide!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Aperir in"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Falleva le operation",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contrasigno"),
    "password_text": MessageLookupByLibrary.simpleMessage("Jelszó"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Engedély megtagadva",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Engedélyezze"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Az Estrella Musicnak szüksége van ezekre az engedélyekre a zene kezeléséhez és az összes lejátszási funkció biztosításához.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Engedélyek az induláshoz",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Adja meg a szükséges engedélyeket",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Csak akkor használatos, ha úgy dönt, hogy azonosít egy dalt, amely körülötted szól.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Megjeleníti a lejátszási vezérlőket, a letöltési folyamatot és az alkalmazásokkal kapcsolatos fontos megjegyzéseket.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Értesítések",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Beállítások elemre",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "A folytatáshoz mindhárom engedély szükséges. Ezeket később módosíthatja a rendszerbeállításokban.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Lehetővé teszi zenék lejátszását, letöltések mentését, lejátszási listák exportálását és frissítések előkészítését.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Zene és tárolás",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisation"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction de Piped synchronisate!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Plan"),
    "play": MessageLookupByLibrary.simpleMessage("Játssz"),
    "playNext": MessageLookupByLibrary.simpleMessage("Reproducer sequente"),
    "playNow": MessageLookupByLibrary.simpleMessage("Játssz most"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Lejátszási sebesség",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("IU de reproductor"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Selige le interfacie de usator del reproductor",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Lejátszás:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "LEJÁTSZÁS ALBUMRÓL",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "JÁTSZÁS MŰVÉSZTŐL",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "LEJÁTSZÁS LEJÁTSZÁSI LISTÁBÓL",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "JÁTÉK VÁLASZTÁSBÓL",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Lejátszási lista elemre"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction in le lista nigre!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction marcate!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcator del lista de reproduction removite!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listák közreműködői",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction create!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction create e canto addite!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "A lejátszási lista sikeresen exportálva ide",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "A lejátszási lista sikeresen importálva",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reproduction removite!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Renominate con successo!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Listas de reproduction"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Hamarosan"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcastok"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Népszerű számok"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Files in processo...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Hang feldolgozása...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profilok"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("farokhurok"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "A sorhurok mód nem tiltható le, ha a véletlen sorrendű mód engedélyezve van.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "A farokhurok mód rádió üzemmódban nem aktiválható.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Le cauda non pote esser miscite quando le modo aleatori es activate",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Le cauda non pote esser rearrangiate quando le modo aleatori es activate",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Gyors kiválasztás"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Selectiones rapide"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio non disponibile pro iste artista!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Véletlenszerű rádió"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Véletlenszerű kiválasztás",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Rearrangiar le lista de reproduction",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Dalok átrendezése"),
    "readMore": MessageLookupByLibrary.simpleMessage("Olvass tovább"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Legutóbbi keresések",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Reproducite recentemente",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Javasoljuk, hogy aktiválja a Felhő módot a Spotify-szerű élmény érdekében: valós idejű szinkronizálás az összes eszköz között és automatikus biztonsági mentés anélkül, hogy bármit is tenne.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Ajánlott"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Ajánlott"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Távolítsa el a gyorsítótárból",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Remover ab le cantos de bibliotheca",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Törlés a könyvtárból",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Remover ab le lista de reproduction",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Deler del cauda"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Deler multiple cantos",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Deler le lista de reproduction",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Renominar"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Renominar le lista de reproduction",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reprodukálta"),
    "reset": MessageLookupByLibrary.simpleMessage("Reinitialisar"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Az alapértelmezett beállítások visszaállítása",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Alkalmazásbeállítások visszaállítása az alapértelmezettre (Újraindítás szükséges)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Az alapértelmezett beállítások visszaállítása befejeződött, kérjük, indítsa újra az alkalmazást",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Restabilir le listas de reproduction in lista nigre",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Restabilir tote le listas de reproduction de piped in lista nigre",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Reinitiar le app"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restaurar datos del application",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurar le ultime session de reproduction",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaura automaticamente le ultime session de reproduction al initio del application",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Restaurate con successo!\nLe cambios essera applicate in le reinitio",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Restaurar le parametros e listas de reproduction",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restaura tote le parametros, datos de initio de session e listas de reproduction ab un file de copia de securitate. Superscribe tote le datos actual",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a biztonsági másolat fájlt",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("in restauration..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultatos"),
    "retry": MessageLookupByLibrary.simpleMessage("Retenta lo!"),
    "save": MessageLookupByLibrary.simpleMessage("Mentés"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Mentve"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scannante..."),
    "search": MessageLookupByLibrary.simpleMessage("Cercar"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Cantos, Listas de reproduction, Album o Artista",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Keresés a könyvtárban",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Resultatos del recerca"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Legutóbbi keresések",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage(
      "Válassza ki az összeset",
    ),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Selige un instantia de authentication",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Selige le instantia de authentication!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage(
      "Válassza a Fájl lehetőséget",
    ),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Válasszon dalokat"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "A kiválasztott fájl nem található.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "A munkamenet lejárt. Jelentkezzen be újra.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Definir le discoperta de contento",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Parametros"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Az Estrella Musicról",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Verzió, nyílt forráskódú projekt és GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Fiók és szinkronizálás",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Felhő mód, biztonsági mentések, barátlista és migráció.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Téma, nyelv és interfész animációk.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Biztonsági mentés a felhőből",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Feltöltés, visszaállítás és kezelés...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Töltse fel az alkalmazás .hmb biztonsági másolatát a szerverre, és ha szükséges, állítsa vissza a mentett biztonsági másolatok bármelyikét.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Fedezze fel a szűrőket, a Pipeddel való integrációt és a gyorsítótárakat.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Letöltések és tárolás",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Hangformátumok, mappák és automatikus letöltések.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "tábornok",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Válassza ki, migrálja vagy tekintse át a szinkronizálás állapotát a Joss Red segítségével.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Helyi mód / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Jelentkezzen ki"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listák, dalok importálása...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migráció a Joss Music Kotlin szolgáltatásból",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("barátaim"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Kezelje közvetlenül Joss Red barátait.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streaming minőség, normalizálás, némítás és akkumulátor.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Ha a Discover-tartalom nem töltődik be, állítsd újra a YouTube Music ID-t.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Frissítési azonosító (látogatóazonosító)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Hiba"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült új azonosítót létrehozni. Kérjük, próbálja újra később.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Frissített azonosító",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Sikeresen létrehoztunk egy új látogatóazonosítót.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Album megosztása"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista megosztása",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Compartir iste canto"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Egyezések keresése a Shazam adatbázisban...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Véletlenszerű"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("mix farok"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Saltar le silentio"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Le silentio essera saltate in le reproduction de musica",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Tu temporisator de somno es definite",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Temporisator de somno"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Canto addite al lista!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Le canto jam existe!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Canto jam foras de linea in le cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Canto in le cauda!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Dal megtalálva!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Information del canto"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Le canto non se pote reproducer a causa de un restriction de servitor!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("dal hangja"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Removite ab"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Removite ab le cauda!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Tu non pote remover le canto actualmente in reproduction",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Cantos"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "A Joss Music Kotlinból importált dalok",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Növekvő/csökkenő rendezés",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage(
      "Rendezés dátum szerint",
    ),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Rendezés időtartam szerint",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Rendezés név szerint"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Sebesség és hangmagasság",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Szabványos"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Initiar le radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Nyissa meg indításkor",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Válassza ki azt a részt, amelyet az Estrella Music először nyit meg",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Stato"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Stoppar le musica al rader le barra de cargas",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Le reproduction de musica stoppara quando le application sia glissate foras del gestor de cargas",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Qualitate de fluxo",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Qualitate del fluxo de musica",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("subscriptores"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Csúsztassa ujját a lehetőségek felfedezéséhez",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Felhő mód aktiválva. A meglévő könyvtár letöltése.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Felhő mód aktiválva. Áttelepített könyvtár.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Felhő mód aktív",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Felhő mód aktív. Függőben lévő szinkronizálás.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült letölteni a szinkronizálást.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Az EMusic módosításainak letöltése...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Szinkronizált könyvtár.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Naprakész könyvtár.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Új helyi változások vannak. A letöltés előtt feltöltésre kerülnek.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Az Ön adatait csak ezen az eszközön tároljuk.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Helyi mód aktív",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline. A változtatások függőben vannak.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline. A változtatások mentve újrapróbálkozáshoz.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista dalainak szinkronizálása",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "Az EMusic nem erősítette meg az összes változtatást. Újra meg fogják próbálni.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült felkelni. Később újra megpróbáljuk.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "A módosítások megfelelően feltöltve.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "A módosítások sikeresen feltöltve (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült feltölteni a WS használatával. Később újra megpróbáljuk.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Módosítások feltöltése az EMusicba...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synchronisate"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Parolas de canto synchronisate non disponibile!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Predefinite del systema",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Modo de thema"),
    "title": MessageLookupByLibrary.simpleMessage("Titulo"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Legnépszerűbb zenei videók",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Videos musical plus reguardate",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Tendentias"),
    "unLink": MessageLookupByLibrary.simpleMessage("Separar"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Separate con successo!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Cím nélküli dal"),
    "upNext": MessageLookupByLibrary.simpleMessage("Postea"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Alkalmazás frissítése"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL detegite. Clicca lo pro aperir/reproducer le contento associate",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Letiltott felhasználó",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "A válasz nem tartalmazza a felhasználók listáját.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Feloldott felhasználó",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nomine de usator"),
    "video": MessageLookupByLibrary.simpleMessage("videót"),
    "videos": MessageLookupByLibrary.simpleMessage("Videos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Vider toto"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Vider le artista"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Korszerűsítettük platformunkat. A manuális biztonsági mentések feltöltésének régi rendszere le van tiltva. Mostantól két egyértelmű módon kezelheti zenei könyvtárát.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Válassza ki, hogyan szeretné ezentúl megélni az Estrella zenét.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "A te zenéd, a te módszered",
    ),
  };
}
