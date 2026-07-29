// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hu locale. All the
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
  String get localeName => 'hu';

  static String m0(songTitle) => "Letöltés: ${songTitle}";

  static String m1(error) => "Hiba történt a regenerálás során: ${error}";

  static String m2(title) => "Hasonló ehhez: ${title}";

  static String m3(current) => "3. ${current}. lépés";

  static String m4(count) => "${count} változtatások végrehajtva.";

  static String m5(count) => "${count} szinkronizált változtatások.";

  static String m6(statusCode) =>
      "Nem sikerült felhasználókat keresni (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Új lejátszólista",
    ),
    "about": MessageLookupByLibrary.simpleMessage("Körülbelül"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Még 5 perc"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok lejátszólistához adása",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Hozzáadás lejátszólistához",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albums": MessageLookupByLibrary.simpleMessage("Albumok"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Alkalmazás információ"),
    "artists": MessageLookupByLibrary.simpleMessage("Előadók"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
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
      "Acepto usar mis datos...",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Nyilvántartás"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Jelszó megerősítése",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Keresztnév"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Elfelejtettem a jelszavamat",
    ),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Vezetéknév"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Sikeres bejelentkezés",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Üdvözöljük az Estrella Music oldalán",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Üdvözöljük az Estrella Music oldalán",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Kedvelt dalok automatikus letöltése",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "A kedvelt dalok automatikus letöltése, ha hozzáadja a kedvencekhez",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Visszatérés"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "adatbázis található",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Mentés folyamatban...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "A mentés sikeresen elkészült!",
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
      "Szeretnél biztonsági mentést készíteni?",
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
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Válassza ki, hogy mely adatokról szeretne biztonsági másolatot készíteni",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "A biztonsági másolat megfelelően feltöltve.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Az utolsó interakció alapján",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Cache-elt/offline",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Mégse"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Időzítés vége"),
    "close": MessageLookupByLibrary.simpleMessage("Közeli"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Alkalmazás bezárása"),
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
      "Intelligens szinkronizálás: Dolgozzon offline módban, és automatikusan töltse fel a módosításokat, amikor helyreáll az internet.",
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
      "Közösségi lejátszólisták",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Tartalom"),
    "create": MessageLookupByLibrary.simpleMessage("Létrehozás"),
    "createnAdd": MessageLookupByLibrary.simpleMessage(
      "Létrehozás és hozzáadás",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Napi felfedezés"),
    "dark": MessageLookupByLibrary.simpleMessage("Sötét"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a letöltések közül",
    ),
    "discover": MessageLookupByLibrary.simpleMessage("Felfedezés"),
    "done": MessageLookupByLibrary.simpleMessage("Kész"),
    "download": MessageLookupByLibrary.simpleMessage("Letöltés"),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "A kért dal nem tölthető le a szerver korlátozása miatt. Megpróbálhatja újra",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "A letöltés hálózati/lejátszási hiba miatt megszakadt! Próbáld újra",
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
    "downloads": MessageLookupByLibrary.simpleMessage("Letöltések"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamikus"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Üres lejátszólista!",
    ),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("A dal vége"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Dal sorba állítása"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Hiba történt"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Hiba lejátszás közben:",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Kedvencek"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Kiemelt lejátszólisták",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Folytatás"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("követte"),
    "following": MessageLookupByLibrary.simpleMessage("Következő"),
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
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Dzsessz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Szikla"),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Irány az album"),
    "home": MessageLookupByLibrary.simpleMessage("Kezdőlap"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlinból importálva",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Érvénytelen szerver válasz.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "A munkamenet nem tartalmaz érvényes tokent.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("Tárgyak"),
    "keepListening": MessageLookupByLibrary.simpleMessage("hallgass tovább"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "A képernyő bekapcsolva tartása lejátszás közben",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Ha engedélyezve van, a készülék képernyője lejátszás közben bekapcsolva marad",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Nyelv"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Állítsa be az alkalmazás nyelvét",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Legújabb kiadás"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Kezdjük!"),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Gyűjtemény albumai"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Gyűjtemény előadói"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Gyűjtemény lejátszólistái",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Gyűjtemény dalai"),
    "library": MessageLookupByLibrary.simpleMessage("Gyüjtemény"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Library Playlist",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Világos"),
    "listenNow": MessageLookupByLibrary.simpleMessage("Figyelj most"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "A környezetre figyelve...",
    ),
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
    "minutes": MessageLookupByLibrary.simpleMessage("perc"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "A leghallgatottabb dal",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Zene & Lejátszás",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("Zene felismerés"),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Hálózati hiba! Ellenőrizze a hálózati kapcsolatot.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Hoppá, hálózati hiba!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red App (Play Áruház)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Megértve"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100%-os szinkronizálás Joss Reddel, lejátszási listák a barátokkal és még sok más. Koppintson az újdonságok megtekintéséhez.",
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
      "Estrella Music News",
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
    "noBookmarks": MessageLookupByLibrary.simpleMessage(
      "Nincsenek könyvjelzők!",
    ),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Nincsenek hozzáadott barátaid a Joss Red-en.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Nincs lib lejátszási listád!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Nem található dal a rögzített hanganyagban",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Nincs egyezés"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Nincsenek offline dalok!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Ebben a gyűjteményben nincsenek dalok",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Nincs hitelesítve",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Megnyitás itt:"),
    "password_text": MessageLookupByLibrary.simpleMessage("Jelszó"),
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
    "personalisation": MessageLookupByLibrary.simpleMessage("Személyreszabás"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist",
    ),
    "playNext": MessageLookupByLibrary.simpleMessage("Következő lejátszása"),
    "playNow": MessageLookupByLibrary.simpleMessage("Játssz most"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Lejátszási sebesség",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Lejátszó Ui"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Lejátszás:",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listák közreműködői",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Lejátszólisták"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Következő"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Népszerű számok"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Fájlok előkészítése...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Hang feldolgozása...",
    ),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Várólista ismétlése"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "A várólista ismétlése mód nem tiltható le, ha a keverés mód engedélyezett.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "A várólista ismétlése rádió módban nem engedélyezhető.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A várólista nem keverhető, ha a keverés mód engedélyezett",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A várólista nem rendezhető át, ha a keverés mód engedélyezett",
    ),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Gyors választások"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszólista rendezése",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Zenék átrendezése"),
    "readMore": MessageLookupByLibrary.simpleMessage("Olvass tovább"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Legutóbbi keresések",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Mostanában játszott",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Javasoljuk, hogy aktiválja a Felhő módot a Spotify-szerű élmény érdekében: valós idejű szinkronizálás az összes eszköz között és automatikus biztonsági mentés anélkül, hogy bármit is tenne.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Ajánlott"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Ajánlott"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a gyűjteményből",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a lejátszólistáról",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a sorból",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Több dal eltávolítása",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszólista eltávolítása",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Átnevezés"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszólista átnevezése",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reprodukálta"),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Alkalmazás újraindítása",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Visszaállítás"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Alkalmazás adatok visszaállítása",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Sikeresen visszaállítva!\nA változtatások a következő újraindításnál életbelépnek",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Minden beállítást, belépési adatot, lejátszási listát visszaállít a mentési fájlból. Felülír minden jelenlegi adatot",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Visszaállítás..."),
    "retry": MessageLookupByLibrary.simpleMessage("Újrapróbálom!"),
    "save": MessageLookupByLibrary.simpleMessage("Tartsa"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Mentve"),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Keresés a könyvtárban",
    ),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Legutóbbi keresések",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Összes kiválasztása"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Számok kiválástása"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "A kiválasztott fájl nem található.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "A munkamenet lejárt. Jelentkezzen be újra.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Állítsa be a felfedezés tartalmát",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Beállítások"),
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
      "Általános",
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
    "settings_visitor_exception": m1,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Frissített azonosító",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Sikeresen létrehoztunk egy új látogatóazonosítót.",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Dal megosztása"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Egyezések keresése a Shazam adatbázisban...",
    ),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Várólista keverése"),
    "similarToTitle": m2,
    "singles": MessageLookupByLibrary.simpleMessage("Kislemezek"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Alvás időzítő"),
    "slide_indicator": m3,
    "songFound": MessageLookupByLibrary.simpleMessage("Dal megtalálva!"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "A dal nem játszható le, a szerver korlátozása miatt!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("dal hangja"),
    "songs": MessageLookupByLibrary.simpleMessage("Számok"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "A Joss Music Kotlinból importált dalok",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Sebesség és hangmagasság",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Alapértelmezett"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Rádió indítása"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Nyissa meg indításkor",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Válassza ki azt a részt, amelyet az Estrella Music először nyit meg",
    ),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Csúsztassa ujját a lehetőségek felfedezéséhez ➔",
    ),
    "syncChangesConfirmed": m4,
    "syncChangesSynced": m5,
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
    "systemDefault": MessageLookupByLibrary.simpleMessage("Alapértelmezett"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Legjobb Zenei Videók",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Felkapott"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Névtelen dal"),
    "upNext": MessageLookupByLibrary.simpleMessage("Következő"),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Letiltott felhasználó",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "A válasz nem tartalmazza a felhasználók listáját.",
    ),
    "userSearchFailed": m6,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Feloldott felhasználó",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Felhasználónév"),
    "video": MessageLookupByLibrary.simpleMessage("Videó"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Irány az előadó"),
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
