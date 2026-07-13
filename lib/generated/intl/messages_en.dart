// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m6(count) => "Albums: ${count}";

  static String m7(count) => "Artists: ${count}";

  static String m8(count) => "Favorites: ${count}";

  static String m9(count) => "Playlists: ${count}";

  static String m10(count) => "Songs: ${count}";

  static String m11(source) => "Migration completed from ${source}.";

  static String m0(error) => "An error occurred while regenerating: ${error}";

  static String m1(title) => "Similar to ${title}";

  static String m2(current) => "Step ${current} of 3";

  static String m3(count) => "${count} changes committed.";

  static String m4(count) => "${count} synchronized changes.";

  static String m5(statusCode) => "Could not search for users (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Create new playlist",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Add 5 minutes"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Add songs to playlist",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Add to Library"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("Add to playlist"),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album bookmarked!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album bookmark removed!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albums"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "All fields required",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("App Info"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artist bookmarked!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artist bookmark removed!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Description not available!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artists"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Audio Codec"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar mis datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "We brought the login, registration, and password recovery from the previous project, adapted for this music app.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Your session lives in secure storage and is validated with the same backend you already used.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "The .env file needs to be configured to connect the authentication backend.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Login"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Register"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Send email"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Backend authentication is not configured in the .env file.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Your account is not yet verified.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Could not complete the operation.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("First name"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "I forgot my password",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "We will send instructions to your account email.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("name@email.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Last name"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Successfully logged in",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Could not send email.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Email sent.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Could not create account.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Account created successfully.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Welcome to Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Auto download favorite songs",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Automatically download favorite songs when added to favorites",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Auto open player screen",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Enable/disable auto opening of player full screen on selection of song for play",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Return"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("databases found"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Background music play",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAppData": MessageLookupByLibrary.simpleMessage("Backup App data"),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Backup in progress...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Backup successfully saved!",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Saves all settings, playlists and login data in a backup file",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "You need an active session...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage("Restart app"),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Upload backup now",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Do you want to perform a backup?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Backup deleted.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "There are no backups yet...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Backup restored. ",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Select backup file folder",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Choose which data to backup",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Backup uploaded correctly.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Based on last interaction",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Blacklist playlist",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Reset successfully!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("by"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Cache home screen content data",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Enable Caching home screen content data, Home screen will load instantly if this option is enabled",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cache Songs"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Caching songs while playing for future/offline playback, it will take additional space on your device",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Cached/Offline"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Cancel timer"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Sleep timer cancelled",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("Clear images cache"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Images cache cleared successfully",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Close App"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Cloud library found.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "A cloud library was found. ",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Cloud mode is ready. ",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Log in securely using your Joss Red account.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Access your playlists, favorites and history from any device (Windows, Android, etc.) instantly.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: Work offline and upload changes automatically when you recover internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage("Activate Cloud sync"),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Real-time synchronization with Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Cloud Mode (Recommended)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Collaborative Playlist",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Select the friends who will be able to see and edit this playlist:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Collaborators updated correctly.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Community Playlists",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. License GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Create & add"),
    "customIns": MessageLookupByLibrary.simpleMessage("Custom Instance"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Please select Custom Instance",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Daily discovery"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Remove from downloads",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Successfully removed from downloads!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Developed and Maintained by Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Disable transition animation",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Enable this option to disable tab transition animation",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
    "discover": MessageLookupByLibrary.simpleMessage("Discover"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
    "done": MessageLookupByLibrary.simpleMessage("Ready"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Don\'t show this info again",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "downloaded files found",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Download album songs",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Requested song is not downloadable due to server restriction. You may try again",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Downloading failed due to network/stream error! Please try again",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Download Location",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Download playlist",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Downloading File Format",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Select downloading file format. \"Opus\" will provide best quality",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Downloads"),
    "duration": MessageLookupByLibrary.simpleMessage("Duration"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamic"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Empty playlist!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Bottom navigation bar",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Switch to bottom navigation bar",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Enable slidable actions",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Enable slidable actions on song tile",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Enabled"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("End of this song"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Enqueue album songs",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Enqueue all"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Enqueue this song"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage("Enqueue songs"),
    "episodes": MessageLookupByLibrary.simpleMessage("Episodes"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Open system equalizer",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Some error occured!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Error when playing:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Export"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Export downloaded files",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Click here to export downloaded file from inApp dir to external dir",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Error exporting playlist",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Error formatting playlist data",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Permission denied while exporting",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Not enough storage space",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Files successfully exported",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("Export Playlist"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Export Playlist as CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Can\'t be imported here",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Export playlist to JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "This format can be imported",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Export to Youtube music",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "It will push your playlist (songs < 50) to current queue, don\'t forget to add to playlist/save after opening in YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Downloaded file export location",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exporting..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exporting playlist...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Featured Playlists",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("File not found"),
    "follow": MessageLookupByLibrary.simpleMessage("Continue"),
    "following": MessageLookupByLibrary.simpleMessage("Following"),
    "for1": MessageLookupByLibrary.simpleMessage("for"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "forgotten favorites",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Friend"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Friend request accepted",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Friend request sent",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Friends"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Sign in to find friends.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Friendship removed",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Mistake"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Electronics"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("Latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rock"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gesture"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "View GitHub source code \nif you like this project, don\'t forget to give a ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Go to album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Click here to go to download page",
    ),
    "high": MessageLookupByLibrary.simpleMessage("High"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL to Piped instance",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Home content count",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Select the number of initial homescreen-content(approx). Lesser results faster loading",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignore battery optimization",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "If you are facing notification issues or playback stopped by system optimization, please enable this option",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Error importing playlist",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Error saving to database",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Could not access the selected file",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid file format",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Note: Large playlists may take longer to import",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("Import Playlist"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Select a previously exported playlist JSON file to import",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Imported"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Imported from Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Imported Playlist",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importing playlist...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "In App storage directory",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Include downloded songs files",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Information not available",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Invalid playlist file structure",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Invalid server response.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "The session does not contain a valid token.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("items"),
    "keepListening": MessageLookupByLibrary.simpleMessage("keep listening"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Keep screen on while playing",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "If enabled, the device screen will stay awake while music is playing",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Set App language"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Latest release"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Latest Version Available",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Let\'s start.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Library Albums"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Library Artists"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("Library Playlists"),
    "libSongs": MessageLookupByLibrary.simpleMessage("Library Songs"),
    "library": MessageLookupByLibrary.simpleMessage("Library"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Library Playlist",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Linked successfully!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link copied to clipboard",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Link with piped for playlists",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Listen now"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Listening to the environment...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Could not load update information",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "It works without the need to log in.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Your entire library stays strictly on this computer.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Note: No manual cloud backups. ",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Use only on this device",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Absolute privacy on your device",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Local Mode"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Loudness normalization",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Low"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Lyrics"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Lyrics not available!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Manage collaborators (friends)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Make sure the music is playing loud enough near your microphone.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Migrated album"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage("Migrated library"),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Migrated Playlist",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "There is already a migration in progress.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyzing the local library...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Checking if EMusic Cloud already has a library...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migration completed.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Creating a local backup before connecting cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "The migration failed. ",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Log in to Joss Red before migrating.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Preparing the migration in EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud could not start the migration.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Not all data could be uploaded. ",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Uploading playlists, favorites and history...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud could not validate the migration.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verifying integrity in EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Select file and import",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Select song.db or a .backup file",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migration completed successfully.",
    ),
    "migration_summary_albums": m6,
    "migration_summary_artists": m7,
    "migration_summary_favorites": m8,
    "migration_summary_playlists": m9,
    "migration_summary_songs": m10,
    "migration_summary_start": m11,
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "misc": MessageLookupByLibrary.simpleMessage("Misc"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "The most listened to song",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Music & Playback",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Music Recognition",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Network error! Check your network connection.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Oops network error!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "New version available!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Joss Red App (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Understood"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% synchronization with Joss Red, playlists with friends and much more. ",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music has evolved!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "To add friends, accept requests or manage your security profile, please use Joss Red on its official platforms:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Friends and Account Management:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Create playlists with your friends! ",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Collaborative Playlists",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Your playlists and favorites are now saved and synced in the cloud automatically with your main Joss Red account.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Full Integration with Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "You no longer need to click manual sync buttons; ",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Transparent Synchronization",
    ),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("No bookmarks!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "You have no added friends on Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "You don\'t have any lib playlist!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Could not find any songs in the recorded audio",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("No Matches"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("No offline songs!"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "There are no songs in this collection",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("No Match found for"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Not authenticated",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Not a Song/Music-Video!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Not a valid link!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Open in"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operation failed"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_text": MessageLookupByLibrary.simpleMessage("Password"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permission denied",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisation"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Piped Playlist",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped playlist synced!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Plain"),
    "play": MessageLookupByLibrary.simpleMessage("Play"),
    "playNext": MessageLookupByLibrary.simpleMessage("Play next"),
    "playNow": MessageLookupByLibrary.simpleMessage("Play Now"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Playback speed"),
    "playerUi": MessageLookupByLibrary.simpleMessage("Player Ui"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Select player user interface",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Playing:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "PLAYING FROM ÁLBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "PLAYING FROM ARTIST",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "PLAYING FROM PLAYLIST",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "PLAYING FROM SELECTION",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Playlist"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist blacklisted!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist bookmarked!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist bookmark removed!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Playlist contributors",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist created!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist created & song added!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist exported successfully to",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist imported successfully",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist removed!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Renamed successfully!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Playlists"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Popular tracks"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Processing files..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Processing the audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Queue loop"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Queue loop mode cannot be disabled when shuffle mode is enabled.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Queue loop mode cannot be enabled in radio mode.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Queue can\'t be shuffled when shuffle mode is enabled",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Queue can\'t be rearranged when shuffle mode is enabled",
    ),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Quick Picks"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio not available for this artist!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Random Radio"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Random Selection"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Rearrange playlist",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Rearrange songs"),
    "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Recent searches"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Recently Played"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "We recommend activating Cloud Mode for a Spotify-like experience: real-time synchronization between all your devices and automatic backup without you having to do anything.",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Remove from Library Songs",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Remove from Library",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Remove from playlist",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Remove from queue",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Remove multiple songs",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Remove playlist"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("Rename Playlist"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproduced by"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restore default settings",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Reset app settings to default (Restart required)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Settings reset to default completed, Please restart app",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Reset blacklisted playlists",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Reset all the piped blacklisted playlists",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Restart App"),
    "restore": MessageLookupByLibrary.simpleMessage("Restore"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage("Restore App data"),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restore last playback session",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Automatically restore the last playback session on app start",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Successfully restored!\nChanges are applied on restart",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restores all settings, login data and playlists from a backup file. Overwrites all current data",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Select backup file",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Restoring..."),
    "results": MessageLookupByLibrary.simpleMessage("Results"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry!"),
    "save": MessageLookupByLibrary.simpleMessage("Keep"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scanning..."),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Songs, Playlist, Album or Artist",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Search in Library",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Search results"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Recent searches",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select All"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Select Auth Instance",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Please select Authentication instance!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Select File"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Select songs"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "The selected file was not found.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Your session has expired. ",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Set discover content",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "About Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Version, open source project and GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Account and Sync",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Cloud mode, backups, friends list and migrations.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Theme, language and interface animations.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cloud backup",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Upload, restore and manage...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Upload a .hmb backup to the server and restore any saved backups if needed.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Discover filters, integration with Piped and caches.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Downloads and Storage",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Audio formats, folders and automatic downloads.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("General"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Choose, migrate or review the synchronization status with Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Local Mode / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Import playlists, songs...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrate from Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("my friends"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Manage your Joss Red friends directly.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Streaming quality, normalization, silences and battery.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Regenerate your YouTube Music ID if Discover content doesn\'t load.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Refresh ID (Visitor ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Mistake"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "A new identifier could not be generated. ",
    ),
    "settings_visitor_exception": m0,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Updated identifier",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "A new Visitor ID was generated successfully.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Share album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("Share playlist"),
    "shareSong": MessageLookupByLibrary.simpleMessage("Share this song"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Searching the Shazam database for matches...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Shuffle"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Shuffle Queue"),
    "similarToTitle": m1,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Skip silence"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Silence will be skipped in music playback",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Your sleep timer is set",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sleep Timer"),
    "slide_indicator": m2,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Song added to playlist!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Song already exists!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Song already offline in cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage("Song enqueued!"),
    "songFound": MessageLookupByLibrary.simpleMessage("Song Found!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Song Info"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Song is not playable due to server restriction!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("song tone"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Removed from"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Removed from queue!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "You can\'t remove currently playing song",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Songs"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Songs imported from Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sort ascending/descending",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sort by Date"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage("Sort by Duration"),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sort by Name"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Speed ​​and Pitch"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Start radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Open on startup"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the section that Estrella Music opens first",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Stop music on task clear",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Music playback will stop when App being swiped away from the task manager",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Streaming quality",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Quality of music stream",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("subscribers"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Swipe to explore options",
    ),
    "syncChangesConfirmed": m3,
    "syncChangesSynced": m4,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Cloud mode activated. ",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Cloud mode activated. ",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Cloud mode active. ",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to download sync.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Downloading EMusic changes...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Synchronized library.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Library up to date.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "There are new local changes. ",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Your data is kept only on this device.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Local mode active",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage("Offline. "),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage("Offline. "),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sync playlist songs",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic did not confirm all the changes. ",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Could not get up. ",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Changes uploaded correctly.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Changes uploaded successfully (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Could not upload using WS. ",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Uploading changes to EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synced"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synced lyrics not available!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("System default"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme Mode"),
    "title": MessageLookupByLibrary.simpleMessage("Title"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Top Music Videos"),
    "trending": MessageLookupByLibrary.simpleMessage("Trending"),
    "unLink": MessageLookupByLibrary.simpleMessage("Unlink"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Unlinked successfully!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Untitled song"),
    "upNext": MessageLookupByLibrary.simpleMessage("Up Next"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Update Application"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Url detected click on it to open/play associated content",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Blocked user"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "The response does not contain a list of users.",
    ),
    "userSearchFailed": m5,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("Unlocked user"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Videos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View all"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("View Artist"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "We have modernized our platform. ",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Choose how you want to experience Estrella Music from now on.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Your music, your way",
    ),
  };
}
