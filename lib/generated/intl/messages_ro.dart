// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ro locale. All the
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
  String get localeName => 'ro';

  static String m0(songTitle) => "Se descarcă: ${songTitle}";

  static String m1(count) => "Albume: ${count}";

  static String m2(count) => "Artiști: ${count}";

  static String m3(count) => "Favorite: ${count}";

  static String m4(count) => "Liste de redare: ${count}";

  static String m5(count) => "Cântece: ${count}";

  static String m6(source) => "Migrarea a fost finalizată de la ${source}.";

  static String m7(error) =>
      "A apărut o eroare în timpul regenerării: ${error}";

  static String m8(title) => "Similar cu ${title}";

  static String m9(current) => "Pasul ${current} din 3";

  static String m10(count) => "${count} modificări efectuate.";

  static String m11(count) => "${count} modificări sincronizate.";

  static String m12(statusCode) =>
      "Nu s-au putut căuta utilizatori (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Creează playlist",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Despre"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Adaugă 5 minute"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Adăugați melodii la playlist",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Adăugați în bibliotecă",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("Adaugă la playlist"),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Albumul a fost marcat.",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcajul albumului a fost eliminat!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albume"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Dupa gusturile tale",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Toate câmpurile obligatorii",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Netestat: selectând caseta de selectare după descărcarea a peste 60 de fișiere, procesul poate consuma o cantitate mare de memorie și poate cauza blocarea telefonului sau a aplicației. Continuați pe risc propriu.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Despre aplicație"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artistul a fost marcat!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcajul artistului a fost eliminat!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Descrierea nu este disponibilă!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artiști"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Dupa gusturile tale",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Codec audio"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Cod de autentificare",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Introduceți un cod valid din 6 cifre sau conectați-vă din nou.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Introdu codul din 6 cifre din aplicația de autentificare. Acest acces expiră în 5 minute.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Autentificare cu doi factori",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Verificați și continuați",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Sunt de acord să-mi folosesc datele...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Am adus login-ul, înregistrarea și recuperarea parolei din proiectul anterior, adaptate pentru această aplicație muzicală.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Sesiunea dvs. se află în spațiu de stocare securizat și este validată cu același backend pe care îl utilizați deja.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Fișierul .env trebuie configurat pentru a conecta backend-ul de autentificare.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Log in"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Registru"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Trimite mail"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirmați parola",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "E-mail sau parolă incorectă.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Introduceți un e-mail valid.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Backend-ul de autentificare lipsește pentru a fi configurat în fișierul .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Contul dvs. nu este încă verificat.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Operația nu a fost posibilă.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Prenume"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Mi-am uitat parola",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vă vom trimite instrucțiunile pe e-mailul contului dvs.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nume@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Nume"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Conectat cu succes",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Nu s-a putut trimite e-mailul.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-mail trimis.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Contul nu a putut fi creat.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Cont creat cu succes.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Bun venit la Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Bun venit la Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Descarcă automat melodiile preferate",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Descărcați automat melodiile preferate atunci când sunt adăugate la favorite",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Deschide automat ecranul de redare",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Activați/dezactivați deschiderea automată a ecranului complet al playerului la selectarea melodiei pentru redare",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Reveni"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "baze de date găsite",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Redarea muzicii în fundal",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Activează/Dezactivează redarea muzicii în fundal (Aplicația va putea fi accesată din tăvița de sistem când aplicația rulează în fundal)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Arhivează datele aplicației",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Backup în curs...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Backup salvat cu succes!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Setări de rezervă și liste de redare",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Salvează toate setările, listele de redare și datele de conectare într-un fișier de rezervă",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Ai nevoie de o sesiune activa...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Reporniți aplicația",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Încărcați acum backup",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Doriți să faceți o copie de rezervă?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Backup șters.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Nu există încă copii de rezervă...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Backup restaurat. Reporniți aplicația.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Selectați folderul pentru backup",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Alegeți ce date să faceți backup",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Backup încărcat corect.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Bazat pe ultima interacțiune",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista neagră de redare",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Resetare cu succes!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("de"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Salvează conținutul ecranului acasă",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Activează salvarea conținutului ecranului Acasă, ecranul Acasă se va încărca instant când această opțiune este activată",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Melodii în Cache"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Salvarea melodiilor în cache în timpul redării pentru redare viitoare/offline, va ocupa spațiu suplimentar pe dispozitiv",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("În Cache/Offline"),
    "cancel": MessageLookupByLibrary.simpleMessage("Anulează"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Anulați cronometrul"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Cronometrul somn anulat",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Șterge imaginile salvate",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Imaginile salvate au fost șterse cu succes",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Apasă aici ca să ștergi miniaturile/imaginile. (Nu este recomandat doar daca vrei sa reîmprospătezi imaginiile)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Închide"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Închideți aplicația"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Bibliotecă cloud găsită.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "A fost găsită o bibliotecă cloud. Acest dispozitiv îl va descărca fără a-l suprascrie.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Modul cloud este gata. Acest dispozitiv va funcționa ca cache offline.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Conectați-vă în siguranță utilizând contul dvs. Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Accesați-vă listele de redare, favoritele și istoricul de pe orice dispozitiv (Windows, Android etc.) instantaneu.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Sincronizare inteligentă: lucrați offline și încărcați automat modificările atunci când recuperați internetul.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Activați sincronizarea cloud",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronizare în timp real cu Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modul cloud (recomandat)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Playlist de colaborare",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Selectați prietenii care vor putea vedea și edita această listă de redare:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Colaboratorii au actualizat corect.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlist-urile Comunității",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Conținut"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOPROX. Licență GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Creează"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Crează și adăugă"),
    "customIns": MessageLookupByLibrary.simpleMessage("Instanță personalizată"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Selectează instanța personalizată",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Descoperire zilnică",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Întunecat"),
    "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Eliminați din descărcări",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Eliminate cu succes din descărcări!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Dezvoltat și întreținut de Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Oprește animația de tranziție",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Activează această opțiune pentru a dezactiva animația de tranziție a filei",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Dezactivat"),
    "discover": MessageLookupByLibrary.simpleMessage("Descoperă"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Omite"),
    "done": MessageLookupByLibrary.simpleMessage("Gata"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Nu mai arăta această informație",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "fișiere descărcate găsite",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Descarcă"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Descărcați melodii de pe album",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Melodia cerută nu poate fi descărcată din cauza unei restricții de la server. Poți încerca încă o dată",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Descărcarea a eșuat din cauza unei erori de rețea. Vă rugăm să încercați încă o dată",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Locația Descărcării",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Păstrează descărcările muzicale active în fundal.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "descărcări de muzică",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Se pregătesc descărcările…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Descărcarea muzicii",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Descărcați lista de redare",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Formatul fișierului de descărcat",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Selectează formatul fișierului de descărcat. \"Opus\" va furniza cea mai înaltă calitate",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Descărcări"),
    "duration": MessageLookupByLibrary.simpleMessage("Durată"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamic"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Playlist gol!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Bara de navigare de jos",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Comutați la bara de navigare de jos",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Activează acțiuni cu glisare",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Activează acțiuni cu glisare pe cartonașul melodiei",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activat"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Sfârșitul acestei melodii",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Adăugați melodii din album în coadă",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Pune toate în coadă"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Pune în coadă"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Adăugați melodii în coadă",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episoade"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Egalizator"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Deschide egalizatorul de sistem",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "A apărut o eroare!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("A apărut o eroare"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Eroare la redare:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportă"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportă fișierele descărcate",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Apasă aici să exporți fișierele descărcate din directorul aplicației într-un director extern",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Eroare la exportarea listei de redare",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Eroare la formatarea datelor playlistului",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Permisiune refuzată la export",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Spațiu de depozitare insuficient",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Fișierele au fost exportate cu succes",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportați lista de redare",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportați lista de redare ca CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nu se poate importa aici",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportați lista de redare în JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Acest format poate fi importat",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportați muzică pe Youtube",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Acesta vă va împinge lista de redare (melodii < 50) în coada curentă, nu uitați să o adăugați la lista de redare/salvare după ce o deschideți în YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Locația fișierului descărcat",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Se exportă..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Se exportă lista de redare...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorite"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlist-uri Recomandate",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Fișierul nu a fost găsit",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Continua"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("urmat"),
    "following": MessageLookupByLibrary.simpleMessage("Urmând"),
    "for1": MessageLookupByLibrary.simpleMessage("pentru"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "favorite uitate",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Prietene"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Cerere de prietenie acceptată",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Solicitare de prietenie trimisă",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Prieteni"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Conectați-vă pentru a găsi prieteni.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Prietenia eliminată",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Greşeală"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Electronice"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("stâncă"),
    "gesture": MessageLookupByLibrary.simpleMessage("Mișcare"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Vezi codul sursă în GitHub\ndacă îți place acest proiect, nu uita să ne dai o stea",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Vezi albumul"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Apasă aici să mergi la pagina de descărcare",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Salut Lume"),
    "high": MessageLookupByLibrary.simpleMessage("Ridicat"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL la instanța Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Acasă"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Numărul conținutului de acasă",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Alege numărul de elemente inițiale de pe ecranul de acasă(aprox). Mai puține elemente conduc la încărcare mai rapidă",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignoră optimizarea bateriei",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Dacă întâmpini probleme cu notificarea sau redarea este oprită de optimizarea sistemului, te rog activează această opțiune",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Eroare la importarea listei de redare",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Eroare la salvarea în baza de date",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Fișierul selectat nu a putut fi accesat",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Format de fișier nevalid",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Notă: importarea listelor de redare mari poate dura mai mult",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importă lista de redare",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Selectați un fișier JSON de listă de redare exportat anterior pentru a importa",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importat"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importat de la Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de redare importată",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Se importă lista de redare...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Director de stocare internă",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Includeți fișierele de melodii descărcate",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informații nu sunt disponibile",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Structura fișierului playlist nevalidă",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Răspuns server nevalid.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Sesiunea nu conține un token valid.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elemente"),
    "keepListening": MessageLookupByLibrary.simpleMessage(
      "asculta in continuare",
    ),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Păstrează ecranul aprins în timpul redării",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Dacă este activat, ecranul dispozitivului va rămâne aprins în timp ce muzica se redă",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Limbă"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Setați limba aplicației",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Ultima lansare"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Ultima versiune disponibilă",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Sa incepem.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Biblioteca de albume"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Biblioteca de artiști"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Biblioteca de playlist-uri",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Biblioteca de melodii"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotecă"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de redare a bibliotecii",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Luminos"),
    "link": MessageLookupByLibrary.simpleMessage("Conectează"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Conectat cu succes!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link copiat în clipboard",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Conectează cu Piped pentru liste",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Ascultă acum"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Ascultând mediul înconjurător...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Nu s-au putut încărca informațiile de actualizare",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Funcționează fără a fi nevoie să vă autentificați.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Întreaga dvs. bibliotecă rămâne strict pe acest computer.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Notă: Nu există copii de rezervă manuale în cloud. Dacă vă pierdeți dispozitivul sau dezinstalați aplicația, datele dvs. nu pot fi recuperate.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Utilizați numai pe acest dispozitiv",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Confidențialitate absolută pe dispozitivul dvs",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Modul local"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalizarea Volumului",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Setează același volum pentru toate melodiile (Experimental) (Nu o să funcționeze pentru melodiile descărcate pe versiuni anterioare(< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Scăzut"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Scrisori"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Versuri indispensabile!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Gestionați colaboratorii (prietenii)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Asigurați-vă că muzica este redată suficient de tare lângă microfon.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Album migrat"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Bibliotecă migrată",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de redare migrată",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Există deja o migrație în curs.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analizând biblioteca locală...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Se verifică dacă EMusic Cloud are deja o bibliotecă...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migrația s-a încheiat.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Se creează o copie de rezervă locală înainte de a vă conecta la cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migrarea a eșuat. Datele dvs. locale nu au fost modificate.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Conectați-vă la Joss Red înainte de a migra.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Se pregătește migrarea în EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nu a putut începe migrarea.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Nu toate datele au putut fi încărcate. Vă păstrăm sprijinul local.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Se încarcă liste de redare, favorite și istoric...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nu a putut valida migrarea.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Se verifică integritatea în EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Selectați fișierul și importați",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selectați song.db sau o copie de rezervă .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migrarea a fost finalizată cu succes.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minute"),
    "misc": MessageLookupByLibrary.simpleMessage("Diverse"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Cea mai ascultată melodie",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage("Muzică & Redare"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Recunoașterea muzicii",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Eroare la rețea! Verifică conexiunea la internet.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Ups, eroare de rețea!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "O nouă versiune este disponibilă!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplicația Joss Red (Magazin Play)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Înțeles"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronizare 100% cu Joss Red, liste de redare cu prietenii și multe altele. Atingeți pentru a vedea ce este nou.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music a evoluat!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Pentru a adăuga prieteni, pentru a accepta solicitări sau pentru a vă gestiona profilul de securitate, vă rugăm să utilizați Joss Red pe platformele sale oficiale:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Prieteni și gestionarea contului:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Creează liste de redare cu prietenii tăi! Când creați o listă de redare, bifați caseta de selectare Colaborare și alegeți prietenii pentru a edita împreună.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Liste de redare colaborative",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Listele de redare și favoritele tale sunt acum salvate și sincronizate în cloud automat cu contul tău principal Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integrare completă cu Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Nu mai trebuie să faceți clic pe butoanele de sincronizare manuală; Noul motor este responsabil pentru schimbarea automată în sus și în jos.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sincronizare transparentă",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Nu"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Nu sunt marcaje!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Nu ai niciun prieten adăugat pe Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Nu ai nici un playlist în bibliotecă!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Nu s-a putut găsi nicio melodie în audio înregistrat",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Fără meciuri"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Nu aveți melodii offline!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Nu există cântece în această colecție",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Nici o potrivire nu a fost găsită",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Neautentificat"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Nu este o Melodie/Videoclip!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Nu este un link valid!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Deschide cu"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Operațiunea a eșuat",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Parolă"),
    "password_text": MessageLookupByLibrary.simpleMessage("Parolă"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("acces refuzat"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Permite"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music are nevoie de aceste permisiuni pentru a vă gestiona muzica și pentru a oferi toate funcțiile de redare.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Permisiuni pentru a începe",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Acordați permisiunile necesare",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Este folosit doar atunci când alegeți să identificați o melodie care se cântă în jurul vostru.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Microfon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Afișează comenzile de redare, progresul descărcării și notificări importante despre aplicații.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Notificări",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("Setări"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Toate cele trei permise sunt necesare pentru a continua. Le puteți modifica mai târziu în setările sistemului.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Vă permite să redați muzică, să salvați descărcări, să exportați liste de redare și să pregătiți actualizări.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Muzică și stocare",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalizare"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Listă de redare cu canalizare",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped playlist sincronizat!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Simplu"),
    "play": MessageLookupByLibrary.simpleMessage("Reproduce"),
    "playNext": MessageLookupByLibrary.simpleMessage(
      "Redă după melodia actuală",
    ),
    "playNow": MessageLookupByLibrary.simpleMessage("Joacă acum"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Viteza de redare"),
    "playerUi": MessageLookupByLibrary.simpleMessage("Interfață Player"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Alege interfața pentru player",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Joc:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SE REDĂ DIN ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SE REDĂ DE LA ARTIST",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "SE REDĂ DIN PLAYLIST",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "SE REDĂ DIN SELECȚIE",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Lista de redare"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist adăugat pe lista neagră!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist adăugat la marcaje!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcajul listei a fost eliminat!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Colaboratori la playlist",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Listă a fost creată!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist-ul fost creat și melodia adăugată!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Lista de redare a fost exportată cu succes în",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Lista de redare a fost importată cu succes",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist-ul a fost eliminat!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Redenumită cu succes!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Playlist-uri"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Urmează"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasturi"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Piese populare"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Se procesează fișiere...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Se procesează audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiluri"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Repetare coadă"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Modul repetare coadă nu poate fi dezactivat atunci când modul aleatoriu este activat.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Modul repetare coadă nu poate fi activat în modul radio.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Coada nu poate fi amestecată când redarea aleatoare este activată",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Coada nu poate fi reordonată când redarea aleatoare este pornită",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Selecție rapidă"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Alegeri rapide"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio nu este disponibil pentru acest artist!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Radio aleatoriu"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Selecție aleatoare",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Reordonează playlist",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Reordonați melodiile",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Citeşte mai mult"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Căutări recente"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Redat recent"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Vă recomandăm să activați modul Cloud pentru o experiență asemănătoare Spotify: sincronizare în timp real între toate dispozitivele dvs. și backup automat fără a fi nevoie să faceți nimic.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Recomandat"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Recomandat"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Scoateți din cache",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Eliminați din Biblioteca de Melodii",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Ștergeți din bibliotecă",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Elimină din playlist",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Elimină din coadă",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Eliminați mai multe melodii",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Ștergeți playlist"),
    "rename": MessageLookupByLibrary.simpleMessage("Redenumește"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Redenumiți playlist",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproduce de"),
    "reset": MessageLookupByLibrary.simpleMessage("Resetează"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restaurează setările implicite",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Resetează setările aplicației la cele implicite (Restart necesar)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Restaurarea setărilor implicite este completă, te rog restartează aplicația",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Resetează playlist-urile din lista neagră",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Resetați toate playlist-urile incluse pe lista neagră",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Reporniți aplicația"),
    "restore": MessageLookupByLibrary.simpleMessage("Restabilește"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restaurați datele aplicației",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurați ultima sesiune de redare",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaurează automat ultima sesiune de redare când pornește aplicația",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Restaurat cu succes! \nModificările se aplică la repornire",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Restabiliți setările și listele de redare",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restabilește toate setările, datele de conectare și listele de redare dintr-un fișier de rezervă. Suprascrie toate datele curente",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selectați fișierul de rezervă",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Se restabilește..."),
    "results": MessageLookupByLibrary.simpleMessage("Rezultate"),
    "retry": MessageLookupByLibrary.simpleMessage("Reîncercare!"),
    "save": MessageLookupByLibrary.simpleMessage("Păstrează"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Salvat"),
    "scanning": MessageLookupByLibrary.simpleMessage("Se scanează..."),
    "search": MessageLookupByLibrary.simpleMessage("Căutare"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Melodii, Playlist, Album sau Artist",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Căutați în bibliotecă",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Rezultatele căutării"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Căutări recente",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Selectați toate"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Selectează instanța Auth",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Selectează instanța de autentificare",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Selectați Fișier"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Selectați melodii"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Fișierul selectat nu a fost găsit.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Sesiunea dvs. a expirat. Conectați-vă din nou.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Setați descoperire conținut",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Setări"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Despre Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versiune, proiect open source și GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Cont și sincronizare",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Modul cloud, copii de rezervă, lista de prieteni și migrări.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Animații cu temă, limba și interfață.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Backup în cloud",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Încărcați, restaurați și gestionați...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Încărcați o copie de rezervă .hmb a aplicației pe server și, dacă este necesar, restaurați oricare dintre copiile de rezervă salvate.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Descoperiți filtre, integrare cu Piped și cache.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Descărcări și stocare",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Formate audio, foldere și descărcări automate.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("General"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Alegeți, migrați sau revizuiți starea de sincronizare cu Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Mod local / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Deconectați-vă"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importă liste de redare, melodii...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrați de la Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "Prietenii mei",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Gestionați-vă direct prietenii Joss Red.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Calitate streaming, normalizare, tăcere și baterie.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Regenerați ID-ul dvs. de muzică YouTube dacă conținutul Discover nu se încarcă.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Actualizați ID (ID vizitator)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Greşeală"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Nu a putut fi generat un nou identificator. Vă rugăm să încercați din nou mai târziu.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identificator actualizat",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Un nou ID de vizitator a fost generat cu succes.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Partajați albumul"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Partajați lista de redare",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage(
      "Trimite această melodie",
    ),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Se caută potriviri în baza de date Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Aleatoriu"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Amestecă Coada"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Sari peste liniște"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Liniștea va fi omisă în timpul redării",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Cronometrul somn setat",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sleep Timer"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Melodia a fost adăugată la playlist!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Melodia există deja.",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Melodia este deja salvată în cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Melodia este adăugată în coadă!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Cântec găsit!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Info melodie"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Melodia nu poate fi redată din cauza unei restricții de la server!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("tonul cântecului"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Eliminată din"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Eliminat din playlist!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Nu puteți elimina melodia care se redă în prezent",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Melodii"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Cântece importate de la Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sortați crescător/descrescător",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sortați după dată"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Sortați după durată",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sortați după nume"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Viteză și pas"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Porniți radioul"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Deschide la pornire",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Alegeți secțiunea pe care Estrella Music o deschide mai întâi",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Stare"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Oprește redarea la ștergerea sarcinii",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Redarea se va opri când aplicația este eliminată din managerul de aplicații",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Calitatea redării în flux",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Calitatea fluxului muzical",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("de abonați"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Glisați pentru a explora opțiunile",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Modul cloud activat. Descărcarea bibliotecii existente.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Modul cloud activat. Bibliotecă migrată.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Modul cloud activ",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Modul cloud activ. Sincronizare în așteptare.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Sincronizarea a eșuat.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Se descarcă modificările EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Bibliotecă sincronizată.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Biblioteca la zi.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Sunt noi schimbări locale. Acestea vor fi încărcate înainte de descărcare.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Datele dvs. sunt păstrate numai pe acest dispozitiv.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Modul local activ",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline. Modificările sunt în așteptare.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline. Modificările au fost salvate pentru reîncercare.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sincronizați melodiile din lista de redare",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic nu a confirmat toate modificările. Vor fi rejudecate.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Nu m-am putut ridica. Se va reîncerca mai târziu.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Modificările au fost încărcate corect.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Modificările au fost încărcate cu succes (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Nu s-a putut încărca folosind WS. Se va reîncerca mai târziu.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Se încarcă modificări în EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sincronizat"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Versurile sincronizate indisponibile!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Sistem implicit"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Modul Temă"),
    "title": MessageLookupByLibrary.simpleMessage("Titlu"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Clipuri muzicale de top",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Top Videoclipuri Muzicale",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Tendințe"),
    "unLink": MessageLookupByLibrary.simpleMessage("Deconectează"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Deconectat cu succes!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Cântec fără titlu"),
    "upNext": MessageLookupByLibrary.simpleMessage("Urmează"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Actualizați aplicația"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Url detectat apasă pe el sa deschizi/redai conținutul asociat",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Utilizator blocat"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Răspunsul nu conține o listă de utilizatori.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Utilizator deblocat",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Utilizator"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videoclipuri"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Vezi tot"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Vezi Artist"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Ne-am modernizat platforma. Vechiul sistem de încărcare a backup-urilor manuale a fost dezactivat. Acum aveți două moduri clare de a vă gestiona biblioteca muzicală.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Alege cum vrei să experimentezi Estrella Music de acum înainte.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Muzica ta, în felul tău",
    ),
  };
}
