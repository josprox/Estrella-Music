// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(error) =>
      "Beim Neugenerieren ist ein Fehler aufgetreten: ${error}";

  static String m1(title) => "Ähnlich wie ${title}";

  static String m2(current) => "Schritt ${current} von 3";

  static String m3(count) => "${count} Änderungen übernommen.";

  static String m4(count) => "${count} synchronisierte Änderungen.";

  static String m5(statusCode) =>
      "Es konnte nicht nach Benutzern gesucht werden (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Neue Wiedergabeliste erstellen",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Um"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("5 Minuten hinzufügen"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Lieder zu Wiedergabeliste hinzufügen",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Zur Wiedergabeliste hinzufügen",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album als Lesezeichen markiert!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album-Lesezeichen entfernt!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Alben"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Ganz nach Ihrem Geschmack",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Alle Felder benötigt",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Nicht getestet: Wenn du das Kontrollkästchen nach dem Herunterladen von mehr als 60 Dateien aktivierst, kann der Vorgang viel Speicher beanspruchen und zum Absturz des Telefons oder der App führen. Fahre auf eigene Gefahr fort.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("App Infos"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Künstler als Lesezeichen markiert!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Künstler-Lesezeichen entfernt!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Beschreibung nicht verfügbar!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Künstler"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Ganz nach Ihrem Geschmack",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audio Codec"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Akzeptieren Sie die Verwendung meiner Daten...",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Login"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Registrieren"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Vorname"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Ich habe mein Passwort vergessen",
    ),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Nachname"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Erfolgreich angemeldet",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Willkommen bei Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Willkommen bei Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Lade Favoriten automatisch herunter",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Lade Lieder automatisch herunter wenn sie zu Favoriten hinzugefügt werden",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Öffne Player Bildschirm automatisch",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Aktiviere/Deaktiviere automatisches öffnen des Vollbildplayers, wenn ein Lied ausgewählt wurde",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Zurückkehren"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "Datenbanken gefunden",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Hintergrundwiedergabe",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Musikwiedergabe im Hintergrund aktivieren/deaktivieren (auf die App kann über die Taskleiste zugegriffen werden, wenn die App im Hintergrund ausgeführt wird)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sicherung"),
    "backupAppData": MessageLookupByLibrary.simpleMessage("App-Daten sichern"),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Sicherung läuft...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Sicherung erfolgreich gespeichert!",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Sichert alle Einstellungen, Wiedergabelisten und Login-Daten in einer Sicherungsdatei",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Sie benötigen eine aktive Sitzung...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "App neu starten",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Jetzt Backup hochladen",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Möchten Sie ein Backup durchführen?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Sicherung gelöscht.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Es sind noch keine Backups vorhanden...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Sicherung wiederhergestellt. Starten Sie die App neu.",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie aus, welche Daten gesichert werden sollen",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Backup korrekt hochgeladen.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Basierend auf der letzten Interaktion",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Erfolgreich zurückgesetzt!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("von"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Inhalt des Startbildschirms zwischenspeichern",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Aktivieren das Zwischenspeichern des Inhalts des Startbildschirms. Der Startbildschirm wird sofort geladen, wenn diese Option aktiviert ist",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Zwischenspeichern von Liedern",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Zwischenspeichern von Liedern während der Wiedergabe für die zukünftige/offline-Wiedergabe. Nimmt zusätzlichen Speicherplatz auf deinem Gerät in Anspruch",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Zwischengespeichert/Offline",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Timer abbrechen"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Sleep-Timer abgebrochen",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Lösche Bildspeicher",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Bildspeicher erfolgreich gelöscht",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klicke hier, um die gespeicherten Miniaturansichten/Bilder zu löschen. (Nicht empfohlen, es sei denn, eine Aktualisierung der gespeicherten Bilder ist erwünscht)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Schließen"),
    "closeApp": MessageLookupByLibrary.simpleMessage("App schließen"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Cloud-Bibliothek gefunden.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Eine Cloud-Bibliothek wurde gefunden. Dieses Gerät lädt es herunter, ohne es zu überschreiben.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Der Cloud-Modus ist bereit. Dieses Gerät fungiert als Offline-Cache.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Melden Sie sich sicher mit Ihrem Joss Red-Konto an.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Greifen Sie von jedem Gerät (Windows, Android usw.) sofort auf Ihre Wiedergabelisten, Favoriten und Ihren Verlauf zu.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Arbeiten Sie offline und laden Sie Änderungen automatisch hoch, wenn Sie die Internetverbindung wiederherstellen.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktivieren Sie die Cloud-Synchronisierung",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Echtzeitsynchronisierung mit Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Cloud-Modus (empfohlen)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Kollaborative Playlist",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie die Freunde aus, die diese Playlist sehen und bearbeiten können:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Mitarbeiter wurden korrekt aktualisiert.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Community Wiedergabelisten",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Inhalt"),
    "create": MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createnAdd": MessageLookupByLibrary.simpleMessage(
      "Erstellen & hinzufügen",
    ),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Benutzerdefinierte Instanz",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Bitte wählen Sie „Benutzerdefinierte Instanz“ aus",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Tägliche Entdeckung",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Dunkel"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Aus Downloads entfernen",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Erfolgreich aus Downloads entfernt!",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Übergangsanimationen Ausschalten",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktiviere dies, um Tabübergangsanimationen abzuschalten",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Deaktiviert"),
    "discover": MessageLookupByLibrary.simpleMessage("Entdecken"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Ablehnen"),
    "done": MessageLookupByLibrary.simpleMessage("Bereit"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Diese Information nicht mehr anzeigen",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "heruntergeladene Dateien gefunden",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Herunterladen"),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Der angeforderte Titel kann aufgrund von Serverbeschränkungen nicht heruntergeladen werden. Du kannst es erneut versuchen",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Herunterladen fehlgeschlagen aufgrund eines Netzwerk-/Streamfehlers! Versuche es erneut",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Downloadpfad"),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Download-Format",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Wähle das Dateiformat für Downloads aus. „Opus“ bietet die beste Qualität",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Downloads"),
    "duration": MessageLookupByLibrary.simpleMessage("Dauer"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamisch"),
    "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Leere Wiedergabeliste!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Untere Navigationsleiste",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Wechsle zur unteren Navigationsleiste",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktiviere Gestenaktionen",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktiviere Gestenaktionen beim Songtitel",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktiviert"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Ende dieses Liedes"),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Alle einreihen"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Dieses Lied einreihen",
    ),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Öffne den System-Equalizer",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Es ist ein Fehler aufgetreten!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Es ist ein Fehler aufgetreten",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Abspielen:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportieren"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportiere heruntergeladene Dateien",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klicke hier, um die heruntergeladenen Dateien vom inApp Verzeichnis zu einem externen Verzeichnis zu exportieren",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Exportieren der Playlist",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Formatieren der Playlistdaten",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Berechtigung beim Exportieren verweigert",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Nicht genug Speicher",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Dateien erfolgreich exportiert",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Playlist exportieren",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Exportverzeichnis",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportiert..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportiere Playlist...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoriten"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Vorgestellte Playlists",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Datei nicht gefunden",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Weitermachen"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("gefolgt"),
    "following": MessageLookupByLibrary.simpleMessage("Nachfolgend"),
    "for1": MessageLookupByLibrary.simpleMessage("für"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "vergessene Favoriten",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Freund"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Freundschaftsanfrage angenommen",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Freundschaftsanfrage gesendet",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Freunde"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Melden Sie sich an, um Freunde zu finden.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Freundschaft entfernt",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Fehler"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronik"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("Hip Hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("lateinisch"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Felsen"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesten"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "GitHub-Quellcode ansehen \nWenn dir dieses Projekt gefällt, vergesse nicht, einen ⭐ zu geben",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Zum Album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Klicken Sie hier, um zur Download-Seite zu gelangen",
    ),
    "high": MessageLookupByLibrary.simpleMessage("hoch"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API-URL zur Piped-Instanz",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Start"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Startseiteninhalt",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Wähle die Anzahl der initialen Startseiteninhalte (ungefähr). Niedrigere Werte laden schneller",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Akku-Optimierung ignorieren",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Wenn du Probleme mit Benachrichtigungen hast oder die Wiedergabe durch die Systemoptimierung gestoppt wird, aktiviere bitte diese Option",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Importieren der Playlist",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Speichern in der Datenbank",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Auf die ausgewählte Datei konnte nicht zugegriffen werden",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Ungültiges Dateiformat",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Hinweis: Der Import großer Playlisten kann länger dauern",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Playlist importieren",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Wähle eine zuvor exportierte Playlist-JSON-Datei zum Importieren aus",
    ),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importiert von Joss Music Kotlin",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importiere Playlist...",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Heruntergeladene Musikdateien einbeziehen",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Ungültige Playlist Dateistruktur",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Ungültige Serverantwort.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Die Sitzung enthält kein gültiges Token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("Artikel"),
    "keepListening": MessageLookupByLibrary.simpleMessage("Hör weiter zu"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Bildschirm während der Wiedergabe eingeschaltet lassen",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Wenn aktiviert, bleibt der Bildschirm des Geräts beim Musikhören eingeschaltet",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Sprache"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Sprache ändern"),
    "latestRelease": MessageLookupByLibrary.simpleMessage(
      "Neueste Veröffentlichung",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Lass uns anfangen..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage(
      "Alben in der Bibliothek",
    ),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Künstler in der Bibliothek",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Wiedergabelisten in der Bibliothek",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage(
      "Lieder in der Bibliothek",
    ),
    "library": MessageLookupByLibrary.simpleMessage("Bibliothek"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Bibliotheks-Playlist",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Hell"),
    "link": MessageLookupByLibrary.simpleMessage("Verknüpfung"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Erfolgreich verbunden!"),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Mit Piped verknüpfen",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Hören Sie jetzt zu"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Auf die Umgebung hören...",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokal"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Es funktioniert, ohne dass Sie sich anmelden müssen.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Ihre gesamte Bibliothek bleibt ausschließlich auf diesem Computer.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Hinweis: Keine manuellen Cloud-Backups. Wenn Sie Ihr Gerät verlieren oder die App deinstallieren, können Ihre Daten nicht wiederhergestellt werden.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Nur auf diesem Gerät verwenden",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolute Privatsphäre auf Ihrem Gerät",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Lokaler Modus"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Lautstärke Db"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Lautstärkenormalisierung",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Stellt für alle Titel die gleiche Lautstärke ein (experimentell) (Funktioniert nicht bei Titeln, die mit einer früheren Version (< v1.10.0) heruntergeladen wurden)",
    ),
    "low": MessageLookupByLibrary.simpleMessage("niedrig"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Liedtext nicht verfügbar!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Mitarbeiter (Freunde) verwalten",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Stellen Sie sicher, dass die Musik in der Nähe Ihres Mikrofons laut genug abgespielt wird.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migriertes Album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Migrierte Bibliothek",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrierte Playlist",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Es ist bereits eine Migration im Gange.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyse der lokalen Bibliothek...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Überprüfen, ob EMusic Cloud bereits über eine Bibliothek verfügt ...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migration abgeschlossen.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Erstellen Sie ein lokales Backup, bevor Sie die Cloud verbinden ...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Die Migration ist fehlgeschlagen. Ihre lokalen Daten wurden nicht geändert.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Melden Sie sich vor der Migration bei Joss Red an.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Vorbereitung der Migration in EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud konnte die Migration nicht starten.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Es konnten nicht alle Daten hochgeladen werden. Wir behalten Ihre lokale Unterstützung.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Playlists, Favoriten und Verlauf werden hochgeladen...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud konnte die Migration nicht validieren.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Überprüfung der Integrität in EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Datei auswählen und importieren",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Minuten"),
    "misc": MessageLookupByLibrary.simpleMessage("Sonstiges"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Das meistgehörte Lied",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musik & Wiedergabe",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Musikanerkennung",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Netzwerkfehler! Überprüfe deine Internetverbindung.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Ups, Netzwerkfehler!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Neue Version verfügbar!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red App (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Verstanden"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100 % Synchronisierung mit Joss Red, Playlists mit Freunden und vieles mehr. Tippen Sie hier, um zu sehen, was es Neues gibt.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music hat sich weiterentwickelt!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Um Freunde hinzuzufügen, Anfragen anzunehmen oder Ihr Sicherheitsprofil zu verwalten, verwenden Sie bitte Joss Red auf seinen offiziellen Plattformen:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Freundes- und Kontoverwaltung:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Musiknachrichten",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Erstelle Playlists mit deinen Freunden! Aktivieren Sie beim Erstellen einer Wiedergabeliste das Kontrollkästchen „Gemeinsam“ und wählen Sie Ihre Freunde aus, die Sie gemeinsam bearbeiten möchten.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Kollaborative Playlists",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Ihre Wiedergabelisten und Favoriten werden jetzt automatisch in der Cloud mit Ihrem Joss Red-Hauptkonto gespeichert und synchronisiert.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Vollständige Integration mit Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Sie müssen nicht mehr auf manuelle Synchronisierungsschaltflächen klicken; Für das automatische Hoch- und Runterschalten ist der neue Motor zuständig.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparente Synchronisierung",
    ),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Keine Lesezeichen!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Sie haben keine Freunde auf Joss Red hinzugefügt.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Du hast keine Wiedergabeliste in der Bibliothek!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Im aufgenommenen Audio konnten keine Lieder gefunden werden",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Keine Übereinstimmungen",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Keine Lieder Offline!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Diese Sammlung enthält keine Lieder",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Keine Übereinstimmung gefunden für",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Nicht authentifiziert",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Kein Lied/Musik-Video!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Kein gültiger Link!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Öffnen in"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Operation fehlgeschlagen",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Passwort"),
    "password_text": MessageLookupByLibrary.simpleMessage("Passwort"),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisierung"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Gespeiste Playlist",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist synchronisiert!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Einfach"),
    "playNext": MessageLookupByLibrary.simpleMessage("Als Nächstes spielen"),
    "playNow": MessageLookupByLibrary.simpleMessage("jetzt spielen"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Wiedergabegeschwindigkeit",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Player UI"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Wähle Player Benutzeroberfläche",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Spielen:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SPIELE AUS ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SPIELE AUS KÜNSTLER",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "SPIELE AUS PLAYLIST",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "SPIELE AUS AUSWAHL",
    ),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste auf die schwarze Liste gesetzt!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste als Lesezeichen markiert!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste-Lesezeichen entfernt!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Mitwirkende der Playlist",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste erstellt!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste erstellt & Lied hinzugefügt!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist erfolgreich exportiert nach",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist erfolgreich importiert",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste entfernt!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Erfolgreich umbenannt!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Wiedergabelisten"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Nächster"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Beliebte Titel"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Verarbeitet Dateien...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Verarbeiten des Audios...",
    ),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Wiederholen"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Wiederholen kann nicht deaktiviert werden, wenn Zufallswiedergabe aktiv ist.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Wiederholung kann nicht aktiviert werden wenn der Radio Modus läuft.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Warteschlange kann nicht gemischt werden, wenn der Shuffle-Modus aktiviert ist",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Die Warteschlange kann nicht neu geordnet werden, wenn der Shuffle-Modus aktiviert ist",
    ),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Schnellauswahl"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio für diesen Künstler nicht verfügbar!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Zufälliges Radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Zufallsauswahl"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste neu anordnen",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Lieder neu anordnen",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Mehr lesen"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Aktuelle Suchanfragen",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Kürzlich abgespielt",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Für ein Spotify-ähnliches Erlebnis empfehlen wir die Aktivierung des Cloud-Modus: Echtzeitsynchronisierung zwischen all Ihren Geräten und automatische Sicherung, ohne dass Sie etwas tun müssen.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Empfohlen"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Empfohlen"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Lied aus der Bibliothek entfernen",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Aus Wiedergabeliste entfernen",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Aus der Warteschlange entfernen",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Mehrere Lieder entfernen",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste entfernen",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Umbenennen"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Wiedergabeliste umbenennen",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproduziert von"),
    "reset": MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Standardeinstellungen wiederherstellen",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Setze die App-Einstellungen auf die Standards zurück (Neustart erforderlich)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Zurücksetzen der Einstellungen abgeschlossen, bitte starte die App neu",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Auf die schwarze Liste gesetzte Wiedergabelisten zurücksetzen",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Setzen Sie alle Piped Wiedergabelisten auf der schwarzen Liste zurück",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("App neustarten"),
    "restore": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "App-Daten wiederherstellen",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Letzte Sitzung wiederherstellen",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Stellt automatisch beim Starten der App die letzte Wiedergabe wieder her",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Erfolgreich wiederhergestellt!\nÄnderungen werden beim Neustart in Kraft treten",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Stellt alle Einstellungen, Login-Daten und Wiedergabelisten mit einer Sicherungsdatei wieder her. Überschreibt alle jetzigen Daten",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Wiederherstellen..."),
    "results": MessageLookupByLibrary.simpleMessage("Ergebnisse"),
    "retry": MessageLookupByLibrary.simpleMessage("Wiederholen!"),
    "save": MessageLookupByLibrary.simpleMessage("Halten"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Gespeichert"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scanne..."),
    "search": MessageLookupByLibrary.simpleMessage("Suche"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Lieder, Wiedergabeliste, Album oder Künstler",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "In der Bibliothek suchen",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Suchergebnisse"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Aktuelle Suchanfragen",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Alles auswählen"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Autorisierungsinstanz auswählen",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Bitte wähle Authentifizierungsinstanz!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Datei auswählen"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Lieder auswählen"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Die ausgewählte Datei wurde nicht gefunden.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Ihre Sitzung ist abgelaufen. Melden Sie sich erneut an.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "„Inhalte entdecken“",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Über Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Version, Open-Source-Projekt und GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Konto und Synchronisierung",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Cloud-Modus, Backups, Freundesliste und Migrationen.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Themen-, Sprach- und Schnittstellenanimationen.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloud-Backup",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Hochladen, Wiederherstellen und Verwalten...",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Entdecken Sie Filter, Integration mit Piped und Caches.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Downloads und Speicherung",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Audioformate, Ordner und automatische Downloads.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Allgemein",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie, migrieren Sie oder überprüfen Sie den Synchronisierungsstatus mit Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Lokaler Modus / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Playlists, Songs importieren...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Von Joss Music Kotlin migrieren",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "meine Freunde",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Verwalten Sie Ihre Joss Red-Freunde direkt.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streaming-Qualität, Normalisierung, Stille und Akku.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Generieren Sie Ihre YouTube Music ID neu, wenn Discover-Inhalte nicht geladen werden.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Aktualisierungs-ID (Besucher-ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Fehler"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Es konnte kein neuer Bezeichner generiert werden. Bitte versuchen Sie es später noch einmal.",
    ),
    "settings_visitor_exception": m0,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Aktualisierte Kennung",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Eine neue Besucher-ID wurde erfolgreich generiert.",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Dieses Lied teilen"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Suche in der Shazam-Datenbank nach Übereinstimmungen...",
    ),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Mischen"),
    "similarToTitle": m1,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Stille überspringen"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Stille wird bei der Musikwiedergabe übersprungen",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Dein Sleep-Timer ist gesetzt",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sleep-Timer"),
    "slide_indicator": m2,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Lied zur Wiedergabeliste hinzugefügt!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Das Lied existiert bereits!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Das Lied ist bereits offline gespeichert",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Lied in der Warteschlange!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Lied gefunden!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Liedinfo"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Song ist aufgrund von Servereinschränkungen nicht abspielbar!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("Liedton"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Entfernt von"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Aus der Warteschlange entfernt!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Du kannst das aktuell gespielte Lied nicht entfernen",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Lieder"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Von Joss Music Kotlin importierte Songs",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Geschwindigkeit und Tonhöhe",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Radio starten"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Beim Start öffnen"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie den Abschnitt aus, den Estrella Music zuerst öffnet",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Musik stoppen, wenn Task gestoppt wird",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Die Musikwiedergabe wird gestoppt, wenn die App aus dem Task-Manager weggewischt wird",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streaming-Qualität",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Qualität des Musikstreams",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("Abonnenten"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Wischen Sie, um die Optionen zu erkunden ➔",
    ),
    "syncChangesConfirmed": m3,
    "syncChangesSynced": m4,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Cloud-Modus aktiviert. Herunterladen der vorhandenen Bibliothek.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Cloud-Modus aktiviert. Migrierte Bibliothek.",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Cloud-Modus aktiv. Ausstehende Synchronisierung.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung konnte nicht heruntergeladen werden.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "EMusic-Änderungen werden heruntergeladen...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synchronisierte Bibliothek.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Bibliothek auf dem neuesten Stand.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Es gibt neue lokale Änderungen. Sie werden vor dem Herunterladen hochgeladen.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Ihre Daten werden nur auf diesem Gerät gespeichert.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Lokaler Modus aktiv",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline. Änderungen stehen an.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline. Änderungen zur Wiederholung gespeichert.",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic hat nicht alle Änderungen bestätigt. Sie werden erneut versucht.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Konnte nicht aufstehen. Es wird später erneut versucht.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Änderungen wurden korrekt hochgeladen.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Änderungen erfolgreich hochgeladen (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Konnte mit WS nicht hochgeladen werden. Es wird später erneut versucht.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Änderungen werden auf EMusic hochgeladen...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synchron"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synchronisierte Texte nicht verfügbar!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Systemvorgabe"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Farbmodus"),
    "title": MessageLookupByLibrary.simpleMessage("Titel"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Top Musikvideos"),
    "trending": MessageLookupByLibrary.simpleMessage("Trend"),
    "unLink": MessageLookupByLibrary.simpleMessage("Aufheben der Verknüpfung"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Verknüpfung erfolgreich getrennt!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Lied ohne Titel"),
    "upNext": MessageLookupByLibrary.simpleMessage("Als Nächstes"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL erkannt. Tippe darauf, um den zugehörigen Inhalt zu öffnen/abzuspielen",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Gesperrter Benutzer"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Die Antwort enthält keine Benutzerliste.",
    ),
    "userSearchFailed": m5,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Entsperrter Benutzer",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Benutzername"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Alle anzeigen"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Künstler anzeigen"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Wir haben unsere Plattform modernisiert. Das alte System zum Hochladen manueller Backups wurde deaktiviert. Sie haben jetzt zwei klare Möglichkeiten, Ihre Musikbibliothek zu verwalten.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie, wie Sie Estrella Music von nun an erleben möchten.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Deine Musik, dein Weg",
    ),
  };
}
