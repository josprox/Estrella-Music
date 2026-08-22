// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fi locale. All the
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
  String get localeName => 'fi';

  static String m0(songTitle) => "Ladataan: ${songTitle}";

  static String m1(count) => "Albumit: ${count}";

  static String m2(count) => "Artistit: ${count}";

  static String m3(count) => "Suosikit: ${count}";

  static String m4(count) => "Soittolistat: ${count}";

  static String m5(count) => "Kappaleet: ${count}";

  static String m6(source) => "Siirto suoritettu ${source}.";

  static String m7(error) => "Uudelleen luomisessa tapahtui virhe: ${error}";

  static String m8(title) => "Samanlainen kuin ${title}";

  static String m9(current) => "Vaihe ${current}/3";

  static String m10(count) => "${count} muutoksia tehty.";

  static String m11(count) => "${count} synkronoidut muutokset.";

  static String m12(statusCode) => "Käyttäjiä ei voitu etsiä (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Luo soittolista",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Noin"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Lisää 5 minuuttia"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Lisää kappaleita soittolistaan",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Lisää kirjastoon"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lisää soittolistaan",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Albumi"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Albumi lisätty kirjanmerkkeihin!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Albumin kirjanmerkki poistettu!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albumit"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Sinun makusi mukaan",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Kaikki tiedot vaaditaan",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Ei testattu: Jos valitset valintaruudun yli 60 tiedoston lataamisen jälkeen, prosessi saattaa kuluttaa paljon muistia ja saattaa aiheuttaa puhelimen tai sovelluksen kaatumisen. Jatka omalla vastuullasi.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Sovelluksen tiedot"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artisti lisätty kirjanmerkkeihin!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artistin kirjanmerkki poistettu!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Kuvausta ei ole saatavilla!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistit"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Sinun makusi mukaan",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Äänikoodekki"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Todennuskoodi"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Anna kelvollinen 6-numeroinen koodi tai kirjaudu sisään uudelleen.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Syötä 6-numeroinen koodi todennussovelluksesta. Tämä käyttöoikeus vanhenee 5 minuutin kuluttua.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Kaksivaiheinen todennus",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Tarkista ja jatka",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar mis datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Toimme sisäänkirjautumisen, rekisteröinnin ja salasanan palautuksen edellisestä projektista, mukautettuna tähän musiikkisovellukseen.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Istuntosi on suojatussa tallennustilassa, ja se on validoitu samalla taustalla, jota jo käytit.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      ".env-tiedosto on määritettävä, jotta todennustausta voidaan yhdistää.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Kirjaudu sisään"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Rekisteröidy"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Lähetä postia",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Vahvista salasana",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Väärä sähköpostiosoite tai salasana.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Anna kelvollinen sähköpostiosoite.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Todennustaustaosaa ei voida määrittää .env-tiedostossa.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Tiliäsi ei ole vielä vahvistettu.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Operaatiota ei voitu suorittaa loppuun.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Etunimi"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Unohdin salasanani",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Lähetämme ohjeet tilisi sähköpostiisi.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nimi@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Sukunimi"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Sisäänkirjautuminen onnistui",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Sähköpostia ei voitu lähettää.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Sähköposti lähetetty.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Tiliä ei voitu luoda.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Tili luotu onnistuneesti.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Tervetuloa Estrella Musiciin",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Tervetuloa Estrella Musiciin",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Suosikkikappaleiden automaattinen lataus",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Lataa suosikkikappaleet automaattisesti, kun ne lisätään suosikkeihin",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Avaa automaattisesti soittimen näyttö",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Aktivoi/deaktivoi soittimen automaattinen avautuminen koko näytölle, kun valitset toistettavan kappaleen",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Palata"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "tietokantoja löytynyt",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Musiikin toisto taustalla",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Ota taustamusiikin toisto käyttöön tai poista se käytöstä (sovellusta voidaan käyttää ilmaisinalueelta, kun sovellus on käynnissä taustalla)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Varmuuskopio"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopioi sovellustiedot",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopiointi käynnissä...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopio tallennettu onnistuneesti!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopiointiasetukset ja soittolistat",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Tallenna kaikki asetukset, soittolistat ja kirjautumistiedot varmuuskopiotiedostoon",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Tarvitset aktiivisen istunnon...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Käynnistä sovellus uudelleen",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Lataa varmuuskopio nyt",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Haluatko tehdä varmuuskopion?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopio poistettu.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopioita ei ole vielä...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopio palautettu. Käynnistä sovellus uudelleen.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Valitse kansio varmuuskopiointia varten",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Valitse varmuuskopioitavat tiedot",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Varmuuskopio ladattu oikein.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Viimeisimpään toimintaan perustuvat",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bittinopeus"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Soittolistan musta lista",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Nollattu!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("by"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Tallenna aloitusnäytön sisältötiedot",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Ota käyttöön aloitusnäytön sisällön tietojen tallennus, aloitusnäyttö latautuu välittömästi, jos tämä vaihtoehto on käytössä",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Kappaleet välimuistiin",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Pidä kappaleet välimuistissa myöhempää- tai offline-toistoa varten. Käyttää tilaa laitteelta",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Välimuistissa/ladatut",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Peruuta"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Peruuta ajastin"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Uniajastin peruutettu",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Tyhjennä kuvavälimuisti",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Kuvavälimuisti tyhjennetty onnistuneesti",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Napsauta tätä tyhjentääksesi välimuistissa olevat pikkukuvat/kuvat. (Ei suositella, ellet halua päivittää välimuistissa olevia kuvatietoja)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Lähellä"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Sulje sovellus"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Pilvikirjasto löytyi.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Pilvikirjasto löytyi. Tämä laite lataa sen korvaamatta sitä.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Pilvitila on valmis. Tämä laite toimii offline-välimuistina.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Kirjaudu sisään turvallisesti Joss Red -tililläsi.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Käytä soittolistojasi, suosikkejasi ja historiaasi välittömästi miltä tahansa laitteelta (Windows, Android jne.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Työskentele offline-tilassa ja lataa muutokset automaattisesti, kun internet palautuu.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktivoi pilvisynkronointi",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Reaaliaikainen synkronointi Joss Redin kanssa",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage("Pilvitila (suositus)"),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Yhteistyösoittolista",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Valitse ystävät, jotka voivat nähdä ja muokata tätä soittolistaa:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Yhteistyökumppanit päivitetty oikein.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Yhteisön soittolistat",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Sisältö"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL-lisenssi v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Luo"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Luo & lisää"),
    "customIns": MessageLookupByLibrary.simpleMessage("Muu instanssi"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Valitse \'Muu instanssi\'",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Päivittäinen löytö"),
    "dark": MessageLookupByLibrary.simpleMessage("Tumma"),
    "delete": MessageLookupByLibrary.simpleMessage("Poista"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Poista latauksista",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Poistettu latauksista onnistuneesti!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Kehittäjä ja ylläpitäjä Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Poista siirtymäanimaatio käytöstä",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktivoi tämä vaihtoehto, jos haluat poistaa välilehden siirtymän animaation käytöstä",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Poissa käytöstä"),
    "discover": MessageLookupByLibrary.simpleMessage("Löydöt"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Ohita"),
    "done": MessageLookupByLibrary.simpleMessage("Valmis"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Älä näytä tätä uudelleen",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "ladatut tiedostot löytyivät",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Lataa"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Lataa kappaleita albumilta",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Pyydettyä kappaletta ei voi ladata palvelinrajoitusten vuoksi. Voit yrittää uudelleen",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Lataus epäonnistui verkko-/siirtovirheen vuoksi! Yritä uudelleen",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Latausten sijainti",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Pitää musiikkilataukset aktiivisina taustalla.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "musiikin lataukset",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Valmistellaan latauksiasi…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Musiikin lataaminen",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lataa soittolista",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Latausten tiedostomuoto",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Valitse ladattavan tiedoston muoto. \"Opus\" tarjoaa parhaan laadun",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Lataukset"),
    "duration": MessageLookupByLibrary.simpleMessage("Kesto"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynaaminen"),
    "email": MessageLookupByLibrary.simpleMessage("Sähköposti"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Tyhjä soittolista!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Navigointipalkin sijainti",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Siirrä navigointipalkki ruudun alaosaan",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktivoi liukusäätimen toiminnot",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktivoi pyyhkäisytoiminnot kappaleruudussa",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Käytössä"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Soita kappale loppuun",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Lisää albumin kappaleita jonoon",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Lisää kaikki jonoon"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Lisää jonoon"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Lisää kappaleita jonoon",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Jaksot"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Taajuuskorjain"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "avaa järjestelmän taajuuskorjain",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Tapahtui virhe!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Tapahtui virhe"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Virhe pelatessa:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Vie"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Vie ladatut tiedostot",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Napsauta tätä viedäksesi ladatut tiedostot sovellushakemistosta ulkoiseen hakemistoon",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Virhe vietäessä soittolistaa",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Virhe soittolistan tietojen muotoilussa",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Lupa evätty viennin aikana",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Säilytystila ei riitä",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Tiedostojen vienti onnistui",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("Vie soittolista"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Vie soittolista CSV-muodossa",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ei voi tuoda tänne",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Vie soittolista JSON-muotoon",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tämä muoto voidaan tuoda",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Vie Youtube-musiikkiin",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Se työntää soittolistasi (kappaleita < 50) nykyiseen jonoon, älä unohda lisätä sitä soittolistaan/tallentaa avattuasi sen YtMusicissa",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Vie ladattujen tiedostojen sijainti",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Viedään..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Viedään soittolistaa...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Suosikit"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Suositellut soittolistat",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Tiedostoa ei löydy"),
    "follow": MessageLookupByLibrary.simpleMessage("Jatkaa"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("seurannut"),
    "following": MessageLookupByLibrary.simpleMessage("Jälkeen"),
    "for1": MessageLookupByLibrary.simpleMessage("haulla"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "unohdetut suosikit",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("ystävä"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Ystäväpyyntö hyväksytty",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Ystäväpyyntö lähetetty",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Ystävät"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Kirjaudu sisään löytääksesi ystäviä.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Ystävyys poistettu",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Albumi"),
    "genericError": MessageLookupByLibrary.simpleMessage("Virhe"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektroniikka"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latina"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Ele"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Näytä lähdekoodi GitHubissa\njos pidät tästä projektista, muista antaa ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Näytä albumi"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Avaa tästä lataussivu",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hei maailma"),
    "high": MessageLookupByLibrary.simpleMessage("Korkea"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "Piped-instanssin API:n URL",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Koti"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Aloitusnäkymän sisällön määrä",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Valitse lähtökohtainen aloitusnäkymän sisällön määrä. Pienempi määrä latautuu nopeammin",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Poista akun optimointi käytöstä",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Jos kohtaat ongelmia ilmoitusten tai toiston kanssa, ota tämä käyttöön.",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Virhe soittolistan tuonnissa",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Virhe tallennettaessa tietokantaan",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Valittua tiedostoa ei voitu käyttää",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Virheellinen tiedostomuoto",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Huomautus: suurten soittolistojen tuonti voi kestää kauemmin",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("Tuo soittolista"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Valitse tuotavaksi aiemmin viety soittolistan JSON-tiedosto",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Tuotu"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Tuotu Joss Music Kotlinista",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tuotu soittolista",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tuodaan soittolistaa...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Sisäinen tallennushakemisto",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Sisällytä ladatut kappaletiedostot",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Tietoja ei ole saatavilla",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Virheellinen soittolistatiedostorakenne",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Virheellinen palvelimen vastaus.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Istunto ei sisällä kelvollista tunnusta.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("kohteet"),
    "keepListening": MessageLookupByLibrary.simpleMessage(
      "jatka kuuntelemista",
    ),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Pidä näyttö päällä toiston aikana",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Jos käytössä, laitteen näyttö pysyy päällä musiikin toiston aikana",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Kieli"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Valitse sovelluksen kieli",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Viimeisin julkaisu"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Uusin versio saatavilla",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Aloitetaan.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Kirjaston albumit"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Kirjaston artistit"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Kirjaston soittolistat",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Kirjaston kappaleet"),
    "library": MessageLookupByLibrary.simpleMessage("Kirjasto"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Kirjaston soittolista",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Vaalea"),
    "link": MessageLookupByLibrary.simpleMessage("Yhdistä"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Yhdistetty!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Linkki kopioitu leikepöydälle",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Yhdistä Piped soittolistojen synkronointiin",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Kuuntele nyt"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Kuuntelee ympäristöä...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Päivitystietoja ei voitu ladata",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Paikallinen"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Se toimii ilman tarvetta kirjautua sisään.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Koko kirjastosi pysyy tiukasti tällä tietokoneella.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Huomautus: Ei manuaalisia pilvivarmuuskopioita. Jos kadotat laitteesi tai poistat sovelluksen, tietojasi ei voida palauttaa.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Käytä vain tässä laitteessa",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Täydellinen yksityisyys laitteellasi",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Paikallinen tila"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Äänenvoimakkuuden normalisointi",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Asettaa saman äänenvoimakkuustason kaikille kappaleille (kokeellinen) (Ei toimi vanhemmissa versioissa ladatuissa kappaleissa (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Matala"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Kirjeitä"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sanoituksia ei ole saatavilla!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Hallinnoi yhteistyökumppaneita (ystäviä)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Varmista, että musiikki soi tarpeeksi kovaa mikrofonin lähellä.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Siirretty albumi"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Siirretty kirjasto",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Siirretty soittolista",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Siirto on jo käynnissä.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analysoidaan paikallista kirjastoa...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Tarkistetaan, onko EMusic Cloudissa jo kirjasto...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Siirto suoritettu.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Luodaan paikallista varmuuskopiota ennen pilveen yhdistämistä...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Siirto epäonnistui. Paikallisia tietojasi ei muutettu.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Kirjaudu Joss Rediin ennen siirtoa.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Valmistellaan siirtoa EMusic Cloudissa...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud ei voinut aloittaa siirtoa.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Kaikkia tietoja ei voitu ladata. Säilytämme paikallisen tuen.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Ladataan soittolistoja, suosikkeja ja historiaa...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud ei voinut vahvistaa siirtoa.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Vahvistetaan eheyttä EMusic Cloudissa...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Valitse tiedosto ja tuo",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Valitse song.db tai varmuuskopio .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Siirto suoritettu onnistuneesti.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minuuttia"),
    "misc": MessageLookupByLibrary.simpleMessage("Erilaisia"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Eniten kuunneltu kappale",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musiikki ja toisto",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Musiikin tunnistus",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Verkkovirhe! Tarkista Internet-yhteytesi.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("Oho, verkkovirhe!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Uusi versio saatavilla!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red -sovellus (Play Kauppa)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Ymmärretty"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100 % synkronointi Joss Redin kanssa, soittolistat ystävien kanssa ja paljon muuta. Napauta nähdäksesi mitä uutta.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music on kehittynyt!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Jos haluat lisätä ystäviä, hyväksyä pyyntöjä tai hallita suojausprofiiliasi, käytä Joss Rediä sen virallisilla alustoilla:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Ystävät ja tilinhallinta:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella musiikkiuutisia",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Luo soittolistoja ystäviesi kanssa! Kun luot soittolistaa, valitse Yhteistyö-valintaruutu ja valitse ystäväsi muokattaviksi yhdessä.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Yhteistyösoittolistat",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Soittolistasi ja suosikkisi tallennetaan nyt ja synkronoidaan automaattisesti pilveen Joss Red -päätilisi kanssa.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Täysi integrointi Joss Redin kanssa",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Sinun ei enää tarvitse napsauttaa manuaalisia synkronointipainikkeita. Uusi moottori vastaa automaattisesti ylös ja alas vaihtamisesta.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Läpinäkyvä synkronointi",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Ei"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Ei kirjanmerkkejä!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Sinulla ei ole lisättyjä ystäviä Joss Redissä.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage("Ei soittolistoja!"),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Tallennetusta äänestä ei löytynyt yhtään kappaletta",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Ei otteluita"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Ei ladattuja kappaleita!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Tässä kokoelmassa ei ole kappaleita",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Ei hakutuloksia kohteelle",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Ei todennettu"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Ei kappale/musiikkivideo!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Epäkelpo linkki!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Avaa sisään"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Toiminto epäonnistui",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Salasana"),
    "password_text": MessageLookupByLibrary.simpleMessage("Salasana"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("Lupa evätty"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Salli"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music tarvitsee nämä luvat hallitakseen musiikkiasi ja tarjotakseen kaikkia toistoominaisuuksia.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Luvat aloittaaksesi",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Myönnä tarvittavat käyttöoikeudet",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Sitä käytetään vain, kun päätät tunnistaa ympärilläsi soivan kappaleen.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikrofoni",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Näyttää toistosäätimet, latauksen edistymisen ja tärkeät sovellusilmoitukset.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Ilmoitukset",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Asetukset",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Jatkamiseen vaaditaan kaikki kolme lupaa. Voit muuttaa niitä myöhemmin järjestelmäasetuksissa.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Sen avulla voit toistaa musiikkia, tallentaa latauksia, viedä soittolistoja ja valmistella päivityksiä.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musiikkia ja tallennustilaa",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personointi"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped-soittolista",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Synkronoitu Piped-soittolista!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("yksinkertainen"),
    "play": MessageLookupByLibrary.simpleMessage("Pelaa"),
    "playNext": MessageLookupByLibrary.simpleMessage("Toista seuraavaksi"),
    "playNow": MessageLookupByLibrary.simpleMessage("Pelaa nyt"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Toistonopeus"),
    "playerUi": MessageLookupByLibrary.simpleMessage(
      "Soittimen käyttöliittymä",
    ),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Valitse soittimen käyttöliittymä",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Toistetaan:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "SOITTAMME ALBUMILLA",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "TOISTAA ARTISTILTA",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "TOISTAMINEN SOITTOLISTALTA",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "PELAAMINEN VALINNASTA",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Soittolista"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolista siirretty mustalle listalla!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolista lisätty kirjanmerkkeihin!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolistan kirjanmerkki poistettu!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Soittolistan avustajat",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolista luotu!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolista luotu & kappale lisätty!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Soittolista vietiin onnistuneesti kohteeseen",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Soittolistan tuonti onnistui",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Soittolista poistettu!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Nimi muutettu!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Soittolistat"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Tulossa pian"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcastit"),
    "popularTracks": MessageLookupByLibrary.simpleMessage(
      "Suosittuja kappaleita",
    ),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Käsitellään tiedostoja...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Käsitellään ääntä...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiilit"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("häntälenkki"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Jonosilmukkatilaa ei voi poistaa käytöstä, kun satunnaistoistotila on käytössä.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Tail loop -tilaa ei voi aktivoida radiotilassa.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Satunnainen tila on aktivoitu. Et voi sekoittaa jonoa manuaalisesti.",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Jonoa ei voi järjestää uudelleen, kun satunnaistoisto on päällä",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Nopea valinta"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Pikavalinnat"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Tälle artistille ei ole saatavilla radiota!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Random Radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Satunnainen valinta",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Järjestä soittolista uudelleen",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Järjestä kappaleet uudelleen",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Lue lisää"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Viimeaikaiset haut",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Viimeksi soitetut"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Suosittelemme Cloud Moden aktivointia Spotifyn kaltaisen kokemuksen saamiseksi: reaaliaikainen synkronointi kaikkien laitteidesi välillä ja automaattinen varmuuskopiointi ilman, että sinun tarvitsee tehdä mitään.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Suositeltava"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Suositeltava"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Poista välimuistista",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage("Poista kirjastosta"),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Poista kirjastosta",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Poista soittolistalta",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Poista jonosta"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Poista useita kappaleita",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Poista soittolista",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Nimeä uudelleen"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Uudelleennimeä soittolista",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Toistettu"),
    "reset": MessageLookupByLibrary.simpleMessage("Nollaa"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Palauta oletusasetukset",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Palauta sovelluksen oletusasetukset (vaatii uudelleenkäynnistyksen)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Oletusasetusten palautus on valmis, käynnistä sovellus uudelleen",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Nollaa soittolistojen musta lista",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Nollaa kaikki Pipedin soittolistojen mustat listat",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Käynnistä sovellus uudelleen",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Palauta"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Palauta sovellustiedot",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Palauta viimeinen toistoistunto",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Palauta viimeinen toistoistunto automaattisesti, kun sovellus käynnistetään",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Onnistuneesti kunnostettu!\nMuutokset otetaan käyttöön uudelleenkäynnistyksen yhteydessä",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Palauta asetukset ja soittolistat",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Palauttaa kaikki asetukset, kirjautumistiedot ja soittolistat varmuuskopiotiedostosta. Korvaa kaikki nykyiset tiedot",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Valitse varmuuskopiotiedosto",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Palautetaan..."),
    "results": MessageLookupByLibrary.simpleMessage("Tulokset"),
    "retry": MessageLookupByLibrary.simpleMessage("Yritä uudelleen!"),
    "save": MessageLookupByLibrary.simpleMessage("Pitää"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Tallennettu"),
    "scanning": MessageLookupByLibrary.simpleMessage("Skannataan..."),
    "search": MessageLookupByLibrary.simpleMessage("Etsi"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Kappale, soittolista, albumi tai artisti",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("Hae kirjastosta"),
    "searchRes": MessageLookupByLibrary.simpleMessage("Hakutulokset"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Viimeaikaiset haut",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Valitse kaikki"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("Valitse instanssi"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Valitse instanssi!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Valitse Tiedosto"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Valitse kappaleet"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Valittua tiedostoa ei löytynyt.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Istuntosi on vanhentunut. Kirjaudu uudelleen sisään.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Aseta löytöjen sisältö",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Asetukset"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Tietoja Estrella Musicista",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versio, avoimen lähdekoodin projekti ja GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Tili ja synkronointi",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Pilvitila, varmuuskopiot, ystäväluettelo ja siirrot.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Teema-, kieli- ja käyttöliittymäanimaatiot.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Pilvivarmuuskopio",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Lataa, palauta ja hallinnoi...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Lataa sovelluksen .hmb-varmuuskopio palvelimelle ja palauta tarvittaessa kaikki tallennetut varmuuskopiot.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Tutustu suodattimiin, integraatioon Pipediin ja välimuistiin.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Lataukset ja tallennus",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Ääniformaatit, kansiot ja automaattiset lataukset.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Kenraali",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Valitse, siirrä tai tarkista synkronoinnin tila Joss Redin kanssa.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Paikallinen tila / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Tuo soittolistoja, kappaleita...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Siirrä Joss Music Kotlinista",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("ystäväni"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Hallitse Joss Redin ystäviäsi suoraan.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Suoratoiston laatu, normalisointi, hiljaisuudet ja akku.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Luo YouTube Music -tunnuksesi uudelleen, jos Discover-sisältö ei lataudu.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Päivitä tunnus (vierailijatunnus)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Virhe"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Uutta tunnistetta ei voitu luoda. Yritä myöhemmin uudelleen.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Tunniste päivitetty",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Uusi vierailijatunnus luotiin onnistuneesti.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Jaa albumi"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("Jaa soittolista"),
    "shareSong": MessageLookupByLibrary.simpleMessage("Jaa kappale"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Haetaan osumia Shazam-tietokannasta...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Satunnainen"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("sekoita häntää"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singlet"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Ohita hiljaisuus"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Hiljaiset kohdat ohitetaan toistossa",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Uniajastin on asetettu",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Uniajastin"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Kappale lisätty soittolistaan!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Kappale on jo olemassa!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Kappale on jo välimuistissa",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Kappale lisätty jonoon!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Kappale löytynyt!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Kappaleen tiedot"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Kappaletta ei voi soittaa palvelinrajoitusten vuoksi!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("laulun sävy"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Poistettu kohteesta",
    ),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Poistettu jonosta!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Et voi poistaa parhaillaan soivaa kappaletta",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Kappaleet"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlinista tuotuja kappaleita",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Lajittele nousevasti/laskevasti",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage(
      "Lajittele päivämäärän mukaan",
    ),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Lajittele keston mukaan",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage(
      "Lajittele nimen mukaan",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Nopeus ja sävelkorkeus",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Vakio"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Käynnistä radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Avaa käynnistyksen yhteydessä",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Valitse osio, jonka Estrella Music avaa ensin",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Tila"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Musiikin pysäytys",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Musiikki pysäytetään, kun sovellus pyyhkäistään pois viimeisimpien sovellusten luettelosta",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Suoratoiston laatu",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Valitse suoratoistettavan musiikin laatu",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("tilaajat"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Selaa vaihtoehtoja pyyhkäisemällä ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Pilvitila aktivoitu. Ladataan olemassa olevaa kirjastoa.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Pilvitila aktivoitu. Siirretty kirjasto.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Pilvitila aktiivinen",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Pilvitila aktiivinen. Odottaa synkronointia.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Synkronoinnin lataaminen epäonnistui.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Ladataan EMusic-muutoksia...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synkronoitu kirjasto.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Kirjasto ajan tasalla.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Uusia paikallisia muutoksia on tulossa. Ne ladataan ennen lataamista.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Tietosi säilytetään vain tällä laitteella.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Paikallinen tila aktiivinen",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Offline-tilassa. Muutokset odottavat.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Offline-tilassa. Muutokset tallennettu uudelleen yrittämistä varten.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synkronoi soittolistan kappaleita",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic ei vahvistanut kaikkia muutoksia. Niitä yritetään uudelleen.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Ei päässyt ylös. Sitä yritetään myöhemmin uudelleen.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Muutokset ladattu oikein.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Muutokset lähetetty onnistuneesti (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Ei voitu ladata WS:n avulla. Sitä yritetään myöhemmin uudelleen.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Lähetetään muutoksia EMusiciin...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synkronoitu"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synkronoituja sanoituksia ei ole saatavilla!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Järjestelmän oletus",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Teeman tila"),
    "title": MessageLookupByLibrary.simpleMessage("Otsikko"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Suosituimmat musiikkivideot",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Parhaat musiikkivideot",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Trendaavat"),
    "unLink": MessageLookupByLibrary.simpleMessage("Poista yhteys"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("Yhteys poistettu!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Nimetön kappale"),
    "upNext": MessageLookupByLibrary.simpleMessage("Seuraavaksi"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Päivitä sovellus"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Havaittu URL-osoite napsauttamalla sitä avataksesi tai toistaaksesi siihen liittyvän sisällön",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Estetty käyttäjä"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Vastaus ei sisällä luetteloa käyttäjistä.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Avattu käyttäjä"),
    "username": MessageLookupByLibrary.simpleMessage("Käyttäjätunnus"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videot"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Näytä kaikki"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Näytä artisti"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Olemme modernisoineet alustamme. Vanha manuaalisten varmuuskopioiden latausjärjestelmä on poistettu käytöstä. Sinulla on nyt kaksi selkeää tapaa hallita musiikkikirjastoasi.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Valitse, miten haluat kokea Estrella Musicin tästä eteenpäin.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Sinun musiikkisi, sinun tapasi",
    ),
  };
}
