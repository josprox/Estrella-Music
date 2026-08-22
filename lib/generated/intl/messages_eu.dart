// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a eu locale. All the
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
  String get localeName => 'eu';

  static String m0(songTitle) => "Deskargatzen: ${songTitle}";

  static String m1(count) => "Albumak: ${count}";

  static String m2(count) => "Artistak: ${count}";

  static String m3(count) => "Gogokoak: ${count}";

  static String m4(count) => "Erreprodukzio-zerrendak: ${count}";

  static String m5(count) => "Abestiak: ${count}";

  static String m6(source) => "Migrazioa ${source}tik aurrera burutu da.";

  static String m7(error) => "Errore bat gertatu da birsortzerakoan: ${error}";

  static String m8(title) => "${title} antzekoa";

  static String m9(current) => "${current} 3ko urratsa";

  static String m10(count) => "${count} aldaketak konprometituta.";

  static String m11(count) => "${count} sinkronizatutako aldaketak.";

  static String m12(statusCode) =>
      "Ezin izan dira bilatu erabiltzaileak (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda berria sortu",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Kanalizatua"),
    "about": MessageLookupByLibrary.simpleMessage("Honi buruz"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("5 minutu gehitu"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Abestiak erreprodukzio-zerrendara gehitu",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Gehitu liburutegira"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendara gehitu",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Albuma"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Albuma markatua!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Albumaren markagailua kendua!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albumak"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Zure gustuen arabera",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Eremu guztiak bete behar dira",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Ez da probatu: 60 fitxategi baino gehiago deskargatu ondoren kontrol-laukia hautatzen baduzu, prozesuak memoria kopuru handia kontsumi dezake eta telefonoa edo aplikazioa huts egin dezake. Jarrai ezazu zure ardurapean.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Aplikazioari buruzko informazioa",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artista markatuta!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artistaren markagailua kendua!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Deskribapena ez dago eskuragarri!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistak"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Zure gustuen arabera",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audioaren kodekak"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Autentifikazio-kodea",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Sartu baliozko 6 digituko kodea edo hasi saioa berriro.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sartu 6 digituko kodea zure autentifikazio-aplikaziotik. Sarbide hau 5 minutu barru iraungiko da.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Bi faktoreko autentifikazioa",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Egiaztatu eta jarraitu",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Nire datuak erabiltzea onartzen dut...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Saio-hasiera, erregistroa eta pasahitza berreskuratzea aurreko proiektutik ekarri dugu, musika aplikazio honetara egokituta.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Zure saioa biltegiratze seguruan bizi da eta erabiltzen ari zinen backend berarekin balioztatuta dago.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      ".env fitxategia konfiguratu behar da autentifikazio backend-a konektatzeko.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Saioa hasi"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Izena eman"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Bidali posta"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Berretsi pasahitza",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Helbide elektronikoa edo pasahitza okerra.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Sartu baliozko posta elektroniko bat.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Autentifikazio-backend-a falta da .env fitxategian konfiguratzeko.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Zure kontua ez dago egiaztatuta oraindik.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Ezin izan zen operazioa amaitu.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Izena"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Pasahitza ahaztu zait",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Argibideak zure kontuko posta elektronikora bidaliko dizkizugu.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("izena@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Abizena"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Behar bezala hasi da saioa",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da mezu elektronikoa bidali.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Bidali da mezu elektronikoa.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da kontua sortu.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Kontua behar bezala sortu da.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ongi etorri Estrella Music-era",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Ongi etorri Estrella Music-era",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Abesti gustukoenak automatikoki deskargatu",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Abesti gustukoenak automatikoki deskargatu, zure gustukoenei gehitzen zaizkienean",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Ireki automatikoki erreproduzitzailearen pantaila",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Gaitu/desgaitu erreproduzitzailearen pantaila osoko irekiera automatikoa erreproduzitzeko abestia aukeratzerakoan",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Itzuli"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "Datu baseak aurkitu dira",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Atzealdeko musika erreproduzitu",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Gaitu/Desgaitu musika atzeko planoan erreproduzitzea (aplikazioa sistemaren erretilutik atzi daiteke, atzeko planoan exekutatzen ari denean)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Babeskopia egin"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Aplikazioaren datuen babeskopia egin",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Babeskopia burutzen ari da...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Babeskopia ongi gorde da!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Babeskopia-ezarpenak eta erreprodukzio-zerrendak",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Ezarpen guztiak, erreprodukzio-zerrendak eta saioa hasteko datuak babeskopia-fitxategi batean gordetzen ditu",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Saio aktibo bat behar duzu...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Berrabiarazi aplikazioa",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Kargatu babeskopia orain",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Babeskopia bat egin nahi duzu?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Babeskopia ezabatu da.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Oraindik ez dago babeskopiarik...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Babeskopia leheneratu da. Berrabiarazi aplikazioa.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Hautatu babeskopia egiteko karpeta",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Aukeratu zer datu babeskopiak egin nahi dituzun",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Babeskopia behar bezala kargatu da.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Azken interakzioan oinarritua",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bit jarioa"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda zerrenda beltza",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Ongi berrezarri da!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("-(ren) eskutik"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Hasierako pantailaren edukiaren datuak katxeatu",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Gaitu hasierako pantailako edukiaren datuak cachean gordetzea. Hasierako pantaila berehala kargatuko da aukera hau gaituta badago",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Katxeatutako abestiak"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Abestiak katxean biltegiratzearekin batera konexiorik gabe erreproduzitzeak, espazio gehigarria hartuko du zure gailuan",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Konexiorik gabe"),
    "cancel": MessageLookupByLibrary.simpleMessage("Ezeztatu"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Tenporizadorea ezeztatu",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Lo egiteko tenporizadorea bertan behera utzi da",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Irudien katxea garbitu",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Irudien katxea ongi garbitu da",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Egin klik hemen katxean gordetako irudi txikiak/irudiak garbitzeko. (Ez da gomendagarria, katxeko irudien datuak freskatu nahi ez badira behintzat)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Itxi"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Aplikazioa itxi"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Hodeiko liburutegia aurkitu da.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Hodeiko liburutegi bat aurkitu da. Gailu honek gainidatzi gabe deskargatuko du.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Hodei modua prest dago. Gailu honek lineaz kanpoko cache gisa funtzionatuko du.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Hasi saioa modu seguruan zure Joss Red kontua erabiliz.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Sartu zure erreprodukzio-zerrenda, gogoko eta historia edozein gailutatik (Windows, Android, etab.) berehala.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Lan egin lineaz kanpo eta kargatu aldaketak automatikoki Internet berreskuratzen duzunean.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktibatu Hodeiaren sinkronizazioa",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Denbora errealeko sinkronizazioa Joss Red-ekin",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Hodei modua (gomendatua)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda kolaboratiboa",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Hautatu erreprodukzio-zerrenda hau ikusi eta editatu ahal izango duten lagunak:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Kolaboratzaileak behar bezala eguneratu dira.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda komunitarioa",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Edukia"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL Lizentzia v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Sortu"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Sortu eta gehitu"),
    "customIns": MessageLookupByLibrary.simpleMessage("Instantzia lehenetsia"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Instantzia lehenetsia hautatu, mesedez",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Eguneroko aurkikuntza",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Iluna"),
    "delete": MessageLookupByLibrary.simpleMessage("Ezabatu"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Deskargetatik kendu",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Deskargetatik ongi kendu da!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Joss Estradak (JOSPROX) garatu eta mantentzen du",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Animazioak trantsizioetan kendu",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Gaitu aukera hau fitxaren trantsizio-animazioa desaktibatzeko",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Desaktibatuta"),
    "discover": MessageLookupByLibrary.simpleMessage("Deskubritu"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Baztertu"),
    "done": MessageLookupByLibrary.simpleMessage("Prest"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Ez ezazu informazio hau berriro erakutsi",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "Deskargatutako fitxategiak aurkitu dira",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Deskargatu"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Deskargatu albumeko abestiak",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Eskatutako abestia ezin da deskargatu zerbitzariaren murrizketa dela eta. Berriro saiatu",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Sareko akats baten ondorioz, deskargak huts egin du! Mesedez, saia zaitez berriro",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Deskargen kokapena",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Zure musika deskargak aktibo mantentzen ditu atzeko planoan.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "musika deskargak",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Deskargak prestatzen…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Musika deskargatzen",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Deskargatu erreprodukzio zerrenda",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Deskargatutako fitxategiaren formatua",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Hautatu deskargatzeko fitxategi-formatua. \"Opus\"-ek kalitate onena emango du",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Deskargak"),
    "duration": MessageLookupByLibrary.simpleMessage("Iraupena"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamikoa"),
    "email": MessageLookupByLibrary.simpleMessage("Posta elektronikoa"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda hutsik da!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barra nabigatzailearen botoia",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Barra nabigatzailearen botoira aldatu",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Gaitu ekintza irristagarriak",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Gaitu ekintza irristagarriak abestien fitxan",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktibatuta"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Abestiaren bukaera"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Gehitu albumeko abestiak ilaran",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Guztiak ilarara gehitu",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Abesti hau ilaran ezarri",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Gehitu abestiak ilaran",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Pasarteak"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ekualizadorea"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Sistemaren ekualizadorea ireki",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Akats bat gertatu da!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Errore bat gertatu da",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Errorea erreproduzitzean:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Esportatu"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Deskargatutako fitxategiak deskargatu",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Egin klik hemen deskargatutako fitxategia aplikazioaren barne direktoriotik kanpoko direktoriora esportatzeko",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Errorea erreprodukzio-zerrenda esportatzean",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Errorea erreprodukzio-zerrendaren datuak formateatzen",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Baimena ukatuta esportatzean",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Ez dago biltegiratze leku nahikorik",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Fitxategiak ongi esportatu dira",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda esportatu",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Esportatu erreprodukzio-zerrenda CSV gisa",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ezin da hemen inportatu",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Esportatu erreprodukzio-zerrenda JSON formatuan",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Formatu hau inportatu daiteke",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Esportatu Youtube music-era",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Zure erreprodukzio-zerrenda (50 abesti baino gutxiago) uneko ilaran jarriko du, ez ahaztu erreprodukzio-zerrendan gehitzea/gordetzea YtMusic-en ireki ondoren",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Deskargatutako fitxategiaren esportazioaren kokapena",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage(
      "Esportazioa gauzatzen...",
    ),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda esportatzen...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Gustukoenak"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Nabarmendutako erreprodukzio-zerrendak",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Fitxategia ez da aurkitu",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Jarraitu"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("jarraitu zuen"),
    "following": MessageLookupByLibrary.simpleMessage("Jarraian"),
    "for1": MessageLookupByLibrary.simpleMessage("-(r)entzat"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "gogoko ahaztuak",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Laguna"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Lagun eskaera onartu da",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Lagun eskaera bidali da",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Lagunak"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Hasi saioa lagunak bilatzeko.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Adiskidetasuna kenduta",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Albuma"),
    "genericError": MessageLookupByLibrary.simpleMessage("Akatsa"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronika"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazza"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latina"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Harkaitza"),
    "gesture": MessageLookupByLibrary.simpleMessage("Keinuen bitartekoa"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Kode iturria ikusi Github-en.\nProiektua gustukoa baduzu, ez ahaztu ⭐ ematea",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Albumera joan"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Egin klik hemen deskarga orrira joateko",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Kaixo mundua"),
    "high": MessageLookupByLibrary.simpleMessage("Altua"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL kanalizatutako instantziara",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Menu Nagusia"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Orrialde nagusiaren edukiaren kontaketa",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Hasierako pantailaren hasierako edukiaren zenbakia hautatu (gutxi gora-behera). Zenbat eta emaitza gutxiago, hainbat eta karga azkarragoa",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Identifikatzailea"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Bateriaren optimizazioa alde batera utzi",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Sistemaren optimizazioa dela-eta, jakinarazpen- edo erreprodukzio-arazoak badituzu, mesedez, gaitu aukera hau",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Errorea erreprodukzio-zerrenda inportatzean",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Errorea datu-basean gordetzean",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da hautatutako fitxategira sartu",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Fitxategi formatu baliogabea",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Oharra: baliteke erreprodukzio-zerrenda handiak inportatzeko denbora gehiago behar izatea",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Inportatu erreprodukzio-zerrenda",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Hautatu inportatzeko aurretik esportatutako erreprodukzio-zerrenda JSON fitxategi bat",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Inportatua"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlin-etik inportatua",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Inportatutako erreprodukzio-zerrenda",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda inportatzen...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Barne biltegiratze direktorioa",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Barne hartu deskargatutako abestien fitxategiak",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informazioa ez dago eskuragarri",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendaren fitxategi-egitura baliogabea",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Zerbitzariaren erantzun baliogabea.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Saioak ez du baliozko token bat.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("gaiak"),
    "keepListening": MessageLookupByLibrary.simpleMessage("jarraitu entzuten"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Mantendu pantaila piztuta erreproduzitzen den bitartean",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Gaituta badago, gailuaren pantaila piztuta egongo da musika erreproduzitzen den bitartean",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Hizkuntza"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Aplikazioaren hizkuntza hautatu",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Azken bertsioa"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Eskuragarri dagoen azken bertsioa",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Has gaitezen..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Musikategiko albumak"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Musikategiko artistak"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Musikategiko erreprodukzio-zerrendak",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Musikategiko abestiak"),
    "library": MessageLookupByLibrary.simpleMessage("Musikategia"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Liburutegiko erreprodukzio zerrenda",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Argia"),
    "link": MessageLookupByLibrary.simpleMessage("Esteka"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Estekatzea burutu da!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Esteka arbelean kopiatu da",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendarentzat esteka kanalizazioarekin",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Entzun orain"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Ingurumena entzuten...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da eguneratze-informazioa kargatu",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokala"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Saioa hasi beharrik gabe funtzionatzen du.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Zure liburutegi osoa zorrozki geratzen da ordenagailu honetan.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Oharra: ez dago eskuzko babeskopiarik hodeian. Zure gailua galtzen baduzu edo aplikazioa desinstalatzen baduzu, ezin izango dira zure datuak berreskuratu.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Erabili gailu honetan soilik",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Erabateko pribatutasuna zure gailuan",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Tokiko modua"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("OzentasunaDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Sonoritatearen normalizazioa",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Abesti guztietarako distira bera ezartzen du (Esperimentala) (Ez du aurreko bertsioan deskargatutako abestietan lan egingo (< 1.10.0 bertsioa))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Baxua"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Letrak"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Letrak ez dira eskuragarri!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Kudeatu kolaboratzaileak (lagunak)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Ziurtatu mikrofonoaren ondoan musika nahikoa ozen jotzen ari dela.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migratutako albuma"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Migratutako liburutegia",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migratutako erreprodukzio-zerrenda",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Dagoeneko migrazio bat dago martxan.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Herriko liburutegia aztertzen...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud dagoeneko liburutegirik duen egiaztatzen...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migrazioa amaitu da.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Hodeia konektatu aurretik tokiko babeskopia bat sortzen...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migrazioak huts egin du. Zure tokiko datuak ez dira aldatu.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Hasi saioa Joss Red-en migratu aurretik.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud-en migrazioa prestatzen...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud-ek ezin izan du migrazioa hasi.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Ezin izan dira datu guztiak kargatu. Zure tokiko laguntza mantentzen dugu.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio zerrendak, gogokoak eta historia kargatzen...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud-ek ezin izan du migrazioa balioztatu.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud-en osotasuna egiaztatzen...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Hautatu fitxategia eta inportatu",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Hautatu song.db edo backup .backup bat",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migrazioa behar bezala burutu da.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutu"),
    "misc": MessageLookupByLibrary.simpleMessage("Miszelanea"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Gehien entzuten den abestia",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musika eta erreprodukzioa",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Musika Aitorpena",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Errorea sarean! Konproba ezazu zure konexioa.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Sareak arazoren bat du!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Bertsio berria eskuragarri dago!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red aplikazioa (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Ulertua"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "% 100eko sinkronizazioa Joss Red-ekin, lagunekin erreprodukzio-zerrendak eta askoz gehiago. Sakatu zer berri dagoen ikusteko.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Musikak eboluzionatu du!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Lagunak gehitzeko, eskaerak onartzeko edo zure segurtasun-profila kudeatzeko, erabili Joss Red bere plataforma ofizialetan:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Lagunak eta kontuen kudeaketa:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Sortu erreprodukzio-zerrendak zure lagunekin! Erreprodukzio-zerrenda bat sortzean, hautatu Elkarlaneko kontrol-laukia eta aukeratu zure lagunak elkarrekin editatzeko.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Lankidetza-zerrendak",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Zure erreprodukzio-zerrendak eta gogokoenak hodeian automatikoki gordetzen eta sinkronizatzen dira zure Joss Red kontu nagusiarekin.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integrazio osoa Joss Red-ekin",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Jada ez duzu eskuzko sinkronizazio botoiak sakatu behar; Motor berria automatikoki gora eta behera aldatzeaz arduratzen da.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sinkronizazio gardena",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Ez"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Markagailurik ez!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Ez duzu lagunik gehitu Joss Red-en.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ez duzu erreprodukzio-zerrendarik!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da abestirik aurkitu grabatutako audioan",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Partidurik ez"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Ez dago lineaz kanpoko abestirik!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Bilduma honetan ez dago abestirik",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Ez da emaitzarik aurkitu honentzat",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Ez autentifikatu",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Ez dago abesti/musika-bideorik!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Esteka ez da baliozkoa!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Ireki hemen"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Eragiketak huts egin du",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Pasahitza"),
    "password_text": MessageLookupByLibrary.simpleMessage("Pasahitza"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("baimena ukatua"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Baimendu"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music-ek baimen hauek behar ditu zure musika kudeatzeko eta erreproduzitzeko eginbide guztiak eskaintzeko.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Hasteko baimenak",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Eman beharrezko baimenak",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Zure inguruan jotzen ari den abesti bat identifikatzea aukeratzen duzunean bakarrik erabiltzen da.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofonoa",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio kontrolak, deskargaren aurrerapena eta aplikazioen ohar garrantzitsuak erakusten ditu.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Jakinarazpenak",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Ezarpenak",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Hiru baimenak behar dira jarraitzeko. Geroago alda ditzakezu sistemaren ezarpenetan.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Musika erreproduzitzeko, deskargak gordetzeko, erreprodukzio zerrendak esportatzeko eta eguneraketak prestatzeko aukera ematen du.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musika eta biltegiratzea",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Pertsonalizazioa"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda kanalizatua",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Kanalizatutako erreprodukzio-zerrenda sinkronizatuta!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Soila"),
    "play": MessageLookupByLibrary.simpleMessage("Ugaldu"),
    "playNext": MessageLookupByLibrary.simpleMessage("Hurrengoa jo"),
    "playNow": MessageLookupByLibrary.simpleMessage("Jokatu orain"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio abiadura",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage(
      "Erreproduzitzailearen erabiltzaile-interfazea",
    ),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Erreproduzitzailearen erabiltzaile-interfazea hautatu",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Jolasean:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "ALBUMETIK ERREPRODUZITZEN",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "ARTISTATIK ERREPRODUZITZEN",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "ERREPRODUKZIO-ZERRENDATIK ERREPRODUZITZEN",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "HAUTAKETATIK ERREPRODUZITZEN",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Erreprodukzio-zerrenda"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda zerrenda beltzera pasa da!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda markatuta!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendaren markagailua kendua!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenden laguntzaileak",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda sortua!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda sortua eta abestia gehituta!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda arrakastaz esportatu da hona",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda behar bezala inportatu da",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda kendua!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Berrizendaketa ongi gauzatu da!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendak",
    ),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Jarraian entzungai"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcastak"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Ibilbide ezagunak"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Fitxategiak prozesatzen...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Audioa prozesatzen...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profilak"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Ilara buklean entzun"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Ilara buklean entzuteko modua ezin da desaktibatu, ausazko modua aktibatuta dagoenean.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Ilara buklean entzuteko modua ezin da aktibatu, irrati modua aktibatuta dagoenean.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Ilara ezin da nahastu, ausazko modua aktibatuta dagoenean",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Ilara ezin da berrantolatu, ausazko modua aktibatuta dagoenean",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Aukeraketa azkarra"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Hautaketa azkarrak"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Irratia ez dago eskuragarri artista honentzat!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Ausazko Irratia"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Ausazko Hautaketa",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda berrantolatu",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Abestiak berrantolatu",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Irakurri gehiago"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Azken bilaketak"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Berriki entzundakoak",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Hodei modua aktibatzea gomendatzen dugu Spotify antzeko esperientzia baterako: zure gailu guztien arteko denbora errealeko sinkronizazioa eta babeskopia automatikoa ezer egin beharrik gabe.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Gomendagarria"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Gomendagarria"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("Kendu cachetik"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Abestien bildumatik kendu",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Ezabatu liburutegitik",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrendatik kendu",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Ilaratik kendu"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Hainbat abesti ezabatu",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda ezabatu",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Berrizendatu"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Erreprodukzio-zerrenda berrizendatu",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Erreproduzitua"),
    "reset": MessageLookupByLibrary.simpleMessage("Berrezarri"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Berrezarri lehenetsitako ezarpenak",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Berrezarri aplikazioaren ezarpenak lehenespenetara (Berrabiarazi behar da)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Ezarpenak lehenetsitakoetara itzultzea gauzatu da, Berrabiarazi aplikazioa, mesedez",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Zerrenda beltzean dauden erreprodukzio-zerrendak berrezarri dira",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Berrezarri kanalizatutako zerrenda beltzeko zerrenda guztiak",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Aplikazioa berrabiarazi",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Berreskuratu"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Berrezarri aplikazioaren datuak",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Azken erreprodukzio-saioa berrezarri",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Aplikazioaren hasieran, azken erreprodukzio-saioa automatikoki berrezarri",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Ongi berrezarri da!\nAldaketak aplikatuko dira berrabiarazi ondoren",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Berrezarri ezarpenak eta erreprodukzio-zerrendak",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Babeskopia fitxategi batetik ezarpen guztiak, saioa hasteko datuak eta erreprodukzio-zerrendak leheneratzen ditu. Uneko datu guztiak gainidazten ditu",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Hautatu babeskopia fitxategia",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Berrezartzen..."),
    "results": MessageLookupByLibrary.simpleMessage("Emaitzak"),
    "retry": MessageLookupByLibrary.simpleMessage("Saiatu berriro!"),
    "save": MessageLookupByLibrary.simpleMessage("Mantendu"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Gorde"),
    "scanning": MessageLookupByLibrary.simpleMessage("Eskaneatzea burutzen..."),
    "search": MessageLookupByLibrary.simpleMessage("Bilatu"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Abestiak, erreprodukzio-zerrenda, albuma edo artista",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Bilatu Liburutegian",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Bilaketaren emaitzak"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Azken bilaketak",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Denak hautatu"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Hautatu autentifikaziorako instantzia",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Mesedez, hautatu autentifikazio instantzia!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Hautatu fitxategia"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Abestiak hautatu"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Hautatutako fitxategia ez da aurkitu.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Zure saioa iraungi da. Hasi saioa berriro.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Detekzio-edukia ezarri",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Ezarpenak"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Estrella Music buruz",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Bertsioa, kode irekiko proiektua eta GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Kontua eta sinkronizazioa",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Hodei modua, babeskopiak, lagunen zerrenda eta migrazioak.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Gaia, hizkuntza eta interfazearen animazioak.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Hodeiko babeskopia",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Kargatu, leheneratu eta kudeatu...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Kargatu aplikazioaren .hmb babeskopia zerbitzarira eta, behar izanez gero, leheneratu gordetako babeskopietako bat.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Ezagutu iragazkiak, Piped-ekin eta cacheekin integratzea.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Deskargak eta biltegiratzea",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Audio formatuak, karpetak eta deskarga automatikoak.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Orokorra",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Aukeratu, migratu edo berrikusi Joss Red-ekin sinkronizazio-egoera.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Tokiko modua / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Amaitu saioa"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Inportatu erreprodukzio zerrendak, abestiak...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migratu Joss Music Kotlin-etik",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("nire lagunak"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Kudeatu Joss Red lagunak zuzenean.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streaming kalitatea, normalizazioa, isiluneak eta bateria.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Sortu zure YouTube Music ID Discover edukia kargatzen ez bada.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Freskatu IDa (Bisitariaren IDa)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Akatsa"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da identifikatzaile berririk sortu. Saiatu berriro geroago.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identifikatzailea eguneratua",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Bisitari ID berri bat behar bezala sortu da.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Partekatu albuma"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Partekatu erreprodukzio zerrenda",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Abestia partekatu"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Shazam datu-basean partidak bilatzen...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Ausazko"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Ilara nahastu"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Single-ak"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Isiltasuna hautsi"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Isiltasuna ez da musika erreproduzitzean izango",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Lo egiteko tenporizadorea ezarrita dago",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Tenporizadorea"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Abestia erreprodukzio-zerrendara gehitu da!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Abestia existitzen da jada!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Abestia dagoeneko konexiorik gabe katxean",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Abestia ilaran jarrita!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Abestia aurkitu!"),
    "songInfo": MessageLookupByLibrary.simpleMessage(
      "Abestiari buruzko informazioa",
    ),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Abestia ezin da erreproduzitu, zerbitzariak dituen mugengatik!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("abestiaren tonua"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Hemendik kenduta",
    ),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Ilaratik kendu da!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Ezin duzu kendu erreproduzitzen ari den abestia",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Abestiak"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlin-etik inportatutako abestiak",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Goranzko/beheranzko ordenatu",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage(
      "Ordenatu dataren arabera",
    ),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Ordenatu iraupenaren arabera",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage(
      "Ordenatu izenaren arabera",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Abiadura eta Pitch"),
    "standard": MessageLookupByLibrary.simpleMessage("Estandarra"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Irratia abiatu"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Ireki abiaraztean"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Aukeratu Estrella Music-ek lehenik irekitzen duen atala",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Egoera"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Gelditu musika zereginen garbiketa burutzerakoan",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Musika-erreprodukzioa geldituko da aplikazioa zeregin-kudeatzailetik urruntzen denean",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Zuzenekoaren kalitatea",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Zuzeneko musikaren kalitatea",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("harpidedun"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Irristatu aukerak arakatzeko",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Hodei modua aktibatuta dago. Lehendik dagoen liburutegia deskargatzea.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Hodei modua aktibatuta dago. Migratutako liburutegia.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Hodei modua aktibo",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Hodei modua aktibo. Sinkronizazioa zain.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da deskargatu sinkronizazioa.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "EMusic aldaketak deskargatzen...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Liburutegi sinkronizatua.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Liburutegia eguneratuta.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Tokiko aldaketa berriak daude. Deskargatu aurretik igoko dira.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Zure datuak gailu honetan soilik gordetzen dira.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Tokiko modua aktibo",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Lineaz kanpo. Aldaketak zain daude.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Lineaz kanpo. Aldaketak gorde dira berriro saiatzeko.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sinkronizatu erreprodukzio-zerrendako abestiak",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic-ek ez ditu aldaketa guztiak baieztatu. Berriro epaituko dira.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Ezin altxatu. Beranduago saiatuko da.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Aldaketak behar bezala kargatu dira.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Aldaketak behar bezala kargatu dira (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Ezin izan da kargatu WS erabiliz. Beranduago saiatuko da.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "EMusic-era aldaketak kargatzen...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sinkronizatuta"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sinkronizatutako letrak ez dira eskuragarri!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Sistemak lehenetsitakoa",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Gaiak"),
    "title": MessageLookupByLibrary.simpleMessage("Titulua"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Musika-bideo nagusiak",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Bideo musikal onenak",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Joerak"),
    "unLink": MessageLookupByLibrary.simpleMessage("Esteka ezabatu"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Estekagabetzea ongi burutu da!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage(
      "Izenbururik gabeko abestia",
    ),
    "upNext": MessageLookupByLibrary.simpleMessage("Jarraian"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Eguneratu aplikazioa"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Url-a detektatu da. Bertan klik egin, lotutako edukia ireki/erreproduzitzeko",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Blokeatutako erabiltzailea",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Erantzunak ez du erabiltzaileen zerrendarik.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Erabiltzailea desblokeatua",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Erabiltzailea"),
    "video": MessageLookupByLibrary.simpleMessage("Bideoa"),
    "videos": MessageLookupByLibrary.simpleMessage("Bideoak"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Denak ikusi"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Artista ikusi"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Gure plataforma modernizatu dugu. Eskuzko babeskopiak kargatzeko sistema zaharra desgaitu da. Orain zure musika liburutegia kudeatzeko bi modu argi dituzu.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Aukeratu hemendik aurrera Estrella Music nola bizi nahi duzun.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Zure musika, zure erara",
    ),
  };
}
