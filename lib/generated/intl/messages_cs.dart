// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static String m0(songTitle) => "Stahování: ${songTitle}";

  static String m1(count) => "Alba: ${count}";

  static String m2(count) => "Umělci: ${count}";

  static String m3(count) => "Oblíbené: ${count}";

  static String m4(count) => "Seznamy videí: ${count}";

  static String m5(count) => "Skladby: ${count}";

  static String m6(source) => "Migrace dokončena z ${source}.";

  static String m7(error) => "Při regeneraci došlo k chybě: ${error}";

  static String m8(title) => "Podobné jako ${title}";

  static String m9(current) => "Krok ${current} ze 3";

  static String m10(count) => "${count} změny potvrzeny.";

  static String m11(count) => "${count} synchronizovaných změn.";

  static String m12(statusCode) => "Nelze vyhledat uživatele (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Vytvořit nový playlist",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("O"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Ještě 5 minut"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Přidat skladby do playlistu",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Přidat do knihovny"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Přidat do playlistu",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album přidáno do záložek!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album odstraněno ze záložek!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Alba"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Podle vašich chutí"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Všechna pole jsou povinná",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Netestováno: Zaškrtnutím políčka po stažení více než 60 souborů může proces spotřebovat velké množství paměti a může způsobit pád telefonu nebo aplikace. Pokračujte na vlastní nebezpečí.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Informace o aplikaci"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Interpret přidán do záložek!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Interpret odstraněn ze záložek!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Popis není k dispozici!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Interpreti"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Podle vašich chutí",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audio kodek"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Autentizační kód"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Zadejte platný 6místný kód nebo se znovu přihlaste.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Zadejte 6místný kód z aplikace pro ověřování. Tento přístup vyprší za 5 minut.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Dvoufaktorová autentizace",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Zkontrolujte a pokračujte",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Přijímáme nesprávné údaje...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Přinesli jsme přihlášení, registraci a obnovení hesla z předchozího projektu, přizpůsobené pro tuto hudební aplikaci.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Vaše relace žije v zabezpečeném úložišti a je ověřena stejným backendem, který jste již používali.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Soubor .env musí být nakonfigurován pro připojení ověřovacího backendu.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Přihlášení"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Rejstřík"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Odeslat poštu",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Potvrďte heslo",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Nesprávný e-mail nebo heslo.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Zadejte platný e-mail.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "V souboru .env chybí ověřovací backend pro konfiguraci.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Váš účet ještě není ověřen.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Operaci nebylo možné dokončit.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Křestní jméno"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Zapomněl jsem heslo",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Pokyny vám zašleme na e-mail vašeho účtu.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("jmeno@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Příjmení"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Úspěšně přihlášeni",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "E-mail nebylo možné odeslat.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Email odeslán.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Účet se nepodařilo vytvořit.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Účet byl úspěšně vytvořen.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vítejte v Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Vítejte v Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Automaticky stáhnout oblíbené skladby",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Automaticky stáhne oblíbené skladby po přidání do oblíbených položek",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Automaticky otevřít obrazovku přehrávače",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Povolí/zakáže automatické otevření přehrávače na celou obrazovku při výběru skladby pro přehrávání",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Návrat"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("databáze nalezené"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Přehrávání na pozadí",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Zapni/Vypni přehrávání hudby na pozadí (Hudba se potom dá ovládat v horní liště a na zamčené obrazovce)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Zálohovat"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Zálohovat data aplikace",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Probíhá zálohování...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Záloha úspěšně uložena!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Zálohovat nastavení a playlisty",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Uloží všechna nastavení, playlisty a přihlašovací údaje do záložního souboru",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Potřebujete aktivní relaci...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Restartujte aplikaci",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Nahrajte zálohu nyní",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Chcete provést zálohu?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Záloha byla smazána.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Zatím nejsou žádné zálohy...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Záloha obnovena. Restartujte aplikaci.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Vyberte složku pro zálohování",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Vyberte, která data chcete zálohovat",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Záloha byla nahrána správně.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage("Podle poslední akce"),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Seznam zakázaných skladeb",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Resetování proběhlo úspěšně!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("od"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Data obsahu domovské obrazovky v mezipaměti",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Zapněte ukládání dat obsahu domovské obrazovky do mezipaměti. Pokud je tato možnost povolena, domovská obrazovka se načte okamžitě",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Skladby mezipaměti"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Ukládání skladeb do mezipaměti během přehrávání pro budoucí/offline přehrávání zabere v zařízení další místo",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Uloženo do mezipaměti / Dostupné Offline",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Zrušit"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Zruš časovač"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Časovač spánku byl zrušen",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Vyčisti cache obrázků",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Vymazání mezipaměti obrázků proběhlo úspěšně",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klikni sem aby si vyčistil cache obrázků (Není doporučeno ale může se hodit při obnově zachovaného data z obrázků)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Blízko"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Zavřít aplikaci"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Byla nalezena cloudová knihovna.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Byla nalezena cloudová knihovna. Toto zařízení jej stáhne, aniž by jej přepsalo.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Cloudový režim je připraven. Toto zařízení bude fungovat jako offline mezipaměť.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Přihlaste se bezpečně pomocí svého účtu Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Okamžitý přístup ke svým seznamům skladeb, oblíbeným položkám a historii z jakéhokoli zařízení (Windows, Android atd.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Pracujte offline a automaticky nahrajte změny, když obnovíte internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktivujte synchronizaci cloudu",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Synchronizace v reálném čase s Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Cloudový režim (doporučeno)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Seznam skladeb pro spolupráci",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Vyberte přátele, kteří budou moci zobrazit a upravovat tento seznam skladeb:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Spolupracovníci byli správně aktualizováni.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Komunitní playlisty",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Obsah"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. Licence GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Vytvořit"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Vytvořit a přidat"),
    "customIns": MessageLookupByLibrary.simpleMessage("Vlastní instance"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Prosím, vyberte možnost Vlastní instance",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Denní objevování"),
    "dark": MessageLookupByLibrary.simpleMessage("Tmavý"),
    "delete": MessageLookupByLibrary.simpleMessage("Smazat"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Odstranit ze stažených",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Úspěšně odstraněno ze stažených!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Vyvinul a spravuje Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Vypnout přechodovou animaci",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Zapnutím této možnosti zakážete přechodovou animaci mezi kartami",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Zakázáno"),
    "discover": MessageLookupByLibrary.simpleMessage("Doporučené skladby"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Odmítnout"),
    "done": MessageLookupByLibrary.simpleMessage("Připraveno"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Tuto informaci již nezobrazujte",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "stažené soubory nalezeny",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Stáhnout"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Stáhněte si písně z alba",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Požadovanou skladbu nelze stáhnout z důvodu omezení serveru. Můžete to zkusit znovu",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Stažení se nezdařilo kvůli chybě sítě/streamu! Zkuste to prosím znovu",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Umístění stažených písniček",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Udržuje stahování hudby aktivní na pozadí.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "stahování hudby",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Příprava stahování…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Stahování hudby",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Stáhnout playlist",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Formát stahovaného souboru",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Vyberte formát stahovaného souboru. \"Opus\" poskytne nejlepší kvalitu",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Stažené"),
    "duration": MessageLookupByLibrary.simpleMessage("Délka"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamický"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Prázdný playlist!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Dolní navigační lišta",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Přejdí na dolní lištu",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Povolit akce gesty",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Povolit akce gesty na dlaždici skladby",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Povoleno"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Konec skladby"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Přidejte skladby z alba do fronty",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Zařadit vše do fronty"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Zařadit tuto skladbu do fronty",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Přidejte skladby do fronty",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Epizody"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ekvalizér"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Otevřete systémový ekvalizér",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Došlo k nějaké chybě!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Došlo k chybě"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Chyba při přehrávání:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportovat"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportovat stažené soubory",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klikněte zde pro export staženého souboru z adresáře aplikace do externího adresáře",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Chyba při exportování playlistu",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Chyba formátování dat playlistu",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Oprávnění odepřeno při exportování",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Nedostatek úložného místa",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Soubory byly úspěšně exportovány",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportovat playlist",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportovat playlist jako CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nelze importovat sem",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportovat playlist do JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tento formát lze importovat",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "Exportovat na Online Music",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vaše playlisty (s méně než 50 skladbami) se přesunou do aktuální fronty. Nezapomeňte je po otevření v MusicService přidat do playlistu/uložit",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Umístění exportu staženého souboru",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportování..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportování playlistu...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Oblíbené"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Doporučené playlisty",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Soubor nebyl nalezen",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Pokračovat"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("následoval"),
    "following": MessageLookupByLibrary.simpleMessage("Následující"),
    "for1": MessageLookupByLibrary.simpleMessage("pro"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "zapomenuté oblíbené",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("příteli"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Žádost o přátelství přijata",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Žádost o přátelství odeslána",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Přátelé"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Chcete-li najít přátele, přihlaste se.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Přátelství odstraněno",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Chyba"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronika"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latinský"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesta"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Zobrazit zdrojový kód GitHub\nPokud se vám tento projekt líbí, nezapomeňte dát ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Přejít do alba"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Kliknutím sem přejdete na stránku ke stažení",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Ahoj světe"),
    "high": MessageLookupByLibrary.simpleMessage("Vysoká 🔥"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "Adresa URL rozhraní API na instanci Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Domů"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Počet položek v domovské stránce",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Vyber si počet zobrazených položek na domovské obrazovce. Menší počet = Rychlejší načítání",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorovat optimalizaci baterie",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Pokud se potýkáte s problémy s oznámeními nebo se přehrávání zastavilo kvůli optimalizaci systému, povolte tuto možnost",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Chyba při importování playlistu",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Chyba při ukládání do databáze",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Nepodařilo se získat přístup k vybranému souboru",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Nesprávný formát souboru",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Poznámka: Import velkých playlistů může trvat déle",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importovat playlist",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Výběr dříve exportovaného souboru JSON s playlistem k importu",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importováno"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Dovezeno z Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importovaný seznam skladeb",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importování playlistu...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Adresář interního úložiště",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Zahrnout stažené skladby",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informace nejsou k dispozici",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Nesprávná struktura souboru playlistu",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Neplatná odpověď serveru.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Relace neobsahuje platný token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("položky"),
    "keepListening": MessageLookupByLibrary.simpleMessage("poslouchejte dál"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Nechat obrazovku zapnutou během přehrávání",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Pokud je povoleno, obrazovka zařízení zůstane během přehrávání hudby zapnutá",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Jazyk"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Nastavení jazyka aplikace",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Nejnovější vydání"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Nejnovější dostupná verze",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Začínáme..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Knihovna alb"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Knihovna interpretů"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("Knihovna playlistů"),
    "libSongs": MessageLookupByLibrary.simpleMessage("Knihovna skladeb"),
    "library": MessageLookupByLibrary.simpleMessage("Knihovna"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Knihovna Playlist",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Světlý"),
    "link": MessageLookupByLibrary.simpleMessage("Odkaz"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Úspěšně propojeno!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Odkaz zkopírován do schránky",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Odkaz s Piped pro playlisty",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Poslouchej teď"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Naslouchat prostředí...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Nelze načíst informace o aktualizaci",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Místní"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Funguje bez nutnosti přihlášení.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Celá vaše knihovna zůstává výhradně na tomto počítači.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Poznámka: Žádné ruční cloudové zálohy. Pokud ztratíte zařízení nebo odinstalujete aplikaci, vaše data nebude možné obnovit.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Používejte pouze na tomto zařízení",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolutní soukromí na vašem zařízení",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Místní režim"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Hlasitost (Db)"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalizace hlasitosti",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Nastaví stejnou úroveň hlasitosti pro všechny skladby (Experimentální) (Nebude fungovat u skladeb stažených v předchozí verzi(< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Nízká 🪨"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Dopisy"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Text není k dispozici!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Správa spolupracovníků (přátel)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Ujistěte se, že hudba hraje v blízkosti mikrofonu dostatečně hlasitě.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migrované album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Migrovaná knihovna",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrovaný seznam skladeb",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Migrace již probíhá.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analýza místní knihovny...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Kontrola, zda EMusic Cloud již má knihovnu...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migrace dokončena.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Před připojením cloudu se vytváří místní záloha...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migrace se nezdařila. Vaše místní data nebyla změněna.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Před migrací se přihlaste k Joss Red.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Příprava migrace v EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nemohl spustit migraci.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Ne všechna data bylo možné nahrát. Udržujeme vaši místní podporu.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Nahrávání seznamů skladeb, oblíbených položek a historie...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nemohl ověřit migraci.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Ověřování integrity v EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Vyberte soubor a importujte",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Vyberte song.db nebo záložní .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migrace byla úspěšně dokončena.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minut"),
    "misc": MessageLookupByLibrary.simpleMessage("Různé"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Nejposlouchanější písnička",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Hudba a přehrávání",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Rozpoznávání hudby",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Chyba sítě! Zkontrolujte připojení k internetu.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("Ups chyba sítě!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "K dispozici je nová verze!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplikace Joss Red (Obchod Play)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Rozuměl"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% synchronizace s Joss Red, seznamy skladeb s přáteli a mnoho dalšího. Klepnutím zobrazíte, co je nového.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music se vyvinula!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Chcete-li přidat přátele, přijímat žádosti nebo spravovat svůj bezpečnostní profil, použijte Joss Red na jeho oficiálních platformách:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Přátelé a správa účtu:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Vytvářejte seznamy skladeb se svými přáteli! Při vytváření seznamu skladeb zaškrtněte políčko Spolupráce a vyberte přátele, které chcete společně upravovat.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Seznamy skladeb pro spolupráci",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Vaše seznamy skladeb a oblíbené položky se nyní ukládají a automaticky synchronizují v cloudu s vaším hlavním účtem Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Plná integrace s Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Již nemusíte klikat na tlačítka ruční synchronizace; Nový motor je zodpovědný za automatické řazení nahoru a dolů.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparentní synchronizace",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Ne"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Žádné záložky!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Nemáte žádné přidané přátele na Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Nemáte žádný playlist v knihovně!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "V nahraném zvuku nelze najít žádné skladby",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Žádné shody"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Žádné skladby offline!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "V této sbírce nejsou žádné skladby",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Nebyla nalezena shoda pro",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Neověřeno"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Není to skladba/hudební video!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Neplatný odkaz!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Otevřít v"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operace selhala"),
    "password": MessageLookupByLibrary.simpleMessage("Heslo"),
    "password_text": MessageLookupByLibrary.simpleMessage("Heslo"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Povolení odepřeno",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Povolit"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music potřebuje tato oprávnění, aby mohla spravovat vaši hudbu a nabízet všechny funkce přehrávání.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Oprávnění začít",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Udělte požadovaná oprávnění",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Používá se pouze v případě, že se rozhodnete identifikovat skladbu, která hraje kolem vás.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Zobrazuje ovládací prvky přehrávání, průběh stahování a důležitá upozornění aplikací.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Oznámení",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Nastavení",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "K pokračování jsou potřeba všechna tři povolení. Později je můžete změnit v nastavení systému.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Umožňuje přehrávat hudbu, ukládat stažené soubory, exportovat seznamy skladeb a připravovat aktualizace.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Hudba a úložiště",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Přizpůsobení"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped playlist synchronizován!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Prostý"),
    "play": MessageLookupByLibrary.simpleMessage("hrát"),
    "playNext": MessageLookupByLibrary.simpleMessage("Přehrát jako další"),
    "playNow": MessageLookupByLibrary.simpleMessage("Hrát hned"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Rychlost přehrávání",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Rozhraní přehrávače"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Vybrat uživatelské rozhraní přehrávače",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Přehrávání:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "Přehrávání z albumu",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "Přehrávání od umělce",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Přehrávání z playlistu",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "Přehrávání z výběru",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Seznam skladeb"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist na černé listině!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist přidán do záložek!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist odstraněn ze záložek!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Přispěvatelé seznamu videí",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist vytvořen!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist vytvořen a skladba přidána!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist úspěšně exportován do",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist úspěšně importován",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist odstraněn!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Úspěšně přejmenováno!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Playlisty"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Následuje"),
    "podcasts": MessageLookupByLibrary.simpleMessage("podcasty"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Populární skladby"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Zpracování souborů...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Zpracování zvuku...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profily"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Opakovat"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Režim opakování nelze vypnout, pokud je povoleno promíchání.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Opakování nelze povolit v režimu rádia.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Frontu nelze zamíchat, když je povolen režim náhodného výběru",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Frontu nelze měnit, když je povolen režim promíchání",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Rychlý výběr"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Rychlý výběr"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Rádio pro tohoto interpreta není k dispozici!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Náhodné rádio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Náhodný výběr"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Přeskupit playlist",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Přeskupit skladby"),
    "readMore": MessageLookupByLibrary.simpleMessage("Přečtěte si více"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Nedávná vyhledávání",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Nedávno přehrané"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Pro zážitek podobný Spotify doporučujeme aktivovat Cloud Mode: synchronizace mezi všemi vašimi zařízeními v reálném čase a automatické zálohování, aniž byste museli cokoli dělat.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Doporučeno"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Doporučeno"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Odstranit z mezipaměti",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Odebrat z knihovny skladeb",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Smazat z knihovny",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Odstranit z playlistu",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Odstranit z fronty",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Odstranit více skladeb",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Odstranit playlist",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Přejmenovat"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Přejmenovat playlist",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage(
      "Reprodukováno uživatelem",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Resetovat"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Obnovit výchozí nastavení",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Obnovit výchozí nastavení aplikace (nutný restart)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Obnovení výchozího nastavení bylo dokončeno, restartujte aplikaci",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Resetovat playlisty na černé listině",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Resetování všech playlistů zařazených na černou listinu",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Restartovat aplikaci"),
    "restore": MessageLookupByLibrary.simpleMessage("Obnovit"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Obnovit data aplikace",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Obnovit poslední relaci přehrávání",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Automaticky obnoví poslední relaci přehrávání při spuštění aplikace",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Úspěšně obnoveno!\nZměny se aplikují po restartu",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Obnovit nastavení a playlisty",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Obnoví všechna nastavení, přihlašovací údaje a playlisty ze záložního souboru. Přepíše všechna aktuální data",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Vyberte záložní soubor",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Obnovování..."),
    "results": MessageLookupByLibrary.simpleMessage("Výsledky"),
    "retry": MessageLookupByLibrary.simpleMessage("Zkuste to znovu!"),
    "save": MessageLookupByLibrary.simpleMessage("Nechat"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Uloženo"),
    "scanning": MessageLookupByLibrary.simpleMessage("Skenování..."),
    "search": MessageLookupByLibrary.simpleMessage("Hledat"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Skladby, playlisty, alba, interprety",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Hledat v knihovně",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Výsledky vyhledávání"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Nedávná vyhledávání",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Vybrat všechno"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Vyberte Instanci ověření",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Prosím, vyberte instanci ověřování!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Vybrat soubor"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Vybrat skladby"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Vybraný soubor nebyl nalezen.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Vaše relace vypršela. Znovu se přihlaste.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Nastav si domovskou stránku",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Nastavení"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "O Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Verze, open source projekt a GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Účet a synchronizace",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Cloudový režim, zálohy, seznam přátel a migrace.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Téma, jazyk a animace rozhraní.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloudové zálohování",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Nahrát, obnovit a spravovat...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Nahrajte zálohu aplikace .hmb na server a v případě potřeby obnovte kteroukoli z uložených záloh.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Objevte filtry, integraci s Piped a mezipaměti.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Stahování a ukládání",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Zvukové formáty, složky a automatické stahování.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Generál"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Vyberte, migrujte nebo zkontrolujte stav synchronizace pomocí Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Místní režim / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Odhlaste se"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importujte seznamy skladeb, skladby...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrujte z Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("moji přátelé"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Spravujte své přátele Joss Red přímo.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Kvalita streamování, normalizace, ztišení a baterie.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Pokud se obsah kanálu Objevit nenačte, znovu vygenerujte své ID Online Music.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Obnovit ID (ID návštěvníka)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Chyba"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Nepodařilo se vygenerovat nový identifikátor. Zkuste to znovu později.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Aktualizovaný identifikátor",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Nové ID návštěvníka bylo úspěšně vygenerováno.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Sdílejte album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Sdílejte seznam skladeb",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Sdílet tuto skladbu"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Hledání shod v databázi Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Náhodné"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Promíchat"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singly"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Přeskočit ticho"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Při přehrávání hudby se přeskočí ticho",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Váš časovač spánku byl spuštěn",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Časovač spánku"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Skladba přidána do playlistu!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Skladba už existuje!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Skladba je již offline v mezipaměti",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Skladba zařazena!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Píseň nalezena!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Informace skladby"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Skladbu nelze přehrát z důvodu omezení serveru!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("tón písně"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Odstraněno z"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Odstraněno z fronty!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Aktuálně přehrávanou skladbu nelze odebrat",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Skladby"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Skladby importované z Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Seřadit vzestupně/sestupně",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Seřadit podle data"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Seřadit podle trvání",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Seřadit podle názvu"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Rychlost a rozteč"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Spustit rádio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Otevřete při spuštění",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Vyberte sekci, kterou Estrella Music otevře jako první",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Stav"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Zastavení hudby při vymazání správce úloh",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Přehrávání hudby se zastaví, když se přejede prstem po aplikaci ze správce úloh",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("Kvalita streamu"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Kvalita hudebního streamu",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("odběratelé"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Přejetím prozkoumejte možnosti ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Aktivován cloudový režim. Stahování stávající knihovny.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Aktivován cloudový režim. Migrovaná knihovna.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Cloudový režim je aktivní",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Cloudový režim je aktivní. Čeká na synchronizaci.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Stažení synchronizace se nezdařilo.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Stahování změn EMusic...",
    ),
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las playlists, favoritos, historial, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca hudební remota?",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanentecen locales.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Zrušit sincronización y subir ESTA základnu",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synchronizovaná knihovna.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Knihovna aktuální.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Došlo k novým místním změnám. Před stažením budou nahrány.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Vaše data jsou uchovávána pouze v tomto zařízení.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Místní režim je aktivní",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline. Změny čekají na vyřízení.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline. Změny uloženy pro opakování.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synchronizujte skladby ze seznamu skladeb",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic nepotvrdila všechny změny. Budou znovu souzeni.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Nedalo se vstát. Bude to zopakováno později.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Změny byly nahrány správně.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Změny byly úspěšně nahrány (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Nelze nahrát pomocí WS. Bude to zopakováno později.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Nahrávání změn do EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synchronizovaný"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synchronizovaný text není k dispozici!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Výchozí nastavení systému",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Vzhled"),
    "title": MessageLookupByLibrary.simpleMessage("Název"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Nejlepší hudební videa",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Topovky"),
    "trending": MessageLookupByLibrary.simpleMessage("Trendy"),
    "unLink": MessageLookupByLibrary.simpleMessage("Odstranit odkaz"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("Úspěšně odpojeno!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Píseň bez názvu"),
    "upNext": MessageLookupByLibrary.simpleMessage("Další skladba"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Aktualizovat aplikaci"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Zjištěná URL Kliknutím na ni otevřete/přehrajete související obsah",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Blokovaný uživatel"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Odpověď neobsahuje seznam uživatelů.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Odemčený uživatel"),
    "username": MessageLookupByLibrary.simpleMessage("Uživatelské jméno"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videa"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Zobrazit vše"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Zobrazit interpreta"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Modernizovali jsme naši platformu. Starý systém nahrávání ručních záloh byl deaktivován. Nyní máte dva jasné způsoby, jak spravovat svou hudební knihovnu.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vyberte si, jak chcete od této chvíle zažít Estrella Music.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Vaše hudba, vaše cesta",
    ),
  };
}
