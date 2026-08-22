// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(songTitle) => "Downloaden: ${songTitle}";

  static String m1(count) => "Albums: ${count}";

  static String m2(count) => "Artiesten: ${count}";

  static String m3(count) => "Favorieten: ${count}";

  static String m4(count) => "Afspeellijsten: ${count}";

  static String m5(count) => "Nummers: ${count}";

  static String m6(source) => "Migratie voltooid vanaf ${source}.";

  static String m7(error) =>
      "Er is een fout opgetreden tijdens het regenereren van: ${error}";

  static String m8(title) => "gelijk aan ${title}";

  static String m9(current) => "Stap ${current} van 3";

  static String m10(count) => "${count} wijzigingen vastgelegd.";

  static String m11(count) => "${count} gesynchroniseerde wijzigingen.";

  static String m12(statusCode) =>
      "Kan niet zoeken naar gebruikers (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Creëer nieuwe afspeellijst",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Over"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Voeg 5 minuten toe"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Voeg liedjes toe aan afspeellijst",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Toevoegen aan bibliotheek",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Voeg toe aan afspeellijst",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album gebladwijzerd!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album bladwijzer verwijderd!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albums"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Volgens jouw smaak"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Alle velden zijn vereist",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Niet getest: als u het selectievakje inschakelt nadat u meer dan 60 bestanden hebt gedownload, kan het proces een grote hoeveelheid geheugen in beslag nemen en kan de telefoon of app crashen. Ga verder op eigen risico.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Applicatie-informatie"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artiest gebladwijzerd!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artiest bladwijzer verwijderd!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Beschrijving niet beschikbaar!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artiesten"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Volgens jouw smaak",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audiocodec"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Authenticatiecode"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Voer een geldige 6-cijferige code in of log opnieuw in.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Voer de 6-cijferige code van uw authenticator-app in. Deze toegang vervalt over 5 minuten.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Tweefactorauthenticatie",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Controleer en ga verder",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Gebruik verkeerde gegevens...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "We hebben de login, registratie en wachtwoordherstel van het vorige project meegenomen, aangepast voor deze muziekapp.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Uw sessie bevindt zich in een beveiligde opslag en wordt gevalideerd met dezelfde backend die u al gebruikte.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Het .env-bestand moet worden geconfigureerd om verbinding te maken met de authenticatie-backend.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Login"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Register"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Stuur e-mail"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Bevestig wachtwoord",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Onjuist e-mailadres of wachtwoord.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Voer een geldig e-mailadres in.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "De authenticatie-backend ontbreekt om te worden geconfigureerd in het .env-bestand.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Uw account is nog niet geverifieerd.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Het was niet mogelijk de operatie te voltooien.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Voornaam"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Ik ben mijn wachtwoord vergeten",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "We sturen u de instructies naar uw account-e-mailadres.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("naam@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Achternaam"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Succesvol ingelogd",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Het was niet mogelijk om de e-mail te verzenden.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-mail verzonden.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Het account kon niet worden aangemaakt.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Account aangemaakt.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Welkom bij Estrella Muziek",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Welkom bij Estrella Muziek",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Automatisch downloaden van favoriete nummers",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Download automatisch favoriete nummers wanneer ze aan favorieten worden toegevoegd",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Automatisch spelersscherm openen",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Activeer/deactiveer het automatisch openen van de speler naar volledig scherm bij het selecteren van een nummer om af te spelen",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Opbrengst"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "databanken gevonden",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Achtergrond muziek spelen",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Aanzetten/uitzetten achtergrondmuziek (App is toegankelijk door systeemtray wanneer de app in de achtergrond actief is)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Back-up"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Maak een back-up van app-gegevens",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Back-up wordt uitgevoerd...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Back-up succesvol opgeslagen!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Back-up instellingen en afspeellijsten",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Bewaart alle instellingen, afspeellijsten en aanmeldgegevens in een back-up bestand",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Je hebt een actieve sessie nodig...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Start de app opnieuw",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Upload nu een back-up",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Wilt u een back-up uitvoeren?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Back-up verwijderd.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Er zijn nog geen back-ups...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Back-up hersteld. Start de app opnieuw.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecteer de map voor back-up",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Kies welke gegevens u wilt back-uppen",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Back-up correct geüpload.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Gebaseerd op laatste interactie",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitsnelheid"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Zwarte lijst voor afspeellijsten",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Successvolle reset!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("door"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Cahce homescherm inhoud data",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Zet Caching homescherm inhoud data aan, homescherm laad meteen als deze optie aanstaat",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cache Liedjes"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Caching Liedjes tijdens het luisteren voor toekomstig/offline afluisteren, dit neemt extra ruimte in op je apparaat",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Cached/Offline"),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuleer"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Annuleer timer"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Slaap timer geannuleerd",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Verwijder afbeeldingen cache",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Afbeeldingen cache is successvol verwijderd",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klik hier om de thumbnail/afbeeldingen cache te verwijderen. (Niet aangeraden tenzij je afbeelding cache wilt verversen)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Dichtbij"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Sluit de applicatie"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Cloudbibliotheek gevonden.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Er is een cloudbibliotheek gevonden. Dit apparaat downloadt het zonder het te overschrijven.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus is klaar. Dit apparaat werkt als een offline cache.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Log veilig in met uw Joss Red-account.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Krijg direct toegang tot uw afspeellijsten, favorieten en geschiedenis vanaf elk apparaat (Windows, Android, enz.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Slimme synchronisatie: werk offline en upload wijzigingen automatisch wanneer u weer internet hebt.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Activeer Cloud-synchronisatie",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Realtime synchronisatie met Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus (aanbevolen)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Gezamenlijke afspeellijst",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Selecteer de vrienden die deze afspeellijst kunnen zien en bewerken:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Bijdragers zijn correct bijgewerkt.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Community Playlists",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Inhoud"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL-licentie v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Creëer"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Creëer & voeg toe"),
    "customIns": MessageLookupByLibrary.simpleMessage("Aangepaste Instantie"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Selecteer Aangepaste Instantie",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Dagelijkse ontdekking",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Donker"),
    "delete": MessageLookupByLibrary.simpleMessage("Verwijderen"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Verwijder van downloads",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Successvol verwijderd van downloads!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Ontwikkeld en onderhouden door Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Zet transitie-animatie uit",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Schakel deze optie in om de tabtransitie-animatie uit te zetten",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Uit"),
    "discover": MessageLookupByLibrary.simpleMessage("Ontdek"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Afwijzen"),
    "done": MessageLookupByLibrary.simpleMessage("Klaar"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Niet opnieuw deze info laten zien",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "gedownloade bestanden gevonden",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Downloaden"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Download nummers van het album",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Het opgevraagde nummer kan niet worden gedownload vanwege serverbeperkingen. Je kunt het opnieuw proberen",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Downloaden mislukt vanwege netwerk-/transmissiefout! Probeer het opnieuw",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Downloadlocatie"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Houdt uw muziekdownloads actief op de achtergrond.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "muziek downloaden",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Uw downloads voorbereiden…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Muziek downloaden",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Speellijst downloaden",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Bestandsformaat aan het downloaden",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Selecteer bestandsformaat downloaden. \"Opus\" geeft de beste kwaliteit",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Downloads"),
    "duration": MessageLookupByLibrary.simpleMessage("Duur"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamisch"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Lege Afspeellijst!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Onderste navigatiebalk",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Schakel naar onderste navigatiebalk",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Activeer schuifacties",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Activeer veegacties op de nummertegel",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aan"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Einde van dit liedje",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Voeg albumnummers toe aan de wachtrij",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Alles in wachtrij"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Voeg dit liedje toe aan wachtrij",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Voeg nummers toe aan de wachtrij",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Afleveringen"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Open systeem equalizer",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Er is een fout opgetreden!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Er is een fout opgetreden",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Fout bij het afspelen:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exporteer"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exporteer gedownloade bestanden",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klik hier om gedownloade bestanden van inApp dir naar externe dir te exporteren",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Fout bij exporteren van afspeellijst",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Fout bij het formatteren van afspeellijstgegevens",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Toestemming geweigerd bij exporteren",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Onvoldoende opslagruimte",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Bestanden successvol geëxporteerd",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst exporteren",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exporteer afspeellijst als CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kan hier niet importeren",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exporteer afspeellijst naar JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Dit formaat kan worden geïmporteerd",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exporteren naar YouTube-muziek",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Het zal je afspeellijst (nummers < 50) naar de huidige wachtrij pushen, vergeet niet om deze aan de afspeellijst toe te voegen/op te slaan nadat je deze in YtMusic hebt geopend",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Gedownload bestand exporteerlocatie",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exporteren..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst exporteren...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorieten"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Aanbevolen Afspeellijsten",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Bestand niet gevonden",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Doorgaan"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("gevolgd"),
    "following": MessageLookupByLibrary.simpleMessage("Volgende"),
    "for1": MessageLookupByLibrary.simpleMessage("voor"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "vergeten favorieten",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Vriend"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Vriendschapsverzoek geaccepteerd",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Vriendschapsverzoek verzonden",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Vrienden"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Log in om vrienden te vinden.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Vriendschap verwijderd",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Fout"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronica"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hiphop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("Latijns"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Knal"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Steen"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gebaar"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Bekijk GitHub-broncode\nals je dit project leuk vindt, vergeet dan niet een ⭐ te geven",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Ga naar album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Klik hier om naar de downloadpagina te gaan",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hallo wereld"),
    "high": MessageLookupByLibrary.simpleMessage("Hoog"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL naar Piped instantie",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Home inhoudsaantal",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Selecteer het nummer van initiële homescherminhoud(gemiddeld). Minder resultaten sneller laden",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Identiteitskaart"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Negeer batterij optimalisatie",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Als u meldingsproblemen ondervindt of het afspelen is gestopt door systeemoptimalisatie, schakel deze optie in",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Fout bij importeren van afspeellijst",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Fout bij opslaan in database",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Het geselecteerde bestand kon niet worden geopend",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Ongeldig bestandsformaat",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Opmerking: het importeren van grote afspeellijsten kan langer duren",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importeer afspeellijst",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Selecteer een eerder geëxporteerd afspeellijst-JSON-bestand om te importeren",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Geïmporteerd"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Geïmporteerd van Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Geïmporteerde afspeellijst",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst importeren...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage("Interne opslagmap"),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Inclusief gedownloade songbestanden",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informatie niet beschikbaar",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Ongeldige bestandsstructuur van afspeellijst",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Ongeldige serverreactie.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "De sessie bevat geen geldig token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("items"),
    "keepListening": MessageLookupByLibrary.simpleMessage("blijf luisteren"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Scherm aanhouden tijdens afspelen",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Indien ingeschakeld blijft het scherm van het apparaat ingeschakeld tijdens het afspelen van muziek",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Taal"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Zet App taal"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Nieuwste uitgave"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Nieuwste versie beschikbaar",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Laten we beginnen.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Bibliotheek Albums"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Bibliotheek Artiesten"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Bibliotheek Afspeellijsten",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Bibliotheek liedjes"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotheek"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Bibliotheek-afspeellijst",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Licht"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Successvol gelinked!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link gekopieerd naar klembord",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Link met piped voor afspeellijsten",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Luister nu"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Luisteren naar de omgeving...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Kan update-informatie niet laden",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokaal"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Het werkt zonder dat je hoeft in te loggen.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Uw hele bibliotheek blijft strikt op deze computer.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Let op: Geen handmatige cloudback-ups. Als u uw apparaat kwijtraakt of de app verwijdert, kunnen uw gegevens niet worden hersteld.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Alleen op dit apparaat gebruiken",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolute privacy op uw apparaat",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Lokale modus"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LuidheidDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisatie van de luidheid",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Stelt hetzelfde luidheidsniveau in voor alle nummers (experimenteel) (werkt niet op nummers die zijn gedownload in oudere versies (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Laag"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Brieven"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Tekst niet beschikbaar!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Beheer bijdragers (vrienden)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Zorg ervoor dat de muziek luid genoeg staat in de buurt van uw microfoon.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Gemigreerd album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Gemigreerde bibliotheek",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Gemigreerde afspeellijst",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Er is al een migratie gaande.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyse van de plaatselijke bibliotheek...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Controleren of EMusic Cloud al een bibliotheek heeft...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migratie voltooid.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Een lokale back-up maken voordat u verbinding maakt met de cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "De migratie is mislukt. Uw lokale gegevens zijn niet gewijzigd.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Meld u aan bij Joss Red voordat u migreert.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "De migratie voorbereiden in EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kon de migratie niet starten.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Niet alle gegevens konden worden geüpload. Wij behouden uw lokale steun.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Afspeellijsten, favorieten en geschiedenis uploaden...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kon de migratie niet valideren.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Integriteit verifiëren in EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Bestand selecteren en importeren",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecteer song.db of een back-up .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migratie succesvol afgerond.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minuten"),
    "misc": MessageLookupByLibrary.simpleMessage("Diversen"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Het meest beluisterde nummer",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Muziek en afspelen",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Muziekherkenning",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Netwerkfout! Controleer uw internetverbinding.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Oops netwerk error!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nieuwe versie beschikbaar!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red-app (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Begrepen"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Rood Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% synchronisatie met Joss Red, afspeellijsten met vrienden en nog veel meer. Tik om te zien wat er nieuw is.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Muziek is geëvolueerd!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Om vrienden toe te voegen, verzoeken te accepteren of uw beveiligingsprofiel te beheren, gebruikt u Joss Red op zijn officiële platforms:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Vrienden- en accountbeheer:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Muzieknieuws",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Maak afspeellijsten met je vrienden! Wanneer u een afspeellijst maakt, selecteert u het selectievakje Samenwerken en kiest u uw vrienden om samen te bewerken.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Gezamenlijke afspeellijsten",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Uw afspeellijsten en favorieten worden nu automatisch in de cloud opgeslagen en gesynchroniseerd met uw hoofdaccount van Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Volledige integratie met Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "U hoeft niet langer op handmatige synchronisatieknoppen te klikken; De nieuwe motor is verantwoordelijk voor het automatisch op- en terugschakelen.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparante synchronisatie",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Nee"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Geen bladwijzers!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Je hebt geen toegevoegde vrienden op Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Je hebt geen lib afspeellijsten!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Kon geen nummers vinden in de opgenomen audio",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Geen overeenkomsten",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Geen offline liedjes!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Er zijn geen nummers in deze collectie",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Geen overeenkomst gevonden",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Niet geauthenticeerd",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Niet een Liedje/Muziekvideo!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Niet een valide link!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Openen in"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operatie gefaald"),
    "password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
    "password_text": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Toestemming geweigerd",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Toestaan"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music heeft deze machtigingen nodig om je muziek te beheren en alle afspeelfuncties aan te bieden.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Machtigingen om aan de slag te gaan",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Verleen de vereiste machtigingen",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Het wordt alleen gebruikt als u ervoor kiest een nummer te identificeren dat om u heen wordt afgespeeld.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Microfoon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Toont afspeelknoppen, downloadvoortgang en belangrijke app-meldingen.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Meldingen",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Instellingen",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Alle drie de vergunningen zijn vereist om door te kunnen gaan. U kunt ze later wijzigen in de systeeminstellingen.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Hiermee kunt u muziek afspelen, downloads opslaan, afspeellijsten exporteren en updates voorbereiden.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Muziek en opslag",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisatie"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Doorgesluisde afspeellijst",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped afspeellijst gesynchroniseerd!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Vlak"),
    "play": MessageLookupByLibrary.simpleMessage("Spelen"),
    "playNext": MessageLookupByLibrary.simpleMessage("Speel volgende"),
    "playNow": MessageLookupByLibrary.simpleMessage("Speel nu"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Afspeelsnelheid"),
    "playerUi": MessageLookupByLibrary.simpleMessage("Speler-UI"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Selecteer de gebruikersinterface van de speler",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Spelen:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SPELEN VAN ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SPELEN VAN KUNSTENAAR",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "AFSPELEN VANUIT AFSPEELLIJST",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "SPELEN VANUIT SELECTIE",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Afspeellijst"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst op zwarte lijst gezet!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst gebladwijzerd!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst bladwijzer verwijderd!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Bijdragers van afspeellijsten",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst gecreëerd!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst gecreëerd en liedje toegevoegd!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst succesvol geëxporteerd naar",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst geïmporteerd",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst verwijderd!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Successvol hernoemd!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Afspeellijsten"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage(
      "Binnenkort beschikbaar",
    ),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Populaire nummers"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Bestanden verwerken...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Het geluid verwerken...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profielen"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("staart lus"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "De wachtrijlusmodus kan niet worden uitgeschakeld als de shuffle-modus is ingeschakeld.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "De staartlusmodus kan niet worden geactiveerd in de radiomodus.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "De willekeurige modus is geactiveerd. U kunt de wachtrij niet handmatig mixen.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "De wachtrij kan niet opnieuw worden gerangschikt als de shuffle-modus is ingeschakeld",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Snelle selectie"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Snelle keuzes"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio is niet beschikbaar voor deze artiest!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Willekeurige radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Willekeurige selectie",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Afspeellijst herschikken",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Nummers opnieuw ordenen",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Lees meer"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Recente zoekopdrachten",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Onlangs Gespeeld"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Voor een Spotify-achtige ervaring raden wij aan om de Cloud Mode te activeren: real-time synchronisatie tussen al je apparaten en automatische back-up zonder dat je er iets voor hoeft te doen.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Aanbevolen"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Aanbevolen"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Verwijderen uit cache",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Verwijder van bibliotheek Liedjes",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Verwijderen uit bibliotheek",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Verwijder van afspeellijst",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Verwijder van wachtrij",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Verwijder meerdere liedjes",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Verwijder Afspeellijst",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Hernoem"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Hernoem Afspeellijst",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Gereproduceerd door"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Standaardinstellingen herstellen",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "App-instellingen terugzetten naar standaard (herstart vereist)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Het terugzetten van de instellingen naar de standaardinstellingen is voltooid. Start de app opnieuw",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Reset op de zwarte lijst gezette afspeellijsten",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Reset alle piped, op de zwarte lijst gezette afspeellijsten",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Start de applicatie opnieuw",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Herstellen"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "App-gegevens herstellen",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Herstel van vorige afspeelsessie",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Herstel automatisch de laatste afspeelsessie wanneer de app start",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Succesvol hersteld!\nWijzigingen worden toegepast bij het opnieuw opstarten",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Herstel instellingen en afspeellijsten",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Herstelt alle instellingen, aanmeldgegevens en afspeellijsten van een back-up bestand. Overschrijft alle huidige gegevens",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecteer het back-upbestand",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Herstellen..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultaten"),
    "retry": MessageLookupByLibrary.simpleMessage("Probeer opnieuw!"),
    "save": MessageLookupByLibrary.simpleMessage("Houden"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scannen..."),
    "search": MessageLookupByLibrary.simpleMessage("Zoek"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Liedjes, Afspeelijst, Album of Artiest",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Zoek in Bibliotheek",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Zoek resultaten"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Recente zoekopdrachten",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Selecteer alle"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Selecteer Auth Instantie",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Selecteer Authenticatie instantie!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Selecteer Bestand"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Selecteer liedjes"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Het geselecteerde bestand is niet gevonden.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Uw sessie is verlopen. Meld u opnieuw aan.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Zet ontdekkingsinhoud",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Over Estrella-muziek",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versie, open source project en GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Account en synchronisatie",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus, back-ups, vriendenlijst en migraties.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Thema-, taal- en interface-animaties.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloud-back-up",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Uploaden, herstellen en beheren...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Upload een .hmb-back-up van de app naar de server en herstel indien nodig een van de opgeslagen back-ups.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Ontdek filters, integratie met Piped en caches.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Downloads en opslag",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Audioformaten, mappen en automatische downloads.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Algemeen",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Kies, migreer of bekijk de synchronisatiestatus met Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Lokale modus / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Uitloggen"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importeer afspeellijsten, nummers...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migreren van Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "mijn vrienden",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Beheer uw Joss Red-vrienden rechtstreeks.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streamingkwaliteit, normalisatie, stiltes en batterij.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Genereer je YouTube Music-ID opnieuw als Discover-content niet wordt geladen.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Vernieuwings-ID (bezoekers-ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Fout"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Er kan geen nieuwe ID worden gegenereerd. Probeer het later opnieuw.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Bijgewerkte identificatie",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Er is met succes een nieuwe bezoekers-ID gegenereerd.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Album delen"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("Deel afspeellijst"),
    "shareSong": MessageLookupByLibrary.simpleMessage("Deel dit liedje"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Zoeken in de Shazam-database naar overeenkomsten...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Willekeurig"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("gemengde staart"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Stilte overslaan"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Stilte wordt overgeslagen in muziek afspeling",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Je slaap timer is ingezet",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Slaap timer"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Liedje toegevoegd aan afspeellijst!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Liedje bestaat al!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Liedje is al offline in cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Liedje toegevoegd aan wachtrij!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Lied gevonden!"),
    "songInfo": MessageLookupByLibrary.simpleMessage(
      "Informatie over het nummer",
    ),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Het nummer kan niet worden afgespeeld vanwege serverbeperkingen!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("toon van het lied"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Verwijderd van"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Verwijder van wachtrij!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Je kunt niet het liedje dat nu afspeelt verwijderen",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Liedjes"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Nummers geïmporteerd uit Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sorteer oplopend/aflopend",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sorteer op datum"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage("Sorteer op duur"),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sorteer op naam"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Snelheid en toonhoogte",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standaard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Start radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Openen bij opstarten",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Kies de sectie die Estrella Music als eerste opent",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Stop muziek wanneer taak duidelijk is",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Het afspelen van muziek stopt wanneer de App uit Taakbeheer wordt weggeveegd",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streaming kwaliteit",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Kwaliteit van muziekstream",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("abonnees"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Veeg om opties te verkennen ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus geactiveerd. De bestaande bibliotheek downloaden.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus geactiveerd. Gemigreerde bibliotheek.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus actief",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Cloudmodus actief. Synchronisatie in behandeling.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Kan de synchronisatie niet downloaden.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "EMusic-wijzigingen downloaden...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Gesynchroniseerde bibliotheek.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Bibliotheek up-to-date.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Er zijn nieuwe lokale veranderingen. Ze worden geüpload voordat ze worden gedownload.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Uw gegevens worden alleen op dit apparaat bewaard.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Lokale modus actief",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline. Er zijn wijzigingen in voorbereiding.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline. Wijzigingen opgeslagen voor opnieuw proberen.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synchroniseer afspeellijstnummers",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic heeft niet alle wijzigingen bevestigd. Ze zullen opnieuw worden geprobeerd.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Kon niet opstaan. Het wordt later opnieuw geprobeerd.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Wijzigingen correct geüpload.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Wijzigingen zijn succesvol geüpload (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Kan niet uploaden met WS. Het wordt later opnieuw geprobeerd.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Wijzigingen uploaden naar EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Gesynchroniseerd"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Gesynchroniseerde teksten niet beschikbaar!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Systeem standaard"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Thema modus"),
    "title": MessageLookupByLibrary.simpleMessage("Titel"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("Topmuziekvideo\'s"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Top muziek videos"),
    "trending": MessageLookupByLibrary.simpleMessage("Trending"),
    "unLink": MessageLookupByLibrary.simpleMessage("Unlink"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("Successvol unlink!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Titelloos nummer"),
    "upNext": MessageLookupByLibrary.simpleMessage("Volgende"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Applicatie bijwerken"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Gedetecteerde URL klik erop om de bijbehorende inhoud te openen/af te spelen",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Geblokkeerde gebruiker",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Het antwoord bevat geen lijst met gebruikers.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Ontgrendelde gebruiker",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Bekijk alles"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Bekijk Artiest"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "We hebben ons platform gemoderniseerd. Het oude systeem voor het uploaden van handmatige back-ups is uitgeschakeld. Je hebt nu twee duidelijke manieren om je muziekbibliotheek te beheren.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Kies zelf hoe jij Estrella Music voortaan wilt beleven.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Jouw muziek, jouw manier",
    ),
  };
}
