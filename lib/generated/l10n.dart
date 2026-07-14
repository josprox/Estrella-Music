// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Songs`
  String get songs {
    return Intl.message('Songs', name: 'songs', desc: '', args: []);
  }

  /// `Playlists`
  String get playlists {
    return Intl.message('Playlists', name: 'playlists', desc: '', args: []);
  }

  /// `Albums`
  String get albums {
    return Intl.message('Albums', name: 'albums', desc: '', args: []);
  }

  /// `Album`
  String get album {
    return Intl.message('Album', name: 'album', desc: '', args: []);
  }

  /// `Singles`
  String get singles {
    return Intl.message('Singles', name: 'singles', desc: '', args: []);
  }

  /// `Artists`
  String get artists {
    return Intl.message('Artists', name: 'artists', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Library`
  String get library {
    return Intl.message('Library', name: 'library', desc: '', args: []);
  }

  /// `Library Songs`
  String get libSongs {
    return Intl.message('Library Songs', name: 'libSongs', desc: '', args: []);
  }

  /// `Migrated library`
  String get migratedLibrary {
    return Intl.message(
      'Migrated library',
      name: 'migratedLibrary',
      desc: '',
      args: [],
    );
  }

  /// `There are no songs in this collection`
  String get noSongsInCollection {
    return Intl.message(
      'There are no songs in this collection',
      name: 'noSongsInCollection',
      desc: '',
      args: [],
    );
  }

  /// `Open on startup`
  String get startupScreen {
    return Intl.message(
      'Open on startup',
      name: 'startupScreen',
      desc: '',
      args: [],
    );
  }

  /// `Choose the section that Estrella Music opens first`
  String get startupScreenDescription {
    return Intl.message(
      'Choose the section that Estrella Music opens first',
      name: 'startupScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message('Friends', name: 'friends', desc: '', args: []);
  }

  /// `Daily discovery`
  String get dailyDiscover {
    return Intl.message(
      'Daily discovery',
      name: 'dailyDiscover',
      desc: '',
      args: [],
    );
  }

  /// `keep listening`
  String get keepListening {
    return Intl.message(
      'keep listening',
      name: 'keepListening',
      desc: '',
      args: [],
    );
  }

  /// `Similar to {title}`
  String similarToTitle(String title) {
    return Intl.message(
      'Similar to $title',
      name: 'similarToTitle',
      desc: '',
      args: [title],
    );
  }

  /// `Piped Playlist`
  String get pipedPlaylistDescription {
    return Intl.message(
      'Piped Playlist',
      name: 'pipedPlaylistDescription',
      desc: '',
      args: [],
    );
  }

  /// `Collaborative Playlist`
  String get collaborativePlaylistDescription {
    return Intl.message(
      'Collaborative Playlist',
      name: 'collaborativePlaylistDescription',
      desc: '',
      args: [],
    );
  }

  /// `Library Playlist`
  String get libraryPlaylistDescription {
    return Intl.message(
      'Library Playlist',
      name: 'libraryPlaylistDescription',
      desc: '',
      args: [],
    );
  }

  /// `Untitled song`
  String get untitledSong {
    return Intl.message(
      'Untitled song',
      name: 'untitledSong',
      desc: '',
      args: [],
    );
  }

  /// `Migrated Playlist`
  String get migratedPlaylist {
    return Intl.message(
      'Migrated Playlist',
      name: 'migratedPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Migrated album`
  String get migratedAlbum {
    return Intl.message(
      'Migrated album',
      name: 'migratedAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Songs imported from Joss Music Kotlin`
  String get songsImportedFromJossMusic {
    return Intl.message(
      'Songs imported from Joss Music Kotlin',
      name: 'songsImportedFromJossMusic',
      desc: '',
      args: [],
    );
  }

  /// `Imported from Joss Music Kotlin`
  String get importedFromJossMusic {
    return Intl.message(
      'Imported from Joss Music Kotlin',
      name: 'importedFromJossMusic',
      desc: '',
      args: [],
    );
  }

  /// `Local mode active`
  String get syncLocalModeActive {
    return Intl.message(
      'Local mode active',
      name: 'syncLocalModeActive',
      desc: '',
      args: [],
    );
  }

  /// `Cloud mode active. `
  String get syncCloudPending {
    return Intl.message(
      'Cloud mode active. ',
      name: 'syncCloudPending',
      desc: '',
      args: [],
    );
  }

  /// `Cloud mode activated. `
  String get syncCloudDownloadingExisting {
    return Intl.message(
      'Cloud mode activated. ',
      name: 'syncCloudDownloadingExisting',
      desc: '',
      args: [],
    );
  }

  /// `Cloud mode activated. `
  String get syncCloudMigrationComplete {
    return Intl.message(
      'Cloud mode activated. ',
      name: 'syncCloudMigrationComplete',
      desc: '',
      args: [],
    );
  }

  /// `Your data is kept only on this device.`
  String get syncLocalDeviceOnly {
    return Intl.message(
      'Your data is kept only on this device.',
      name: 'syncLocalDeviceOnly',
      desc: '',
      args: [],
    );
  }

  /// `Downloading EMusic changes...`
  String get syncDownloading {
    return Intl.message(
      'Downloading EMusic changes...',
      name: 'syncDownloading',
      desc: '',
      args: [],
    );
  }

  /// `Failed to download sync.`
  String get syncDownloadFailed {
    return Intl.message(
      'Failed to download sync.',
      name: 'syncDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `There are new local changes. `
  String get syncLocalChangesFirst {
    return Intl.message(
      'There are new local changes. ',
      name: 'syncLocalChangesFirst',
      desc: '',
      args: [],
    );
  }

  /// `Synchronized library.`
  String get syncLibrarySynced {
    return Intl.message(
      'Synchronized library.',
      name: 'syncLibrarySynced',
      desc: '',
      args: [],
    );
  }

  /// `Offline. `
  String get syncOfflinePending {
    return Intl.message(
      'Offline. ',
      name: 'syncOfflinePending',
      desc: '',
      args: [],
    );
  }

  /// `Library up to date.`
  String get syncLibraryUpToDate {
    return Intl.message(
      'Library up to date.',
      name: 'syncLibraryUpToDate',
      desc: '',
      args: [],
    );
  }

  /// `{count} synchronized changes.`
  String syncChangesSynced(int count) {
    return Intl.message(
      '$count synchronized changes.',
      name: 'syncChangesSynced',
      desc: '',
      args: [count],
    );
  }

  /// `Uploading changes to EMusic...`
  String get syncUploading {
    return Intl.message(
      'Uploading changes to EMusic...',
      name: 'syncUploading',
      desc: '',
      args: [],
    );
  }

  /// `Changes uploaded successfully (WS).`
  String get syncUploadSuccessWs {
    return Intl.message(
      'Changes uploaded successfully (WS).',
      name: 'syncUploadSuccessWs',
      desc: '',
      args: [],
    );
  }

  /// `Could not upload using WS. `
  String get syncUploadWsRetry {
    return Intl.message(
      'Could not upload using WS. ',
      name: 'syncUploadWsRetry',
      desc: '',
      args: [],
    );
  }

  /// `Changes uploaded correctly.`
  String get syncUploadSuccess {
    return Intl.message(
      'Changes uploaded correctly.',
      name: 'syncUploadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not get up. `
  String get syncUploadRetry {
    return Intl.message(
      'Could not get up. ',
      name: 'syncUploadRetry',
      desc: '',
      args: [],
    );
  }

  /// `Offline. `
  String get syncOfflineRetry {
    return Intl.message(
      'Offline. ',
      name: 'syncOfflineRetry',
      desc: '',
      args: [],
    );
  }

  /// `EMusic did not confirm all the changes. `
  String get syncUnconfirmedRetry {
    return Intl.message(
      'EMusic did not confirm all the changes. ',
      name: 'syncUnconfirmedRetry',
      desc: '',
      args: [],
    );
  }

  /// `{count} changes committed.`
  String syncChangesConfirmed(int count) {
    return Intl.message(
      '$count changes committed.',
      name: 'syncChangesConfirmed',
      desc: '',
      args: [count],
    );
  }

  /// `There is already a migration in progress.`
  String get migrationAlreadyRunning {
    return Intl.message(
      'There is already a migration in progress.',
      name: 'migrationAlreadyRunning',
      desc: '',
      args: [],
    );
  }

  /// `Log in to Joss Red before migrating.`
  String get migrationLoginRequired {
    return Intl.message(
      'Log in to Joss Red before migrating.',
      name: 'migrationLoginRequired',
      desc: '',
      args: [],
    );
  }

  /// `Checking if EMusic Cloud already has a library...`
  String get migrationCheckingCloud {
    return Intl.message(
      'Checking if EMusic Cloud already has a library...',
      name: 'migrationCheckingCloud',
      desc: '',
      args: [],
    );
  }

  /// `A cloud library was found. `
  String get cloudLibraryFoundDeviceWillDownload {
    return Intl.message(
      'A cloud library was found. ',
      name: 'cloudLibraryFoundDeviceWillDownload',
      desc: '',
      args: [],
    );
  }

  /// `Cloud library found.`
  String get cloudLibraryFound {
    return Intl.message(
      'Cloud library found.',
      name: 'cloudLibraryFound',
      desc: '',
      args: [],
    );
  }

  /// `Creating a local backup before connecting cloud...`
  String get migrationCreatingBackup {
    return Intl.message(
      'Creating a local backup before connecting cloud...',
      name: 'migrationCreatingBackup',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing the local library...`
  String get migrationAnalyzingLocal {
    return Intl.message(
      'Analyzing the local library...',
      name: 'migrationAnalyzingLocal',
      desc: '',
      args: [],
    );
  }

  /// `Preparing the migration in EMusic Cloud...`
  String get migrationPreparingCloud {
    return Intl.message(
      'Preparing the migration in EMusic Cloud...',
      name: 'migrationPreparingCloud',
      desc: '',
      args: [],
    );
  }

  /// `EMusic Cloud could not start the migration.`
  String get migrationStartFailed {
    return Intl.message(
      'EMusic Cloud could not start the migration.',
      name: 'migrationStartFailed',
      desc: '',
      args: [],
    );
  }

  /// `Uploading playlists, favorites and history...`
  String get migrationUploadingData {
    return Intl.message(
      'Uploading playlists, favorites and history...',
      name: 'migrationUploadingData',
      desc: '',
      args: [],
    );
  }

  /// `Not all data could be uploaded. `
  String get migrationUploadIncomplete {
    return Intl.message(
      'Not all data could be uploaded. ',
      name: 'migrationUploadIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `Verifying integrity in EMusic Cloud...`
  String get migrationVerifyingIntegrity {
    return Intl.message(
      'Verifying integrity in EMusic Cloud...',
      name: 'migrationVerifyingIntegrity',
      desc: '',
      args: [],
    );
  }

  /// `EMusic Cloud could not validate the migration.`
  String get migrationValidationFailed {
    return Intl.message(
      'EMusic Cloud could not validate the migration.',
      name: 'migrationValidationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Cloud mode is ready. `
  String get cloudModeReadyOfflineCache {
    return Intl.message(
      'Cloud mode is ready. ',
      name: 'cloudModeReadyOfflineCache',
      desc: '',
      args: [],
    );
  }

  /// `Migration completed.`
  String get migrationCompleted {
    return Intl.message(
      'Migration completed.',
      name: 'migrationCompleted',
      desc: '',
      args: [],
    );
  }

  /// `The migration failed. `
  String get migrationFailedLocalPreserved {
    return Intl.message(
      'The migration failed. ',
      name: 'migrationFailedLocalPreserved',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. `
  String get sessionExpiredLoginAgain {
    return Intl.message(
      'Your session has expired. ',
      name: 'sessionExpiredLoginAgain',
      desc: '',
      args: [],
    );
  }

  /// `The selected file was not found.`
  String get selectedFileNotFound {
    return Intl.message(
      'The selected file was not found.',
      name: 'selectedFileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get genericAlbum {
    return Intl.message('Album', name: 'genericAlbum', desc: '', args: []);
  }

  /// `Sign in to find friends.`
  String get friendsLoginRequired {
    return Intl.message(
      'Sign in to find friends.',
      name: 'friendsLoginRequired',
      desc: '',
      args: [],
    );
  }

  /// `The session does not contain a valid token.`
  String get invalidSessionToken {
    return Intl.message(
      'The session does not contain a valid token.',
      name: 'invalidSessionToken',
      desc: '',
      args: [],
    );
  }

  /// `Could not search for users ({statusCode}).`
  String userSearchFailed(int statusCode) {
    return Intl.message(
      'Could not search for users ($statusCode).',
      name: 'userSearchFailed',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Invalid server response.`
  String get invalidServerResponse {
    return Intl.message(
      'Invalid server response.',
      name: 'invalidServerResponse',
      desc: '',
      args: [],
    );
  }

  /// `The response does not contain a list of users.`
  String get userListMissing {
    return Intl.message(
      'The response does not contain a list of users.',
      name: 'userListMissing',
      desc: '',
      args: [],
    );
  }

  /// `Playlist contributors`
  String get playlistCollaboratorsTitle {
    return Intl.message(
      'Playlist contributors',
      name: 'playlistCollaboratorsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select the friends who will be able to see and edit this playlist:`
  String get collaboratorsInstruction {
    return Intl.message(
      'Select the friends who will be able to see and edit this playlist:',
      name: 'collaboratorsInstruction',
      desc: '',
      args: [],
    );
  }

  /// `You have no added friends on Joss Red.`
  String get noJossRedFriends {
    return Intl.message(
      'You have no added friends on Joss Red.',
      name: 'noJossRedFriends',
      desc: '',
      args: [],
    );
  }

  /// `Friend`
  String get friendFallback {
    return Intl.message('Friend', name: 'friendFallback', desc: '', args: []);
  }

  /// `Collaborators updated correctly.`
  String get collaboratorsUpdated {
    return Intl.message(
      'Collaborators updated correctly.',
      name: 'collaboratorsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Keep`
  String get save {
    return Intl.message('Keep', name: 'save', desc: '', args: []);
  }

  /// `Manage collaborators (friends)`
  String get manageCollaborators {
    return Intl.message(
      'Manage collaborators (friends)',
      name: 'manageCollaborators',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get done {
    return Intl.message('Ready', name: 'done', desc: '', args: []);
  }

  /// `Not authenticated`
  String get notAuthenticated {
    return Intl.message(
      'Not authenticated',
      name: 'notAuthenticated',
      desc: '',
      args: [],
    );
  }

  /// `Mistake`
  String get genericError {
    return Intl.message('Mistake', name: 'genericError', desc: '', args: []);
  }

  /// `Friend request sent`
  String get friendRequestSent {
    return Intl.message(
      'Friend request sent',
      name: 'friendRequestSent',
      desc: '',
      args: [],
    );
  }

  /// `Friend request accepted`
  String get friendRequestAccepted {
    return Intl.message(
      'Friend request accepted',
      name: 'friendRequestAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Friendship removed`
  String get friendshipRemoved {
    return Intl.message(
      'Friendship removed',
      name: 'friendshipRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Blocked user`
  String get userBlocked {
    return Intl.message(
      'Blocked user',
      name: 'userBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked user`
  String get userUnblocked {
    return Intl.message(
      'Unlocked user',
      name: 'userUnblocked',
      desc: '',
      args: [],
    );
  }

  /// `According to your tastes`
  String get artistsByTaste {
    return Intl.message(
      'According to your tastes',
      name: 'artistsByTaste',
      desc: '',
      args: [],
    );
  }

  /// `followed`
  String get followedArtists {
    return Intl.message(
      'followed',
      name: 'followedArtists',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommendedArtists {
    return Intl.message(
      'Recommended',
      name: 'recommendedArtists',
      desc: '',
      args: [],
    );
  }

  /// `According to your tastes`
  String get albumsByTaste {
    return Intl.message(
      'According to your tastes',
      name: 'albumsByTaste',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get savedAlbums {
    return Intl.message('Saved', name: 'savedAlbums', desc: '', args: []);
  }

  /// `Recommended`
  String get recommendedAlbums {
    return Intl.message(
      'Recommended',
      name: 'recommendedAlbums',
      desc: '',
      args: [],
    );
  }

  /// `Library Playlists`
  String get libPlaylists {
    return Intl.message(
      'Library Playlists',
      name: 'libPlaylists',
      desc: '',
      args: [],
    );
  }

  /// `Library Albums`
  String get libAlbums {
    return Intl.message(
      'Library Albums',
      name: 'libAlbums',
      desc: '',
      args: [],
    );
  }

  /// `Library Artists`
  String get libArtists {
    return Intl.message(
      'Library Artists',
      name: 'libArtists',
      desc: '',
      args: [],
    );
  }

  /// `Community Playlists`
  String get communityplaylists {
    return Intl.message(
      'Community Playlists',
      name: 'communityplaylists',
      desc: '',
      args: [],
    );
  }

  /// `Featured Playlists`
  String get featuredplaylists {
    return Intl.message(
      'Featured Playlists',
      name: 'featuredplaylists',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message('items', name: 'items', desc: '', args: []);
  }

  /// `Oops network error!`
  String get networkError1 {
    return Intl.message(
      'Oops network error!',
      name: 'networkError1',
      desc: '',
      args: [],
    );
  }

  /// `Retry!`
  String get retry {
    return Intl.message('Retry!', name: 'retry', desc: '', args: []);
  }

  /// `No offline songs!`
  String get noOfflineSong {
    return Intl.message(
      'No offline songs!',
      name: 'noOfflineSong',
      desc: '',
      args: [],
    );
  }

  /// `Recently Played`
  String get recentlyPlayed {
    return Intl.message(
      'Recently Played',
      name: 'recentlyPlayed',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Cached/Offline`
  String get cachedOrOffline {
    return Intl.message(
      'Cached/Offline',
      name: 'cachedOrOffline',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get downloads {
    return Intl.message('Downloads', name: 'downloads', desc: '', args: []);
  }

  /// `Empty playlist!`
  String get emptyPlaylist {
    return Intl.message(
      'Empty playlist!',
      name: 'emptyPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Enqueue all`
  String get enqueueAll {
    return Intl.message('Enqueue all', name: 'enqueueAll', desc: '', args: []);
  }

  /// `Rename Playlist`
  String get renamePlaylist {
    return Intl.message(
      'Rename Playlist',
      name: 'renamePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Remove playlist`
  String get removePlaylist {
    return Intl.message(
      'Remove playlist',
      name: 'removePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Create new playlist`
  String get CreateNewPlaylist {
    return Intl.message(
      'Create new playlist',
      name: 'CreateNewPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Rearrange playlist`
  String get reArrangePlaylist {
    return Intl.message(
      'Rearrange playlist',
      name: 'reArrangePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Rearrange songs`
  String get reArrangeSongs {
    return Intl.message(
      'Rearrange songs',
      name: 'reArrangeSongs',
      desc: '',
      args: [],
    );
  }

  /// `Select songs`
  String get selectSongs {
    return Intl.message(
      'Select songs',
      name: 'selectSongs',
      desc: '',
      args: [],
    );
  }

  /// `Select All`
  String get selectAll {
    return Intl.message('Select All', name: 'selectAll', desc: '', args: []);
  }

  /// `Remove multiple songs`
  String get removeMultiple {
    return Intl.message(
      'Remove multiple songs',
      name: 'removeMultiple',
      desc: '',
      args: [],
    );
  }

  /// `Add songs to playlist`
  String get addMultipleSongs {
    return Intl.message(
      'Add songs to playlist',
      name: 'addMultipleSongs',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Create & add`
  String get createnAdd {
    return Intl.message('Create & add', name: 'createnAdd', desc: '', args: []);
  }

  /// `No bookmarks!`
  String get noBookmarks {
    return Intl.message(
      'No bookmarks!',
      name: 'noBookmarks',
      desc: '',
      args: [],
    );
  }

  /// `Start radio`
  String get startRadio {
    return Intl.message('Start radio', name: 'startRadio', desc: '', args: []);
  }

  /// `Play next`
  String get playNext {
    return Intl.message('Play next', name: 'playNext', desc: '', args: []);
  }

  /// `Add to playlist`
  String get addToPlaylist {
    return Intl.message(
      'Add to playlist',
      name: 'addToPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any lib playlist!`
  String get noLibPlaylist {
    return Intl.message(
      'You don\'t have any lib playlist!',
      name: 'noLibPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Enqueue this song`
  String get enqueueSong {
    return Intl.message(
      'Enqueue this song',
      name: 'enqueueSong',
      desc: '',
      args: [],
    );
  }

  /// `Go to album`
  String get goToAlbum {
    return Intl.message('Go to album', name: 'goToAlbum', desc: '', args: []);
  }

  /// `View Artist`
  String get viewArtist {
    return Intl.message('View Artist', name: 'viewArtist', desc: '', args: []);
  }

  /// `Open in`
  String get openIn {
    return Intl.message('Open in', name: 'openIn', desc: '', args: []);
  }

  /// `Share this song`
  String get shareSong {
    return Intl.message(
      'Share this song',
      name: 'shareSong',
      desc: '',
      args: [],
    );
  }

  /// `Remove from playlist`
  String get removeFromPlaylist {
    return Intl.message(
      'Remove from playlist',
      name: 'removeFromPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Remove from queue`
  String get removeFromQueue {
    return Intl.message(
      'Remove from queue',
      name: 'removeFromQueue',
      desc: '',
      args: [],
    );
  }

  /// `Queue can't be shuffled when shuffle mode is enabled`
  String get queueShufflingDeniedMsg {
    return Intl.message(
      'Queue can\'t be shuffled when shuffle mode is enabled',
      name: 'queueShufflingDeniedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Queue can't be rearranged when shuffle mode is enabled`
  String get queuerearrangingDeniedMsg {
    return Intl.message(
      'Queue can\'t be rearranged when shuffle mode is enabled',
      name: 'queuerearrangingDeniedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Song is not playable due to server restriction!`
  String get songNotPlayable {
    return Intl.message(
      'Song is not playable due to server restriction!',
      name: 'songNotPlayable',
      desc: '',
      args: [],
    );
  }

  /// `Up Next`
  String get upNext {
    return Intl.message('Up Next', name: 'upNext', desc: '', args: []);
  }

  /// `PLAYING FROM ÁLBUM`
  String get playingfromAlbum {
    return Intl.message(
      'PLAYING FROM ÁLBUM',
      name: 'playingfromAlbum',
      desc: '',
      args: [],
    );
  }

  /// `PLAYING FROM PLAYLIST`
  String get playingfromPlaylist {
    return Intl.message(
      'PLAYING FROM PLAYLIST',
      name: 'playingfromPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `PLAYING FROM SELECTION`
  String get playingfromSelection {
    return Intl.message(
      'PLAYING FROM SELECTION',
      name: 'playingfromSelection',
      desc: '',
      args: [],
    );
  }

  /// `PLAYING FROM ARTIST`
  String get playingfromArtist {
    return Intl.message(
      'PLAYING FROM ARTIST',
      name: 'playingfromArtist',
      desc: '',
      args: [],
    );
  }

  /// `Random Selection`
  String get randomSelection {
    return Intl.message(
      'Random Selection',
      name: 'randomSelection',
      desc: '',
      args: [],
    );
  }

  /// `Random Radio`
  String get randomRadio {
    return Intl.message(
      'Random Radio',
      name: 'randomRadio',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get playnextMsg {
    return Intl.message('Upcoming', name: 'playnextMsg', desc: '', args: []);
  }

  /// `Shuffle Queue`
  String get shuffleQueue {
    return Intl.message(
      'Shuffle Queue',
      name: 'shuffleQueue',
      desc: '',
      args: [],
    );
  }

  /// `Queue loop`
  String get queueLoop {
    return Intl.message('Queue loop', name: 'queueLoop', desc: '', args: []);
  }

  /// `Queue loop mode cannot be disabled when shuffle mode is enabled.`
  String get queueLoopNotDisMsg1 {
    return Intl.message(
      'Queue loop mode cannot be disabled when shuffle mode is enabled.',
      name: 'queueLoopNotDisMsg1',
      desc: '',
      args: [],
    );
  }

  /// `Queue loop mode cannot be enabled in radio mode.`
  String get queueLoopNotDisMsg2 {
    return Intl.message(
      'Queue loop mode cannot be enabled in radio mode.',
      name: 'queueLoopNotDisMsg2',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Library Songs`
  String get removeFromLib {
    return Intl.message(
      'Remove from Library Songs',
      name: 'removeFromLib',
      desc: '',
      args: [],
    );
  }

  /// `Sleep Timer`
  String get sleepTimer {
    return Intl.message('Sleep Timer', name: 'sleepTimer', desc: '', args: []);
  }

  /// `Add 5 minutes`
  String get add5Minutes {
    return Intl.message(
      'Add 5 minutes',
      name: 'add5Minutes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel timer`
  String get cancelTimer {
    return Intl.message(
      'Cancel timer',
      name: 'cancelTimer',
      desc: '',
      args: [],
    );
  }

  /// `Remove from downloads`
  String get deleteDownloadData {
    return Intl.message(
      'Remove from downloads',
      name: 'deleteDownloadData',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message('minutes', name: 'minutes', desc: '', args: []);
  }

  /// `End of this song`
  String get endOfThisSong {
    return Intl.message(
      'End of this song',
      name: 'endOfThisSong',
      desc: '',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message('App Info', name: 'appInfo', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `Misc`
  String get misc {
    return Intl.message('Misc', name: 'misc', desc: '', args: []);
  }

  /// `Auto download favorite songs`
  String get autoDownFavSong {
    return Intl.message(
      'Auto download favorite songs',
      name: 'autoDownFavSong',
      desc: '',
      args: [],
    );
  }

  /// `Automatically download favorite songs when added to favorites`
  String get autoDownFavSongDes {
    return Intl.message(
      'Automatically download favorite songs when added to favorites',
      name: 'autoDownFavSongDes',
      desc: '',
      args: [],
    );
  }

  /// `Network error! Check your network connection.`
  String get networkError {
    return Intl.message(
      'Network error! Check your network connection.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Requested song is not downloadable due to server restriction. You may try again`
  String get downloadError2 {
    return Intl.message(
      'Requested song is not downloadable due to server restriction. You may try again',
      name: 'downloadError2',
      desc: '',
      args: [],
    );
  }

  /// `Downloading failed due to network/stream error! Please try again`
  String get downloadError3 {
    return Intl.message(
      'Downloading failed due to network/stream error! Please try again',
      name: 'downloadError3',
      desc: '',
      args: [],
    );
  }

  /// `Music & Playback`
  String get musicAndPlayback {
    return Intl.message(
      'Music & Playback',
      name: 'musicAndPlayback',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: '', args: []);
  }

  /// `Personalisation`
  String get personalisation {
    return Intl.message(
      'Personalisation',
      name: 'personalisation',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message('Theme Mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Dynamic`
  String get dynamic {
    return Intl.message('Dynamic', name: 'dynamic', desc: '', args: []);
  }

  /// `System default`
  String get systemDefault {
    return Intl.message(
      'System default',
      name: 'systemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Player Ui`
  String get playerUi {
    return Intl.message('Player Ui', name: 'playerUi', desc: '', args: []);
  }

  /// `Select player user interface`
  String get playerUiDes {
    return Intl.message(
      'Select player user interface',
      name: 'playerUiDes',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Gesture`
  String get gesture {
    return Intl.message('Gesture', name: 'gesture', desc: '', args: []);
  }

  /// `Set App language`
  String get languageDes {
    return Intl.message(
      'Set App language',
      name: 'languageDes',
      desc: '',
      args: [],
    );
  }

  /// `Set discover content`
  String get setDiscoverContent {
    return Intl.message(
      'Set discover content',
      name: 'setDiscoverContent',
      desc: '',
      args: [],
    );
  }

  /// `Quick Picks`
  String get quickpicks {
    return Intl.message('Quick Picks', name: 'quickpicks', desc: '', args: []);
  }

  /// `Discover`
  String get discover {
    return Intl.message('Discover', name: 'discover', desc: '', args: []);
  }

  /// `Trending`
  String get trending {
    return Intl.message('Trending', name: 'trending', desc: '', args: []);
  }

  /// `Top Music Videos`
  String get topmusicvideos {
    return Intl.message(
      'Top Music Videos',
      name: 'topmusicvideos',
      desc: '',
      args: [],
    );
  }

  /// `Based on last interaction`
  String get basedOnLast {
    return Intl.message(
      'Based on last interaction',
      name: 'basedOnLast',
      desc: '',
      args: [],
    );
  }

  /// `Restore last playback session`
  String get restoreLastPlaybackSession {
    return Intl.message(
      'Restore last playback session',
      name: 'restoreLastPlaybackSession',
      desc: '',
      args: [],
    );
  }

  /// `Automatically restore the last playback session on app start`
  String get restoreLastPlaybackSessionDes {
    return Intl.message(
      'Automatically restore the last playback session on app start',
      name: 'restoreLastPlaybackSessionDes',
      desc: '',
      args: [],
    );
  }

  /// `Auto open player screen`
  String get autoOpenPlayer {
    return Intl.message(
      'Auto open player screen',
      name: 'autoOpenPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Enable/disable auto opening of player full screen on selection of song for play`
  String get autoOpenPlayerDes {
    return Intl.message(
      'Enable/disable auto opening of player full screen on selection of song for play',
      name: 'autoOpenPlayerDes',
      desc: '',
      args: [],
    );
  }

  /// `Home content count`
  String get homeContentCount {
    return Intl.message(
      'Home content count',
      name: 'homeContentCount',
      desc: '',
      args: [],
    );
  }

  /// `Select the number of initial homescreen-content(approx). Lesser results faster loading`
  String get homeContentCountDes {
    return Intl.message(
      'Select the number of initial homescreen-content(approx). Lesser results faster loading',
      name: 'homeContentCountDes',
      desc: '',
      args: [],
    );
  }

  /// `Bottom navigation bar`
  String get enableBottomNav {
    return Intl.message(
      'Bottom navigation bar',
      name: 'enableBottomNav',
      desc: '',
      args: [],
    );
  }

  /// `Switch to bottom navigation bar`
  String get enableBottomNavDes {
    return Intl.message(
      'Switch to bottom navigation bar',
      name: 'enableBottomNavDes',
      desc: '',
      args: [],
    );
  }

  /// `Cache Songs`
  String get cacheSongs {
    return Intl.message('Cache Songs', name: 'cacheSongs', desc: '', args: []);
  }

  /// `Caching songs while playing for future/offline playback, it will take additional space on your device`
  String get cacheSongsDes {
    return Intl.message(
      'Caching songs while playing for future/offline playback, it will take additional space on your device',
      name: 'cacheSongsDes',
      desc: '',
      args: [],
    );
  }

  /// `Skip silence`
  String get skipSilence {
    return Intl.message(
      'Skip silence',
      name: 'skipSilence',
      desc: '',
      args: [],
    );
  }

  /// `Silence will be skipped in music playback`
  String get skipSilenceDes {
    return Intl.message(
      'Silence will be skipped in music playback',
      name: 'skipSilenceDes',
      desc: '',
      args: [],
    );
  }

  /// `Loudness normalization`
  String get loudnessNormalization {
    return Intl.message(
      'Loudness normalization',
      name: 'loudnessNormalization',
      desc: '',
      args: [],
    );
  }

  /// `Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))`
  String get loudnessNormalizationDes {
    return Intl.message(
      'Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))',
      name: 'loudnessNormalizationDes',
      desc: '',
      args: [],
    );
  }

  /// `Streaming quality`
  String get streamingQuality {
    return Intl.message(
      'Streaming quality',
      name: 'streamingQuality',
      desc: '',
      args: [],
    );
  }

  /// `Quality of music stream`
  String get streamingQualityDes {
    return Intl.message(
      'Quality of music stream',
      name: 'streamingQualityDes',
      desc: '',
      args: [],
    );
  }

  /// `Disable transition animation`
  String get disableTransitionAnimation {
    return Intl.message(
      'Disable transition animation',
      name: 'disableTransitionAnimation',
      desc: '',
      args: [],
    );
  }

  /// `Enable this option to disable tab transition animation`
  String get disableTransitionAnimationDes {
    return Intl.message(
      'Enable this option to disable tab transition animation',
      name: 'disableTransitionAnimationDes',
      desc: '',
      args: [],
    );
  }

  /// `Enable slidable actions`
  String get enableSlidableAction {
    return Intl.message(
      'Enable slidable actions',
      name: 'enableSlidableAction',
      desc: '',
      args: [],
    );
  }

  /// `Enable slidable actions on song tile`
  String get enableSlidableActionDes {
    return Intl.message(
      'Enable slidable actions on song tile',
      name: 'enableSlidableActionDes',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Background music play`
  String get backgroundPlay {
    return Intl.message(
      'Background music play',
      name: 'backgroundPlay',
      desc: '',
      args: [],
    );
  }

  /// `Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)`
  String get backgroundPlayDes {
    return Intl.message(
      'Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)',
      name: 'backgroundPlayDes',
      desc: '',
      args: [],
    );
  }

  /// `Download Location`
  String get downloadLocation {
    return Intl.message(
      'Download Location',
      name: 'downloadLocation',
      desc: '',
      args: [],
    );
  }

  /// `Cache home screen content data`
  String get cacheHomeScreenData {
    return Intl.message(
      'Cache home screen content data',
      name: 'cacheHomeScreenData',
      desc: '',
      args: [],
    );
  }

  /// `Enable Caching home screen content data, Home screen will load instantly if this option is enabled`
  String get cacheHomeScreenDataDes {
    return Intl.message(
      'Enable Caching home screen content data, Home screen will load instantly if this option is enabled',
      name: 'cacheHomeScreenDataDes',
      desc: '',
      args: [],
    );
  }

  /// `Downloading File Format`
  String get downloadingFormat {
    return Intl.message(
      'Downloading File Format',
      name: 'downloadingFormat',
      desc: '',
      args: [],
    );
  }

  /// `Select downloading file format. "Opus" will provide best quality`
  String get downloadingFormatDes {
    return Intl.message(
      'Select downloading file format. "Opus" will provide best quality',
      name: 'downloadingFormatDes',
      desc: '',
      args: [],
    );
  }

  /// `Export downloaded files`
  String get exportDowloadedFiles {
    return Intl.message(
      'Export downloaded files',
      name: 'exportDowloadedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Click here to export downloaded file from inApp dir to external dir`
  String get exportDowloadedFilesDes {
    return Intl.message(
      'Click here to export downloaded file from inApp dir to external dir',
      name: 'exportDowloadedFilesDes',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded file export location`
  String get exportedFileLocation {
    return Intl.message(
      'Downloaded file export location',
      name: 'exportedFileLocation',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message('Export', name: 'export', desc: '', args: []);
  }

  /// `Exporting...`
  String get exporting {
    return Intl.message('Exporting...', name: 'exporting', desc: '', args: []);
  }

  /// `Scanning...`
  String get scanning {
    return Intl.message('Scanning...', name: 'scanning', desc: '', args: []);
  }

  /// `downloaded files found`
  String get downFilesFound {
    return Intl.message(
      'downloaded files found',
      name: 'downFilesFound',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Files successfully exported`
  String get exportMsg {
    return Intl.message(
      'Files successfully exported',
      name: 'exportMsg',
      desc: '',
      args: [],
    );
  }

  /// `Equalizer`
  String get equalizer {
    return Intl.message('Equalizer', name: 'equalizer', desc: '', args: []);
  }

  /// `Open system equalizer`
  String get equalizerDes {
    return Intl.message(
      'Open system equalizer',
      name: 'equalizerDes',
      desc: '',
      args: [],
    );
  }

  /// `Clear images cache`
  String get clearImgCache {
    return Intl.message(
      'Clear images cache',
      name: 'clearImgCache',
      desc: '',
      args: [],
    );
  }

  /// `Images cache cleared successfully`
  String get clearImgCacheAlert {
    return Intl.message(
      'Images cache cleared successfully',
      name: 'clearImgCacheAlert',
      desc: '',
      args: [],
    );
  }

  /// `Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)`
  String get clearImgCacheDes {
    return Intl.message(
      'Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)',
      name: 'clearImgCacheDes',
      desc: '',
      args: [],
    );
  }

  /// `Ignore battery optimization`
  String get ignoreBatOpt {
    return Intl.message(
      'Ignore battery optimization',
      name: 'ignoreBatOpt',
      desc: '',
      args: [],
    );
  }

  /// `If you are facing notification issues or playback stopped by system optimization, please enable this option`
  String get ignoreBatOptDes {
    return Intl.message(
      'If you are facing notification issues or playback stopped by system optimization, please enable this option',
      name: 'ignoreBatOptDes',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Enabled`
  String get enabled {
    return Intl.message('Enabled', name: 'enabled', desc: '', args: []);
  }

  /// `Disabled`
  String get disabled {
    return Intl.message('Disabled', name: 'disabled', desc: '', args: []);
  }

  /// `Restore default settings`
  String get resetToDefault {
    return Intl.message(
      'Restore default settings',
      name: 'resetToDefault',
      desc: '',
      args: [],
    );
  }

  /// `Reset app settings to default (Restart required)`
  String get resetToDefaultDes {
    return Intl.message(
      'Reset app settings to default (Restart required)',
      name: 'resetToDefaultDes',
      desc: '',
      args: [],
    );
  }

  /// `Settings reset to default completed, Please restart app`
  String get resetToDefaultMsg {
    return Intl.message(
      'Settings reset to default completed, Please restart app',
      name: 'resetToDefaultMsg',
      desc: '',
      args: [],
    );
  }

  /// `GitHub`
  String get github {
    return Intl.message('GitHub', name: 'github', desc: '', args: []);
  }

  /// `View GitHub source code \nif you like this project, don't forget to give a ⭐`
  String get githubDes {
    return Intl.message(
      'View GitHub source code \nif you like this project, don\'t forget to give a ⭐',
      name: 'githubDes',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message('by', name: 'by', desc: '', args: []);
  }

  /// `Url detected click on it to open/play associated content`
  String get urlSearchDes {
    return Intl.message(
      'Url detected click on it to open/play associated content',
      name: 'urlSearchDes',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Songs, Playlist, Album or Artist`
  String get searchDes {
    return Intl.message(
      'Songs, Playlist, Album or Artist',
      name: 'searchDes',
      desc: '',
      args: [],
    );
  }

  /// `Search results`
  String get searchRes {
    return Intl.message(
      'Search results',
      name: 'searchRes',
      desc: '',
      args: [],
    );
  }

  /// `for`
  String get for1 {
    return Intl.message('for', name: 'for1', desc: '', args: []);
  }

  /// `Videos`
  String get videos {
    return Intl.message('Videos', name: 'videos', desc: '', args: []);
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: '', args: []);
  }

  /// `Results`
  String get results {
    return Intl.message('Results', name: 'results', desc: '', args: []);
  }

  /// `No Match found for`
  String get nomatch {
    return Intl.message(
      'No Match found for',
      name: 'nomatch',
      desc: '',
      args: [],
    );
  }

  /// `subscribers`
  String get subscribers {
    return Intl.message('subscribers', name: 'subscribers', desc: '', args: []);
  }

  /// `Synced`
  String get synced {
    return Intl.message('Synced', name: 'synced', desc: '', args: []);
  }

  /// `Plain`
  String get plain {
    return Intl.message('Plain', name: 'plain', desc: '', args: []);
  }

  /// `Song Info`
  String get songInfo {
    return Intl.message('Song Info', name: 'songInfo', desc: '', args: []);
  }

  /// `Id`
  String get id {
    return Intl.message('Id', name: 'id', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Audio Codec`
  String get audioCodec {
    return Intl.message('Audio Codec', name: 'audioCodec', desc: '', args: []);
  }

  /// `Bitrate`
  String get bitrate {
    return Intl.message('Bitrate', name: 'bitrate', desc: '', args: []);
  }

  /// `LoudnessDb`
  String get loudnessDb {
    return Intl.message('LoudnessDb', name: 'loudnessDb', desc: '', args: []);
  }

  /// `Successfully removed from downloads!`
  String get deleteDownloadedDataAlert {
    return Intl.message(
      'Successfully removed from downloads!',
      name: 'deleteDownloadedDataAlert',
      desc: '',
      args: [],
    );
  }

  /// `Sleep timer cancelled`
  String get cancelTimerAlert {
    return Intl.message(
      'Sleep timer cancelled',
      name: 'cancelTimerAlert',
      desc: '',
      args: [],
    );
  }

  /// `Your sleep timer is set`
  String get sleepTimeSetAlert {
    return Intl.message(
      'Your sleep timer is set',
      name: 'sleepTimeSetAlert',
      desc: '',
      args: [],
    );
  }

  /// `Radio not available for this artist!`
  String get radioNotAvailable {
    return Intl.message(
      'Radio not available for this artist!',
      name: 'radioNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Removed from queue!`
  String get songRemovedfromQueue {
    return Intl.message(
      'Removed from queue!',
      name: 'songRemovedfromQueue',
      desc: '',
      args: [],
    );
  }

  /// `You can't remove currently playing song`
  String get songRemovedfromQueueCurrSong {
    return Intl.message(
      'You can\'t remove currently playing song',
      name: 'songRemovedfromQueueCurrSong',
      desc: '',
      args: [],
    );
  }

  /// `Song added to playlist!`
  String get songAddedToPlaylistAlert {
    return Intl.message(
      'Song added to playlist!',
      name: 'songAddedToPlaylistAlert',
      desc: '',
      args: [],
    );
  }

  /// `Song already exists!`
  String get songAlreadyExists {
    return Intl.message(
      'Song already exists!',
      name: 'songAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Song already offline in cache`
  String get songAlreadyOfflineAlert {
    return Intl.message(
      'Song already offline in cache',
      name: 'songAlreadyOfflineAlert',
      desc: '',
      args: [],
    );
  }

  /// `Song enqueued!`
  String get songEnqueueAlert {
    return Intl.message(
      'Song enqueued!',
      name: 'songEnqueueAlert',
      desc: '',
      args: [],
    );
  }

  /// `Removed from`
  String get songRemovedAlert {
    return Intl.message(
      'Removed from',
      name: 'songRemovedAlert',
      desc: '',
      args: [],
    );
  }

  /// `Some error occured!`
  String get errorOccuredAlert {
    return Intl.message(
      'Some error occured!',
      name: 'errorOccuredAlert',
      desc: '',
      args: [],
    );
  }

  /// `Piped playlist synced!`
  String get pipedplstSyncAlert {
    return Intl.message(
      'Piped playlist synced!',
      name: 'pipedplstSyncAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist created!`
  String get playlistCreatedAlert {
    return Intl.message(
      'Playlist created!',
      name: 'playlistCreatedAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist created & song added!`
  String get playlistCreatednsongAddedAlert {
    return Intl.message(
      'Playlist created & song added!',
      name: 'playlistCreatednsongAddedAlert',
      desc: '',
      args: [],
    );
  }

  /// `Renamed successfully!`
  String get playlistRenameAlert {
    return Intl.message(
      'Renamed successfully!',
      name: 'playlistRenameAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist removed!`
  String get playlistRemovedAlert {
    return Intl.message(
      'Playlist removed!',
      name: 'playlistRemovedAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist bookmarked!`
  String get playlistBookmarkAddAlert {
    return Intl.message(
      'Playlist bookmarked!',
      name: 'playlistBookmarkAddAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist bookmark removed!`
  String get playlistBookmarkRemoveAlert {
    return Intl.message(
      'Playlist bookmark removed!',
      name: 'playlistBookmarkRemoveAlert',
      desc: '',
      args: [],
    );
  }

  /// `Album bookmarked!`
  String get albumBookmarkAddAlert {
    return Intl.message(
      'Album bookmarked!',
      name: 'albumBookmarkAddAlert',
      desc: '',
      args: [],
    );
  }

  /// `Album bookmark removed!`
  String get albumBookmarkRemoveAlert {
    return Intl.message(
      'Album bookmark removed!',
      name: 'albumBookmarkRemoveAlert',
      desc: '',
      args: [],
    );
  }

  /// `Artist bookmarked!`
  String get artistBookmarkAddAlert {
    return Intl.message(
      'Artist bookmarked!',
      name: 'artistBookmarkAddAlert',
      desc: '',
      args: [],
    );
  }

  /// `Artist bookmark removed!`
  String get artistBookmarkRemoveAlert {
    return Intl.message(
      'Artist bookmark removed!',
      name: 'artistBookmarkRemoveAlert',
      desc: '',
      args: [],
    );
  }

  /// `Lyrics not available!`
  String get lyricsNotAvailable {
    return Intl.message(
      'Lyrics not available!',
      name: 'lyricsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Synced lyrics not available!`
  String get syncedLyricsNotAvailable {
    return Intl.message(
      'Synced lyrics not available!',
      name: 'syncedLyricsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Description not available!`
  String get artistDesNotAvailable {
    return Intl.message(
      'Description not available!',
      name: 'artistDesNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `New version available!`
  String get newVersionAvailable {
    return Intl.message(
      'New version available!',
      name: 'newVersionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Don't show this info again`
  String get dontShowInfoAgain {
    return Intl.message(
      'Don\'t show this info again',
      name: 'dontShowInfoAgain',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: '', args: []);
  }

  /// `Not a Song/Music-Video!`
  String get notaSongVideo {
    return Intl.message(
      'Not a Song/Music-Video!',
      name: 'notaSongVideo',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid link!`
  String get notaValidLink {
    return Intl.message(
      'Not a valid link!',
      name: 'notaValidLink',
      desc: '',
      args: [],
    );
  }

  /// `Operation failed`
  String get operationFailed {
    return Intl.message(
      'Operation failed',
      name: 'operationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Click here to go to download page`
  String get goToDownloadPage {
    return Intl.message(
      'Click here to go to download page',
      name: 'goToDownloadPage',
      desc: '',
      args: [],
    );
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: '', args: []);
  }

  /// `Piped`
  String get Piped {
    return Intl.message('Piped', name: 'Piped', desc: '', args: []);
  }

  /// `Link`
  String get link {
    return Intl.message('Link', name: 'link', desc: '', args: []);
  }

  /// `Unlink`
  String get unLink {
    return Intl.message('Unlink', name: 'unLink', desc: '', args: []);
  }

  /// `API URL to Piped instance`
  String get hintApiUrl {
    return Intl.message(
      'API URL to Piped instance',
      name: 'hintApiUrl',
      desc: '',
      args: [],
    );
  }

  /// `Custom Instance`
  String get customIns {
    return Intl.message(
      'Custom Instance',
      name: 'customIns',
      desc: '',
      args: [],
    );
  }

  /// `Please select Custom Instance`
  String get customInsSelectMsg {
    return Intl.message(
      'Please select Custom Instance',
      name: 'customInsSelectMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please select Authentication instance!`
  String get selectAuthInsMsg {
    return Intl.message(
      'Please select Authentication instance!',
      name: 'selectAuthInsMsg',
      desc: '',
      args: [],
    );
  }

  /// `All fields required`
  String get allFieldsReqMsg {
    return Intl.message(
      'All fields required',
      name: 'allFieldsReqMsg',
      desc: '',
      args: [],
    );
  }

  /// `Link with piped for playlists`
  String get linkPipedDes {
    return Intl.message(
      'Link with piped for playlists',
      name: 'linkPipedDes',
      desc: '',
      args: [],
    );
  }

  /// `Select Auth Instance`
  String get selectAuthIns {
    return Intl.message(
      'Select Auth Instance',
      name: 'selectAuthIns',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Linked successfully!`
  String get linkAlert {
    return Intl.message(
      'Linked successfully!',
      name: 'linkAlert',
      desc: '',
      args: [],
    );
  }

  /// `Unlinked successfully!`
  String get unlinkAlert {
    return Intl.message(
      'Unlinked successfully!',
      name: 'unlinkAlert',
      desc: '',
      args: [],
    );
  }

  /// `Playlist blacklisted!`
  String get playlistBlacklistAlert {
    return Intl.message(
      'Playlist blacklisted!',
      name: 'playlistBlacklistAlert',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Reset successfully!`
  String get blacklistPlstResetAlert {
    return Intl.message(
      'Reset successfully!',
      name: 'blacklistPlstResetAlert',
      desc: '',
      args: [],
    );
  }

  /// `Reset blacklisted playlists`
  String get resetblacklistedplaylist {
    return Intl.message(
      'Reset blacklisted playlists',
      name: 'resetblacklistedplaylist',
      desc: '',
      args: [],
    );
  }

  /// `Reset all the piped blacklisted playlists`
  String get resetblacklistedplaylistDes {
    return Intl.message(
      'Reset all the piped blacklisted playlists',
      name: 'resetblacklistedplaylistDes',
      desc: '',
      args: [],
    );
  }

  /// `Stop music on task clear`
  String get stopMusicOnTaskClear {
    return Intl.message(
      'Stop music on task clear',
      name: 'stopMusicOnTaskClear',
      desc: '',
      args: [],
    );
  }

  /// `Music playback will stop when App being swiped away from the task manager`
  String get stopMusicOnTaskClearDes {
    return Intl.message(
      'Music playback will stop when App being swiped away from the task manager',
      name: 'stopMusicOnTaskClearDes',
      desc: '',
      args: [],
    );
  }

  /// `Backup App data`
  String get backupAppData {
    return Intl.message(
      'Backup App data',
      name: 'backupAppData',
      desc: '',
      args: [],
    );
  }

  /// `Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.`
  String get androidBackupWarning {
    return Intl.message(
      'Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.',
      name: 'androidBackupWarning',
      desc: '',
      args: [],
    );
  }

  /// `Saves all settings, playlists and login data in a backup file`
  String get backupSettingsAndPlaylistsDes {
    return Intl.message(
      'Saves all settings, playlists and login data in a backup file',
      name: 'backupSettingsAndPlaylistsDes',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Let's start..`
  String get letsStrart {
    return Intl.message(
      'Let\'s start..',
      name: 'letsStrart',
      desc: '',
      args: [],
    );
  }

  /// `Processing files...`
  String get processFiles {
    return Intl.message(
      'Processing files...',
      name: 'processFiles',
      desc: '',
      args: [],
    );
  }

  /// `Include downloded songs files`
  String get includeDownloadedFiles {
    return Intl.message(
      'Include downloded songs files',
      name: 'includeDownloadedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Backup in progress...`
  String get backupInProgress {
    return Intl.message(
      'Backup in progress...',
      name: 'backupInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Restore App data`
  String get restoreAppData {
    return Intl.message(
      'Restore App data',
      name: 'restoreAppData',
      desc: '',
      args: [],
    );
  }

  /// `Restores all settings, login data and playlists from a backup file. Overwrites all current data`
  String get restoreSettingsAndPlaylistsDes {
    return Intl.message(
      'Restores all settings, login data and playlists from a backup file. Overwrites all current data',
      name: 'restoreSettingsAndPlaylistsDes',
      desc: '',
      args: [],
    );
  }

  /// `Backup successfully saved!`
  String get backupMsg {
    return Intl.message(
      'Backup successfully saved!',
      name: 'backupMsg',
      desc: '',
      args: [],
    );
  }

  /// `databases found`
  String get backFilesFound {
    return Intl.message(
      'databases found',
      name: 'backFilesFound',
      desc: '',
      args: [],
    );
  }

  /// `Successfully restored!\nChanges are applied on restart`
  String get restoreMsg {
    return Intl.message(
      'Successfully restored!\nChanges are applied on restart',
      name: 'restoreMsg',
      desc: '',
      args: [],
    );
  }

  /// `Restoring...`
  String get restoring {
    return Intl.message('Restoring...', name: 'restoring', desc: '', args: []);
  }

  /// `Restore`
  String get restore {
    return Intl.message('Restore', name: 'restore', desc: '', args: []);
  }

  /// `Close App`
  String get closeApp {
    return Intl.message('Close App', name: 'closeApp', desc: '', args: []);
  }

  /// `Restart App`
  String get restartApp {
    return Intl.message('Restart App', name: 'restartApp', desc: '', args: []);
  }

  /// `Lyrics`
  String get lyrics {
    return Intl.message('Lyrics', name: 'lyrics', desc: '', args: []);
  }

  /// `Export Playlist`
  String get exportPlaylist {
    return Intl.message(
      'Export Playlist',
      name: 'exportPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Export Playlist as CSV`
  String get exportPlaylistCsv {
    return Intl.message(
      'Export Playlist as CSV',
      name: 'exportPlaylistCsv',
      desc: '',
      args: [],
    );
  }

  /// `Exporting playlist...`
  String get exportingPlaylist {
    return Intl.message(
      'Exporting playlist...',
      name: 'exportingPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Playlist exported successfully to`
  String get playlistExportedMsg {
    return Intl.message(
      'Playlist exported successfully to',
      name: 'playlistExportedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Error exporting playlist`
  String get exportError {
    return Intl.message(
      'Error exporting playlist',
      name: 'exportError',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied while exporting`
  String get exportErrorPermission {
    return Intl.message(
      'Permission denied while exporting',
      name: 'exportErrorPermission',
      desc: '',
      args: [],
    );
  }

  /// `Not enough storage space`
  String get exportErrorStorage {
    return Intl.message(
      'Not enough storage space',
      name: 'exportErrorStorage',
      desc: '',
      args: [],
    );
  }

  /// `Error formatting playlist data`
  String get exportErrorFormat {
    return Intl.message(
      'Error formatting playlist data',
      name: 'exportErrorFormat',
      desc: '',
      args: [],
    );
  }

  /// `Import Playlist`
  String get importPlaylist {
    return Intl.message(
      'Import Playlist',
      name: 'importPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Importing playlist...`
  String get importingPlaylist {
    return Intl.message(
      'Importing playlist...',
      name: 'importingPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Select a previously exported playlist JSON file to import`
  String get importPlaylistDesc {
    return Intl.message(
      'Select a previously exported playlist JSON file to import',
      name: 'importPlaylistDesc',
      desc: '',
      args: [],
    );
  }

  /// `Select File`
  String get selectFile {
    return Intl.message('Select File', name: 'selectFile', desc: '', args: []);
  }

  /// `Playlist imported successfully`
  String get playlistImportedMsg {
    return Intl.message(
      'Playlist imported successfully',
      name: 'playlistImportedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Error importing playlist`
  String get importError {
    return Intl.message(
      'Error importing playlist',
      name: 'importError',
      desc: '',
      args: [],
    );
  }

  /// `Could not access the selected file`
  String get importErrorFileAccess {
    return Intl.message(
      'Could not access the selected file',
      name: 'importErrorFileAccess',
      desc: '',
      args: [],
    );
  }

  /// `Invalid file format`
  String get importErrorFormat {
    return Intl.message(
      'Invalid file format',
      name: 'importErrorFormat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid playlist file structure`
  String get invalidPlaylistFile {
    return Intl.message(
      'Invalid playlist file structure',
      name: 'invalidPlaylistFile',
      desc: '',
      args: [],
    );
  }

  /// `Error saving to database`
  String get importErrorDatabase {
    return Intl.message(
      'Error saving to database',
      name: 'importErrorDatabase',
      desc: '',
      args: [],
    );
  }

  /// `File not found`
  String get fileNotFound {
    return Intl.message(
      'File not found',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Note: Large playlists may take longer to import`
  String get importLargeFileNote {
    return Intl.message(
      'Note: Large playlists may take longer to import',
      name: 'importLargeFileNote',
      desc: '',
      args: [],
    );
  }

  /// `Export playlist to JSON`
  String get exportPlaylistJson {
    return Intl.message(
      'Export playlist to JSON',
      name: 'exportPlaylistJson',
      desc: '',
      args: [],
    );
  }

  /// `This format can be imported`
  String get exportPlaylistJsonSubtitle {
    return Intl.message(
      'This format can be imported',
      name: 'exportPlaylistJsonSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Can't be imported here`
  String get exportPlaylistCsvSubtitle {
    return Intl.message(
      'Can\'t be imported here',
      name: 'exportPlaylistCsvSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Export to Youtube music`
  String get exportToYouTubeMusic {
    return Intl.message(
      'Export to Youtube music',
      name: 'exportToYouTubeMusic',
      desc: '',
      args: [],
    );
  }

  /// `It will push your playlist (songs < 50) to current queue, don't forget to add to playlist/save after opening in YtMusic`
  String get exportToYouTubeMusicSubtitle {
    return Intl.message(
      'It will push your playlist (songs < 50) to current queue, don\'t forget to add to playlist/save after opening in YtMusic',
      name: 'exportToYouTubeMusicSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Link copied to clipboard`
  String get linkCopied {
    return Intl.message(
      'Link copied to clipboard',
      name: 'linkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Keep screen on while playing`
  String get keepScreenOnWhilePlaying {
    return Intl.message(
      'Keep screen on while playing',
      name: 'keepScreenOnWhilePlaying',
      desc: '',
      args: [],
    );
  }

  /// `If enabled, the device screen will stay awake while music is playing`
  String get keepScreenOnWhilePlayingDes {
    return Intl.message(
      'If enabled, the device screen will stay awake while music is playing',
      name: 'keepScreenOnWhilePlayingDes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Podcasts`
  String get podcasts {
    return Intl.message('Podcasts', name: 'podcasts', desc: '', args: []);
  }

  /// `Episodes`
  String get episodes {
    return Intl.message('Episodes', name: 'episodes', desc: '', args: []);
  }

  /// `Profiles`
  String get profiles {
    return Intl.message('Profiles', name: 'profiles', desc: '', args: []);
  }

  /// `Return`
  String get back {
    return Intl.message('Return', name: 'back', desc: '', args: []);
  }

  /// `Add to Library`
  String get addToLibrary {
    return Intl.message(
      'Add to Library',
      name: 'addToLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Library`
  String get removeFromLibrary {
    return Intl.message(
      'Remove from Library',
      name: 'removeFromLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message('Play', name: 'play', desc: '', args: []);
  }

  /// `Enqueue album songs`
  String get enqueueAlbumSongs {
    return Intl.message(
      'Enqueue album songs',
      name: 'enqueueAlbumSongs',
      desc: '',
      args: [],
    );
  }

  /// `Download album songs`
  String get downloadAlbumSongs {
    return Intl.message(
      'Download album songs',
      name: 'downloadAlbumSongs',
      desc: '',
      args: [],
    );
  }

  /// `Share album`
  String get shareAlbum {
    return Intl.message('Share album', name: 'shareAlbum', desc: '', args: []);
  }

  /// `Imported`
  String get imported {
    return Intl.message('Imported', name: 'imported', desc: '', args: []);
  }

  /// `Imported Playlist`
  String get importedPlaylist {
    return Intl.message(
      'Imported Playlist',
      name: 'importedPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Enqueue songs`
  String get enqueueSongs {
    return Intl.message(
      'Enqueue songs',
      name: 'enqueueSongs',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle`
  String get shuffle {
    return Intl.message('Shuffle', name: 'shuffle', desc: '', args: []);
  }

  /// `Download playlist`
  String get downloadPlaylist {
    return Intl.message(
      'Download playlist',
      name: 'downloadPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Sync playlist songs`
  String get syncPlaylistSongs {
    return Intl.message(
      'Sync playlist songs',
      name: 'syncPlaylistSongs',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist playlist`
  String get blacklistPipedPlaylist {
    return Intl.message(
      'Blacklist playlist',
      name: 'blacklistPipedPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Share playlist`
  String get sharePlaylist {
    return Intl.message(
      'Share playlist',
      name: 'sharePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Playlist`
  String get playlist {
    return Intl.message('Playlist', name: 'playlist', desc: '', args: []);
  }

  /// `Sort by Name`
  String get sortByName {
    return Intl.message('Sort by Name', name: 'sortByName', desc: '', args: []);
  }

  /// `Sort by Date`
  String get sortByDate {
    return Intl.message('Sort by Date', name: 'sortByDate', desc: '', args: []);
  }

  /// `Sort by Duration`
  String get sortByDuration {
    return Intl.message(
      'Sort by Duration',
      name: 'sortByDuration',
      desc: '',
      args: [],
    );
  }

  /// `Sort ascending/descending`
  String get sortAscendNDescend {
    return Intl.message(
      'Sort ascending/descending',
      name: 'sortAscendNDescend',
      desc: '',
      args: [],
    );
  }

  /// `Successfully logged in`
  String get auth_login_success {
    return Intl.message(
      'Successfully logged in',
      name: 'auth_login_success',
      desc: '',
      args: [],
    );
  }

  /// `Cloud backup`
  String get settings_cloud_backup {
    return Intl.message(
      'Cloud backup',
      name: 'settings_cloud_backup',
      desc: '',
      args: [],
    );
  }

  /// `Migrate from Joss Music Kotlin`
  String get settings_migration_title {
    return Intl.message(
      'Migrate from Joss Music Kotlin',
      name: 'settings_migration_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to perform a backup?`
  String get backup_confirm_question {
    return Intl.message(
      'Do you want to perform a backup?',
      name: 'backup_confirm_question',
      desc: '',
      args: [],
    );
  }

  /// `Choose which data to backup`
  String get backup_selection_prompt {
    return Intl.message(
      'Choose which data to backup',
      name: 'backup_selection_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Recent searches`
  String get search_recent_title {
    return Intl.message(
      'Recent searches',
      name: 'search_recent_title',
      desc: '',
      args: [],
    );
  }

  /// `I forgot my password`
  String get auth_forgot_password {
    return Intl.message(
      'I forgot my password',
      name: 'auth_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get auth_btn_login {
    return Intl.message('Login', name: 'auth_btn_login', desc: '', args: []);
  }

  /// `Register`
  String get auth_btn_register {
    return Intl.message(
      'Register',
      name: 'auth_btn_register',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message('E-mail', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password_text {
    return Intl.message(
      'Password',
      name: 'password_text',
      desc: 'Contraseña texto traducido',
      args: [],
    );
  }

  /// `Confirm Password`
  String get auth_confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'auth_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Estrella Music`
  String get auth_welcome_title {
    return Intl.message(
      'Welcome to Estrella Music',
      name: 'auth_welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Estrella Music`
  String get auth_welcome_subtitle {
    return Intl.message(
      'Welcome to Estrella Music',
      name: 'auth_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get auth_first_name {
    return Intl.message(
      'First name',
      name: 'auth_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get auth_last_name {
    return Intl.message(
      'Last name',
      name: 'auth_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Acepto usar mis datos...`
  String get auth_agree_personal_data {
    return Intl.message(
      'Acepto usar mis datos...',
      name: 'auth_agree_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get settings_general_section {
    return Intl.message(
      'General',
      name: 'settings_general_section',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get settings_logout {
    return Intl.message('Log out', name: 'settings_logout', desc: '', args: []);
  }

  /// `Upload, restore and manage...`
  String get settings_cloud_backup_desc {
    return Intl.message(
      'Upload, restore and manage...',
      name: 'settings_cloud_backup_desc',
      desc: '',
      args: [],
    );
  }

  /// `Import playlists, songs...`
  String get settings_migration_desc {
    return Intl.message(
      'Import playlists, songs...',
      name: 'settings_migration_desc',
      desc: '',
      args: [],
    );
  }

  /// `Migration completed from {source}.`
  String migration_summary_start(String source) {
    return Intl.message(
      'Migration completed from $source.',
      name: 'migration_summary_start',
      desc: '',
      args: [source],
    );
  }

  /// `Playlists: {count}`
  String migration_summary_playlists(num count) {
    return Intl.message(
      'Playlists: $count',
      name: 'migration_summary_playlists',
      desc: '',
      args: [count],
    );
  }

  /// `Songs: {count}`
  String migration_summary_songs(num count) {
    return Intl.message(
      'Songs: $count',
      name: 'migration_summary_songs',
      desc: '',
      args: [count],
    );
  }

  /// `Favorites: {count}`
  String migration_summary_favorites(num count) {
    return Intl.message(
      'Favorites: $count',
      name: 'migration_summary_favorites',
      desc: '',
      args: [count],
    );
  }

  /// `Albums: {count}`
  String migration_summary_albums(num count) {
    return Intl.message(
      'Albums: $count',
      name: 'migration_summary_albums',
      desc: '',
      args: [count],
    );
  }

  /// `Artists: {count}`
  String migration_summary_artists(num count) {
    return Intl.message(
      'Artists: $count',
      name: 'migration_summary_artists',
      desc: '',
      args: [count],
    );
  }

  /// `Select song.db or a .backup file`
  String get migration_select_file_dialog {
    return Intl.message(
      'Select song.db or a .backup file',
      name: 'migration_select_file_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Migration completed successfully.`
  String get migration_success {
    return Intl.message(
      'Migration completed successfully.',
      name: 'migration_success',
      desc: '',
      args: [],
    );
  }

  /// `Select backup file folder`
  String get backup_select_folder_dialog {
    return Intl.message(
      'Select backup file folder',
      name: 'backup_select_folder_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Select backup file`
  String get restore_select_file_dialog {
    return Intl.message(
      'Select backup file',
      name: 'restore_select_file_dialog',
      desc: '',
      args: [],
    );
  }

  /// `name@email.com`
  String get auth_hint_email {
    return Intl.message(
      'name@email.com',
      name: 'auth_hint_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email.`
  String get auth_error_invalid_email {
    return Intl.message(
      'Enter a valid email.',
      name: 'auth_error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Upload a .hmb backup to the server and restore any saved backups if needed.`
  String get settings_cloud_backup_dialog_desc {
    return Intl.message(
      'Upload a .hmb backup to the server and restore any saved backups if needed.',
      name: 'settings_cloud_backup_dialog_desc',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `In App storage directory`
  String get in_app_storage {
    return Intl.message(
      'In App storage directory',
      name: 'in_app_storage',
      desc: '',
      args: [],
    );
  }

  /// `We brought the login, registration, and password recovery from the previous project, adapted for this music app.`
  String get auth_brand_description_1 {
    return Intl.message(
      'We brought the login, registration, and password recovery from the previous project, adapted for this music app.',
      name: 'auth_brand_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Your session lives in secure storage and is validated with the same backend you already used.`
  String get auth_brand_description_2 {
    return Intl.message(
      'Your session lives in secure storage and is validated with the same backend you already used.',
      name: 'auth_brand_description_2',
      desc: '',
      args: [],
    );
  }

  /// `The .env file needs to be configured to connect the authentication backend.`
  String get auth_brand_not_configured {
    return Intl.message(
      'The .env file needs to be configured to connect the authentication backend.',
      name: 'auth_brand_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Restart app`
  String get backup_btn_restart {
    return Intl.message(
      'Restart app',
      name: 'backup_btn_restart',
      desc: '',
      args: [],
    );
  }

  /// `Upload backup now`
  String get backup_btn_upload {
    return Intl.message(
      'Upload backup now',
      name: 'backup_btn_upload',
      desc: '',
      args: [],
    );
  }

  /// `There are no backups yet...`
  String get backup_no_backups {
    return Intl.message(
      'There are no backups yet...',
      name: 'backup_no_backups',
      desc: '',
      args: [],
    );
  }

  /// `You need an active session...`
  String get backup_auth_required {
    return Intl.message(
      'You need an active session...',
      name: 'backup_auth_required',
      desc: '',
      args: [],
    );
  }

  /// `Backup uploaded correctly.`
  String get backup_upload_success {
    return Intl.message(
      'Backup uploaded correctly.',
      name: 'backup_upload_success',
      desc: '',
      args: [],
    );
  }

  /// `Backup restored. `
  String get backup_restore_success {
    return Intl.message(
      'Backup restored. ',
      name: 'backup_restore_success',
      desc: '',
      args: [],
    );
  }

  /// `Backup deleted.`
  String get backup_delete_success {
    return Intl.message(
      'Backup deleted.',
      name: 'backup_delete_success',
      desc: '',
      args: [],
    );
  }

  /// `Pop`
  String get genre_pop {
    return Intl.message('Pop', name: 'genre_pop', desc: '', args: []);
  }

  /// `Rock`
  String get genre_rock {
    return Intl.message('Rock', name: 'genre_rock', desc: '', args: []);
  }

  /// `hip hop`
  String get genre_hiphop {
    return Intl.message('hip hop', name: 'genre_hiphop', desc: '', args: []);
  }

  /// `Electronics`
  String get genre_electronic {
    return Intl.message(
      'Electronics',
      name: 'genre_electronic',
      desc: '',
      args: [],
    );
  }

  /// `Jazz`
  String get genre_jazz {
    return Intl.message('Jazz', name: 'genre_jazz', desc: '', args: []);
  }

  /// `Latin`
  String get genre_latin {
    return Intl.message('Latin', name: 'genre_latin', desc: '', args: []);
  }

  /// `Select file and import`
  String get migration_btn_select {
    return Intl.message(
      'Select file and import',
      name: 'migration_btn_select',
      desc: '',
      args: [],
    );
  }

  /// `We will send instructions to your account email.`
  String get auth_forgot_password_subtitle {
    return Intl.message(
      'We will send instructions to your account email.',
      name: 'auth_forgot_password_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send email`
  String get auth_btn_send_email {
    return Intl.message(
      'Send email',
      name: 'auth_btn_send_email',
      desc: '',
      args: [],
    );
  }

  /// `Backend authentication is not configured in the .env file.`
  String get auth_error_not_configured {
    return Intl.message(
      'Backend authentication is not configured in the .env file.',
      name: 'auth_error_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get auth_error_invalid_credentials {
    return Intl.message(
      'Incorrect email or password.',
      name: 'auth_error_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Your account is not yet verified.`
  String get auth_error_not_verified {
    return Intl.message(
      'Your account is not yet verified.',
      name: 'auth_error_not_verified',
      desc: '',
      args: [],
    );
  }

  /// `Could not complete the operation.`
  String get auth_error_unknown {
    return Intl.message(
      'Could not complete the operation.',
      name: 'auth_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully.`
  String get auth_register_success {
    return Intl.message(
      'Account created successfully.',
      name: 'auth_register_success',
      desc: '',
      args: [],
    );
  }

  /// `Could not create account.`
  String get auth_register_error {
    return Intl.message(
      'Could not create account.',
      name: 'auth_register_error',
      desc: '',
      args: [],
    );
  }

  /// `Email sent.`
  String get auth_recovery_email_sent {
    return Intl.message(
      'Email sent.',
      name: 'auth_recovery_email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Could not send email.`
  String get auth_recovery_email_error {
    return Intl.message(
      'Could not send email.',
      name: 'auth_recovery_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Latest Version Available`
  String get latestVersion {
    return Intl.message(
      'Latest Version Available',
      name: 'latestVersion',
      desc: '',
      args: [],
    );
  }

  /// `Update Application`
  String get updateApp {
    return Intl.message(
      'Update Application',
      name: 'updateApp',
      desc: '',
      args: [],
    );
  }

  /// `Could not load update information`
  String get loadInfoUpdate {
    return Intl.message(
      'Could not load update information',
      name: 'loadInfoUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Information not available`
  String get infoNotAvailable {
    return Intl.message(
      'Information not available',
      name: 'infoNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Developed and Maintained by Joss Estrada (JOSPROX)`
  String get developedBy {
    return Intl.message(
      'Developed and Maintained by Joss Estrada (JOSPROX)',
      name: 'developedBy',
      desc: '',
      args: [],
    );
  }

  /// `© 2026 JOSPROX. License GPL v3.0`
  String get copyrightNotice {
    return Intl.message(
      '© 2026 JOSPROX. License GPL v3.0',
      name: 'copyrightNotice',
      desc: '',
      args: [],
    );
  }

  /// `forgotten favorites`
  String get forgottenFavorites {
    return Intl.message(
      'forgotten favorites',
      name: 'forgottenFavorites',
      desc: '',
      args: [],
    );
  }

  /// `The most listened to song`
  String get mostListenedSong {
    return Intl.message(
      'The most listened to song',
      name: 'mostListenedSong',
      desc: '',
      args: [],
    );
  }

  /// `Reproduced by`
  String get reproducedBy {
    return Intl.message(
      'Reproduced by',
      name: 'reproducedBy',
      desc: '',
      args: [],
    );
  }

  /// `Recent searches`
  String get recentSearches {
    return Intl.message(
      'Recent searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Popular tracks`
  String get popularTracks {
    return Intl.message(
      'Popular tracks',
      name: 'popularTracks',
      desc: '',
      args: [],
    );
  }

  /// `Latest release`
  String get latestRelease {
    return Intl.message(
      'Latest release',
      name: 'latestRelease',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get follow {
    return Intl.message('Continue', name: 'follow', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Listen now`
  String get listenNow {
    return Intl.message('Listen now', name: 'listenNow', desc: '', args: []);
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Speed ​​and Pitch`
  String get speedAndPitch {
    return Intl.message(
      'Speed ​​and Pitch',
      name: 'speedAndPitch',
      desc: '',
      args: [],
    );
  }

  /// `Playback speed`
  String get playbackSpeed {
    return Intl.message(
      'Playback speed',
      name: 'playbackSpeed',
      desc: '',
      args: [],
    );
  }

  /// `song tone`
  String get songPitch {
    return Intl.message('song tone', name: 'songPitch', desc: '', args: []);
  }

  /// `Music Recognition`
  String get musicRecognition {
    return Intl.message(
      'Music Recognition',
      name: 'musicRecognition',
      desc: '',
      args: [],
    );
  }

  /// `Listening to the environment...`
  String get listeningToEnvironment {
    return Intl.message(
      'Listening to the environment...',
      name: 'listeningToEnvironment',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the music is playing loud enough near your microphone.`
  String get micInstruction {
    return Intl.message(
      'Make sure the music is playing loud enough near your microphone.',
      name: 'micInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Processing the audio...`
  String get processingAudio {
    return Intl.message(
      'Processing the audio...',
      name: 'processingAudio',
      desc: '',
      args: [],
    );
  }

  /// `Searching the Shazam database for matches...`
  String get shazamSearching {
    return Intl.message(
      'Searching the Shazam database for matches...',
      name: 'shazamSearching',
      desc: '',
      args: [],
    );
  }

  /// `Song Found!`
  String get songFound {
    return Intl.message('Song Found!', name: 'songFound', desc: '', args: []);
  }

  /// `Play Now`
  String get playNow {
    return Intl.message('Play Now', name: 'playNow', desc: '', args: []);
  }

  /// `Search in Library`
  String get searchInLibrary {
    return Intl.message(
      'Search in Library',
      name: 'searchInLibrary',
      desc: '',
      args: [],
    );
  }

  /// `No Matches`
  String get noMatchesFound {
    return Intl.message(
      'No Matches',
      name: 'noMatchesFound',
      desc: '',
      args: [],
    );
  }

  /// `Could not find any songs in the recorded audio`
  String get noMatchInstruction {
    return Intl.message(
      'Could not find any songs in the recorded audio',
      name: 'noMatchInstruction',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Playing:`
  String get playingRecognizedTrack {
    return Intl.message(
      'Playing:',
      name: 'playingRecognizedTrack',
      desc: '',
      args: [],
    );
  }

  /// `Error when playing:`
  String get errorPlayingTrack {
    return Intl.message(
      'Error when playing:',
      name: 'errorPlayingTrack',
      desc: '',
      args: [],
    );
  }

  /// `Your music, your way`
  String get welcome_title {
    return Intl.message(
      'Your music, your way',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose how you want to experience Estrella Music from now on.`
  String get welcome_subtitle {
    return Intl.message(
      'Choose how you want to experience Estrella Music from now on.',
      name: 'welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `We have modernized our platform. `
  String get welcome_intro {
    return Intl.message(
      'We have modernized our platform. ',
      name: 'welcome_intro',
      desc: '',
      args: [],
    );
  }

  /// `We recommend activating Cloud Mode for a Spotify-like experience: real-time synchronization between all your devices and automatic backup without you having to do anything.`
  String get recommend_cloud {
    return Intl.message(
      'We recommend activating Cloud Mode for a Spotify-like experience: real-time synchronization between all your devices and automatic backup without you having to do anything.',
      name: 'recommend_cloud',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to explore options`
  String get swipe_prompt {
    return Intl.message(
      'Swipe to explore options',
      name: 'swipe_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Local Mode`
  String get local_title {
    return Intl.message('Local Mode', name: 'local_title', desc: '', args: []);
  }

  /// `Absolute privacy on your device`
  String get local_subtitle {
    return Intl.message(
      'Absolute privacy on your device',
      name: 'local_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `It works without the need to log in.`
  String get local_b1 {
    return Intl.message(
      'It works without the need to log in.',
      name: 'local_b1',
      desc: '',
      args: [],
    );
  }

  /// `Your entire library stays strictly on this computer.`
  String get local_b2 {
    return Intl.message(
      'Your entire library stays strictly on this computer.',
      name: 'local_b2',
      desc: '',
      args: [],
    );
  }

  /// `Note: No manual cloud backups. `
  String get local_b3 {
    return Intl.message(
      'Note: No manual cloud backups. ',
      name: 'local_b3',
      desc: '',
      args: [],
    );
  }

  /// `Use only on this device`
  String get local_btn {
    return Intl.message(
      'Use only on this device',
      name: 'local_btn',
      desc: '',
      args: [],
    );
  }

  /// `Cloud Mode (Recommended)`
  String get cloud_title {
    return Intl.message(
      'Cloud Mode (Recommended)',
      name: 'cloud_title',
      desc: '',
      args: [],
    );
  }

  /// `Real-time synchronization with Joss Red`
  String get cloud_subtitle {
    return Intl.message(
      'Real-time synchronization with Joss Red',
      name: 'cloud_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in securely using your Joss Red account.`
  String get cloud_b1 {
    return Intl.message(
      'Log in securely using your Joss Red account.',
      name: 'cloud_b1',
      desc: '',
      args: [],
    );
  }

  /// `Access your playlists, favorites and history from any device (Windows, Android, etc.) instantly.`
  String get cloud_b2 {
    return Intl.message(
      'Access your playlists, favorites and history from any device (Windows, Android, etc.) instantly.',
      name: 'cloud_b2',
      desc: '',
      args: [],
    );
  }

  /// `Smart Sync: Work offline and upload changes automatically when you recover internet.`
  String get cloud_b3 {
    return Intl.message(
      'Smart Sync: Work offline and upload changes automatically when you recover internet.',
      name: 'cloud_b3',
      desc: '',
      args: [],
    );
  }

  /// `Activate Cloud sync`
  String get cloud_btn {
    return Intl.message(
      'Activate Cloud sync',
      name: 'cloud_btn',
      desc: '',
      args: [],
    );
  }

  /// `Step {current} of 3`
  String slide_indicator(Object current) {
    return Intl.message(
      'Step $current of 3',
      name: 'slide_indicator',
      desc: '',
      args: [current],
    );
  }

  /// `Estrella Music has evolved!`
  String get news_card_title {
    return Intl.message(
      'Estrella Music has evolved!',
      name: 'news_card_title',
      desc: '',
      args: [],
    );
  }

  /// `100% synchronization with Joss Red, playlists with friends and much more. `
  String get news_card_subtitle {
    return Intl.message(
      '100% synchronization with Joss Red, playlists with friends and much more. ',
      name: 'news_card_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Estrella Music News`
  String get news_dialog_title {
    return Intl.message(
      'Estrella Music News',
      name: 'news_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Full Integration with Joss Red`
  String get news_item_sync_title {
    return Intl.message(
      'Full Integration with Joss Red',
      name: 'news_item_sync_title',
      desc: '',
      args: [],
    );
  }

  /// `Your playlists and favorites are now saved and synced in the cloud automatically with your main Joss Red account.`
  String get news_item_sync_desc {
    return Intl.message(
      'Your playlists and favorites are now saved and synced in the cloud automatically with your main Joss Red account.',
      name: 'news_item_sync_desc',
      desc: '',
      args: [],
    );
  }

  /// `Collaborative Playlists`
  String get news_item_collab_title {
    return Intl.message(
      'Collaborative Playlists',
      name: 'news_item_collab_title',
      desc: '',
      args: [],
    );
  }

  /// `Create playlists with your friends! `
  String get news_item_collab_desc {
    return Intl.message(
      'Create playlists with your friends! ',
      name: 'news_item_collab_desc',
      desc: '',
      args: [],
    );
  }

  /// `Transparent Synchronization`
  String get news_item_trans_title {
    return Intl.message(
      'Transparent Synchronization',
      name: 'news_item_trans_title',
      desc: '',
      args: [],
    );
  }

  /// `You no longer need to click manual sync buttons; `
  String get news_item_trans_desc {
    return Intl.message(
      'You no longer need to click manual sync buttons; ',
      name: 'news_item_trans_desc',
      desc: '',
      args: [],
    );
  }

  /// `Friends and Account Management:`
  String get news_dialog_section_friends {
    return Intl.message(
      'Friends and Account Management:',
      name: 'news_dialog_section_friends',
      desc: '',
      args: [],
    );
  }

  /// `To add friends, accept requests or manage your security profile, please use Joss Red on its official platforms:`
  String get news_dialog_friends_desc {
    return Intl.message(
      'To add friends, accept requests or manage your security profile, please use Joss Red on its official platforms:',
      name: 'news_dialog_friends_desc',
      desc: '',
      args: [],
    );
  }

  /// `Joss Red App (Play Store)`
  String get news_btn_app {
    return Intl.message(
      'Joss Red App (Play Store)',
      name: 'news_btn_app',
      desc: '',
      args: [],
    );
  }

  /// `Joss Red Web`
  String get news_btn_web {
    return Intl.message(
      'Joss Red Web',
      name: 'news_btn_web',
      desc: '',
      args: [],
    );
  }

  /// `Understood`
  String get news_btn_dismiss {
    return Intl.message(
      'Understood',
      name: 'news_btn_dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Theme, language and interface animations.`
  String get settings_appearance_desc {
    return Intl.message(
      'Theme, language and interface animations.',
      name: 'settings_appearance_desc',
      desc: '',
      args: [],
    );
  }

  /// `Discover filters, integration with Piped and caches.`
  String get settings_content_desc {
    return Intl.message(
      'Discover filters, integration with Piped and caches.',
      name: 'settings_content_desc',
      desc: '',
      args: [],
    );
  }

  /// `Streaming quality, normalization, silences and battery.`
  String get settings_playback_desc {
    return Intl.message(
      'Streaming quality, normalization, silences and battery.',
      name: 'settings_playback_desc',
      desc: '',
      args: [],
    );
  }

  /// `Downloads and Storage`
  String get settings_downloads_desc {
    return Intl.message(
      'Downloads and Storage',
      name: 'settings_downloads_desc',
      desc: '',
      args: [],
    );
  }

  /// `Audio formats, folders and automatic downloads.`
  String get settings_downloads_sub {
    return Intl.message(
      'Audio formats, folders and automatic downloads.',
      name: 'settings_downloads_sub',
      desc: '',
      args: [],
    );
  }

  /// `Account and Sync`
  String get settings_account_desc {
    return Intl.message(
      'Account and Sync',
      name: 'settings_account_desc',
      desc: '',
      args: [],
    );
  }

  /// `Cloud mode, backups, friends list and migrations.`
  String get settings_account_sub {
    return Intl.message(
      'Cloud mode, backups, friends list and migrations.',
      name: 'settings_account_sub',
      desc: '',
      args: [],
    );
  }

  /// `About Estrella Music`
  String get settings_about_desc {
    return Intl.message(
      'About Estrella Music',
      name: 'settings_about_desc',
      desc: '',
      args: [],
    );
  }

  /// `Version, open source project and GitHub.`
  String get settings_about_sub {
    return Intl.message(
      'Version, open source project and GitHub.',
      name: 'settings_about_sub',
      desc: '',
      args: [],
    );
  }

  /// `Local Mode / EMusic Cloud`
  String get settings_local_cloud_title {
    return Intl.message(
      'Local Mode / EMusic Cloud',
      name: 'settings_local_cloud_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose, migrate or review the synchronization status with Joss Red.`
  String get settings_local_cloud_desc {
    return Intl.message(
      'Choose, migrate or review the synchronization status with Joss Red.',
      name: 'settings_local_cloud_desc',
      desc: '',
      args: [],
    );
  }

  /// `my friends`
  String get settings_my_friends {
    return Intl.message(
      'my friends',
      name: 'settings_my_friends',
      desc: '',
      args: [],
    );
  }

  /// `Manage your Joss Red friends directly.`
  String get settings_my_friends_desc {
    return Intl.message(
      'Manage your Joss Red friends directly.',
      name: 'settings_my_friends_desc',
      desc: '',
      args: [],
    );
  }

  /// `Refresh ID (Visitor ID)`
  String get settings_refresh_visitor_title {
    return Intl.message(
      'Refresh ID (Visitor ID)',
      name: 'settings_refresh_visitor_title',
      desc: '',
      args: [],
    );
  }

  /// `Regenerate your YouTube Music ID if Discover content doesn't load.`
  String get settings_refresh_visitor_desc {
    return Intl.message(
      'Regenerate your YouTube Music ID if Discover content doesn\'t load.',
      name: 'settings_refresh_visitor_desc',
      desc: '',
      args: [],
    );
  }

  /// `Updated identifier`
  String get settings_visitor_updated {
    return Intl.message(
      'Updated identifier',
      name: 'settings_visitor_updated',
      desc: '',
      args: [],
    );
  }

  /// `A new Visitor ID was generated successfully.`
  String get settings_visitor_updated_desc {
    return Intl.message(
      'A new Visitor ID was generated successfully.',
      name: 'settings_visitor_updated_desc',
      desc: '',
      args: [],
    );
  }

  /// `Mistake`
  String get settings_visitor_error {
    return Intl.message(
      'Mistake',
      name: 'settings_visitor_error',
      desc: '',
      args: [],
    );
  }

  /// `A new identifier could not be generated. `
  String get settings_visitor_error_desc {
    return Intl.message(
      'A new identifier could not be generated. ',
      name: 'settings_visitor_error_desc',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while regenerating: {error}`
  String settings_visitor_exception(Object error) {
    return Intl.message(
      'An error occurred while regenerating: $error',
      name: 'settings_visitor_exception',
      desc: '',
      args: [error],
    );
  }

  /// `music downloads`
  String get downloadNotificationChannelName {
    return Intl.message(
      'music downloads',
      name: 'downloadNotificationChannelName',
      desc: '',
      args: [],
    );
  }

  /// `Keeps your music downloads active in the background.`
  String get downloadNotificationChannelDescription {
    return Intl.message(
      'Keeps your music downloads active in the background.',
      name: 'downloadNotificationChannelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Downloading music`
  String get downloadNotificationTitle {
    return Intl.message(
      'Downloading music',
      name: 'downloadNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Preparing your downloads…`
  String get downloadNotificationPreparing {
    return Intl.message(
      'Preparing your downloads…',
      name: 'downloadNotificationPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Downloading: {songTitle}`
  String downloadNotificationSong(Object songTitle) {
    return Intl.message(
      'Downloading: $songTitle',
      name: 'downloadNotificationSong',
      desc: '',
      args: [songTitle],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'be'),
      Locale.fromSubtags(languageCode: 'bg'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'et'),
      Locale.fromSubtags(languageCode: 'eu'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fil'),
      Locale.fromSubtags(languageCode: 'fj'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ga'),
      Locale.fromSubtags(languageCode: 'gl'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'hr'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'ia'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'km'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'ku'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nb', countryCode: 'NO'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'or'),
      Locale.fromSubtags(languageCode: 'pa'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sr'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
