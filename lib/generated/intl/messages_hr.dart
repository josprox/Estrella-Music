// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
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
  String get localeName => 'hr';

  static String m0(songTitle) => "Preuzimanje: ${songTitle}";

  static String m1(count) => "Albumi: ${count}";

  static String m2(count) => "Umjetnici: ${count}";

  static String m3(count) => "Omiljeni: ${count}";

  static String m4(count) => "Popisi za reprodukciju: ${count}";

  static String m5(count) => "Pjesme: ${count}";

  static String m6(source) => "Migracija dovršena od ${source}.";

  static String m7(error) =>
      "Došlo je do pogreške prilikom regeneracije: ${error}";

  static String m8(title) => "Slično ${title}";

  static String m9(current) => "Korak ${current} od 3";

  static String m10(count) => "${count} izvršenih promjena.";

  static String m11(count) => "${count} sinkronizirane promjene.";

  static String m12(statusCode) =>
      "Nije moguće tražiti korisnike (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Napravi novu playlistu",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Cijevi"),
    "about": MessageLookupByLibrary.simpleMessage("O"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Dodajte 5 minuta"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Dodajte pjesme na popis za reprodukciju",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Dodaj u knjižnicu"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Dodaj na popis za reprodukciju",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album dodan u oznake!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Oznaka albuma uklonjena!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albumi"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Prema vašem ukusu"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Sva polja su obavezna",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Nije testirano: odabir potvrdnog okvira nakon preuzimanja više od 60 datoteka može uzrokovati da proces zauzme veliku količinu memorije i može uzrokovati rušenje telefona ili aplikacije. Nastavite na vlastitu odgovornost.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Informacije o aplikaciji"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Izvođač dodan u oznake!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Oznaka izvođača uklonjena!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Opis nije dostupan!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Izvođač"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("Prema vašem ukusu"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audio kodek"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Autentifikacijski kod",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Unesite važeći 6-znamenkasti kod ili se ponovno prijavite.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Unesite 6-znamenkasti kod iz aplikacije za autentifikaciju. Ovaj pristup istječe za 5 minuta.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Dvofaktorska autentifikacija",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Provjerite i nastavite",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Slažem se s korištenjem mojih podataka...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Donijeli smo login, registraciju i oporavak lozinke iz prethodnog projekta, prilagođenog ovoj glazbenoj aplikaciji.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Vaša sesija živi u sigurnoj pohrani i potvrđena je istom pozadinom koju ste već koristili.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Datoteka .env mora biti konfigurirana za povezivanje pozadine za provjeru autentičnosti.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Prijavite se"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage(
      "Registrirajte se",
    ),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Pošalji mail"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Potvrdite lozinku",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Netočna adresa e-pošte ili lozinka.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Unesite valjanu e-poštu.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Nedostaje pozadina provjere autentičnosti za konfiguraciju u .env datoteci.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Vaš račun još nije potvrđen.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Operaciju nije bilo moguće dovršiti.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Ime"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Zaboravio sam lozinku",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Poslat ćemo vam upute na e-mail vašeg računa.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("ime@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Prezime"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Uspješno prijavljen",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Nije bilo moguće poslati e-poštu.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Email poslan.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Račun nije moguće izraditi.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Račun je uspješno kreiran.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Dobrodošli u Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Dobrodošli u Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Automatsko preuzimanje omiljenih pjesama",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Automatski preuzimajte omiljene pjesme kada ih dodate u favorite",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Automatski otvori zaslon playera",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Aktivirajte/deaktivirajte automatsko otvaranje playera na cijelom ekranu prilikom odabira pjesme za reprodukciju",
    ),
    "back": MessageLookupByLibrary.simpleMessage("natrag"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "pronađene baze podataka",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Svira glazbu u pozadini",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Omogući/onemogući reprodukciju pozadinske glazbe (aplikaciji se može pristupiti iz programske trake kada aplikacija radi u pozadini)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sigurnosna kopija"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija podataka aplikacije",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Sigurnosno kopiranje u tijeku...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija je uspješno spremljena!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Sigurnosne kopije postavki i popisa za reprodukciju",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Spremite sve postavke, popise pjesama i podatke za prijavu u datoteku sigurnosne kopije",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Trebate aktivnu sesiju...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Ponovno pokrenite aplikaciju",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Prenesi sigurnosnu kopiju sada",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Želite li napraviti sigurnosnu kopiju?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija izbrisana.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Još nema sigurnosnih kopija...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija vraćena. Ponovno pokrenite aplikaciju.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Odaberite mapu za sigurnosno kopiranje",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Odaberite koje podatke želite sigurnosno kopirati",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija je ispravno učitana.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Na temelju posljednje interakcije",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bit rate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Crna lista za reprodukciju",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Uspješno resetirano!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("po"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Pohranjujte podatke o sadržaju početnog zaslona",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Omogućite pohranjivanje podataka sadržaja početnog zaslona, početni zaslon će se odmah učitati ako je ova opcija omogućena",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Spremanje pjesama u predmemoriju",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Spremanje pjesama u predmemoriju dok se reproduciraju za buduću/izvanmrežnu reprodukciju zauzet će dodatni prostor na vašem uređaju",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Predmemorija/izvan mreže",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Odustani"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Otkaži mjerač vremena",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Mjerač vremena za isključivanje otkazan",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Očisti predmemoriju slika",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Predmemorija slika uspješno je izbrisana",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Kliknite ovdje da biste izbrisali predmemorirane sličice/slike. (Ne preporučuje se osim ako ne želite ažurirati predmemorirane slikovne podatke)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Zatvori"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Zatvori aplikaciju"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Pronađena biblioteka u oblaku.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Pronađena je biblioteka u oblaku. Ovaj uređaj će ga preuzeti bez prepisivanja.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku je spreman. Ovaj uređaj će raditi kao izvanmrežna predmemorija.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Prijavite se na siguran način koristeći svoj Joss Red račun.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Trenutačno pristupite svojim popisima za reprodukciju, favoritima i povijesti s bilo kojeg uređaja (Windows, Android itd.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Pametna sinkronizacija: Radite izvan mreže i automatski učitajte promjene kada obnovite internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage("Aktivirajte Cloud sync"),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sinkronizacija u stvarnom vremenu s Joss Redom",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku (preporučeno)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Kolaborativni popis za reprodukciju",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Odaberite prijatelje koji će moći vidjeti i uređivati ovaj popis za reprodukciju:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Suradnici su ispravno ažurirani.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Popisi za reprodukciju zajednice",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Sadržaj"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL licenca v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Stvorite"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Kreirajte i dodajte"),
    "customIns": MessageLookupByLibrary.simpleMessage("Prilagođena instanca"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Odaberite prilagođenu instancu",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Svakodnevno otkriće",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("mračno"),
    "delete": MessageLookupByLibrary.simpleMessage("Izbriši"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Ukloni iz preuzimanja",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Uspješno uklonjeno iz preuzimanja!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Razvio i održava Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Onemogući animaciju prijelaza",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktivirajte ovu opciju da biste onemogućili animaciju prijelaza kartice",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Onesposobljeno"),
    "discover": MessageLookupByLibrary.simpleMessage("Otkrij"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Odbaciti"),
    "done": MessageLookupByLibrary.simpleMessage("spreman"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Ne prikazuj više ove informacije",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "pronađenih preuzetih datoteka",
    ),
    "download": MessageLookupByLibrary.simpleMessage("preuzimanje"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Preuzmite pjesme s albuma",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Zatražena pjesma ne može se preuzeti zbog ograničenja poslužitelja. Možete pokušati ponovo",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje nije uspjelo zbog pogreške mreže/prijenosa! Molimo pokušajte ponovo",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Lokacija preuzimanja",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Održava preuzimanje glazbe aktivnim u pozadini.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "preuzimanja glazbe",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Priprema preuzimanja…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje glazbe",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Preuzmite popis za reprodukciju",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Preuzmite format datoteke",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Odaberite format datoteke za preuzimanje. Opus će pružiti najbolju kvalitetu",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Preuzimanja"),
    "duration": MessageLookupByLibrary.simpleMessage("Trajanje"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamično"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Playlista je prazna!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Donja navigacijska traka",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Prebacite se na donju navigacijsku traku",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktivirajte radnje klizača",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktivirajte radnje prijelaza na pločici pjesme",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Aktiviran"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Kraj ove pjesme"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Dodajte pjesme albuma u red čekanja",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Dodaj sve u red čekanja",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Dodaj ovu pjesmu u red čekanja",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Dodajte pjesme u red čekanja",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Epizode"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ekvilajzer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Otvorite ekvilizator sustava",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Došlo je do pogreške!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Došlo je do pogreške",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Greška prilikom igranja:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Izvoz"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Izvoz preuzetih datoteka",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Kliknite ovdje za izvoz preuzetih datoteka iz direktorija aplikacije u vanjski direktorij",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Pogreška pri izvozu popisa za reprodukciju",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Pogreška pri formatiranju podataka popisa za reprodukciju",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Dopuštenje je odbijeno prilikom izvoza",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Nedovoljno prostora za pohranu",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Datoteke su uspješno izvezene",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Izvoz popisa za reprodukciju",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Izvezi popis za reprodukciju kao CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ovdje se ne može uvesti",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Izvezi popis za reprodukciju u JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ovaj format se može uvesti",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Izvoz u Youtube glazbu",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vaš popis za reprodukciju (pjesme < 50) gurnut će u trenutni red čekanja, ne zaboravite ga dodati na popis za reprodukciju/spremiti nakon otvaranja u YtMusicu",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Izvoz lokacije preuzetih datoteka",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Izvoz..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Izvoz popisa za reprodukciju...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoriti"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Istaknuti popisi za reprodukciju",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Datoteka nije pronađena",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Slijedite"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("pratio"),
    "following": MessageLookupByLibrary.simpleMessage("Praćenje"),
    "for1": MessageLookupByLibrary.simpleMessage("za"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "zaboravljeni favoriti",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Prijatelj"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Zahtjev za prijateljstvo prihvaćen",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Zahtjev za prijateljstvo poslan",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Prijatelji"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Prijavite se da pronađete prijatelje.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Prijateljstvo uklonjeno",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Greška"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronika"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latinski"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesta"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Pogledajte GitHub izvorni kod \nAko vam se sviđa ovaj projekt, ne zaboravite mu dati ⭐!",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Idi na album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Kliknite ovdje za odlazak na stranicu za preuzimanje",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Pozdrav svijete"),
    "high": MessageLookupByLibrary.simpleMessage("visoko"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL za Piped instancu",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Početna"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Broj sadržaja pri pokretanju",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Odaberite broj početnih sadržaja početnog zaslona (približno). Manji broj rezultata učitava se brže",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Zanemari optimizaciju baterije",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Ako imate problema s obavijestima ili prekidima reprodukcije zbog optimizacije sustava, aktivirajte ovu opciju",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Pogreška pri uvozu popisa za reprodukciju",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Pogreška pri spremanju u bazu podataka",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Nije moguće pristupiti odabranoj datoteci",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Nevažeći format datoteke",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Napomena: uvoz velikih popisa za reprodukciju može potrajati dulje",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Uvezi popis za reprodukciju",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Odaberite prethodno izvezenu JSON datoteku popisa za reprodukciju za uvoz",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Uvezeno"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Uvezeno iz Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Uvezeni popis za reprodukciju",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Uvoz popisa za reprodukciju...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Direktorij interne pohrane",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Uključi preuzete datoteke pjesama",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informacije nisu dostupne",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Nevažeća struktura datoteke popisa za reprodukciju",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Nevažeći odgovor poslužitelja.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Sesija ne sadrži važeći token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("elementi"),
    "keepListening": MessageLookupByLibrary.simpleMessage("nastavi slušati"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Ostavi zaslon uključen tijekom reprodukcije",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Ako je omogućeno, zaslon uređaja ostat će uključen tijekom reprodukcije glazbe",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Jezik"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Postavite jezik aplikacije",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Najnovije izdanje"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Najnovija dostupna verzija",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Počnimo.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Albumi biblioteke"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Biblioteka izvođača"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("Prijevod"),
    "libSongs": MessageLookupByLibrary.simpleMessage("Biblioteka pjesama"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteka"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju knjižnice",
    ),
    "light": MessageLookupByLibrary.simpleMessage("naravno"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Uspješno povezano!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Veza je kopirana u međuspremnik",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Povežite se s Pipedom za popise za reprodukciju",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Slušaj sada"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Osluškujući okolinu...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Nije moguće učitati ažurirane informacije",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokalni"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Radi bez potrebe za prijavom.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Vaša cijela biblioteka ostaje isključivo na ovom računalu.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Napomena: nema ručnih sigurnosnih kopija u oblaku. Ako izgubite uređaj ili deinstalirate aplikaciju, vaši se podaci ne mogu vratiti.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Koristite samo na ovom uređaju",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Apsolutna privatnost na vašem uređaju",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Lokalni način rada"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("GlasnoćaDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalizacija glasnoće",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Postavlja istu razinu glasnoće za sve pjesme (Eksperimentalno) (Neće raditi na pjesmama preuzetim u starijim verzijama (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Niska"),
    "lyrics": MessageLookupByLibrary.simpleMessage("pisma"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Stihovi nisu dostupni!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Upravljanje suradnicima (prijateljima)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Provjerite svira li glazba dovoljno glasno u blizini vašeg mikrofona.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Preseljeni album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Preseljena biblioteka",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrirani popis za reprodukciju",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Migracija je već u tijeku.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analiziram lokalnu knjižnicu...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Provjera ima li EMusic Cloud već knjižnicu...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migracija dovršena.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Stvaranje lokalne sigurnosne kopije prije povezivanja s oblakom...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migracija nije uspjela. Vaši lokalni podaci nisu izmijenjeni.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Prijavite se na Joss Red prije migracije.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Priprema migracije u EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nije mogao pokrenuti migraciju.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Ne mogu se učitati svi podaci. Zadržavamo vašu lokalnu podršku.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Prijenos popisa za reprodukciju, favorita i povijesti...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud nije mogao potvrditi migraciju.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Provjera integriteta u EMusic Cloudu...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Odaberite datoteku i uvezite",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Odaberite song.db ili sigurnosnu kopiju .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migracija je uspješno dovršena.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minuta"),
    "misc": MessageLookupByLibrary.simpleMessage("Razni"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Najslušanija pjesma",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Glazba i reprodukcija",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Prepoznavanje glazbe",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Greška na mreži! Provjerite internetsku vezu.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("Greška mreže!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nova verzija dostupna!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplikacija Joss Red (Trgovina Play)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Razumijem"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% sinkronizacija s Joss Redom, playliste s prijateljima i još mnogo toga. Dodirnite da vidite što je novo.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Glazba je evoluirala!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Za dodavanje prijatelja, prihvaćanje zahtjeva ili upravljanje svojim sigurnosnim profilom, koristite Joss Red na njegovim službenim platformama:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Prijatelji i upravljanje računom:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Glazbene vijesti",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Stvorite popise za reprodukciju sa svojim prijateljima! Prilikom izrade popisa za reprodukciju označite potvrdni okvir Suradnja i odaberite prijatelje koje ćete zajedno uređivati.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Kolaborativni popisi za reprodukciju",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Vaši popisi pjesama i favoriti sada se automatski spremaju i sinkroniziraju u oblaku s vašim glavnim Joss Red računom.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Potpuna integracija s Joss Redom",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Više ne morate klikati gumbe za ručnu sinkronizaciju; Novi motor je odgovoran za automatsko mijenjanje brzina gore i dolje.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparentna sinkronizacija",
    ),
    "no": MessageLookupByLibrary.simpleMessage("br"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Nema oznaka!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Nemate dodanih prijatelja na Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Nemate nijedan popis za reprodukciju u svojoj knjižnici!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Nije moguće pronaći nijednu pjesmu u snimljenom zvuku",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Nema podudaranja"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Nema offline pjesama!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "U ovoj zbirci nema nijedne pjesme",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Nije pronađeno nijedno podudaranje za",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Nije ovjereno"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "To nije pjesma/spot!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Ovo nije važeća poveznica!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Otvori u"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Neuspješna operacija",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Lozinka"),
    "password_text": MessageLookupByLibrary.simpleMessage("Lozinka"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Dopuštenje odbijeno",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Dopusti"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music treba ove dozvole za upravljanje vašom glazbom i pružanje svih značajki reprodukcije.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Dopuštenja za početak",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Dodijeli potrebna dopuštenja",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Koristi se samo kada odlučite identificirati pjesmu koja svira oko vas.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Prikazuje kontrole reprodukcije, napredak preuzimanja i važne obavijesti o aplikaciji.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Obavijesti",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("postavke"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Za nastavak su potrebne sve tri dozvole. Kasnije ih možete promijeniti u postavkama sustava.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Omogućuje vam reprodukciju glazbe, spremanje preuzimanja, izvoz popisa za reprodukciju i pripremu ažuriranja.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Glazba i pohrana",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalizacija"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Usmjereni popis za reprodukciju",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Usmjereni popis za reprodukciju sinkroniziran!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("jednostavan"),
    "play": MessageLookupByLibrary.simpleMessage("igrati"),
    "playNext": MessageLookupByLibrary.simpleMessage("Igraj sljedeći"),
    "playNow": MessageLookupByLibrary.simpleMessage("Igrajte sada"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Brzina reprodukcije",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage(
      "Korisničko sučelje igrača",
    ),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Odaberite korisničko sučelje playera",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Igranje:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SVIRANJE IZ ALBUMA",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "SVIRANJE OD UMJETNIKA",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "REPRODUCIRANJE S PLAYLISTA",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "IGRA IZ SELEKCIJE",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Popis pjesama"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju na crnoj listi!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju dodan u oznake!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Oznaka popisa za reprodukciju uklonjena!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Suradnici popisa za reprodukciju",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju stvoren!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju stvoren i pjesma dodana!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju uspješno je izvezen u",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Popis za reprodukciju je uspješno uvezen",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist izbrisan!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Uspješno rebrendirano!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Playlista"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Dolazi uskoro"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasti"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Popularne pjesme"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Obrada datoteka..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage("Obrada zvuka..."),
    "profiles": MessageLookupByLibrary.simpleMessage("Profili"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("repna petlja"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Način rada petlje čekanja ne može se onemogućiti kada je omogućen način nasumične reprodukcije.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Način repne petlje ne može se aktivirati u radijskom načinu rada.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Aktiviran je slučajni način rada. Ne možete ručno miješati red čekanja.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Redoslijed se ne može promijeniti kada je uključen način nasumične reprodukcije",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Brzi odabir"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Brzi odabiri"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio nije dostupan za ovog izvođača!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Slučajni radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Slučajni odabir"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Promjena rasporeda popisa za reprodukciju",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Promjena redoslijeda pjesama",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Pročitaj više"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Nedavne pretrage"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Nedavno pušteno"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Preporučujemo da aktivirate način rada u oblaku za iskustvo slično Spotifyju: sinkronizacija u stvarnom vremenu između svih vaših uređaja i automatsko sigurnosno kopiranje bez potrebe da bilo što radite.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Preporučeno"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Preporučeno"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Ukloni iz predmemorije",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Ukloni iz knjižnice pjesama",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Izbriši iz knjižnice",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ukloni s popisa za reprodukciju",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Ukloni iz reda čekanja",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Izbrišite više pjesama",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Ukloni playlistu"),
    "rename": MessageLookupByLibrary.simpleMessage("Preimenuj"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Preimenuj popis za reprodukciju",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproducirao"),
    "reset": MessageLookupByLibrary.simpleMessage("Resetiraj"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Vratite zadane postavke",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Vraćanje postavki aplikacije na zadane (zahtijeva ponovno pokretanje)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Vraćanje postavki na zadane je završeno, ponovno pokrenite aplikaciju",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Poništi popise za reprodukciju na crnoj listi",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Poništi sve crne popise za reprodukciju",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Ponovno pokrenite aplikaciju",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Vratiti"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Vrati podatke aplikacije",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Vratite posljednju sesiju reprodukcije",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Automatski vrati posljednju sesiju reprodukcije prilikom pokretanja aplikacije",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Uspješno obnovljeno!\nPromjene se primjenjuju nakon ponovnog pokretanja",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Vratite postavke i popise za reprodukciju",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Vraća sve postavke, podatke za prijavu i popise za reprodukciju iz datoteke sigurnosne kopije. Prepisuje sve trenutne podatke",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Odaberite datoteku sigurnosne kopije",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Vraćanje..."),
    "results": MessageLookupByLibrary.simpleMessage("Rezultati"),
    "retry": MessageLookupByLibrary.simpleMessage("Pokušaj ponovno!"),
    "save": MessageLookupByLibrary.simpleMessage("spremiti"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Spremljeno"),
    "scanning": MessageLookupByLibrary.simpleMessage("Skeniranje..."),
    "search": MessageLookupByLibrary.simpleMessage("Traži"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Pjesme, popisi za reprodukciju, albumi ili izvođači",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Traži u knjižnici",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage(
      "Rezultati pretraživanja",
    ),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Nedavne pretrage",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Odaberi sve"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Odaberite instancu provjere autentičnosti",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Odaberite instancu provjere autentičnosti!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Odaberite Datoteka"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Odaberi pjesme"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Odabrana datoteka nije pronađena.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Vaša sesija je istekla. Prijavite se ponovno.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Postavite sadržaj otkrivanja",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Postavke"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "O Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Verzija, projekt otvorenog koda i GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Račun i sinkronizacija",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku, sigurnosne kopije, popis prijatelja i migracije.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Tema, jezik i animacije sučelja.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Sigurnosna kopija u oblaku",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Prenesite, vratite i upravljajte...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Učitajte .hmb sigurnosnu kopiju aplikacije na poslužitelj i, ako je potrebno, vratite bilo koju od spremljenih sigurnosnih kopija.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Otkrijte filtre, integraciju s Pipedom i predmemorije.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Preuzimanja i pohrana",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Audio formati, mape i automatsko preuzimanje.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "generalno",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Odaberite, migrirajte ili pregledajte status sinkronizacije s Joss Redom.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Lokalni način / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Odjavi se"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Uvoz popisa pjesama, pjesama...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migracija iz Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "moji prijatelji",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Izravno upravljajte svojim Joss Red prijateljima.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Kvaliteta strujanja, normalizacija, tišina i baterija.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Ponovno generirajte svoj YouTube Music ID ako se sadržaj Discovera ne učita.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Osvježi ID (ID posjetitelja)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Greška"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Nije moguće generirati novi identifikator. Pokušajte ponovno kasnije.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Ažurirani identifikator",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Novi ID posjetitelja uspješno je generiran.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Podijeli album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Podijeli popis za reprodukciju",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Podijeli ovu pjesmu"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Pretraživanje baze podataka Shazam za podudaranja...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Slučajno"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("miješati rep"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singlovi"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Preskoči tišinu"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Tišina će biti preskočena tijekom reprodukcije glazbe",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Vaš mjerač vremena za spavanje je postavljen",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage(
      "Mjerač vremena za spavanje",
    ),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Pjesma dodana na playlistu!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Pjesma već postoji!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Pjesma je već u cache memoriji",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Pjesma je dodana u red čekanja!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Pronađena pjesma!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Informacije o pjesmi"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Pjesma se ne može reproducirati zbog ograničenja poslužitelja!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("ton pjesme"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("uklonjeno iz"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Uklonjeno iz reda čekanja!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Ne možete izbrisati pjesmu koja se trenutno reproducira",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Pjesme"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Pjesme uvezene s Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Poredaj uzlazno/silazno",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Poredaj po datumu"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Poredaj po trajanju",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Poredaj po imenu"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Brzina i visina"),
    "standard": MessageLookupByLibrary.simpleMessage("Standardno"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Pokrenite radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Otvori pri pokretanju",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Odaberite odjeljak koji Estrella Music prvi otvara",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Zaustavite glazbu pri zatvaranju aplikacije",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Reprodukcija glazbe će se zaustaviti kada se aplikacija zatvori iz upravitelja zadataka",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Kvaliteta strujanja",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Kvaliteta strujanja glazbe",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("pretplatnika"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Prijeđite prstom da istražite opcije",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku aktiviran. Preuzimanje postojeće biblioteke.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku aktiviran. Preseljena biblioteka.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku aktivan",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Način rada u oblaku aktivan. Sinkronizacija na čekanju.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje sinkronizacije nije uspjelo.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje promjena EMusica...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Sinkronizirana biblioteka.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Knjižnica ažurirana.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Postoje nove lokalne promjene. Bit će učitane prije preuzimanja.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Vaši se podaci čuvaju samo na ovom uređaju.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Lokalni način rada aktivan",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Izvan mreže. Promjene su na čekanju.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Izvan mreže. Promjene su spremljene za ponovni pokušaj.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sinkronizirajte pjesme popisa za reprodukciju",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic nije potvrdio sve promjene. Bit će im ponovno suđeno.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Nisam mogao ustati. Kasnije će se pokušati ponovo.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Promjene su ispravno učitane.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Promjene su uspješno učitane (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Nije moguće učitati pomoću WS-a. Kasnije će se pokušati ponovo.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Prijenos promjena na EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sinkronizirano"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sinkronizirani tekstovi nisu dostupni!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Zadane postavke sustava",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Način rada teme"),
    "title": MessageLookupByLibrary.simpleMessage("Naslov"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Najbolji glazbeni spotovi",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Najbolji glazbeni spotovi",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Trendovi"),
    "unLink": MessageLookupByLibrary.simpleMessage("Prekini vezu"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Veza je uspješno prekinuta!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Pjesma bez naslova"),
    "upNext": MessageLookupByLibrary.simpleMessage("Dalje"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Ažurirajte aplikaciju"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Otkriveni URL kliknite na njega da otvorite/reproducirate povezani sadržaj",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Blokiran korisnik"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Odgovor ne sadrži popis korisnika.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Otključan korisnik"),
    "username": MessageLookupByLibrary.simpleMessage("Korisničko ime"),
    "video": MessageLookupByLibrary.simpleMessage("video"),
    "videos": MessageLookupByLibrary.simpleMessage("Video zapisi"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Vidi sve"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Pogledaj umjetnika"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Modernizirali smo našu platformu. Stari sustav učitavanja ručnih sigurnosnih kopija je onemogućen. Sada imate dva jasna načina za upravljanje svojom glazbenom bibliotekom.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Odaberite kako od sada želite doživjeti Estrella Music.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Vaša glazba, vaš način",
    ),
  };
}
