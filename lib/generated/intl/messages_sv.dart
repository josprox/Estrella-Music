// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sv locale. All the
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
  String get localeName => 'sv';

  static String m0(songTitle) => "Laddar ner: ${songTitle}";

  static String m1(count) => "Album: ${count}";

  static String m2(count) => "Artister: ${count}";

  static String m3(count) => "Favoriter: ${count}";

  static String m4(count) => "Spellistor: ${count}";

  static String m5(count) => "Låtar: ${count}";

  static String m6(source) => "Migreringen slutförd från ${source}.";

  static String m7(error) => "Ett fel uppstod under återskapandet: ${error}";

  static String m8(title) => "Liknar ${title}";

  static String m9(current) => "Steg ${current} av 3";

  static String m10(count) => "${count} ändringar har begåtts.";

  static String m11(count) => "${count} synkroniserade ändringar.";

  static String m12(statusCode) =>
      "Det gick inte att söka efter användare (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Skapa Spellista",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Om"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Lägg till 5 minuter"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Lägg till låtar i Spellista",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Lägg till i biblioteket",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lägg till i spellista",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album tillaggd i bibliotek!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album borttagen från bibliotek!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Album"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Enligt din smak"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage("Alla fält krävs"),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Ej testat: Om du markerar kryssrutan efter att ha laddat ner mer än 60 filer kan processen förbruka en stor mängd minne och kan orsaka att telefonen eller appen kraschar. Fortsätt på egen risk.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Ansökningsinformation"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artist tillagd i bibliotek!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artist borttagen från bibliotek!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Beskrivning ej tillgänglig!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artister"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("Enligt din smak"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Ljud-codec"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Autentiseringskod"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Ange en giltig 6-siffrig kod eller logga in igen.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ange den sexsiffriga koden från din autentiseringsapp. Denna åtkomst löper ut om 5 minuter.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Tvåfaktorsautentisering",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Kontrollera och fortsätt",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acceptera att använda miss data...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Vi tog med inloggning, registrering och lösenordsåterställning från det tidigare projektet, anpassat för den här musikappen.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Din session lever i säker lagring och valideras med samma backend som du redan använde.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      ".env-filen måste konfigureras för att ansluta autentiseringsbackend.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Inloggning"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Register"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Skicka mail"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Bekräfta lösenord",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Felaktig e-postadress eller lösenord.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Ange en giltig e-postadress.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Autentiseringsbackend saknas för att konfigureras i .env-filen.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Ditt konto är inte verifierat än.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att slutföra operationen.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Förnamn"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Jag har glömt mitt lösenord",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vi skickar instruktionerna till ditt kontos e-postadress.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("namn@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Efternamn"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Inloggad framgångsrikt",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att skicka mejlet.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-post skickat.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Kontot kunde inte skapas.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Kontot har skapats.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Välkommen till Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Välkommen till Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Automatisk nedladdning av favoritlåtar",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Ladda ned favoritlåtar automatiskt när de läggs till i favoriter",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Öppna spelarskärmen automatiskt",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Aktivera/avaktivera automatisk öppning av spelaren till helskärm när du väljer en låt att spela",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Återvända"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("hittade databaser"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Uppspelning i bakgrunden",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Aktivera/inaktivera bakgrundsuppspelning (Appen kan nås från statusfältet när appen körs i bakgrunden)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Säkerhetskopiering"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopiera appdata",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopiering pågår...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopieringen har sparats!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopieringsinställningar och spellistor",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Spara alla inställningar, spellistor och inloggningsdata till en säkerhetskopia",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Du behöver en aktiv session...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Starta om appen",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Ladda upp säkerhetskopia nu",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Vill du göra en säkerhetskopiering?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopiering raderad.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Det finns inga säkerhetskopior ännu...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopieringen återställd. Starta om appen.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Välj mappen för säkerhetskopiering",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Välj vilken data som ska säkerhetskopieras",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Säkerhetskopieringen har laddats upp korrekt.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Baserat på senaste sessionen",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bithastighet"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Spellista svartlista",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Återställning lyckades!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("av"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Lagra innehållsdata på startskärmen",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Aktivera lagring av innehåll på startskärmen, startskärmen laddas omedelbart om det här alternativet är aktiverat",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cachar låtar"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Att cachelagra låtar medan de spelas för framtida/offlineuppspelning kommer att ta upp ytterligare utrymme på din enhet",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Cached/Offline"),
    "cancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Avbryt timer"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Sovtimer avbruten",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("Rensa bild-cache"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Bild-cachen rensades",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klicka här för att rensa cachade miniatyrer/bilder. (Rekommenderas inte om du inte vill uppdatera cachad bilddata)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Nära"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Stäng ansökan"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Molnbibliotek hittades.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Ett molnbibliotek hittades. Den här enheten kommer att ladda ner den utan att skriva över den.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Molnläget är klart. Den här enheten fungerar som en offlinecache.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Logga in säkert med ditt Joss Red-konto.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Få åtkomst till dina spellistor, favoriter och historik från vilken enhet som helst (Windows, Android, etc.) direkt.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Arbeta offline och ladda upp ändringar automatiskt när du återställer internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktivera molnsynkronisering",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Realtidssynkronisering med Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Molnläge (rekommenderas)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Samarbetande spellista",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Välj de vänner som kommer att kunna se och redigera den här spellistan:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Samarbetspartners uppdaterade korrekt.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Communityspellistor",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Innehåll"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL-licens v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Skapa"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Skapa & lägg till"),
    "customIns": MessageLookupByLibrary.simpleMessage("Egen instans"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Välj egen instans",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Daglig upptäckt"),
    "dark": MessageLookupByLibrary.simpleMessage("Mörkt"),
    "delete": MessageLookupByLibrary.simpleMessage("Ta bort"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Ta bort från nedladdningar",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Borttagen från nedladdningar!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Utvecklad och underhållen av Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Inaktivera övergångsanimeringar",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Inaktivera övergångsanimeringar vid flikbyte",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Inaktiverad"),
    "discover": MessageLookupByLibrary.simpleMessage("Upptäck"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Avfärda"),
    "done": MessageLookupByLibrary.simpleMessage("Redo"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Visa inte denna information igen",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "nedladdade filer hittades",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Ladda ner"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Ladda ner låtar från albumet",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Den begärda låten kan inte laddas ner på grund av serverbegränsningar. Du kan försöka igen",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Nedladdningen misslyckades på grund av nätverks-/överföringsfel! Försök igen",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Ladda ner plats"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Håller din musiknedladdning aktiv i bakgrunden.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "musiknedladdningar",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Förbereder dina nedladdningar...",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Ladda ner musik",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ladda ner spellista",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Nedladdningsformat",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Välj filformat på nedladdad musik. \"Opus\" ger bäst kvalitet",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Nedladdat"),
    "duration": MessageLookupByLibrary.simpleMessage("Varaktighet"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamiskt"),
    "email": MessageLookupByLibrary.simpleMessage("E-post"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Tom Spellista!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Flytta navigeringsfältet till botten",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Flytta navigeringsfältet till botten av skärmen",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktivera reglageåtgärder",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktivera svepåtgärder på låtbrickan",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktiverad"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Slutet på den här låten",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Lägg till albumlåtar i kön",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Köa alla"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Lägg till i kön"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Lägg till låtar i kön",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Avsnitt"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Öppna systemequalizer",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Ett fel uppstod!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Ett fel uppstod"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Fel vid uppspelning:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exportera"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportera nedladdade filer",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klicka här för att exportera nedladdade filer från app-biblioteket till extern mapp",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att exportera spellistan",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Fel vid formatering av spellistdata",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Tillstånd nekad vid export",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Otillräckligt lagringsutrymme",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage("Filer har exporterats"),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportera spellista",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportera spellista som CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kan inte importera hit",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportera spellista till JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Detta format kan importeras",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportera till Youtube-musik",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Det kommer att skicka din spellista (låtar < 50) till den aktuella kön, glöm inte att lägga till den i spellistan/spara efter att ha öppnat den i YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Välj plats för nedladdade filer",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exporterar..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exporterar spellista...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoriter"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Utvalda Spellistor",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Filen hittades inte"),
    "follow": MessageLookupByLibrary.simpleMessage("Fortsätta"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("följde"),
    "following": MessageLookupByLibrary.simpleMessage("Följande"),
    "for1": MessageLookupByLibrary.simpleMessage("för"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "glömda favoriter",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Vän"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Vänförfrågan accepteras",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Vänförfrågan har skickats",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Vänner"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Logga in för att hitta vänner.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Vänskap borttagen",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Misstag"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronik"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Sten"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gest"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Visa GitHub källkod\nom du gillar det här projektet, glöm inte att ge en ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Gå till album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Klicka här för att gå till nedladdningssidan",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hej världen"),
    "high": MessageLookupByLibrary.simpleMessage("Hög"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API-URL till Piped-instans",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Hem"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Mängd innehåll på startsidan",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Välj mängden innehåll som ska visas på startsidan (Ungefärligt). Mindre innehåll resulterar i snabbare laddning",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorera batterioptimering",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Om du stöter på aviseringsproblem eller att uppspelningen stoppas p.g.a systemoptimering, aktivera det här alternativet",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Fel vid import av spellista",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att spara i databasen",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att komma åt den valda filen",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Ogiltigt filformat",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Obs! Det kan ta längre tid att importera stora spellistor",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importera spellista",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Välj en tidigare exporterad spellista JSON-fil att importera",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importerad"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importerad från Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importerad spellista",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importerar spellista...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Intern lagringskatalog",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Inkludera nedladdade låtfiler",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Information inte tillgänglig",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Ogiltig filstruktur för spellistan",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Ogiltigt serversvar.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Sessionen innehåller inte en giltig token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("föremål"),
    "keepListening": MessageLookupByLibrary.simpleMessage("fortsätt lyssna"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Håll skärmen på under uppspelning",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Om aktiverat förblir enhetens skärm på medan musik spelas",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Språk"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Byt språk"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Senaste utgåvan"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Senaste versionen tillgänglig",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Låt oss börja.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Album i Bibliotek"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Artister i Bibliotek"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Spellistor i Bibliotek",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Låtar i Bibliotek"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotek"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Bibliotekets spellista",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Ljust"),
    "link": MessageLookupByLibrary.simpleMessage("Länka"),
    "linkAlert": MessageLookupByLibrary.simpleMessage(
      "Länkades framgångsrikt!",
    ),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Länken har kopierats till urklipp",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Länka med piped för spellistor",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Lyssna nu"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Att lyssna på miljön...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att ladda uppdateringsinformation",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokalt"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Det fungerar utan att behöva logga in.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Hela ditt bibliotek förblir strikt på den här datorn.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Obs: Inga manuella molnsäkerhetskopieringar. Om du tappar bort din enhet eller avinstallerar appen kan din data inte återställas.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Använd endast på denna enhet",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolut integritet på din enhet",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Lokalt läge"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisering av ljudstyrkan",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Ställer in samma ljudstyrka för alla låtar (experimentell) (fungerar inte på låtar som laddats ner i äldre versioner (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Låg"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Bokstäver"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Låttexten är inte tillgänglig!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Hantera medarbetare (vänner)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Se till att musiken spelar tillräckligt högt nära din mikrofon.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migrerat album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Migrerade bibliotek",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrerad spellista",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Det pågår redan en migrering.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyserar det lokala biblioteket...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Kontrollerar om EMusic Cloud redan har ett bibliotek...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migreringen slutförd.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Skapar en lokal säkerhetskopia innan molnet ansluts...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migreringen misslyckades. Din lokala data har inte ändrats.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Logga in på Joss Red innan du migrerar.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Förbereder migreringen i EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kunde inte starta migreringen.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att ladda upp all data. Vi behåller ditt lokala stöd.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Laddar upp spellistor, favoriter och historik...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kunde inte validera migreringen.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verifierar integriteten i EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Välj fil och importera",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Välj song.db eller en backup .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migreringen slutfördes.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minuter"),
    "misc": MessageLookupByLibrary.simpleMessage("Olika"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Den mest lyssnade låten",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musik och uppspelning",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Musikigenkänning",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Nätverksfel! Kontrollera din internetanslutning.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("Nätverksfel!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Ny version tillgänglig!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red-appen (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Förstått"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100 % synkronisering med Joss Red, spellistor med vänner och mycket mer. Tryck för att se vad som är nytt.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music har utvecklats!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "För att lägga till vänner, acceptera förfrågningar eller hantera din säkerhetsprofil, använd Joss Red på dess officiella plattformar:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Vänner och kontohantering:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella musiknyheter",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Skapa spellistor med dina vänner! När du skapar en spellista markerar du kryssrutan Collaborative och väljer dina vänner att redigera tillsammans.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Samarbetande spellistor",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Dina spellistor och favoriter sparas nu och synkroniseras i molnet automatiskt med ditt Joss Red-huvudkonto.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Full integration med Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Du behöver inte längre klicka på knapparna för manuell synkronisering; Den nya motorn är ansvarig för att växla upp och ner automatiskt.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparent synkronisering",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Nej"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Inga bokmärken!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Du har inga tillagda vänner på Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Inga spellistor i biblioteket!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att hitta några låtar i det inspelade ljudet",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Inga matchningar"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("Inga offlinelåtar!"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Det finns inga låtar i den här samlingen",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Inget resultat hittades för",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Ej autentiserad"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Inte en låt/musikvideo!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Ogiltig länk!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Öppna in"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Operationen misslyckades",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Lösenord"),
    "password_text": MessageLookupByLibrary.simpleMessage("Lösenord"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("Tillstånd nekad"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Tillåta"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music behöver dessa behörigheter för att hantera din musik och erbjuda alla uppspelningsfunktioner.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Behörigheter att komma igång",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Bevilja nödvändiga behörigheter",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Den används bara när du väljer att identifiera en låt som spelas omkring dig.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Visar uppspelningskontroller, nedladdningsförlopp och viktiga appmeddelanden.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Aviseringar",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Inställningar",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Alla tre tillstånd krävs för att fortsätta. Du kan ändra dem senare i systeminställningarna.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Det låter dig spela musik, spara nedladdningar, exportera spellistor och förbereda uppdateringar.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musik och förvaring",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisering"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped spellista",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped spellista synkroniserad!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("enkelt"),
    "play": MessageLookupByLibrary.simpleMessage("Spela"),
    "playNext": MessageLookupByLibrary.simpleMessage("Spela nästa"),
    "playNow": MessageLookupByLibrary.simpleMessage("Spela nu"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Uppspelningshastighet",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Spelarens gränssnitt"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Välj spelarens användargränssnitt",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Spelar:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SPELAR FRÅN ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SPELAR FRÅN ARTIST",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "SPELAR FRÅN SPELLISTA",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "SPELAR FRÅN URVAL",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Spellista"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Spellistan svartlistad!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Spellista tillaggd i bibliotek!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Spellista borttagen från bibliotek!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Spellistor",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Spellista skapad!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Spellista skapad & låt tillagd!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Spellistan har exporterats till",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Spellistan har importerats",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Spellista borttagen!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Namnbyte lyckades!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Spellistor"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Kommer snart"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Populära låtar"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Bearbetar filer..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Bearbetar ljudet...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiler"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("svansögla"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Köloopläge kan inte inaktiveras när shuffle-läget är aktiverat.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Svansögleläge kan inte aktiveras i radioläge.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Slumpmässigt läge är aktiverat. Du kan inte blanda kön manuellt.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Kön kan inte ordnas om när shuffle-läget är på",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Snabbt urval"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Snabbval"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio inte tillgänglig för denna artist!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Slumpmässig radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Slumpmässigt urval",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Ordna om i Spellistan",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Ordna om låtarna"),
    "readMore": MessageLookupByLibrary.simpleMessage("Läs mer"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Senaste sökningar"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Senast Spelat"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Vi rekommenderar att du aktiverar molnläget för en Spotify-liknande upplevelse: realtidssynkronisering mellan alla dina enheter och automatisk säkerhetskopiering utan att du behöver göra något.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Rekommenderad"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Rekommenderad"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Ta bort från cachen",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Ta bort låt från bibliotek",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Ta bort från biblioteket",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ta bort från spellista",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Ta bort från kö"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Ta bort flera låtar",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Ta bort Spellista"),
    "rename": MessageLookupByLibrary.simpleMessage("Döp om"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Byt namn på Spellista",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Återges av"),
    "reset": MessageLookupByLibrary.simpleMessage("Återställ"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Återställ standardinställningar",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Återställ appinställningarna till standard (kräver omstart)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Inställningsåterställningen till standard är klar. Starta om appen",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Återställ svartlistade spellistor",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Återställ alla svartlistade piped-spellistor",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Starta om programmet"),
    "restore": MessageLookupByLibrary.simpleMessage("Återställ"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage("Återställ appdata"),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Återställ den senaste sessionen",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Återställ den senaste uppspelningssessionen automatiskt vid appstart",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Återställts framgångsrikt!\nÄndringar tillämpas vid omstart",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Återställ inställningar och spellistor",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Återställer alla inställningar, inloggningsdata och spellistor från en säkerhetskopia. Skriver över alla aktuella data",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Välj säkerhetskopian",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Återställer..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultat"),
    "retry": MessageLookupByLibrary.simpleMessage("Försök igen!"),
    "save": MessageLookupByLibrary.simpleMessage("Hålla"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Sparad"),
    "scanning": MessageLookupByLibrary.simpleMessage("Söker..."),
    "search": MessageLookupByLibrary.simpleMessage("Sök"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Låtar, Spellista, Album eller Artist",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Sök i biblioteket",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Sökresultat"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Senaste sökningar",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Välj alla"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Välj autentiseringsinstans",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Vänligen välj autentiseringsinstans!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Välj Arkiv"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Välj låtar"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Den valda filen hittades inte.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Din session har löpt ut. Logga in igen.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Innehåll som ska visas på Hem",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Inställningar"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Om Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Version, öppen källkodsprojekt och GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Konto och synkronisering",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Molnläge, säkerhetskopior, vänlista och migrering.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Tema-, språk- och gränssnittsanimationer.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloud backup",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Ladda upp, återställ och hantera...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Ladda upp en .hmb-säkerhetskopia av appen till servern och, om det behövs, återställ någon av de sparade säkerhetskopiorna.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Upptäck filter, integration med Piped och cacher.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Nedladdningar och lagring",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Ljudformat, mappar och automatiska nedladdningar.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Allmän"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Välj, migrera eller granska synkroniseringsstatusen med Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Lokalt läge / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importera spellistor, låtar...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrera från Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("mina vänner"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Hantera dina Joss Red-vänner direkt.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streamingkvalitet, normalisering, tystnad och batteri.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Återskapa ditt YouTube Music-ID om Discover-innehåll inte läses in.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Uppdatera ID (besökar-ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Misstag"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "En ny identifierare kunde inte genereras. Försök igen senare.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Uppdaterad identifierare",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Ett nytt besöks-ID har genererats.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Dela album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("Dela spellista"),
    "shareSong": MessageLookupByLibrary.simpleMessage("Dela låt"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Söker i Shazam-databasen efter matchningar...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Slumpmässigt"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("blanda svans"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singlar"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Hoppa över tystnad"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Tystnad hoppas över vid musikuppspelning",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Sovtimer inställd",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sovtimer"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Låten har lagts till i spellistan!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Låten finns redan!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Låten är redan offline i cachen",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage("Låt köad!"),
    "songFound": MessageLookupByLibrary.simpleMessage("Låten hittad!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Låtinformation"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Låten kan inte spelas på grund av serverbegränsningar!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("låtens ton"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Borttagen från"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Borttagen från kö!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Du kan inte ta bort den låt som spelas för närvarande",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Låtar"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Låtar importerade från Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sortera stigande/fallande",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sortera efter datum"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Sortera efter varaktighet",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sortera efter namn"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Hastighet och Pitch",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Starta radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Öppna vid start"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Välj avsnittet som Estrella Music öppnar först",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Stoppa musik när du stänger appen",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Musikuppspelningen stoppas när appen stängs från aktivitetshanteraren",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streamingkvalitet",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Kvalitet på streamad musik",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("följare"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Svep för att utforska alternativen ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Molnläge aktiverat. Laddar ner det befintliga biblioteket.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Molnläge aktiverat. Migrerade bibliotek.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Molnläge aktivt",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Molnläge aktivt. Väntar på synkronisering.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Det gick inte att ladda ned synkronisering.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Laddar ned EMusic-ändringar...",
    ),
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las spellistor, favoriter, historiskt, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca musikalisk remota?",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Cancelar sincronización y subir ESTA bas",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synkroniserat bibliotek.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Biblioteket uppdaterat.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Det finns nya lokala förändringar. De kommer att laddas upp före nedladdning.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Din data sparas endast på den här enheten.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Lokalt läge aktivt",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Off-line. Ändringar väntar.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Off-line. Ändringar sparade för ett nytt försök.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synkronisera spellistlåtar",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic bekräftade inte alla ändringar. De kommer att prövas igen.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Kunde inte resa sig. Det kommer att prövas igen senare.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Ändringarna har laddats upp korrekt.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Ändringar har laddats upp (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ladda upp med WS. Det kommer att prövas igen senare.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Laddar upp ändringar till EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synkad"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synkroniserad låttext är inte tillgänglig!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Systemstandard"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Tema"),
    "title": MessageLookupByLibrary.simpleMessage("Titel"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("Bästa musikvideor"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Populära musikvideor",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Trendar nu"),
    "unLink": MessageLookupByLibrary.simpleMessage("Avlänka"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Länken har tagits bort!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Namnlös låt"),
    "upNext": MessageLookupByLibrary.simpleMessage("Nästa"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Uppdatera applikation"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Upptäckt URL klicka på den för att öppna/spela upp det associerade innehållet",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Blockerad användare"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Svaret innehåller ingen lista över användare.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Olåst användare"),
    "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videoklipp"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Visa allt"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Visa Artist"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Vi har moderniserat vår plattform. Det gamla systemet för uppladdning av manuella säkerhetskopior har inaktiverats. Du har nu två tydliga sätt att hantera ditt musikbibliotek.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Välj hur du vill uppleva Estrella Music från och med nu.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Din musik, på ditt sätt",
    ),
  };
}
