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
      "Új lejátszólista",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Csöves"),
    "about": MessageLookupByLibrary.simpleMessage("Körülbelül"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Még 5 perc"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok lejátszólistához adása",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Hozzáadás a könyvtárhoz",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Hozzáadás lejátszólistához",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album hozzáadva a könyvjelzőkhöz!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Az album könyvjelzője eltávolítva!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albumok"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Minden mező kitöltése kötelező",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Nincs tesztelve: Ha több mint 60 fájl letöltése után bejelöli a jelölőnégyzetet, a folyamat nagy mennyiségű memóriát fogyaszthat, és a telefon vagy az alkalmazás összeomolhat. Továbblépés a saját felelősségére.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Alkalmazás információ"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Előadó hozzáadva a könyvjelzőkhöz!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Előadójelző eltávolítva!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Leírás nem elérhető!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Előadók"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Az Ön ízlése szerint",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audiokodek"),
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
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "A bejelentkezést, a regisztrációt és a jelszó-helyreállítást az előző projektből hoztuk, ehhez a zenei alkalmazáshoz igazítva.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "A munkamenet biztonságos tárhelyen él, és ugyanazzal a háttérprogrammal van érvényesítve, amelyet már használt.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Az .env fájlt be kell állítani a hitelesítési háttérrendszer csatlakoztatásához.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Nyilvántartás"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Levél küldése",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Jelszó megerősítése",
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
      "Kedvelt dalok automatikus letöltése",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "A kedvelt dalok automatikus letöltése, ha hozzáadja a kedvencekhez",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "A lejátszó képernyőjének automatikus megnyitása",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "A lejátszó teljes képernyőre való automatikus megnyitásának be-/kikapcsolása a lejátszandó dal kiválasztásakor",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Visszatérés"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "adatbázis található",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Zene lejátszása a háttérben",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Háttérzene lejátszásának engedélyezése/letiltása (Az alkalmazás a rendszertálcáról érhető el, ha az alkalmazás a háttérben fut)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Biztonsági mentés"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Alkalmazásadatok biztonsági mentése",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Mentés folyamatban...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "A mentés sikeresen elkészült!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Biztonsági mentési beállítások és lejátszási listák",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Mentse el az összes beállítást, lejátszási listát és bejelentkezési adatot egy biztonsági mentési fájlba",
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
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a mappát a biztonsági mentéshez",
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
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitráta"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista feketelista",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Sikeres visszaállítás!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("által"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Tárolja a kezdőképernyő tartalmát",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Engedélyezze a kezdőképernyő tartalmának tárolását, a kezdőképernyő azonnal betöltődik, ha ez az opció engedélyezve van",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok gyorsítótárazása",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "A dalok gyorsítótárazása lejátszás közben a jövőbeni/offline lejátszáshoz további helyet foglal el az eszközön",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Cache-elt/offline",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Mégse"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Időzítés vége"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Az elalvási időzítő törölve",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Kép-gyorsítótár törlése",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "A képgyorsítótár sikeresen törölve",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Kattintson ide a gyorsítótárazott bélyegképek/képek törléséhez. (Nem ajánlott, hacsak nem szeretné frissíteni a gyorsítótárazott képadatokat)",
    ),
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
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL licenc v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Létrehozás"),
    "createnAdd": MessageLookupByLibrary.simpleMessage(
      "Létrehozás és hozzáadás",
    ),
    "customIns": MessageLookupByLibrary.simpleMessage("Egyéni példány"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Kérjük, válasszon egyéni példányt",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Napi felfedezés"),
    "dark": MessageLookupByLibrary.simpleMessage("Sötét"),
    "delete": MessageLookupByLibrary.simpleMessage("Törölje"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a letöltések közül",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Sikeresen eltávolítva a letöltések közül!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Joss Estrada (JOSPROX) fejlesztette és karbantartotta",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Az átmeneti animáció letiltása",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktiválja ezt a lehetőséget a lapátmenet animációjának letiltásához",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Letiltva"),
    "discover": MessageLookupByLibrary.simpleMessage("Felfedezés"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Eldobni"),
    "done": MessageLookupByLibrary.simpleMessage("Kész"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Ne jelenítse meg újra ezt az információt",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "letöltött fájlok találhatók",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Letöltés"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok letöltése az albumról",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "A kért dal nem tölthető le a szerver korlátozása miatt. Megpróbálhatja újra",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "A letöltés hálózati/lejátszási hiba miatt megszakadt! Próbáld újra",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Letöltés helye"),
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
      "Fájlformátum letöltése",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a letöltési fájl formátumát. Az \"Opus\" biztosítja a legjobb minőséget",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Letöltések"),
    "duration": MessageLookupByLibrary.simpleMessage("Időtartam"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamikus"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Üres lejátszólista!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Alsó navigációs sáv",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Váltson az alsó navigációs sávra",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktiválja a csúszkaműveleteket",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Csúsztatási műveletek aktiválása a dalcsempén",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktiválva"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("A dal vége"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Adja hozzá az album dalait a sorhoz",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Az összes hozzáadása a sorhoz",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Dal sorba állítása"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Dalok hozzáadása a sorhoz",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Epizódok"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Nyissa meg a rendszer hangszínszabályzóját",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage("Hiba történt!"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Hiba történt"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Hiba lejátszás közben:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportálás"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "A letöltött fájlok exportálása",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Ide kattintva exportálhatja a letöltött fájlokat az alkalmazáskönyvtárból a külső könyvtárba",
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
      "A fájlok sikeresen exportálva",
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
      "A letöltött fájlok helyének exportálása",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportálás..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista exportálása...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Kedvencek"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Kiemelt lejátszólisták",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "A fájl nem található",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Folytatás"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("követte"),
    "following": MessageLookupByLibrary.simpleMessage("Következő"),
    "for1": MessageLookupByLibrary.simpleMessage("számára"),
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
    "gesture": MessageLookupByLibrary.simpleMessage("Gesztus"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Tekintse meg a GitHub forráskódját \nHa tetszik ez a projekt, ne felejts el egy ⭐-t adni neki!",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Irány az album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Kattintson ide a letöltési oldal eléréséhez",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Helló világ"),
    "high": MessageLookupByLibrary.simpleMessage("Magas"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL a vezetékes példányhoz",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Kezdőlap"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Startup Content Count",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a kezdőképernyő kezdeti tartalmának számát (kb.). Kevesebb eredmény gyorsabban töltődik be",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Az akkumulátor optimalizálás figyelmen kívül hagyása",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Ha problémái vannak az értesítésekkel vagy a lejátszás leáll a rendszer optimalizálása miatt, aktiválja ezt az opciót",
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
      "Tartalmazza a letöltött dalfájlokat",
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
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Elérhető legújabb verzió",
    ),
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
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Sikeres linkelés!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link a vágólapra másolva",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Link a Piped-el a lejátszási listákhoz",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Figyelj most"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "A környezetre figyelve...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Nem sikerült betölteni a frissítési információkat",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Helyi"),
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
      "A hangerő normalizálása",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Ugyanazt a hangerőszintet állítja be az összes dalhoz (kísérleti) (Nem működik a régebbi verziókban letöltött daloknál (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Alacsony"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Levelek"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Dalszöveg nem elérhető!",
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
    "minutes": MessageLookupByLibrary.simpleMessage("perc"),
    "misc": MessageLookupByLibrary.simpleMessage("Különféle"),
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
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Új verzió elérhető!",
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
    "no": MessageLookupByLibrary.simpleMessage("Nem"),
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
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Nincs találat a következőre:",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Nincs hitelesítve",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Ez nem egy dal/zenei videó!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Ez nem érvényes link!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Megnyitás itt:"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Sikertelen művelet",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Jelszó"),
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
    "personalisation": MessageLookupByLibrary.simpleMessage("Személyreszabás"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped lejátszási lista szinkronizálva!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("egyszerű"),
    "play": MessageLookupByLibrary.simpleMessage("Játssz"),
    "playNext": MessageLookupByLibrary.simpleMessage("Következő lejátszása"),
    "playNow": MessageLookupByLibrary.simpleMessage("Játssz most"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Lejátszási sebesség",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Lejátszó Ui"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a lejátszó felhasználói felületét",
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
      "Feketelistás lejátszási lista!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista hozzáadva a könyvjelzőkhöz!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista könyvjelzője eltávolítva!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Lejátszási listák közreműködői",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista létrehozva!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista létrehozva és dal hozzáadva!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "A lejátszási lista sikeresen exportálva ide",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "A lejátszási lista sikeresen importálva",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Lejátszási lista törölve!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Sikeres márkanévváltás!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Lejátszólisták"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Következő"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcastok"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Népszerű számok"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Fájlok előkészítése...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Hang feldolgozása...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profilok"),
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
    "quickPics": MessageLookupByLibrary.simpleMessage("Gyors kiválasztás"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Gyors választások"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "A rádió nem elérhető ennél az előadónál!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Véletlenszerű rádió"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Véletlenszerű kiválasztás",
    ),
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
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Távolítsa el a gyorsítótárból",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Eltávolítás a gyűjteményből",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Törlés a könyvtárból",
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
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
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
      "A feketelistán szereplő lejátszási listák visszaállítása",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Állítsa vissza az összes feketelistán szereplő Piped lejátszási listát",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Alkalmazás újraindítása",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Visszaállítás"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Alkalmazás adatok visszaállítása",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Az utolsó lejátszási munkamenet visszaállítása",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Az utolsó lejátszási munkamenet automatikus visszaállítása az alkalmazás indításakor",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Sikeresen visszaállítva!\nA változtatások a következő újraindításnál életbelépnek",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Beállítások és lejátszási listák visszaállítása",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Minden beállítást, belépési adatot, lejátszási listát visszaállít a mentési fájlból. Felülír minden jelenlegi adatot",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a biztonsági másolat fájlt",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Visszaállítás..."),
    "results": MessageLookupByLibrary.simpleMessage("Eredmények"),
    "retry": MessageLookupByLibrary.simpleMessage("Újrapróbálom!"),
    "save": MessageLookupByLibrary.simpleMessage("Tartsa"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Mentve"),
    "scanning": MessageLookupByLibrary.simpleMessage("Szkennelés..."),
    "search": MessageLookupByLibrary.simpleMessage("Keresés"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Dalok, lejátszási listák, albumok vagy előadók",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Keresés a könyvtárban",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Keresési eredmények"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Legutóbbi keresések",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Összes kiválasztása"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Válassza ki a hitelesítési példányt",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Kérjük, válassza ki a hitelesítési példányt!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage(
      "Válassza a Fájl lehetőséget",
    ),
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
    "shareSong": MessageLookupByLibrary.simpleMessage("Dal megosztása"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Egyezések keresése a Shazam adatbázisban...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Véletlenszerű"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Várólista keverése"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Kislemezek"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Átugrani a csendet"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Zenelejátszás közben a csend kimarad",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Az elalvási időzítő be van állítva",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Alvás időzítő"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "A dal felkerült a lejátszási listára!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "A dal már létezik!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "A dal már a gyorsítótárban van",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "A dal felkerült a sorba!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Dal megtalálva!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Dal információ"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "A dal nem játszható le, a szerver korlátozása miatt!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("dal hangja"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("eltávolítva"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Eltávolítva a sorból!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Az éppen lejátszott dal nem törölhető",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Számok"),
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
    "standard": MessageLookupByLibrary.simpleMessage("Alapértelmezett"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Rádió indítása"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Nyissa meg indításkor",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Válassza ki azt a részt, amelyet az Estrella Music először nyit meg",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Állapot"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Állítsa le a zenét az alkalmazás bezárásakor",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "A zenelejátszás leáll, ha bezárja az alkalmazást a feladatkezelőből",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streaming minőség",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Zene streaming minőség",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("előfizetők"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Csúsztassa ujját a lehetőségek felfedezéséhez ➔",
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
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las playlists, favoritos, historial, álcák, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Reemplazar la biblioteca musical remota?",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Cancelar sincronización y subir ESTA base",
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
    "synced": MessageLookupByLibrary.simpleMessage("Szinkronizált"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Szinkronizált dalszöveg nem érhető el!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Alapértelmezett"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Téma mód"),
    "title": MessageLookupByLibrary.simpleMessage("Cím"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Legnépszerűbb zenei videók",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Legjobb Zenei Videók",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Felkapott"),
    "unLink": MessageLookupByLibrary.simpleMessage("Leválasztás"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Sikeresen leválasztva!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Névtelen dal"),
    "upNext": MessageLookupByLibrary.simpleMessage("Következő"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Alkalmazás frissítése"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Az észlelt URL kattintson rá a kapcsolódó tartalom megnyitásához/lejátszásához",
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
    "username": MessageLookupByLibrary.simpleMessage("Felhasználónév"),
    "video": MessageLookupByLibrary.simpleMessage("Videó"),
    "videos": MessageLookupByLibrary.simpleMessage("Videók"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Az összes megtekintése"),
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
