// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nb locale. All the
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
  String get localeName => 'nb';

  static String m0(songTitle) => "Laster ned: ${songTitle}";

  static String m1(count) => "Album: ${count}";

  static String m2(count) => "Artister: ${count}";

  static String m3(count) => "Favoritter: ${count}";

  static String m4(count) => "Spillelister: ${count}";

  static String m5(count) => "Sanger: ${count}";

  static String m6(source) => "Migrering fullført fra ${source}.";

  static String m7(error) => "Det oppstod en feil under regenerering: ${error}";

  static String m8(title) => "Ligner på ${title}";

  static String m9(current) => "Trinn ${current} av 3";

  static String m10(count) => "${count} endringer begått.";

  static String m11(count) => "${count} synkroniserte endringer.";

  static String m12(statusCode) =>
      "Kunne ikke søke etter brukere (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Opprett ny spilleliste",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Rørlagt"),
    "about": MessageLookupByLibrary.simpleMessage("Om"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Legg til 5 minutter"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Legg til sanger i spillelisten",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Legg til i biblioteket",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Legg til spilleliste",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album lagt til i bokmerker!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Albumbokmerket er fjernet!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Album"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Etter din smak"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Alle felt er obligatoriske",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Ikke testet: Hvis du merker av i avmerkingsboksen etter at du har lastet ned mer enn 60 filer, kan det føre til at prosessen bruker mye minne og kan føre til at telefonen eller appen krasjer. Fortsett på egen risiko.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Søknadsinformasjon"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artist lagt til i bokmerker!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artistmarkør fjernet!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Beskrivelse ikke tilgjengelig!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Kunstnere"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("Etter din smak"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Lydkodek"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Autentiseringskode"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Skriv inn en gyldig 6-sifret kode eller logg på igjen.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Skriv inn den 6-sifrede koden fra autentiseringsappen din. Denne tilgangen utløper om 5 minutter.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "To-faktor autentisering",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Sjekk og fortsett",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Aksepterer bruker mis data...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Vi tok med pålogging, registrering og passordgjenoppretting fra forrige prosjekt, tilpasset denne musikkappen.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Økten din lever i sikker lagring og er validert med den samme backend du allerede brukte.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Env-filen må konfigureres for å koble til autentiseringsbackend.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Logg inn"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Register"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Send mail"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Bekreft passord",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Feil e-post eller passord.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Skriv inn en gyldig e-post.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Autentiseringsstøtten mangler for å konfigureres i .env-filen.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Kontoen din er ikke bekreftet ennå.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Det var ikke mulig å fullføre operasjonen.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Fornavn"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Jeg har glemt passordet mitt",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vi sender deg instruksjonene til e-postadressen for kontoen din.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("navn@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Etternavn"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Vellykket pålogget",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Det var ikke mulig å sende e-posten.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-post sendt.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Kontoen kunne ikke opprettes.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Konto opprettet.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Velkommen til Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Velkommen til Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Automatisk nedlasting av favorittsanger",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Last ned favorittsanger automatisk når de legges til favoritter",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Åpne spillerskjermen automatisk",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Aktiver/deaktiver automatisk åpning av spilleren til fullskjerm når du velger en sang som skal spilles",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Retur"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("databaser funnet"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Spiller musikk i bakgrunnen",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Aktiver/deaktiver avspilling av bakgrunnsmusikk (Appen kan nås fra systemstatusfeltet når appen kjører i bakgrunnen)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sikkerhetskopiering"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopier appdata",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopiering pågår...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopien er lagret!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopieringsinnstillinger og spillelister",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Lagre alle innstillinger, spillelister og påloggingsdata til en sikkerhetskopi",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Du trenger en aktiv økt...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Start appen på nytt",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Last opp sikkerhetskopi nå",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Ønsker du å ta sikkerhetskopi?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopien slettet.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Det er ingen sikkerhetskopier ennå...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopien gjenopprettet. Start appen på nytt.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Velg mappen for sikkerhetskopiering",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Velg hvilke data som skal sikkerhetskopieres",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Sikkerhetskopien er lastet opp på riktig måte.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Basert på siste interaksjon",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bithastighet"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Spilleliste svarteliste",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Vellykket tilbakestilling!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("av"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Lagre innholdsdata på startskjermen",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Aktiver lagring av innhold på startskjermen, startskjermen lastes umiddelbart hvis dette alternativet er aktivert",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Caching av sanger"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Å bufre sanger mens de spilles for fremtidig/frakoblet avspilling vil ta opp ekstra plass på enheten din",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Buffer/frakoblet"),
    "cancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Avbryt tidtaker"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Innsovningstimeren er avbrutt",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("Tøm bildebufferen"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Bildebufferen ble tømt",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klikk her for å tømme bufrede miniatyrbilder/bilder. (Anbefales ikke med mindre du vil oppdatere bufrede bildedata)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Lukke"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Lukk søknaden"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Fant nettskybibliotek.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Et skybibliotek ble funnet. Denne enheten vil laste den ned uten å overskrive den.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Skymodus er klar. Denne enheten vil fungere som en frakoblet hurtigbuffer.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Logg på sikkert med din Joss Red-konto.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Få tilgang til spillelister, favoritter og historikk fra alle enheter (Windows, Android, osv.) umiddelbart.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Arbeid offline og last opp endringer automatisk når du gjenoppretter internett.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktiver skysynkronisering",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sanntidssynkronisering med Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage("Skymodus (anbefalt)"),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Samarbeidsspilleliste",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Velg vennene som skal kunne se og redigere denne spillelisten:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Samarbeidspartnere har oppdatert riktig.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Fellesskapsspillelister",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Innhold"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL-lisens v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Opprett"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Opprett og legg til"),
    "customIns": MessageLookupByLibrary.simpleMessage("Egendefinert forekomst"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Velg en tilpasset forekomst",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Daglig oppdagelse"),
    "dark": MessageLookupByLibrary.simpleMessage("mørkt"),
    "delete": MessageLookupByLibrary.simpleMessage("Slett"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Fjern fra nedlastinger",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Fjernet fra nedlastinger!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Utviklet og vedlikeholdt av Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Deaktiver overgangsanimasjon",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktiver dette alternativet for å deaktivere faneovergangsanimasjonen",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Deaktivert"),
    "discover": MessageLookupByLibrary.simpleMessage("Oppdag"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Kast"),
    "done": MessageLookupByLibrary.simpleMessage("Ferdig"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Ikke vis denne informasjonen igjen",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "nedlastede filer funnet",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Last ned"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Last ned sanger fra albumet",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Den forespurte sangen kan ikke lastes ned på grunn av serverbegrensninger. Du kan prøve igjen",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Nedlasting mislyktes på grunn av nettverks-/overføringsfeil! Vennligst prøv igjen",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Last ned plassering",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Holder musikknedlastingene dine aktive i bakgrunnen.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "nedlasting av musikk",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Forbereder nedlastingene dine …",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Laster ned musikk",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Last ned spilleliste",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Last ned filformat",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Velg nedlastningsfilformatet. «Opus» vil gi den beste kvaliteten",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Nedlastinger"),
    "duration": MessageLookupByLibrary.simpleMessage("Varighet"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamisk"),
    "email": MessageLookupByLibrary.simpleMessage("E-post"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Tom spilleliste!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Nederste navigasjonslinje",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Bytt til nederste navigasjonslinje",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktiver glidebryterhandlinger",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktiver sveipehandlinger på sangflisen",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktivert"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Slutt på denne sangen",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Legg til albumsanger i køen",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Legg til alle i køen"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Legg til denne sangen i køen",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Legg til sanger i køen",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episoder"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Åpne systemequalizeren",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Det har oppstått en feil!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Det oppstod en feil",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Feil under avspilling:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Eksporter"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Eksporter nedlastede filer",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klikk her for å eksportere de nedlastede filene fra applikasjonskatalogen til den eksterne katalogen",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Feil ved eksport av spilleliste",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Feil ved formatering av spillelistedata",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Tillatelse nektet ved eksport",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Utilstrekkelig lagringsplass",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage("Filer ble eksportert"),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Eksporter spilleliste",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Eksporter spilleliste som CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kan ikke importere her",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Eksporter spilleliste til JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Dette formatet kan importeres",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "Eksporter til Online-musikk",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Den vil presse spillelisten din (sanger < 50) til gjeldende kø, ikke glem å legge den til spillelisten/lagre etter å ha åpnet den i MusicService",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Eksporter plasseringen av nedlastede filer",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Eksporterer..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Eksporterer spilleliste ...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoritter"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Utvalgte spillelister",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Filen ble ikke funnet",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Fortsette"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("fulgte"),
    "following": MessageLookupByLibrary.simpleMessage("Følgende"),
    "for1": MessageLookupByLibrary.simpleMessage("for"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "glemte favoritter",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Venn"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Venneforespørsel godtatt",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Venneforespørsel sendt",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Venner"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Logg på for å finne venner.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Vennskap fjernet",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Feil"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronikk"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Stein"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gest"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Se GitHub-kildekoden \nHvis du liker dette prosjektet, ikke glem å gi det en ⭐!",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Gå til album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Klikk her for å gå til nedlastingssiden",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hei verden"),
    "high": MessageLookupByLibrary.simpleMessage("Høy"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API-URL til Piped-forekomst",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Hjem"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Antall oppstartsinnhold",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Velg antall startskjerminnhold (ca.). Færre resultater lastes raskere",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorer batterioptimalisering",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Hvis du har problemer med varsler eller avspillingsstopp på grunn av systemoptimalisering, aktiver dette alternativet",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Feil ved import av spilleliste",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Feil ved lagring i database",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Den valgte filen fikk ikke tilgang",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Ugyldig filformat",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Merk: Store spillelister kan ta lengre tid å importere",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importer spilleliste",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Velg en tidligere eksportert spilleliste-JSON-fil som skal importeres",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importert"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importert fra Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importert spilleliste",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importerer spilleliste ...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Intern lagringskatalog",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Inkluder nedlastede sangfiler",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informasjon ikke tilgjengelig",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Ugyldig spillelistefilstruktur",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Ugyldig serversvar.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Økten inneholder ikke et gyldig token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elementer"),
    "keepListening": MessageLookupByLibrary.simpleMessage("fortsett å lytte"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Hold skjermen på mens du spiller",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Hvis aktivert, vil enhetens skjerm forbli våken mens musikk spilles",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Språk"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Still inn appspråket"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Siste utgivelse"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Siste versjon tilgjengelig",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("La oss begynne.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Bibliotekalbum"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Bibliotekartister"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Bibliotekspillelister",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Bibliotekets sanger"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotek"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Bibliotek spilleliste",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Klart det"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Tilknyttet vellykket!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Linken er kopiert til utklippstavlen",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Koble til Piped for spillelister",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Hør nå"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Å lytte til miljøet...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Kunne ikke laste inn oppdateringsinformasjon",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokalt"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Det fungerer uten at du trenger å logge inn.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Hele biblioteket ditt forblir strengt tatt på denne datamaskinen.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Merk: Ingen manuell sikkerhetskopiering av skyen. Hvis du mister enheten eller avinstallerer appen, kan ikke dataene dine gjenopprettes.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Bruk kun på denne enheten",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolutt personvern på enheten din",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Lokal modus"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LydstyrkeDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisering av lydstyrken",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Angir samme lydstyrkenivå for alle sanger (eksperimentelt) (fungerer ikke på sanger lastet ned i eldre versjoner (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Lavt"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Bokstaver"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Teksten er ikke tilgjengelig!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Administrer samarbeidspartnere (venner)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Sørg for at musikken spilles høyt nok i nærheten av mikrofonen.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migrert album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Migrert bibliotek",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrert spilleliste",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Det pågår allerede en migrering.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyserer det lokale biblioteket...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Sjekker om EMusic Cloud allerede har et bibliotek...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migrering fullført.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Oppretter en lokal sikkerhetskopi før du kobler til skyen...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migreringen mislyktes. Dine lokale data ble ikke endret.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Logg på Joss Red før du migrerer.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Forbereder migreringen i EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kunne ikke starte migreringen.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Ikke alle data kunne lastes opp. Vi beholder din lokale støtte.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Laster opp spillelister, favoritter og historie...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud kunne ikke validere migreringen.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verifiserer integritet i EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Velg fil og importer",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Velg song.db eller en backup .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migreringen er fullført.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutter"),
    "misc": MessageLookupByLibrary.simpleMessage("Ulike"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Den mest lyttede sangen",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musikk og avspilling",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Musikkgjenkjenning",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Nettverksfeil! Sjekk Internett-tilkoblingen din.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Beklager, nettverksfeil!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Ny versjon tilgjengelig!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red-appen (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Forstått"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100 % synkronisering med Joss Red, spillelister med venner og mye mer. Trykk for å se hva som er nytt.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music har utviklet seg!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "For å legge til venner, godta forespørsler eller administrere sikkerhetsprofilen din, vennligst bruk Joss Red på dens offisielle plattformer:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Venner og kontoadministrasjon:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Lag spillelister med vennene dine! Når du oppretter en spilleliste, merker du av for Collaborative og velger vennene dine å redigere sammen.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Samarbeidende spillelister",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Spillelistene og favorittene dine lagres og synkroniseres automatisk i skyen med Joss Red-hovedkontoen din.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Full integrasjon med Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Du trenger ikke lenger å klikke på knapper for manuell synkronisering; Den nye motoren er ansvarlig for å skifte opp og ned automatisk.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparent synkronisering",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Nei"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Ingen bokmerker!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Du har ingen lagt til venner på Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Du har ingen spillelister i biblioteket ditt!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Kunne ikke finne noen sanger i den innspilte lyden",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Ingen treff"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Ingen offline sanger!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Det er ingen sanger i denne samlingen",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("Fant ingen treff for"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Ikke autentisert",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Det er ikke en sang/musikkvideo!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Dette er ikke en gyldig lenke!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Åpne inn"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Mislykket operasjon",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Passord"),
    "password_text": MessageLookupByLibrary.simpleMessage("Passord"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Tillatelse nektet",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Tillate"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music trenger disse tillatelsene for å administrere musikken din og tilby alle avspillingsfunksjoner.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Tillatelser til å komme i gang",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Gi nødvendige tillatelser",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Den brukes bare når du velger å identifisere en sang som spilles rundt deg.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Viser avspillingskontroller, nedlastingsfremgang og viktige appmeldinger.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Varsler",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Innstillinger",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Alle tre tillatelsene kreves for å fortsette. Du kan endre dem senere i systeminnstillingene.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Den lar deg spille musikk, lagre nedlastinger, eksportere spillelister og forberede oppdateringer.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musikk og lagring",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisering"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Pipet spilleliste",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Pipet spilleliste synkronisert!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("enkelt"),
    "play": MessageLookupByLibrary.simpleMessage("Spill"),
    "playNext": MessageLookupByLibrary.simpleMessage("Spill neste"),
    "playNow": MessageLookupByLibrary.simpleMessage("Spill nå"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Avspillingshastighet",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Spillergrensesnitt"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Velg spillerens brukergrensesnitt",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Spiller:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SPILLER FRA ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SPILLER FRA ARTIST",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "SPILLER FRA SPILLELISTE",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "SPILLER FRA UTVALG",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Spilleliste"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Svartelistet spilleliste!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Spilleliste lagt til bokmerker!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Spillelistebokmerket er fjernet!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Spillelistebidragsytere",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Spilleliste opprettet!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Spilleliste opprettet og sang lagt til!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Spillelisten ble eksportert til",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Spillelisten ble importert",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Spilleliste slettet!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Vellykket rebranding!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Spillelister"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Kommer snart"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcaster"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Populære låter"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Behandler filer..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Behandler lyden...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiler"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("haleløkke"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Køløkkemodus kan ikke deaktiveres når tilfeldig rekkefølge er aktivert.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Haleslyngemodus kan ikke aktiveres i radiomodus.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Tilfeldig modus er aktivert. Du kan ikke blande køen manuelt.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Køen kan ikke omorganiseres når tilfeldig rekkefølge er på",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Rask valg"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Raske valg"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio ikke tilgjengelig for denne artisten!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Tilfeldig radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Tilfeldig utvalg"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Omorganiser spillelisten",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Omorganisere sanger",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Les mer"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Nylige søk"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Nylig spilt"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Vi anbefaler å aktivere skymodus for en Spotify-lignende opplevelse: sanntidssynkronisering mellom alle enhetene dine og automatisk sikkerhetskopiering uten at du trenger å gjøre noe.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Anbefalt"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Anbefalt"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Fjern fra bufferen",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Fjern sanger fra biblioteket",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Slett fra biblioteket",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Fjern fra spilleliste",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Fjern fra køen"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Slett flere sanger",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Slett spilleliste"),
    "rename": MessageLookupByLibrary.simpleMessage("Gi nytt navn"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Gi nytt navn til spilleliste",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Gjengitt av"),
    "reset": MessageLookupByLibrary.simpleMessage("Tilbakestill"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Gjenopprett standardinnstillinger",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Tilbakestill appinnstillingene til standard (krever omstart)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Tilbakestilling av innstillinger til standard er fullført. Start appen på nytt",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Tilbakestill svartelistede spillelister",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Tilbakestill alle svartelistede Piped-spillelister",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Start programmet på nytt",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Gjenopprett"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Gjenopprett appdata",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Gjenopprett siste avspillingsøkt",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Gjenopprett automatisk siste avspillingsøkt når du starter appen",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Vellykket gjenopprettet!\nEndringer tas i bruk ved omstart",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Gjenopprett innstillinger og spillelister",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Gjenoppretter alle innstillinger, påloggingsdata og spillelister fra en sikkerhetskopi. Overskriver alle gjeldende data",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Velg sikkerhetskopifilen",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Gjenoppretter ..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultater"),
    "retry": MessageLookupByLibrary.simpleMessage("Prøv på nytt!"),
    "save": MessageLookupByLibrary.simpleMessage("Beholde"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Lagret"),
    "scanning": MessageLookupByLibrary.simpleMessage("Skanner..."),
    "search": MessageLookupByLibrary.simpleMessage("Søk"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Sanger, spillelister, album eller artister",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Søk i biblioteket",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Søkeresultater"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage("Nylige søk"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Velg alle"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Velg autentiseringsforekomst",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Vennligst velg autentiseringsforekomsten!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Velg Fil"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Velg sanger"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Den valgte filen ble ikke funnet.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Økten din er utløpt. Logg på igjen.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Angi oppdagelsesinnhold",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Innstillinger"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Om Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versjon, åpen kildekode-prosjekt og GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Konto og synkronisering",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Skymodus, sikkerhetskopier, venneliste og migreringer.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Tema-, språk- og grensesnittanimasjoner.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloud backup",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Last opp, gjenopprett og administrer...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Last opp en .hmb-sikkerhetskopi av appen til serveren, og gjenopprett om nødvendig noen av de lagrede sikkerhetskopiene.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Oppdag filtre, integrasjon med Piped og cacher.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Nedlastinger og lagring",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Lydformater, mapper og automatiske nedlastinger.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("General"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Velg, migrér eller se gjennom synkroniseringsstatusen med Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Lokal modus / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Logg ut"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importer spillelister, sanger...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrer fra Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("vennene mine"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Administrer Joss Red-vennene dine direkte.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Strømmekvalitet, normalisering, stillhet og batteri.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Regenerer Online Music-ID-en din hvis Discover-innhold ikke lastes inn.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Oppdater ID (besøks-ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Feil"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "En ny identifikator kunne ikke genereres. Prøv igjen senere.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Oppdatert identifikator",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "En ny besøks-ID ble generert.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Del album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("Del spilleliste"),
    "shareSong": MessageLookupByLibrary.simpleMessage("Del denne sangen"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Søker i Shazam-databasen etter treff...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Tilfeldig"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("bland halen"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Enkelt"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Hopp over stillheten"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Stillhet vil bli hoppet over når du spiller musikk",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Innsovningstimeren er stilt inn",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sleep timer"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Sang lagt til spilleliste!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Sangen eksisterer allerede!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Sangen ligger allerede i cachen",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Sang lagt til i køen!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Sangen funnet!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Sanginformasjon"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Sangen kan ikke spilles på grunn av serverbegrensninger!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("sang tone"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("fjernet fra"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Fjernet fra køen!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Du kan ikke slette sangen som spilles for øyeblikket",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Sanger"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Sanger importert fra Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sorter stigende/synkende",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sorter etter dato"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Sorter etter varighet",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sorter etter navn"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Hastighet og tonehøyde",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Start radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Åpne ved oppstart"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Velg delen som Estrella Music åpner først",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Stopp musikk når du lukker appen",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Musikkavspillingen stopper når appen lukkes fra oppgavebehandlingen",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streaming kvalitet",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Musikk streaming kvalitet",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("abonnenter"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Sveip for å utforske alternativer ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Skymodus aktivert. Laster ned det eksisterende biblioteket.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Skymodus aktivert. Migrert bibliotek.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Skymodus aktiv",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Skymodus aktiv. Venter på synkronisering.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Kunne ikke laste ned synkronisering.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Laster ned EMusic-endringer...",
    ),
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Replacer og subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, spillelister, favoritter, historikk, albumer, artister og rettferdige musikaler fra EMusic Cloud er reemplazarán med de faktiske dataene de siste dispositivene. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca musical remote?",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musikalsk remota con los data actuales de este dispositivo. Last ned permanecen lokaler.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Avbryt sincronización y subir esta base",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synkronisert bibliotek.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Bibliotek oppdatert.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Det er nye lokale endringer. De vil bli lastet opp før nedlasting.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Dataene dine lagres kun på denne enheten.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Lokal modus aktiv",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Frakoblet. Endringer venter.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Frakoblet. Endringer lagret for nytt forsøk.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synkroniser spillelistesanger",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic bekreftet ikke alle endringene. De vil bli forsøkt på nytt.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Klarte ikke reise seg. Det vil bli forsøkt på nytt senere.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Endringer lastet opp riktig.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Endringer ble lastet opp (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Kunne ikke laste opp med WS. Det vil bli forsøkt på nytt senere.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Laster opp endringer til EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synkronisert"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synkroniserte tekster er ikke tilgjengelige!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Systemstandard"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Temamodus"),
    "title": MessageLookupByLibrary.simpleMessage("Tittel"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("Topp musikkvideoer"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Beste musikkvideoer",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Trender"),
    "unLink": MessageLookupByLibrary.simpleMessage("Fjern tilknytningen"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("Koblet fra!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Unavngitt sang"),
    "upNext": MessageLookupByLibrary.simpleMessage("Neste"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Oppdater applikasjon"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Oppdaget URL klikk på den for å åpne/spille av det tilknyttede innholdet",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Blokkert bruker"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Svaret inneholder ikke en liste over brukere.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Ulåst bruker"),
    "username": MessageLookupByLibrary.simpleMessage("Brukernavn"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videoer"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Se alle"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Se artist"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Vi har modernisert plattformen vår. Det gamle systemet for opplasting av manuelle sikkerhetskopier er deaktivert. Du har nå to klare måter å administrere musikkbiblioteket på.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Velg hvordan du vil oppleve Estrella Music fra nå av.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Musikken din, din måte",
    ),
  };
}
