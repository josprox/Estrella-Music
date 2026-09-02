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

  /// `Create new playlist`
  String get CreateNewPlaylist {
    return Intl.message(
      'Create new playlist',
      name: 'CreateNewPlaylist',
      desc: 'CreateNewPlaylist',
      args: [],
    );
  }

  /// `Piped`
  String get Piped {
    return Intl.message('Piped', name: 'Piped', desc: 'Piped', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: 'about', args: []);
  }

  /// `Add 5 minutes`
  String get add5Minutes {
    return Intl.message(
      'Add 5 minutes',
      name: 'add5Minutes',
      desc: 'add5Minutes',
      args: [],
    );
  }

  /// `Add songs to playlist`
  String get addMultipleSongs {
    return Intl.message(
      'Add songs to playlist',
      name: 'addMultipleSongs',
      desc: 'addMultipleSongs',
      args: [],
    );
  }

  /// `Add to Library`
  String get addToLibrary {
    return Intl.message(
      'Add to Library',
      name: 'addToLibrary',
      desc: 'addToLibrary',
      args: [],
    );
  }

  /// `Add to playlist`
  String get addToPlaylist {
    return Intl.message(
      'Add to playlist',
      name: 'addToPlaylist',
      desc: 'addToPlaylist',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message('Album', name: 'album', desc: 'album', args: []);
  }

  /// `Album bookmarked!`
  String get albumBookmarkAddAlert {
    return Intl.message(
      'Album bookmarked!',
      name: 'albumBookmarkAddAlert',
      desc: 'albumBookmarkAddAlert',
      args: [],
    );
  }

  /// `Album bookmark removed!`
  String get albumBookmarkRemoveAlert {
    return Intl.message(
      'Album bookmark removed!',
      name: 'albumBookmarkRemoveAlert',
      desc: 'albumBookmarkRemoveAlert',
      args: [],
    );
  }

  /// `Albums`
  String get albums {
    return Intl.message('Albums', name: 'albums', desc: 'albums', args: []);
  }

  /// `According to your tastes`
  String get albumsByTaste {
    return Intl.message(
      'According to your tastes',
      name: 'albumsByTaste',
      desc: 'albumsByTaste',
      args: [],
    );
  }

  /// `All fields required`
  String get allFieldsReqMsg {
    return Intl.message(
      'All fields required',
      name: 'allFieldsReqMsg',
      desc: 'allFieldsReqMsg',
      args: [],
    );
  }

  /// `Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.`
  String get androidBackupWarning {
    return Intl.message(
      'Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.',
      name: 'androidBackupWarning',
      desc: 'androidBackupWarning',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message('App Info', name: 'appInfo', desc: 'appInfo', args: []);
  }

  /// `Artist bookmarked!`
  String get artistBookmarkAddAlert {
    return Intl.message(
      'Artist bookmarked!',
      name: 'artistBookmarkAddAlert',
      desc: 'artistBookmarkAddAlert',
      args: [],
    );
  }

  /// `Artist bookmark removed!`
  String get artistBookmarkRemoveAlert {
    return Intl.message(
      'Artist bookmark removed!',
      name: 'artistBookmarkRemoveAlert',
      desc: 'artistBookmarkRemoveAlert',
      args: [],
    );
  }

  /// `Description not available!`
  String get artistDesNotAvailable {
    return Intl.message(
      'Description not available!',
      name: 'artistDesNotAvailable',
      desc: 'artistDesNotAvailable',
      args: [],
    );
  }

  /// `Artists`
  String get artists {
    return Intl.message('Artists', name: 'artists', desc: 'artists', args: []);
  }

  /// `According to your tastes`
  String get artistsByTaste {
    return Intl.message(
      'According to your tastes',
      name: 'artistsByTaste',
      desc: 'artistsByTaste',
      args: [],
    );
  }

  /// `Audio Codec`
  String get audioCodec {
    return Intl.message(
      'Audio Codec',
      name: 'audioCodec',
      desc: 'audioCodec',
      args: [],
    );
  }

  /// `Authentication code`
  String get auth_2fa_code {
    return Intl.message(
      'Authentication code',
      name: 'auth_2fa_code',
      desc: 'auth_2fa_code',
      args: [],
    );
  }

  /// `Enter a valid 6-digit code or sign in again.`
  String get auth_2fa_invalid {
    return Intl.message(
      'Enter a valid 6-digit code or sign in again.',
      name: 'auth_2fa_invalid',
      desc: 'auth_2fa_invalid',
      args: [],
    );
  }

  /// `Enter the 6-digit code from your authenticator app. `
  String get auth_2fa_subtitle {
    return Intl.message(
      'Enter the 6-digit code from your authenticator app. ',
      name: 'auth_2fa_subtitle',
      desc: 'auth_2fa_subtitle',
      args: [],
    );
  }

  /// `Two-factor authentication`
  String get auth_2fa_title {
    return Intl.message(
      'Two-factor authentication',
      name: 'auth_2fa_title',
      desc: 'auth_2fa_title',
      args: [],
    );
  }

  /// `Check and continue`
  String get auth_2fa_verify {
    return Intl.message(
      'Check and continue',
      name: 'auth_2fa_verify',
      desc: 'auth_2fa_verify',
      args: [],
    );
  }

  /// `Acepto usar mis datos...`
  String get auth_agree_personal_data {
    return Intl.message(
      'Acepto usar mis datos...',
      name: 'auth_agree_personal_data',
      desc: 'auth_agree_personal_data',
      args: [],
    );
  }

  /// `We brought the login, registration, and password recovery from the previous project, adapted for this music app.`
  String get auth_brand_description_1 {
    return Intl.message(
      'We brought the login, registration, and password recovery from the previous project, adapted for this music app.',
      name: 'auth_brand_description_1',
      desc: 'auth_brand_description_1',
      args: [],
    );
  }

  /// `Your session lives in secure storage and is validated with the same backend you already used.`
  String get auth_brand_description_2 {
    return Intl.message(
      'Your session lives in secure storage and is validated with the same backend you already used.',
      name: 'auth_brand_description_2',
      desc: 'auth_brand_description_2',
      args: [],
    );
  }

  /// `The .env file needs to be configured to connect the authentication backend.`
  String get auth_brand_not_configured {
    return Intl.message(
      'The .env file needs to be configured to connect the authentication backend.',
      name: 'auth_brand_not_configured',
      desc: 'auth_brand_not_configured',
      args: [],
    );
  }

  /// `Login`
  String get auth_btn_login {
    return Intl.message(
      'Login',
      name: 'auth_btn_login',
      desc: 'auth_btn_login',
      args: [],
    );
  }

  /// `Register`
  String get auth_btn_register {
    return Intl.message(
      'Register',
      name: 'auth_btn_register',
      desc: 'auth_btn_register',
      args: [],
    );
  }

  /// `Send email`
  String get auth_btn_send_email {
    return Intl.message(
      'Send email',
      name: 'auth_btn_send_email',
      desc: 'auth_btn_send_email',
      args: [],
    );
  }

  /// `Confirm Password`
  String get auth_confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'auth_confirm_password',
      desc: 'auth_confirm_password',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get auth_error_invalid_credentials {
    return Intl.message(
      'Incorrect email or password.',
      name: 'auth_error_invalid_credentials',
      desc: 'auth_error_invalid_credentials',
      args: [],
    );
  }

  /// `Enter a valid email.`
  String get auth_error_invalid_email {
    return Intl.message(
      'Enter a valid email.',
      name: 'auth_error_invalid_email',
      desc: 'auth_error_invalid_email',
      args: [],
    );
  }

  /// `Backend authentication is not configured in the .env file.`
  String get auth_error_not_configured {
    return Intl.message(
      'Backend authentication is not configured in the .env file.',
      name: 'auth_error_not_configured',
      desc: 'auth_error_not_configured',
      args: [],
    );
  }

  /// `Your account is not yet verified.`
  String get auth_error_not_verified {
    return Intl.message(
      'Your account is not yet verified.',
      name: 'auth_error_not_verified',
      desc: 'auth_error_not_verified',
      args: [],
    );
  }

  /// `Could not complete the operation.`
  String get auth_error_unknown {
    return Intl.message(
      'Could not complete the operation.',
      name: 'auth_error_unknown',
      desc: 'auth_error_unknown',
      args: [],
    );
  }

  /// `First name`
  String get auth_first_name {
    return Intl.message(
      'First name',
      name: 'auth_first_name',
      desc: 'auth_first_name',
      args: [],
    );
  }

  /// `I forgot my password`
  String get auth_forgot_password {
    return Intl.message(
      'I forgot my password',
      name: 'auth_forgot_password',
      desc: 'auth_forgot_password',
      args: [],
    );
  }

  /// `We will send instructions to your account email.`
  String get auth_forgot_password_subtitle {
    return Intl.message(
      'We will send instructions to your account email.',
      name: 'auth_forgot_password_subtitle',
      desc: 'auth_forgot_password_subtitle',
      args: [],
    );
  }

  /// `name@email.com`
  String get auth_hint_email {
    return Intl.message(
      'name@email.com',
      name: 'auth_hint_email',
      desc: 'auth_hint_email',
      args: [],
    );
  }

  /// `Last name`
  String get auth_last_name {
    return Intl.message(
      'Last name',
      name: 'auth_last_name',
      desc: 'auth_last_name',
      args: [],
    );
  }

  /// `Successfully logged in`
  String get auth_login_success {
    return Intl.message(
      'Successfully logged in',
      name: 'auth_login_success',
      desc: 'auth_login_success',
      args: [],
    );
  }

  /// `Could not send email.`
  String get auth_recovery_email_error {
    return Intl.message(
      'Could not send email.',
      name: 'auth_recovery_email_error',
      desc: 'auth_recovery_email_error',
      args: [],
    );
  }

  /// `Email sent.`
  String get auth_recovery_email_sent {
    return Intl.message(
      'Email sent.',
      name: 'auth_recovery_email_sent',
      desc: 'auth_recovery_email_sent',
      args: [],
    );
  }

  /// `Could not create account.`
  String get auth_register_error {
    return Intl.message(
      'Could not create account.',
      name: 'auth_register_error',
      desc: 'auth_register_error',
      args: [],
    );
  }

  /// `Account created successfully.`
  String get auth_register_success {
    return Intl.message(
      'Account created successfully.',
      name: 'auth_register_success',
      desc: 'auth_register_success',
      args: [],
    );
  }

  /// `Welcome to Estrella Music`
  String get auth_welcome_subtitle {
    return Intl.message(
      'Welcome to Estrella Music',
      name: 'auth_welcome_subtitle',
      desc: 'auth_welcome_subtitle',
      args: [],
    );
  }

  /// `Welcome to Estrella Music`
  String get auth_welcome_title {
    return Intl.message(
      'Welcome to Estrella Music',
      name: 'auth_welcome_title',
      desc: 'auth_welcome_title',
      args: [],
    );
  }

  /// `Auto download favorite songs`
  String get autoDownFavSong {
    return Intl.message(
      'Auto download favorite songs',
      name: 'autoDownFavSong',
      desc: 'autoDownFavSong',
      args: [],
    );
  }

  /// `Automatically download favorite songs when added to favorites`
  String get autoDownFavSongDes {
    return Intl.message(
      'Automatically download favorite songs when added to favorites',
      name: 'autoDownFavSongDes',
      desc: 'autoDownFavSongDes',
      args: [],
    );
  }

  /// `Auto open player screen`
  String get autoOpenPlayer {
    return Intl.message(
      'Auto open player screen',
      name: 'autoOpenPlayer',
      desc: 'autoOpenPlayer',
      args: [],
    );
  }

  /// `Enable/disable auto opening of player full screen on selection of song for play`
  String get autoOpenPlayerDes {
    return Intl.message(
      'Enable/disable auto opening of player full screen on selection of song for play',
      name: 'autoOpenPlayerDes',
      desc: 'autoOpenPlayerDes',
      args: [],
    );
  }

  /// `Return`
  String get back {
    return Intl.message('Return', name: 'back', desc: 'back', args: []);
  }

  /// `databases found`
  String get backFilesFound {
    return Intl.message(
      'databases found',
      name: 'backFilesFound',
      desc: 'backFilesFound',
      args: [],
    );
  }

  /// `Background music play`
  String get backgroundPlay {
    return Intl.message(
      'Background music play',
      name: 'backgroundPlay',
      desc: 'backgroundPlay',
      args: [],
    );
  }

  /// `Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)`
  String get backgroundPlayDes {
    return Intl.message(
      'Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)',
      name: 'backgroundPlayDes',
      desc: 'backgroundPlayDes',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: 'backup', args: []);
  }

  /// `Backup App data`
  String get backupAppData {
    return Intl.message(
      'Backup App data',
      name: 'backupAppData',
      desc: 'backupAppData',
      args: [],
    );
  }

  /// `Backup in progress...`
  String get backupInProgress {
    return Intl.message(
      'Backup in progress...',
      name: 'backupInProgress',
      desc: 'backupInProgress',
      args: [],
    );
  }

  /// `Backup successfully saved!`
  String get backupMsg {
    return Intl.message(
      'Backup successfully saved!',
      name: 'backupMsg',
      desc: 'backupMsg',
      args: [],
    );
  }

  /// `Backup settings and playlists`
  String get backupSettingsAndPlaylists {
    return Intl.message(
      'Backup settings and playlists',
      name: 'backupSettingsAndPlaylists',
      desc: 'backupSettingsAndPlaylists',
      args: [],
    );
  }

  /// `Saves all settings, playlists and login data in a backup file`
  String get backupSettingsAndPlaylistsDes {
    return Intl.message(
      'Saves all settings, playlists and login data in a backup file',
      name: 'backupSettingsAndPlaylistsDes',
      desc: 'backupSettingsAndPlaylistsDes',
      args: [],
    );
  }

  /// `You need an active session...`
  String get backup_auth_required {
    return Intl.message(
      'You need an active session...',
      name: 'backup_auth_required',
      desc: 'backup_auth_required',
      args: [],
    );
  }

  /// `Restart app`
  String get backup_btn_restart {
    return Intl.message(
      'Restart app',
      name: 'backup_btn_restart',
      desc: 'backup_btn_restart',
      args: [],
    );
  }

  /// `Upload backup now`
  String get backup_btn_upload {
    return Intl.message(
      'Upload backup now',
      name: 'backup_btn_upload',
      desc: 'backup_btn_upload',
      args: [],
    );
  }

  /// `Do you want to perform a backup?`
  String get backup_confirm_question {
    return Intl.message(
      'Do you want to perform a backup?',
      name: 'backup_confirm_question',
      desc: 'backup_confirm_question',
      args: [],
    );
  }

  /// `Backup deleted.`
  String get backup_delete_success {
    return Intl.message(
      'Backup deleted.',
      name: 'backup_delete_success',
      desc: 'backup_delete_success',
      args: [],
    );
  }

  /// `There are no backups yet...`
  String get backup_no_backups {
    return Intl.message(
      'There are no backups yet...',
      name: 'backup_no_backups',
      desc: 'backup_no_backups',
      args: [],
    );
  }

  /// `Backup restored. `
  String get backup_restore_success {
    return Intl.message(
      'Backup restored. ',
      name: 'backup_restore_success',
      desc: 'backup_restore_success',
      args: [],
    );
  }

  /// `Select backup file folder`
  String get backup_select_folder_dialog {
    return Intl.message(
      'Select backup file folder',
      name: 'backup_select_folder_dialog',
      desc: 'backup_select_folder_dialog',
      args: [],
    );
  }

  /// `Choose which data to backup`
  String get backup_selection_prompt {
    return Intl.message(
      'Choose which data to backup',
      name: 'backup_selection_prompt',
      desc: 'backup_selection_prompt',
      args: [],
    );
  }

  /// `Backup uploaded correctly.`
  String get backup_upload_success {
    return Intl.message(
      'Backup uploaded correctly.',
      name: 'backup_upload_success',
      desc: 'backup_upload_success',
      args: [],
    );
  }

  /// `Based on last interaction`
  String get basedOnLast {
    return Intl.message(
      'Based on last interaction',
      name: 'basedOnLast',
      desc: 'basedOnLast',
      args: [],
    );
  }

  /// `Bitrate`
  String get bitrate {
    return Intl.message('Bitrate', name: 'bitrate', desc: 'bitrate', args: []);
  }

  /// `Blacklist playlist`
  String get blacklistPipedPlaylist {
    return Intl.message(
      'Blacklist playlist',
      name: 'blacklistPipedPlaylist',
      desc: 'blacklistPipedPlaylist',
      args: [],
    );
  }

  /// `Reset successfully!`
  String get blacklistPlstResetAlert {
    return Intl.message(
      'Reset successfully!',
      name: 'blacklistPlstResetAlert',
      desc: 'blacklistPlstResetAlert',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message('by', name: 'by', desc: 'by', args: []);
  }

  /// `Cache home screen content data`
  String get cacheHomeScreenData {
    return Intl.message(
      'Cache home screen content data',
      name: 'cacheHomeScreenData',
      desc: 'cacheHomeScreenData',
      args: [],
    );
  }

  /// `Enable Caching home screen content data, Home screen will load instantly if this option is enabled`
  String get cacheHomeScreenDataDes {
    return Intl.message(
      'Enable Caching home screen content data, Home screen will load instantly if this option is enabled',
      name: 'cacheHomeScreenDataDes',
      desc: 'cacheHomeScreenDataDes',
      args: [],
    );
  }

  /// `Cache Songs`
  String get cacheSongs {
    return Intl.message(
      'Cache Songs',
      name: 'cacheSongs',
      desc: 'cacheSongs',
      args: [],
    );
  }

  /// `Caching songs while playing for future/offline playback, it will take additional space on your device`
  String get cacheSongsDes {
    return Intl.message(
      'Caching songs while playing for future/offline playback, it will take additional space on your device',
      name: 'cacheSongsDes',
      desc: 'cacheSongsDes',
      args: [],
    );
  }

  /// `Cached/Offline`
  String get cachedOrOffline {
    return Intl.message(
      'Cached/Offline',
      name: 'cachedOrOffline',
      desc: 'cachedOrOffline',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: 'cancel', args: []);
  }

  /// `Cancel timer`
  String get cancelTimer {
    return Intl.message(
      'Cancel timer',
      name: 'cancelTimer',
      desc: 'cancelTimer',
      args: [],
    );
  }

  /// `Sleep timer cancelled`
  String get cancelTimerAlert {
    return Intl.message(
      'Sleep timer cancelled',
      name: 'cancelTimerAlert',
      desc: 'cancelTimerAlert',
      args: [],
    );
  }

  /// `Clear images cache`
  String get clearImgCache {
    return Intl.message(
      'Clear images cache',
      name: 'clearImgCache',
      desc: 'clearImgCache',
      args: [],
    );
  }

  /// `Images cache cleared successfully`
  String get clearImgCacheAlert {
    return Intl.message(
      'Images cache cleared successfully',
      name: 'clearImgCacheAlert',
      desc: 'clearImgCacheAlert',
      args: [],
    );
  }

  /// `Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)`
  String get clearImgCacheDes {
    return Intl.message(
      'Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)',
      name: 'clearImgCacheDes',
      desc: 'clearImgCacheDes',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: 'close', args: []);
  }

  /// `Close App`
  String get closeApp {
    return Intl.message(
      'Close App',
      name: 'closeApp',
      desc: 'closeApp',
      args: [],
    );
  }

  /// `Cloud library found.`
  String get cloudLibraryFound {
    return Intl.message(
      'Cloud library found.',
      name: 'cloudLibraryFound',
      desc: 'cloudLibraryFound',
      args: [],
    );
  }

  /// `A cloud library was found. `
  String get cloudLibraryFoundDeviceWillDownload {
    return Intl.message(
      'A cloud library was found. ',
      name: 'cloudLibraryFoundDeviceWillDownload',
      desc: 'cloudLibraryFoundDeviceWillDownload',
      args: [],
    );
  }

  /// `Cloud mode is ready. `
  String get cloudModeReadyOfflineCache {
    return Intl.message(
      'Cloud mode is ready. ',
      name: 'cloudModeReadyOfflineCache',
      desc: 'cloudModeReadyOfflineCache',
      args: [],
    );
  }

  /// `Log in securely using your Joss Red account.`
  String get cloud_b1 {
    return Intl.message(
      'Log in securely using your Joss Red account.',
      name: 'cloud_b1',
      desc: 'cloud_b1',
      args: [],
    );
  }

  /// `Access your playlists, favorites and history from any device (Windows, Android, etc.) instantly.`
  String get cloud_b2 {
    return Intl.message(
      'Access your playlists, favorites and history from any device (Windows, Android, etc.) instantly.',
      name: 'cloud_b2',
      desc: 'cloud_b2',
      args: [],
    );
  }

  /// `Smart Sync: Work offline and upload changes automatically when you recover internet.`
  String get cloud_b3 {
    return Intl.message(
      'Smart Sync: Work offline and upload changes automatically when you recover internet.',
      name: 'cloud_b3',
      desc: 'cloud_b3',
      args: [],
    );
  }

  /// `Activate Cloud sync`
  String get cloud_btn {
    return Intl.message(
      'Activate Cloud sync',
      name: 'cloud_btn',
      desc: 'cloud_btn',
      args: [],
    );
  }

  /// `Real-time synchronization with Joss Red`
  String get cloud_subtitle {
    return Intl.message(
      'Real-time synchronization with Joss Red',
      name: 'cloud_subtitle',
      desc: 'cloud_subtitle',
      args: [],
    );
  }

  /// `Cloud Mode (Recommended)`
  String get cloud_title {
    return Intl.message(
      'Cloud Mode (Recommended)',
      name: 'cloud_title',
      desc: 'cloud_title',
      args: [],
    );
  }

  /// `Collaborative Playlist`
  String get collaborativePlaylistDescription {
    return Intl.message(
      'Collaborative Playlist',
      name: 'collaborativePlaylistDescription',
      desc: 'collaborativePlaylistDescription',
      args: [],
    );
  }

  /// `Select the friends who will be able to see and edit this playlist:`
  String get collaboratorsInstruction {
    return Intl.message(
      'Select the friends who will be able to see and edit this playlist:',
      name: 'collaboratorsInstruction',
      desc: 'collaboratorsInstruction',
      args: [],
    );
  }

  /// `Collaborators updated correctly.`
  String get collaboratorsUpdated {
    return Intl.message(
      'Collaborators updated correctly.',
      name: 'collaboratorsUpdated',
      desc: 'collaboratorsUpdated',
      args: [],
    );
  }

  /// `Community Playlists`
  String get communityplaylists {
    return Intl.message(
      'Community Playlists',
      name: 'communityplaylists',
      desc: 'communityplaylists',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: 'content', args: []);
  }

  /// `© 2026 JOSPROX. License GPL v3.0`
  String get copyrightNotice {
    return Intl.message(
      '© 2026 JOSPROX. License GPL v3.0',
      name: 'copyrightNotice',
      desc: 'copyrightNotice',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: 'create', args: []);
  }

  /// `Create & add`
  String get createnAdd {
    return Intl.message(
      'Create & add',
      name: 'createnAdd',
      desc: 'createnAdd',
      args: [],
    );
  }

  /// `Custom Instance`
  String get customIns {
    return Intl.message(
      'Custom Instance',
      name: 'customIns',
      desc: 'customIns',
      args: [],
    );
  }

  /// `Please select Custom Instance`
  String get customInsSelectMsg {
    return Intl.message(
      'Please select Custom Instance',
      name: 'customInsSelectMsg',
      desc: 'customInsSelectMsg',
      args: [],
    );
  }

  /// `Daily discovery`
  String get dailyDiscover {
    return Intl.message(
      'Daily discovery',
      name: 'dailyDiscover',
      desc: 'dailyDiscover',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: 'dark', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: 'delete', args: []);
  }

  /// `Remove from downloads`
  String get deleteDownloadData {
    return Intl.message(
      'Remove from downloads',
      name: 'deleteDownloadData',
      desc: 'deleteDownloadData',
      args: [],
    );
  }

  /// `Successfully removed from downloads!`
  String get deleteDownloadedDataAlert {
    return Intl.message(
      'Successfully removed from downloads!',
      name: 'deleteDownloadedDataAlert',
      desc: 'deleteDownloadedDataAlert',
      args: [],
    );
  }

  /// `Developed and Maintained by Joss Estrada (JOSPROX)`
  String get developedBy {
    return Intl.message(
      'Developed and Maintained by Joss Estrada (JOSPROX)',
      name: 'developedBy',
      desc: 'developedBy',
      args: [],
    );
  }

  /// `Disable transition animation`
  String get disableTransitionAnimation {
    return Intl.message(
      'Disable transition animation',
      name: 'disableTransitionAnimation',
      desc: 'disableTransitionAnimation',
      args: [],
    );
  }

  /// `Enable this option to disable tab transition animation`
  String get disableTransitionAnimationDes {
    return Intl.message(
      'Enable this option to disable tab transition animation',
      name: 'disableTransitionAnimationDes',
      desc: 'disableTransitionAnimationDes',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: 'disabled',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: 'discover',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: 'dismiss', args: []);
  }

  /// `Ready`
  String get done {
    return Intl.message('Ready', name: 'done', desc: 'done', args: []);
  }

  /// `Don't show this info again`
  String get dontShowInfoAgain {
    return Intl.message(
      'Don\'t show this info again',
      name: 'dontShowInfoAgain',
      desc: 'dontShowInfoAgain',
      args: [],
    );
  }

  /// `downloaded files found`
  String get downFilesFound {
    return Intl.message(
      'downloaded files found',
      name: 'downFilesFound',
      desc: 'downFilesFound',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: 'download',
      args: [],
    );
  }

  /// `Download album songs`
  String get downloadAlbumSongs {
    return Intl.message(
      'Download album songs',
      name: 'downloadAlbumSongs',
      desc: 'downloadAlbumSongs',
      args: [],
    );
  }

  /// `Requested song is not downloadable due to server restriction. You may try again`
  String get downloadError2 {
    return Intl.message(
      'Requested song is not downloadable due to server restriction. You may try again',
      name: 'downloadError2',
      desc: 'downloadError2',
      args: [],
    );
  }

  /// `Downloading failed due to network/stream error! Please try again`
  String get downloadError3 {
    return Intl.message(
      'Downloading failed due to network/stream error! Please try again',
      name: 'downloadError3',
      desc: 'downloadError3',
      args: [],
    );
  }

  /// `Download Location`
  String get downloadLocation {
    return Intl.message(
      'Download Location',
      name: 'downloadLocation',
      desc: 'downloadLocation',
      args: [],
    );
  }

  /// `Keeps your music downloads active in the background.`
  String get downloadNotificationChannelDescription {
    return Intl.message(
      'Keeps your music downloads active in the background.',
      name: 'downloadNotificationChannelDescription',
      desc: 'downloadNotificationChannelDescription',
      args: [],
    );
  }

  /// `music downloads`
  String get downloadNotificationChannelName {
    return Intl.message(
      'music downloads',
      name: 'downloadNotificationChannelName',
      desc: 'downloadNotificationChannelName',
      args: [],
    );
  }

  /// `Preparing your downloads…`
  String get downloadNotificationPreparing {
    return Intl.message(
      'Preparing your downloads…',
      name: 'downloadNotificationPreparing',
      desc: 'downloadNotificationPreparing',
      args: [],
    );
  }

  /// `Downloading: {songTitle}`
  String downloadNotificationSong(String songTitle) {
    return Intl.message(
      'Downloading: $songTitle',
      name: 'downloadNotificationSong',
      desc: 'downloadNotificationSong',
      args: [songTitle],
    );
  }

  /// `Downloading music`
  String get downloadNotificationTitle {
    return Intl.message(
      'Downloading music',
      name: 'downloadNotificationTitle',
      desc: 'downloadNotificationTitle',
      args: [],
    );
  }

  /// `Download playlist`
  String get downloadPlaylist {
    return Intl.message(
      'Download playlist',
      name: 'downloadPlaylist',
      desc: 'downloadPlaylist',
      args: [],
    );
  }

  /// `Downloading File Format`
  String get downloadingFormat {
    return Intl.message(
      'Downloading File Format',
      name: 'downloadingFormat',
      desc: 'downloadingFormat',
      args: [],
    );
  }

  /// `Select downloading file format. "Opus" will provide best quality`
  String get downloadingFormatDes {
    return Intl.message(
      'Select downloading file format. "Opus" will provide best quality',
      name: 'downloadingFormatDes',
      desc: 'downloadingFormatDes',
      args: [],
    );
  }

  /// `Downloads`
  String get downloads {
    return Intl.message(
      'Downloads',
      name: 'downloads',
      desc: 'downloads',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: 'duration',
      args: [],
    );
  }

  /// `Dynamic`
  String get dynamic {
    return Intl.message('Dynamic', name: 'dynamic', desc: 'dynamic', args: []);
  }

  /// `E-mail`
  String get email {
    return Intl.message('E-mail', name: 'email', desc: 'email', args: []);
  }

  /// `Empty playlist!`
  String get emptyPlaylist {
    return Intl.message(
      'Empty playlist!',
      name: 'emptyPlaylist',
      desc: 'emptyPlaylist',
      args: [],
    );
  }

  /// `Bottom navigation bar`
  String get enableBottomNav {
    return Intl.message(
      'Bottom navigation bar',
      name: 'enableBottomNav',
      desc: 'enableBottomNav',
      args: [],
    );
  }

  /// `Switch to bottom navigation bar`
  String get enableBottomNavDes {
    return Intl.message(
      'Switch to bottom navigation bar',
      name: 'enableBottomNavDes',
      desc: 'enableBottomNavDes',
      args: [],
    );
  }

  /// `Enable slidable actions`
  String get enableSlidableAction {
    return Intl.message(
      'Enable slidable actions',
      name: 'enableSlidableAction',
      desc: 'enableSlidableAction',
      args: [],
    );
  }

  /// `Enable slidable actions on song tile`
  String get enableSlidableActionDes {
    return Intl.message(
      'Enable slidable actions on song tile',
      name: 'enableSlidableActionDes',
      desc: 'enableSlidableActionDes',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message('Enabled', name: 'enabled', desc: 'enabled', args: []);
  }

  /// `End of this song`
  String get endOfThisSong {
    return Intl.message(
      'End of this song',
      name: 'endOfThisSong',
      desc: 'endOfThisSong',
      args: [],
    );
  }

  /// `Enqueue album songs`
  String get enqueueAlbumSongs {
    return Intl.message(
      'Enqueue album songs',
      name: 'enqueueAlbumSongs',
      desc: 'enqueueAlbumSongs',
      args: [],
    );
  }

  /// `Enqueue all`
  String get enqueueAll {
    return Intl.message(
      'Enqueue all',
      name: 'enqueueAll',
      desc: 'enqueueAll',
      args: [],
    );
  }

  /// `Enqueue this song`
  String get enqueueSong {
    return Intl.message(
      'Enqueue this song',
      name: 'enqueueSong',
      desc: 'enqueueSong',
      args: [],
    );
  }

  /// `Enqueue songs`
  String get enqueueSongs {
    return Intl.message(
      'Enqueue songs',
      name: 'enqueueSongs',
      desc: 'enqueueSongs',
      args: [],
    );
  }

  /// `Episodes`
  String get episodes {
    return Intl.message(
      'Episodes',
      name: 'episodes',
      desc: 'episodes',
      args: [],
    );
  }

  /// `Equalizer`
  String get equalizer {
    return Intl.message(
      'Equalizer',
      name: 'equalizer',
      desc: 'equalizer',
      args: [],
    );
  }

  /// `Open system equalizer`
  String get equalizerDes {
    return Intl.message(
      'Open system equalizer',
      name: 'equalizerDes',
      desc: 'equalizerDes',
      args: [],
    );
  }

  /// `Some error occured!`
  String get errorOccuredAlert {
    return Intl.message(
      'Some error occured!',
      name: 'errorOccuredAlert',
      desc: 'errorOccuredAlert',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: 'errorOccurred',
      args: [],
    );
  }

  /// `Error when playing:`
  String get errorPlayingTrack {
    return Intl.message(
      'Error when playing:',
      name: 'errorPlayingTrack',
      desc: 'errorPlayingTrack',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message('Export', name: 'export', desc: 'export', args: []);
  }

  /// `Export downloaded files`
  String get exportDowloadedFiles {
    return Intl.message(
      'Export downloaded files',
      name: 'exportDowloadedFiles',
      desc: 'exportDowloadedFiles',
      args: [],
    );
  }

  /// `Click here to export downloaded file from inApp dir to external dir`
  String get exportDowloadedFilesDes {
    return Intl.message(
      'Click here to export downloaded file from inApp dir to external dir',
      name: 'exportDowloadedFilesDes',
      desc: 'exportDowloadedFilesDes',
      args: [],
    );
  }

  /// `Error exporting playlist`
  String get exportError {
    return Intl.message(
      'Error exporting playlist',
      name: 'exportError',
      desc: 'exportError',
      args: [],
    );
  }

  /// `Error formatting playlist data`
  String get exportErrorFormat {
    return Intl.message(
      'Error formatting playlist data',
      name: 'exportErrorFormat',
      desc: 'exportErrorFormat',
      args: [],
    );
  }

  /// `Permission denied while exporting`
  String get exportErrorPermission {
    return Intl.message(
      'Permission denied while exporting',
      name: 'exportErrorPermission',
      desc: 'exportErrorPermission',
      args: [],
    );
  }

  /// `Not enough storage space`
  String get exportErrorStorage {
    return Intl.message(
      'Not enough storage space',
      name: 'exportErrorStorage',
      desc: 'exportErrorStorage',
      args: [],
    );
  }

  /// `Files successfully exported`
  String get exportMsg {
    return Intl.message(
      'Files successfully exported',
      name: 'exportMsg',
      desc: 'exportMsg',
      args: [],
    );
  }

  /// `Export Playlist`
  String get exportPlaylist {
    return Intl.message(
      'Export Playlist',
      name: 'exportPlaylist',
      desc: 'exportPlaylist',
      args: [],
    );
  }

  /// `Export Playlist as CSV`
  String get exportPlaylistCsv {
    return Intl.message(
      'Export Playlist as CSV',
      name: 'exportPlaylistCsv',
      desc: 'exportPlaylistCsv',
      args: [],
    );
  }

  /// `Can't be imported here`
  String get exportPlaylistCsvSubtitle {
    return Intl.message(
      'Can\'t be imported here',
      name: 'exportPlaylistCsvSubtitle',
      desc: 'exportPlaylistCsvSubtitle',
      args: [],
    );
  }

  /// `Export playlist to JSON`
  String get exportPlaylistJson {
    return Intl.message(
      'Export playlist to JSON',
      name: 'exportPlaylistJson',
      desc: 'exportPlaylistJson',
      args: [],
    );
  }

  /// `This format can be imported`
  String get exportPlaylistJsonSubtitle {
    return Intl.message(
      'This format can be imported',
      name: 'exportPlaylistJsonSubtitle',
      desc: 'exportPlaylistJsonSubtitle',
      args: [],
    );
  }

  /// `Export to Online music`
  String get exportToOnlineMusic {
    return Intl.message(
      'Export to Online music',
      name: 'exportToOnlineMusic',
      desc: 'exportToOnlineMusic',
      args: [],
    );
  }

  /// `It will push your playlist (songs < 50) to current queue, don't forget to add to playlist/save after opening in MusicService`
  String get exportToOnlineMusicSubtitle {
    return Intl.message(
      'It will push your playlist (songs < 50) to current queue, don\'t forget to add to playlist/save after opening in MusicService',
      name: 'exportToOnlineMusicSubtitle',
      desc: 'exportToOnlineMusicSubtitle',
      args: [],
    );
  }

  /// `Downloaded file export location`
  String get exportedFileLocation {
    return Intl.message(
      'Downloaded file export location',
      name: 'exportedFileLocation',
      desc: 'exportedFileLocation',
      args: [],
    );
  }

  /// `Exporting...`
  String get exporting {
    return Intl.message(
      'Exporting...',
      name: 'exporting',
      desc: 'exporting',
      args: [],
    );
  }

  /// `Exporting playlist...`
  String get exportingPlaylist {
    return Intl.message(
      'Exporting playlist...',
      name: 'exportingPlaylist',
      desc: 'exportingPlaylist',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: 'favorites',
      args: [],
    );
  }

  /// `Featured Playlists`
  String get featuredplaylists {
    return Intl.message(
      'Featured Playlists',
      name: 'featuredplaylists',
      desc: 'featuredplaylists',
      args: [],
    );
  }

  /// `File not found`
  String get fileNotFound {
    return Intl.message(
      'File not found',
      name: 'fileNotFound',
      desc: 'fileNotFound',
      args: [],
    );
  }

  /// `Continue`
  String get follow {
    return Intl.message('Continue', name: 'follow', desc: 'follow', args: []);
  }

  /// `followed`
  String get followedArtists {
    return Intl.message(
      'followed',
      name: 'followedArtists',
      desc: 'followedArtists',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: 'following',
      args: [],
    );
  }

  /// `for`
  String get for1 {
    return Intl.message('for', name: 'for1', desc: 'for1', args: []);
  }

  /// `forgotten favorites`
  String get forgottenFavorites {
    return Intl.message(
      'forgotten favorites',
      name: 'forgottenFavorites',
      desc: 'forgottenFavorites',
      args: [],
    );
  }

  /// `Friend`
  String get friendFallback {
    return Intl.message(
      'Friend',
      name: 'friendFallback',
      desc: 'friendFallback',
      args: [],
    );
  }

  /// `Friend request accepted`
  String get friendRequestAccepted {
    return Intl.message(
      'Friend request accepted',
      name: 'friendRequestAccepted',
      desc: 'friendRequestAccepted',
      args: [],
    );
  }

  /// `Friend request sent`
  String get friendRequestSent {
    return Intl.message(
      'Friend request sent',
      name: 'friendRequestSent',
      desc: 'friendRequestSent',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message('Friends', name: 'friends', desc: 'friends', args: []);
  }

  /// `Sign in to find friends.`
  String get friendsLoginRequired {
    return Intl.message(
      'Sign in to find friends.',
      name: 'friendsLoginRequired',
      desc: 'friendsLoginRequired',
      args: [],
    );
  }

  /// `Friendship removed`
  String get friendshipRemoved {
    return Intl.message(
      'Friendship removed',
      name: 'friendshipRemoved',
      desc: 'friendshipRemoved',
      args: [],
    );
  }

  /// `Album`
  String get genericAlbum {
    return Intl.message(
      'Album',
      name: 'genericAlbum',
      desc: 'genericAlbum',
      args: [],
    );
  }

  /// `Mistake`
  String get genericError {
    return Intl.message(
      'Mistake',
      name: 'genericError',
      desc: 'genericError',
      args: [],
    );
  }

  /// `Electronics`
  String get genre_electronic {
    return Intl.message(
      'Electronics',
      name: 'genre_electronic',
      desc: 'genre_electronic',
      args: [],
    );
  }

  /// `hip hop`
  String get genre_hiphop {
    return Intl.message(
      'hip hop',
      name: 'genre_hiphop',
      desc: 'genre_hiphop',
      args: [],
    );
  }

  /// `Jazz`
  String get genre_jazz {
    return Intl.message(
      'Jazz',
      name: 'genre_jazz',
      desc: 'genre_jazz',
      args: [],
    );
  }

  /// `Latin`
  String get genre_latin {
    return Intl.message(
      'Latin',
      name: 'genre_latin',
      desc: 'genre_latin',
      args: [],
    );
  }

  /// `Pop`
  String get genre_pop {
    return Intl.message('Pop', name: 'genre_pop', desc: 'genre_pop', args: []);
  }

  /// `Rock`
  String get genre_rock {
    return Intl.message(
      'Rock',
      name: 'genre_rock',
      desc: 'genre_rock',
      args: [],
    );
  }

  /// `Gesture`
  String get gesture {
    return Intl.message('Gesture', name: 'gesture', desc: 'gesture', args: []);
  }

  /// `GitHub`
  String get github {
    return Intl.message('GitHub', name: 'github', desc: 'github', args: []);
  }

  /// `View GitHub source code \nif you like this project, don't forget to give a ⭐`
  String get githubDes {
    return Intl.message(
      'View GitHub source code \nif you like this project, don\'t forget to give a ⭐',
      name: 'githubDes',
      desc: 'githubDes',
      args: [],
    );
  }

  /// `Go to album`
  String get goToAlbum {
    return Intl.message(
      'Go to album',
      name: 'goToAlbum',
      desc: 'goToAlbum',
      args: [],
    );
  }

  /// `Click here to go to download page`
  String get goToDownloadPage {
    return Intl.message(
      'Click here to go to download page',
      name: 'goToDownloadPage',
      desc: 'goToDownloadPage',
      args: [],
    );
  }

  /// `Hello world`
  String get helloWorld {
    return Intl.message(
      'Hello world',
      name: 'helloWorld',
      desc: 'Este texto es opcional',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: 'high', args: []);
  }

  /// `API URL to Piped instance`
  String get hintApiUrl {
    return Intl.message(
      'API URL to Piped instance',
      name: 'hintApiUrl',
      desc: 'hintApiUrl',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: 'home', args: []);
  }

  /// `Home content count`
  String get homeContentCount {
    return Intl.message(
      'Home content count',
      name: 'homeContentCount',
      desc: 'homeContentCount',
      args: [],
    );
  }

  /// `Select the number of initial homescreen-content(approx). Lesser results faster loading`
  String get homeContentCountDes {
    return Intl.message(
      'Select the number of initial homescreen-content(approx). Lesser results faster loading',
      name: 'homeContentCountDes',
      desc: 'homeContentCountDes',
      args: [],
    );
  }

  /// `Id`
  String get id {
    return Intl.message('Id', name: 'id', desc: 'id', args: []);
  }

  /// `Identify metadata`
  String get identifySongMetadata {
    return Intl.message(
      'Identify metadata',
      name: 'identifySongMetadata',
      desc: 'Action that searches and stores metadata for a local song',
      args: [],
    );
  }

  /// `Ignore battery optimization`
  String get ignoreBatOpt {
    return Intl.message(
      'Ignore battery optimization',
      name: 'ignoreBatOpt',
      desc: 'ignoreBatOpt',
      args: [],
    );
  }

  /// `If you are facing notification issues or playback stopped by system optimization, please enable this option`
  String get ignoreBatOptDes {
    return Intl.message(
      'If you are facing notification issues or playback stopped by system optimization, please enable this option',
      name: 'ignoreBatOptDes',
      desc: 'ignoreBatOptDes',
      args: [],
    );
  }

  /// `Error importing playlist`
  String get importError {
    return Intl.message(
      'Error importing playlist',
      name: 'importError',
      desc: 'importError',
      args: [],
    );
  }

  /// `Error saving to database`
  String get importErrorDatabase {
    return Intl.message(
      'Error saving to database',
      name: 'importErrorDatabase',
      desc: 'importErrorDatabase',
      args: [],
    );
  }

  /// `Could not access the selected file`
  String get importErrorFileAccess {
    return Intl.message(
      'Could not access the selected file',
      name: 'importErrorFileAccess',
      desc: 'importErrorFileAccess',
      args: [],
    );
  }

  /// `Invalid file format`
  String get importErrorFormat {
    return Intl.message(
      'Invalid file format',
      name: 'importErrorFormat',
      desc: 'importErrorFormat',
      args: [],
    );
  }

  /// `Note: Large playlists may take longer to import`
  String get importLargeFileNote {
    return Intl.message(
      'Note: Large playlists may take longer to import',
      name: 'importLargeFileNote',
      desc: 'importLargeFileNote',
      args: [],
    );
  }

  /// `Import Playlist`
  String get importPlaylist {
    return Intl.message(
      'Import Playlist',
      name: 'importPlaylist',
      desc: 'importPlaylist',
      args: [],
    );
  }

  /// `Select a previously exported playlist JSON file to import`
  String get importPlaylistDesc {
    return Intl.message(
      'Select a previously exported playlist JSON file to import',
      name: 'importPlaylistDesc',
      desc: 'importPlaylistDesc',
      args: [],
    );
  }

  /// `Imported`
  String get imported {
    return Intl.message(
      'Imported',
      name: 'imported',
      desc: 'imported',
      args: [],
    );
  }

  /// `Imported from Joss Music Kotlin`
  String get importedFromJossMusic {
    return Intl.message(
      'Imported from Joss Music Kotlin',
      name: 'importedFromJossMusic',
      desc: 'importedFromJossMusic',
      args: [],
    );
  }

  /// `Imported Playlist`
  String get importedPlaylist {
    return Intl.message(
      'Imported Playlist',
      name: 'importedPlaylist',
      desc: 'importedPlaylist',
      args: [],
    );
  }

  /// `Importing playlist...`
  String get importingPlaylist {
    return Intl.message(
      'Importing playlist...',
      name: 'importingPlaylist',
      desc: 'importingPlaylist',
      args: [],
    );
  }

  /// `In App storage directory`
  String get in_app_storage {
    return Intl.message(
      'In App storage directory',
      name: 'in_app_storage',
      desc: 'in_app_storage',
      args: [],
    );
  }

  /// `Include downloded songs files`
  String get includeDownloadedFiles {
    return Intl.message(
      'Include downloded songs files',
      name: 'includeDownloadedFiles',
      desc: 'includeDownloadedFiles',
      args: [],
    );
  }

  /// `Information not available`
  String get infoNotAvailable {
    return Intl.message(
      'Information not available',
      name: 'infoNotAvailable',
      desc: 'infoNotAvailable',
      args: [],
    );
  }

  /// `Invalid playlist file structure`
  String get invalidPlaylistFile {
    return Intl.message(
      'Invalid playlist file structure',
      name: 'invalidPlaylistFile',
      desc: 'invalidPlaylistFile',
      args: [],
    );
  }

  /// `Invalid server response.`
  String get invalidServerResponse {
    return Intl.message(
      'Invalid server response.',
      name: 'invalidServerResponse',
      desc: 'invalidServerResponse',
      args: [],
    );
  }

  /// `The session does not contain a valid token.`
  String get invalidSessionToken {
    return Intl.message(
      'The session does not contain a valid token.',
      name: 'invalidSessionToken',
      desc: 'invalidSessionToken',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message('items', name: 'items', desc: 'items', args: []);
  }

  /// `keep listening`
  String get keepListening {
    return Intl.message(
      'keep listening',
      name: 'keepListening',
      desc: 'keepListening',
      args: [],
    );
  }

  /// `Keep screen on while playing`
  String get keepScreenOnWhilePlaying {
    return Intl.message(
      'Keep screen on while playing',
      name: 'keepScreenOnWhilePlaying',
      desc: 'keepScreenOnWhilePlaying',
      args: [],
    );
  }

  /// `If enabled, the device screen will stay awake while music is playing`
  String get keepScreenOnWhilePlayingDes {
    return Intl.message(
      'If enabled, the device screen will stay awake while music is playing',
      name: 'keepScreenOnWhilePlayingDes',
      desc: 'keepScreenOnWhilePlayingDes',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'language',
      args: [],
    );
  }

  /// `Set App language`
  String get languageDes {
    return Intl.message(
      'Set App language',
      name: 'languageDes',
      desc: 'languageDes',
      args: [],
    );
  }

  /// `Latest release`
  String get latestRelease {
    return Intl.message(
      'Latest release',
      name: 'latestRelease',
      desc: 'latestRelease',
      args: [],
    );
  }

  /// `Latest Version Available`
  String get latestVersion {
    return Intl.message(
      'Latest Version Available',
      name: 'latestVersion',
      desc: 'latestVersion',
      args: [],
    );
  }

  /// `Let's start..`
  String get letsStrart {
    return Intl.message(
      'Let\'s start..',
      name: 'letsStrart',
      desc: 'letsStrart',
      args: [],
    );
  }

  /// `Library Albums`
  String get libAlbums {
    return Intl.message(
      'Library Albums',
      name: 'libAlbums',
      desc: 'libAlbums',
      args: [],
    );
  }

  /// `Library Artists`
  String get libArtists {
    return Intl.message(
      'Library Artists',
      name: 'libArtists',
      desc: 'libArtists',
      args: [],
    );
  }

  /// `Library Playlists`
  String get libPlaylists {
    return Intl.message(
      'Library Playlists',
      name: 'libPlaylists',
      desc: 'libPlaylists',
      args: [],
    );
  }

  /// `Library Songs`
  String get libSongs {
    return Intl.message(
      'Library Songs',
      name: 'libSongs',
      desc: 'libSongs',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message('Library', name: 'library', desc: 'library', args: []);
  }

  /// `Library Playlist`
  String get libraryPlaylistDescription {
    return Intl.message(
      'Library Playlist',
      name: 'libraryPlaylistDescription',
      desc: 'libraryPlaylistDescription',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: 'light', args: []);
  }

  /// `Link`
  String get link {
    return Intl.message('Link', name: 'link', desc: 'link', args: []);
  }

  /// `Linked successfully!`
  String get linkAlert {
    return Intl.message(
      'Linked successfully!',
      name: 'linkAlert',
      desc: 'linkAlert',
      args: [],
    );
  }

  /// `Link copied to clipboard`
  String get linkCopied {
    return Intl.message(
      'Link copied to clipboard',
      name: 'linkCopied',
      desc: 'linkCopied',
      args: [],
    );
  }

  /// `Link with piped for playlists`
  String get linkPipedDes {
    return Intl.message(
      'Link with piped for playlists',
      name: 'linkPipedDes',
      desc: 'linkPipedDes',
      args: [],
    );
  }

  /// `Listen now`
  String get listenNow {
    return Intl.message(
      'Listen now',
      name: 'listenNow',
      desc: 'listenNow',
      args: [],
    );
  }

  /// `Listening to the environment...`
  String get listeningToEnvironment {
    return Intl.message(
      'Listening to the environment...',
      name: 'listeningToEnvironment',
      desc: 'listeningToEnvironment',
      args: [],
    );
  }

  /// `Could not load update information`
  String get loadInfoUpdate {
    return Intl.message(
      'Could not load update information',
      name: 'loadInfoUpdate',
      desc: 'loadInfoUpdate',
      args: [],
    );
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: 'local', args: []);
  }

  /// `It works without the need to log in.`
  String get local_b1 {
    return Intl.message(
      'It works without the need to log in.',
      name: 'local_b1',
      desc: 'local_b1',
      args: [],
    );
  }

  /// `Your entire library stays strictly on this computer.`
  String get local_b2 {
    return Intl.message(
      'Your entire library stays strictly on this computer.',
      name: 'local_b2',
      desc: 'local_b2',
      args: [],
    );
  }

  /// `Note: No manual cloud backups. `
  String get local_b3 {
    return Intl.message(
      'Note: No manual cloud backups. ',
      name: 'local_b3',
      desc: 'local_b3',
      args: [],
    );
  }

  /// `Use only on this device`
  String get local_btn {
    return Intl.message(
      'Use only on this device',
      name: 'local_btn',
      desc: 'local_btn',
      args: [],
    );
  }

  /// `Absolute privacy on your device`
  String get local_subtitle {
    return Intl.message(
      'Absolute privacy on your device',
      name: 'local_subtitle',
      desc: 'local_subtitle',
      args: [],
    );
  }

  /// `Local Mode`
  String get local_title {
    return Intl.message(
      'Local Mode',
      name: 'local_title',
      desc: 'local_title',
      args: [],
    );
  }

  /// `LoudnessDb`
  String get loudnessDb {
    return Intl.message(
      'LoudnessDb',
      name: 'loudnessDb',
      desc: 'loudnessDb',
      args: [],
    );
  }

  /// `Loudness normalization`
  String get loudnessNormalization {
    return Intl.message(
      'Loudness normalization',
      name: 'loudnessNormalization',
      desc: 'loudnessNormalization',
      args: [],
    );
  }

  /// `Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))`
  String get loudnessNormalizationDes {
    return Intl.message(
      'Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))',
      name: 'loudnessNormalizationDes',
      desc: 'loudnessNormalizationDes',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: 'low', args: []);
  }

  /// `Lyrics`
  String get lyrics {
    return Intl.message('Lyrics', name: 'lyrics', desc: 'lyrics', args: []);
  }

  /// `Lyrics not available!`
  String get lyricsNotAvailable {
    return Intl.message(
      'Lyrics not available!',
      name: 'lyricsNotAvailable',
      desc: 'lyricsNotAvailable',
      args: [],
    );
  }

  /// `Manage collaborators (friends)`
  String get manageCollaborators {
    return Intl.message(
      'Manage collaborators (friends)',
      name: 'manageCollaborators',
      desc: 'manageCollaborators',
      args: [],
    );
  }

  /// `Metadata was saved for this song.`
  String get metadataApplySuccess {
    return Intl.message(
      'Metadata was saved for this song.',
      name: 'metadataApplySuccess',
      desc: 'Success message after saving local metadata',
      args: [],
    );
  }

  /// `No matches found. Try a different search.`
  String get metadataNoResults {
    return Intl.message(
      'No matches found. Try a different search.',
      name: 'metadataNoResults',
      desc: 'Empty state for metadata search',
      args: [],
    );
  }

  /// `The metadata operation failed.`
  String get metadataOperationFailed {
    return Intl.message(
      'The metadata operation failed.',
      name: 'metadataOperationFailed',
      desc: 'Generic metadata lookup or write error',
      args: [],
    );
  }

  /// `This will replace the title, artist, album and cover shown in the local profile while preserving fields the match does not provide.`
  String get metadataOverwriteWarning {
    return Intl.message(
      'This will replace the title, artist, album and cover shown in the local profile while preserving fields the match does not provide.',
      name: 'metadataOverwriteWarning',
      desc: 'Confirmation before storing metadata for a local song',
      args: [],
    );
  }

  /// `Choose the correct match to save its title, artist, album and cover. The audio file will not be modified.`
  String get metadataSearchDescription {
    return Intl.message(
      'Choose the correct match to save its title, artist, album and cover. The audio file will not be modified.',
      name: 'metadataSearchDescription',
      desc: 'Explanation shown above metadata search results',
      args: [],
    );
  }

  /// `Song or artist name`
  String get metadataSearchHint {
    return Intl.message(
      'Song or artist name',
      name: 'metadataSearchHint',
      desc: 'Hint for the metadata search field',
      args: [],
    );
  }

  /// `Identify song`
  String get metadataSearchTitle {
    return Intl.message(
      'Identify song',
      name: 'metadataSearchTitle',
      desc: 'Title of the local song metadata search dialog',
      args: [],
    );
  }

  /// `Make sure the music is playing loud enough near your microphone.`
  String get micInstruction {
    return Intl.message(
      'Make sure the music is playing loud enough near your microphone.',
      name: 'micInstruction',
      desc: 'micInstruction',
      args: [],
    );
  }

  /// `Migrated album`
  String get migratedAlbum {
    return Intl.message(
      'Migrated album',
      name: 'migratedAlbum',
      desc: 'migratedAlbum',
      args: [],
    );
  }

  /// `Migrated library`
  String get migratedLibrary {
    return Intl.message(
      'Migrated library',
      name: 'migratedLibrary',
      desc: 'migratedLibrary',
      args: [],
    );
  }

  /// `Migrated Playlist`
  String get migratedPlaylist {
    return Intl.message(
      'Migrated Playlist',
      name: 'migratedPlaylist',
      desc: 'migratedPlaylist',
      args: [],
    );
  }

  /// `There is already a migration in progress.`
  String get migrationAlreadyRunning {
    return Intl.message(
      'There is already a migration in progress.',
      name: 'migrationAlreadyRunning',
      desc: 'migrationAlreadyRunning',
      args: [],
    );
  }

  /// `Analyzing the local library...`
  String get migrationAnalyzingLocal {
    return Intl.message(
      'Analyzing the local library...',
      name: 'migrationAnalyzingLocal',
      desc: 'migrationAnalyzingLocal',
      args: [],
    );
  }

  /// `Checking if EMusic Cloud already has a library...`
  String get migrationCheckingCloud {
    return Intl.message(
      'Checking if EMusic Cloud already has a library...',
      name: 'migrationCheckingCloud',
      desc: 'migrationCheckingCloud',
      args: [],
    );
  }

  /// `Migration completed.`
  String get migrationCompleted {
    return Intl.message(
      'Migration completed.',
      name: 'migrationCompleted',
      desc: 'migrationCompleted',
      args: [],
    );
  }

  /// `Creating a local backup before connecting cloud...`
  String get migrationCreatingBackup {
    return Intl.message(
      'Creating a local backup before connecting cloud...',
      name: 'migrationCreatingBackup',
      desc: 'migrationCreatingBackup',
      args: [],
    );
  }

  /// `The migration failed. `
  String get migrationFailedLocalPreserved {
    return Intl.message(
      'The migration failed. ',
      name: 'migrationFailedLocalPreserved',
      desc: 'migrationFailedLocalPreserved',
      args: [],
    );
  }

  /// `Log in to Joss Red before migrating.`
  String get migrationLoginRequired {
    return Intl.message(
      'Log in to Joss Red before migrating.',
      name: 'migrationLoginRequired',
      desc: 'migrationLoginRequired',
      args: [],
    );
  }

  /// `Preparing the migration in EMusic Cloud...`
  String get migrationPreparingCloud {
    return Intl.message(
      'Preparing the migration in EMusic Cloud...',
      name: 'migrationPreparingCloud',
      desc: 'migrationPreparingCloud',
      args: [],
    );
  }

  /// `EMusic Cloud could not start the migration.`
  String get migrationStartFailed {
    return Intl.message(
      'EMusic Cloud could not start the migration.',
      name: 'migrationStartFailed',
      desc: 'migrationStartFailed',
      args: [],
    );
  }

  /// `Not all data could be uploaded. `
  String get migrationUploadIncomplete {
    return Intl.message(
      'Not all data could be uploaded. ',
      name: 'migrationUploadIncomplete',
      desc: 'migrationUploadIncomplete',
      args: [],
    );
  }

  /// `Uploading playlists, favorites and history...`
  String get migrationUploadingData {
    return Intl.message(
      'Uploading playlists, favorites and history...',
      name: 'migrationUploadingData',
      desc: 'migrationUploadingData',
      args: [],
    );
  }

  /// `EMusic Cloud could not validate the migration.`
  String get migrationValidationFailed {
    return Intl.message(
      'EMusic Cloud could not validate the migration.',
      name: 'migrationValidationFailed',
      desc: 'migrationValidationFailed',
      args: [],
    );
  }

  /// `Verifying integrity in EMusic Cloud...`
  String get migrationVerifyingIntegrity {
    return Intl.message(
      'Verifying integrity in EMusic Cloud...',
      name: 'migrationVerifyingIntegrity',
      desc: 'migrationVerifyingIntegrity',
      args: [],
    );
  }

  /// `Select file and import`
  String get migration_btn_select {
    return Intl.message(
      'Select file and import',
      name: 'migration_btn_select',
      desc: 'migration_btn_select',
      args: [],
    );
  }

  /// `Select song.db or a .backup file`
  String get migration_select_file_dialog {
    return Intl.message(
      'Select song.db or a .backup file',
      name: 'migration_select_file_dialog',
      desc: 'migration_select_file_dialog',
      args: [],
    );
  }

  /// `Migration completed successfully.`
  String get migration_success {
    return Intl.message(
      'Migration completed successfully.',
      name: 'migration_success',
      desc: 'migration_success',
      args: [],
    );
  }

  /// `Albums: {count}`
  String migration_summary_albums(num count) {
    return Intl.message(
      'Albums: $count',
      name: 'migration_summary_albums',
      desc: 'migration_summary_albums',
      args: [count],
    );
  }

  /// `Artists: {count}`
  String migration_summary_artists(num count) {
    return Intl.message(
      'Artists: $count',
      name: 'migration_summary_artists',
      desc: 'migration_summary_artists',
      args: [count],
    );
  }

  /// `Favorites: {count}`
  String migration_summary_favorites(num count) {
    return Intl.message(
      'Favorites: $count',
      name: 'migration_summary_favorites',
      desc: 'migration_summary_favorites',
      args: [count],
    );
  }

  /// `Playlists: {count}`
  String migration_summary_playlists(num count) {
    return Intl.message(
      'Playlists: $count',
      name: 'migration_summary_playlists',
      desc: 'migration_summary_playlists',
      args: [count],
    );
  }

  /// `Songs: {count}`
  String migration_summary_songs(num count) {
    return Intl.message(
      'Songs: $count',
      name: 'migration_summary_songs',
      desc: 'migration_summary_songs',
      args: [count],
    );
  }

  /// `Migration completed from {source}.`
  String migration_summary_start(String source) {
    return Intl.message(
      'Migration completed from $source.',
      name: 'migration_summary_start',
      desc: 'migration_summary_start',
      args: [source],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message('minutes', name: 'minutes', desc: 'minutes', args: []);
  }

  /// `Misc`
  String get misc {
    return Intl.message('Misc', name: 'misc', desc: 'misc', args: []);
  }

  /// `The most listened to song`
  String get mostListenedSong {
    return Intl.message(
      'The most listened to song',
      name: 'mostListenedSong',
      desc: 'mostListenedSong',
      args: [],
    );
  }

  /// `Music & Playback`
  String get musicAndPlayback {
    return Intl.message(
      'Music & Playback',
      name: 'musicAndPlayback',
      desc: 'musicAndPlayback',
      args: [],
    );
  }

  /// `Music Recognition`
  String get musicRecognition {
    return Intl.message(
      'Music Recognition',
      name: 'musicRecognition',
      desc: 'musicRecognition',
      args: [],
    );
  }

  /// `Network error! Check your network connection.`
  String get networkError {
    return Intl.message(
      'Network error! Check your network connection.',
      name: 'networkError',
      desc: 'networkError',
      args: [],
    );
  }

  /// `Oops network error!`
  String get networkError1 {
    return Intl.message(
      'Oops network error!',
      name: 'networkError1',
      desc: 'networkError1',
      args: [],
    );
  }

  /// `New version available!`
  String get newVersionAvailable {
    return Intl.message(
      'New version available!',
      name: 'newVersionAvailable',
      desc: 'newVersionAvailable',
      args: [],
    );
  }

  /// `Joss Red App (Play Store)`
  String get news_btn_app {
    return Intl.message(
      'Joss Red App (Play Store)',
      name: 'news_btn_app',
      desc: 'news_btn_app',
      args: [],
    );
  }

  /// `Understood`
  String get news_btn_dismiss {
    return Intl.message(
      'Understood',
      name: 'news_btn_dismiss',
      desc: 'news_btn_dismiss',
      args: [],
    );
  }

  /// `Joss Red Web`
  String get news_btn_web {
    return Intl.message(
      'Joss Red Web',
      name: 'news_btn_web',
      desc: 'news_btn_web',
      args: [],
    );
  }

  /// `100% synchronization with Joss Red, playlists with friends and much more. `
  String get news_card_subtitle {
    return Intl.message(
      '100% synchronization with Joss Red, playlists with friends and much more. ',
      name: 'news_card_subtitle',
      desc: 'news_card_subtitle',
      args: [],
    );
  }

  /// `Estrella Music has evolved!`
  String get news_card_title {
    return Intl.message(
      'Estrella Music has evolved!',
      name: 'news_card_title',
      desc: 'news_card_title',
      args: [],
    );
  }

  /// `To add friends, accept requests or manage your security profile, please use Joss Red on its official platforms:`
  String get news_dialog_friends_desc {
    return Intl.message(
      'To add friends, accept requests or manage your security profile, please use Joss Red on its official platforms:',
      name: 'news_dialog_friends_desc',
      desc: 'news_dialog_friends_desc',
      args: [],
    );
  }

  /// `Friends and Account Management:`
  String get news_dialog_section_friends {
    return Intl.message(
      'Friends and Account Management:',
      name: 'news_dialog_section_friends',
      desc: 'news_dialog_section_friends',
      args: [],
    );
  }

  /// `Estrella Music News`
  String get news_dialog_title {
    return Intl.message(
      'Estrella Music News',
      name: 'news_dialog_title',
      desc: 'news_dialog_title',
      args: [],
    );
  }

  /// `Create playlists with your friends! `
  String get news_item_collab_desc {
    return Intl.message(
      'Create playlists with your friends! ',
      name: 'news_item_collab_desc',
      desc: 'news_item_collab_desc',
      args: [],
    );
  }

  /// `Collaborative Playlists`
  String get news_item_collab_title {
    return Intl.message(
      'Collaborative Playlists',
      name: 'news_item_collab_title',
      desc: 'news_item_collab_title',
      args: [],
    );
  }

  /// `Your playlists and favorites are now saved and synced in the cloud automatically with your main Joss Red account.`
  String get news_item_sync_desc {
    return Intl.message(
      'Your playlists and favorites are now saved and synced in the cloud automatically with your main Joss Red account.',
      name: 'news_item_sync_desc',
      desc: 'news_item_sync_desc',
      args: [],
    );
  }

  /// `Full Integration with Joss Red`
  String get news_item_sync_title {
    return Intl.message(
      'Full Integration with Joss Red',
      name: 'news_item_sync_title',
      desc: 'news_item_sync_title',
      args: [],
    );
  }

  /// `You no longer need to click manual sync buttons; `
  String get news_item_trans_desc {
    return Intl.message(
      'You no longer need to click manual sync buttons; ',
      name: 'news_item_trans_desc',
      desc: 'news_item_trans_desc',
      args: [],
    );
  }

  /// `Transparent Synchronization`
  String get news_item_trans_title {
    return Intl.message(
      'Transparent Synchronization',
      name: 'news_item_trans_title',
      desc: 'news_item_trans_title',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: 'no', args: []);
  }

  /// `No bookmarks!`
  String get noBookmarks {
    return Intl.message(
      'No bookmarks!',
      name: 'noBookmarks',
      desc: 'noBookmarks',
      args: [],
    );
  }

  /// `You have no added friends on Joss Red.`
  String get noJossRedFriends {
    return Intl.message(
      'You have no added friends on Joss Red.',
      name: 'noJossRedFriends',
      desc: 'noJossRedFriends',
      args: [],
    );
  }

  /// `You don't have any lib playlist!`
  String get noLibPlaylist {
    return Intl.message(
      'You don\'t have any lib playlist!',
      name: 'noLibPlaylist',
      desc: 'noLibPlaylist',
      args: [],
    );
  }

  /// `Could not find any songs in the recorded audio`
  String get noMatchInstruction {
    return Intl.message(
      'Could not find any songs in the recorded audio',
      name: 'noMatchInstruction',
      desc: 'noMatchInstruction',
      args: [],
    );
  }

  /// `No Matches`
  String get noMatchesFound {
    return Intl.message(
      'No Matches',
      name: 'noMatchesFound',
      desc: 'noMatchesFound',
      args: [],
    );
  }

  /// `No offline songs!`
  String get noOfflineSong {
    return Intl.message(
      'No offline songs!',
      name: 'noOfflineSong',
      desc: 'noOfflineSong',
      args: [],
    );
  }

  /// `There are no songs in this collection`
  String get noSongsInCollection {
    return Intl.message(
      'There are no songs in this collection',
      name: 'noSongsInCollection',
      desc: 'noSongsInCollection',
      args: [],
    );
  }

  /// `No Match found for`
  String get nomatch {
    return Intl.message(
      'No Match found for',
      name: 'nomatch',
      desc: 'nomatch',
      args: [],
    );
  }

  /// `Not authenticated`
  String get notAuthenticated {
    return Intl.message(
      'Not authenticated',
      name: 'notAuthenticated',
      desc: 'notAuthenticated',
      args: [],
    );
  }

  /// `Not a Song/Music-Video!`
  String get notaSongVideo {
    return Intl.message(
      'Not a Song/Music-Video!',
      name: 'notaSongVideo',
      desc: 'notaSongVideo',
      args: [],
    );
  }

  /// `Not a valid link!`
  String get notaValidLink {
    return Intl.message(
      'Not a valid link!',
      name: 'notaValidLink',
      desc: 'notaValidLink',
      args: [],
    );
  }

  /// `Open in`
  String get openIn {
    return Intl.message('Open in', name: 'openIn', desc: 'openIn', args: []);
  }

  /// `Operation failed`
  String get operationFailed {
    return Intl.message(
      'Operation failed',
      name: 'operationFailed',
      desc: 'operationFailed',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'password',
      args: [],
    );
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

  /// `Permission denied`
  String get permissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'permissionDenied',
      desc: 'permissionDenied',
      args: [],
    );
  }

  /// `Allow`
  String get permissionsAllow {
    return Intl.message(
      'Allow',
      name: 'permissionsAllow',
      desc: 'permissionsAllow',
      args: [],
    );
  }

  /// `Estrella Music needs these permissions to manage your music and offer all playback features.`
  String get permissionsConsentDescription {
    return Intl.message(
      'Estrella Music needs these permissions to manage your music and offer all playback features.',
      name: 'permissionsConsentDescription',
      desc: 'permissionsConsentDescription',
      args: [],
    );
  }

  /// `Permissions to get started`
  String get permissionsConsentTitle {
    return Intl.message(
      'Permissions to get started',
      name: 'permissionsConsentTitle',
      desc: 'permissionsConsentTitle',
      args: [],
    );
  }

  /// `Grant required permissions`
  String get permissionsContinueButton {
    return Intl.message(
      'Grant required permissions',
      name: 'permissionsContinueButton',
      desc: 'permissionsContinueButton',
      args: [],
    );
  }

  /// `It is used only when you choose to identify a song that is playing around you.`
  String get permissionsMicrophoneDescription {
    return Intl.message(
      'It is used only when you choose to identify a song that is playing around you.',
      name: 'permissionsMicrophoneDescription',
      desc: 'permissionsMicrophoneDescription',
      args: [],
    );
  }

  /// `Microphone`
  String get permissionsMicrophoneTitle {
    return Intl.message(
      'Microphone',
      name: 'permissionsMicrophoneTitle',
      desc: 'permissionsMicrophoneTitle',
      args: [],
    );
  }

  /// `Shows playback controls, download progress, and important app notices.`
  String get permissionsNotificationsDescription {
    return Intl.message(
      'Shows playback controls, download progress, and important app notices.',
      name: 'permissionsNotificationsDescription',
      desc: 'permissionsNotificationsDescription',
      args: [],
    );
  }

  /// `Notifications`
  String get permissionsNotificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'permissionsNotificationsTitle',
      desc: 'permissionsNotificationsTitle',
      args: [],
    );
  }

  /// `Settings`
  String get permissionsOpenSettings {
    return Intl.message(
      'Settings',
      name: 'permissionsOpenSettings',
      desc: 'permissionsOpenSettings',
      args: [],
    );
  }

  /// `All three permits are required to continue. `
  String get permissionsRequiredNotice {
    return Intl.message(
      'All three permits are required to continue. ',
      name: 'permissionsRequiredNotice',
      desc: 'permissionsRequiredNotice',
      args: [],
    );
  }

  /// `It allows you to play music, save downloads, export playlists and prepare updates.`
  String get permissionsStorageDescription {
    return Intl.message(
      'It allows you to play music, save downloads, export playlists and prepare updates.',
      name: 'permissionsStorageDescription',
      desc: 'permissionsStorageDescription',
      args: [],
    );
  }

  /// `Music and storage`
  String get permissionsStorageTitle {
    return Intl.message(
      'Music and storage',
      name: 'permissionsStorageTitle',
      desc: 'permissionsStorageTitle',
      args: [],
    );
  }

  /// `Personalisation`
  String get personalisation {
    return Intl.message(
      'Personalisation',
      name: 'personalisation',
      desc: 'personalisation',
      args: [],
    );
  }

  /// `Piped Playlist`
  String get pipedPlaylistDescription {
    return Intl.message(
      'Piped Playlist',
      name: 'pipedPlaylistDescription',
      desc: 'pipedPlaylistDescription',
      args: [],
    );
  }

  /// `Piped playlist synced!`
  String get pipedplstSyncAlert {
    return Intl.message(
      'Piped playlist synced!',
      name: 'pipedplstSyncAlert',
      desc: 'pipedplstSyncAlert',
      args: [],
    );
  }

  /// `Plain`
  String get plain {
    return Intl.message('Plain', name: 'plain', desc: 'plain', args: []);
  }

  /// `Play`
  String get play {
    return Intl.message('Play', name: 'play', desc: 'play', args: []);
  }

  /// `Play next`
  String get playNext {
    return Intl.message(
      'Play next',
      name: 'playNext',
      desc: 'playNext',
      args: [],
    );
  }

  /// `Play Now`
  String get playNow {
    return Intl.message('Play Now', name: 'playNow', desc: 'playNow', args: []);
  }

  /// `Playback speed`
  String get playbackSpeed {
    return Intl.message(
      'Playback speed',
      name: 'playbackSpeed',
      desc: 'playbackSpeed',
      args: [],
    );
  }

  /// `Player Ui`
  String get playerUi {
    return Intl.message(
      'Player Ui',
      name: 'playerUi',
      desc: 'playerUi',
      args: [],
    );
  }

  /// `Select player user interface`
  String get playerUiDes {
    return Intl.message(
      'Select player user interface',
      name: 'playerUiDes',
      desc: 'playerUiDes',
      args: [],
    );
  }

  /// `Playing:`
  String get playingRecognizedTrack {
    return Intl.message(
      'Playing:',
      name: 'playingRecognizedTrack',
      desc: 'playingRecognizedTrack',
      args: [],
    );
  }

  /// `PLAYING FROM ÁLBUM`
  String get playingfromAlbum {
    return Intl.message(
      'PLAYING FROM ÁLBUM',
      name: 'playingfromAlbum',
      desc: 'playingfromAlbum',
      args: [],
    );
  }

  /// `PLAYING FROM ARTIST`
  String get playingfromArtist {
    return Intl.message(
      'PLAYING FROM ARTIST',
      name: 'playingfromArtist',
      desc: 'playingfromArtist',
      args: [],
    );
  }

  /// `PLAYING FROM PLAYLIST`
  String get playingfromPlaylist {
    return Intl.message(
      'PLAYING FROM PLAYLIST',
      name: 'playingfromPlaylist',
      desc: 'playingfromPlaylist',
      args: [],
    );
  }

  /// `PLAYING FROM SELECTION`
  String get playingfromSelection {
    return Intl.message(
      'PLAYING FROM SELECTION',
      name: 'playingfromSelection',
      desc: 'playingfromSelection',
      args: [],
    );
  }

  /// `Playlist`
  String get playlist {
    return Intl.message(
      'Playlist',
      name: 'playlist',
      desc: 'playlist',
      args: [],
    );
  }

  /// `Playlist blacklisted!`
  String get playlistBlacklistAlert {
    return Intl.message(
      'Playlist blacklisted!',
      name: 'playlistBlacklistAlert',
      desc: 'playlistBlacklistAlert',
      args: [],
    );
  }

  /// `Playlist bookmarked!`
  String get playlistBookmarkAddAlert {
    return Intl.message(
      'Playlist bookmarked!',
      name: 'playlistBookmarkAddAlert',
      desc: 'playlistBookmarkAddAlert',
      args: [],
    );
  }

  /// `Playlist bookmark removed!`
  String get playlistBookmarkRemoveAlert {
    return Intl.message(
      'Playlist bookmark removed!',
      name: 'playlistBookmarkRemoveAlert',
      desc: 'playlistBookmarkRemoveAlert',
      args: [],
    );
  }

  /// `Playlist contributors`
  String get playlistCollaboratorsTitle {
    return Intl.message(
      'Playlist contributors',
      name: 'playlistCollaboratorsTitle',
      desc: 'playlistCollaboratorsTitle',
      args: [],
    );
  }

  /// `Playlist created!`
  String get playlistCreatedAlert {
    return Intl.message(
      'Playlist created!',
      name: 'playlistCreatedAlert',
      desc: 'playlistCreatedAlert',
      args: [],
    );
  }

  /// `Playlist created & song added!`
  String get playlistCreatednsongAddedAlert {
    return Intl.message(
      'Playlist created & song added!',
      name: 'playlistCreatednsongAddedAlert',
      desc: 'playlistCreatednsongAddedAlert',
      args: [],
    );
  }

  /// `Playlist exported successfully to`
  String get playlistExportedMsg {
    return Intl.message(
      'Playlist exported successfully to',
      name: 'playlistExportedMsg',
      desc: 'playlistExportedMsg',
      args: [],
    );
  }

  /// `Playlist imported successfully`
  String get playlistImportedMsg {
    return Intl.message(
      'Playlist imported successfully',
      name: 'playlistImportedMsg',
      desc: 'playlistImportedMsg',
      args: [],
    );
  }

  /// `Playlist removed!`
  String get playlistRemovedAlert {
    return Intl.message(
      'Playlist removed!',
      name: 'playlistRemovedAlert',
      desc: 'playlistRemovedAlert',
      args: [],
    );
  }

  /// `Renamed successfully!`
  String get playlistRenameAlert {
    return Intl.message(
      'Renamed successfully!',
      name: 'playlistRenameAlert',
      desc: 'playlistRenameAlert',
      args: [],
    );
  }

  /// `Playlists`
  String get playlists {
    return Intl.message(
      'Playlists',
      name: 'playlists',
      desc: 'playlists',
      args: [],
    );
  }

  /// `Upcoming`
  String get playnextMsg {
    return Intl.message(
      'Upcoming',
      name: 'playnextMsg',
      desc: 'playnextMsg',
      args: [],
    );
  }

  /// `Podcasts`
  String get podcasts {
    return Intl.message(
      'Podcasts',
      name: 'podcasts',
      desc: 'podcasts',
      args: [],
    );
  }

  /// `Popular tracks`
  String get popularTracks {
    return Intl.message(
      'Popular tracks',
      name: 'popularTracks',
      desc: 'popularTracks',
      args: [],
    );
  }

  /// `Processing files...`
  String get processFiles {
    return Intl.message(
      'Processing files...',
      name: 'processFiles',
      desc: 'processFiles',
      args: [],
    );
  }

  /// `Processing the audio...`
  String get processingAudio {
    return Intl.message(
      'Processing the audio...',
      name: 'processingAudio',
      desc: 'processingAudio',
      args: [],
    );
  }

  /// `Profiles`
  String get profiles {
    return Intl.message(
      'Profiles',
      name: 'profiles',
      desc: 'profiles',
      args: [],
    );
  }

  /// `Queue loop`
  String get queueLoop {
    return Intl.message(
      'Queue loop',
      name: 'queueLoop',
      desc: 'queueLoop',
      args: [],
    );
  }

  /// `Queue loop mode cannot be disabled when shuffle mode is enabled.`
  String get queueLoopNotDisMsg1 {
    return Intl.message(
      'Queue loop mode cannot be disabled when shuffle mode is enabled.',
      name: 'queueLoopNotDisMsg1',
      desc: 'queueLoopNotDisMsg1',
      args: [],
    );
  }

  /// `Queue loop mode cannot be enabled in radio mode.`
  String get queueLoopNotDisMsg2 {
    return Intl.message(
      'Queue loop mode cannot be enabled in radio mode.',
      name: 'queueLoopNotDisMsg2',
      desc: 'queueLoopNotDisMsg2',
      args: [],
    );
  }

  /// `Queue can't be shuffled when shuffle mode is enabled`
  String get queueShufflingDeniedMsg {
    return Intl.message(
      'Queue can\'t be shuffled when shuffle mode is enabled',
      name: 'queueShufflingDeniedMsg',
      desc: 'queueShufflingDeniedMsg',
      args: [],
    );
  }

  /// `Queue can't be rearranged when shuffle mode is enabled`
  String get queuerearrangingDeniedMsg {
    return Intl.message(
      'Queue can\'t be rearranged when shuffle mode is enabled',
      name: 'queuerearrangingDeniedMsg',
      desc: 'queuerearrangingDeniedMsg',
      args: [],
    );
  }

  /// `Quick selection`
  String get quickPics {
    return Intl.message(
      'Quick selection',
      name: 'quickPics',
      desc: 'quickPics',
      args: [],
    );
  }

  /// `Quick Picks`
  String get quickpicks {
    return Intl.message(
      'Quick Picks',
      name: 'quickpicks',
      desc: 'quickpicks',
      args: [],
    );
  }

  /// `Radio not available for this artist!`
  String get radioNotAvailable {
    return Intl.message(
      'Radio not available for this artist!',
      name: 'radioNotAvailable',
      desc: 'radioNotAvailable',
      args: [],
    );
  }

  /// `Random Radio`
  String get randomRadio {
    return Intl.message(
      'Random Radio',
      name: 'randomRadio',
      desc: 'randomRadio',
      args: [],
    );
  }

  /// `Random Selection`
  String get randomSelection {
    return Intl.message(
      'Random Selection',
      name: 'randomSelection',
      desc: 'randomSelection',
      args: [],
    );
  }

  /// `Rearrange playlist`
  String get reArrangePlaylist {
    return Intl.message(
      'Rearrange playlist',
      name: 'reArrangePlaylist',
      desc: 'reArrangePlaylist',
      args: [],
    );
  }

  /// `Rearrange songs`
  String get reArrangeSongs {
    return Intl.message(
      'Rearrange songs',
      name: 'reArrangeSongs',
      desc: 'reArrangeSongs',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: 'readMore',
      args: [],
    );
  }

  /// `Recent searches`
  String get recentSearches {
    return Intl.message(
      'Recent searches',
      name: 'recentSearches',
      desc: 'recentSearches',
      args: [],
    );
  }

  /// `Recently Played`
  String get recentlyPlayed {
    return Intl.message(
      'Recently Played',
      name: 'recentlyPlayed',
      desc: 'recentlyPlayed',
      args: [],
    );
  }

  /// `We recommend activating Cloud Mode for a Spotify-like experience: real-time synchronization between all your devices and automatic backup without you having to do anything.`
  String get recommend_cloud {
    return Intl.message(
      'We recommend activating Cloud Mode for a Spotify-like experience: real-time synchronization between all your devices and automatic backup without you having to do anything.',
      name: 'recommend_cloud',
      desc: 'recommend_cloud',
      args: [],
    );
  }

  /// `Recommended`
  String get recommendedAlbums {
    return Intl.message(
      'Recommended',
      name: 'recommendedAlbums',
      desc: 'recommendedAlbums',
      args: [],
    );
  }

  /// `Recommended`
  String get recommendedArtists {
    return Intl.message(
      'Recommended',
      name: 'recommendedArtists',
      desc: 'recommendedArtists',
      args: [],
    );
  }

  /// `Remove from cache`
  String get removeFromCache {
    return Intl.message(
      'Remove from cache',
      name: 'removeFromCache',
      desc: 'removeFromCache',
      args: [],
    );
  }

  /// `Remove from Library Songs`
  String get removeFromLib {
    return Intl.message(
      'Remove from Library Songs',
      name: 'removeFromLib',
      desc: 'removeFromLib',
      args: [],
    );
  }

  /// `Remove from Library`
  String get removeFromLibrary {
    return Intl.message(
      'Remove from Library',
      name: 'removeFromLibrary',
      desc: 'removeFromLibrary',
      args: [],
    );
  }

  /// `Remove from playlist`
  String get removeFromPlaylist {
    return Intl.message(
      'Remove from playlist',
      name: 'removeFromPlaylist',
      desc: 'removeFromPlaylist',
      args: [],
    );
  }

  /// `Remove from queue`
  String get removeFromQueue {
    return Intl.message(
      'Remove from queue',
      name: 'removeFromQueue',
      desc: 'removeFromQueue',
      args: [],
    );
  }

  /// `Remove multiple songs`
  String get removeMultiple {
    return Intl.message(
      'Remove multiple songs',
      name: 'removeMultiple',
      desc: 'removeMultiple',
      args: [],
    );
  }

  /// `Remove playlist`
  String get removePlaylist {
    return Intl.message(
      'Remove playlist',
      name: 'removePlaylist',
      desc: 'removePlaylist',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: 'rename', args: []);
  }

  /// `Rename Playlist`
  String get renamePlaylist {
    return Intl.message(
      'Rename Playlist',
      name: 'renamePlaylist',
      desc: 'renamePlaylist',
      args: [],
    );
  }

  /// `Reproduced by`
  String get reproducedBy {
    return Intl.message(
      'Reproduced by',
      name: 'reproducedBy',
      desc: 'reproducedBy',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: 'reset', args: []);
  }

  /// `Restore default settings`
  String get resetToDefault {
    return Intl.message(
      'Restore default settings',
      name: 'resetToDefault',
      desc: 'resetToDefault',
      args: [],
    );
  }

  /// `Reset app settings to default (Restart required)`
  String get resetToDefaultDes {
    return Intl.message(
      'Reset app settings to default (Restart required)',
      name: 'resetToDefaultDes',
      desc: 'resetToDefaultDes',
      args: [],
    );
  }

  /// `Settings reset to default completed, Please restart app`
  String get resetToDefaultMsg {
    return Intl.message(
      'Settings reset to default completed, Please restart app',
      name: 'resetToDefaultMsg',
      desc: 'resetToDefaultMsg',
      args: [],
    );
  }

  /// `Reset blacklisted playlists`
  String get resetblacklistedplaylist {
    return Intl.message(
      'Reset blacklisted playlists',
      name: 'resetblacklistedplaylist',
      desc: 'resetblacklistedplaylist',
      args: [],
    );
  }

  /// `Reset all the piped blacklisted playlists`
  String get resetblacklistedplaylistDes {
    return Intl.message(
      'Reset all the piped blacklisted playlists',
      name: 'resetblacklistedplaylistDes',
      desc: 'resetblacklistedplaylistDes',
      args: [],
    );
  }

  /// `Restart App`
  String get restartApp {
    return Intl.message(
      'Restart App',
      name: 'restartApp',
      desc: 'restartApp',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message('Restore', name: 'restore', desc: 'restore', args: []);
  }

  /// `Restore App data`
  String get restoreAppData {
    return Intl.message(
      'Restore App data',
      name: 'restoreAppData',
      desc: 'restoreAppData',
      args: [],
    );
  }

  /// `Restore last playback session`
  String get restoreLastPlaybackSession {
    return Intl.message(
      'Restore last playback session',
      name: 'restoreLastPlaybackSession',
      desc: 'restoreLastPlaybackSession',
      args: [],
    );
  }

  /// `Automatically restore the last playback session on app start`
  String get restoreLastPlaybackSessionDes {
    return Intl.message(
      'Automatically restore the last playback session on app start',
      name: 'restoreLastPlaybackSessionDes',
      desc: 'restoreLastPlaybackSessionDes',
      args: [],
    );
  }

  /// `Successfully restored!\nChanges are applied on restart`
  String get restoreMsg {
    return Intl.message(
      'Successfully restored!\nChanges are applied on restart',
      name: 'restoreMsg',
      desc: 'restoreMsg',
      args: [],
    );
  }

  /// `Restore settings and playlists`
  String get restoreSettingsAndPlaylists {
    return Intl.message(
      'Restore settings and playlists',
      name: 'restoreSettingsAndPlaylists',
      desc: 'restoreSettingsAndPlaylists',
      args: [],
    );
  }

  /// `Restores all settings, login data and playlists from a backup file. Overwrites all current data`
  String get restoreSettingsAndPlaylistsDes {
    return Intl.message(
      'Restores all settings, login data and playlists from a backup file. Overwrites all current data',
      name: 'restoreSettingsAndPlaylistsDes',
      desc: 'restoreSettingsAndPlaylistsDes',
      args: [],
    );
  }

  /// `Select backup file`
  String get restore_select_file_dialog {
    return Intl.message(
      'Select backup file',
      name: 'restore_select_file_dialog',
      desc: 'restore_select_file_dialog',
      args: [],
    );
  }

  /// `Restoring...`
  String get restoring {
    return Intl.message(
      'Restoring...',
      name: 'restoring',
      desc: 'restoring',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message('Results', name: 'results', desc: 'results', args: []);
  }

  /// `Retry!`
  String get retry {
    return Intl.message('Retry!', name: 'retry', desc: 'retry', args: []);
  }

  /// `Keep`
  String get save {
    return Intl.message('Keep', name: 'save', desc: 'save', args: []);
  }

  /// `Saved`
  String get savedAlbums {
    return Intl.message(
      'Saved',
      name: 'savedAlbums',
      desc: 'savedAlbums',
      args: [],
    );
  }

  /// `Scanning...`
  String get scanning {
    return Intl.message(
      'Scanning...',
      name: 'scanning',
      desc: 'scanning',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: 'search', args: []);
  }

  /// `Songs, Playlist, Album or Artist`
  String get searchDes {
    return Intl.message(
      'Songs, Playlist, Album or Artist',
      name: 'searchDes',
      desc: 'searchDes',
      args: [],
    );
  }

  /// `Search in Library`
  String get searchInLibrary {
    return Intl.message(
      'Search in Library',
      name: 'searchInLibrary',
      desc: 'searchInLibrary',
      args: [],
    );
  }

  /// `Search results`
  String get searchRes {
    return Intl.message(
      'Search results',
      name: 'searchRes',
      desc: 'searchRes',
      args: [],
    );
  }

  /// `Recent searches`
  String get search_recent_title {
    return Intl.message(
      'Recent searches',
      name: 'search_recent_title',
      desc: 'search_recent_title',
      args: [],
    );
  }

  /// `Select All`
  String get selectAll {
    return Intl.message(
      'Select All',
      name: 'selectAll',
      desc: 'selectAll',
      args: [],
    );
  }

  /// `Select Auth Instance`
  String get selectAuthIns {
    return Intl.message(
      'Select Auth Instance',
      name: 'selectAuthIns',
      desc: 'selectAuthIns',
      args: [],
    );
  }

  /// `Please select Authentication instance!`
  String get selectAuthInsMsg {
    return Intl.message(
      'Please select Authentication instance!',
      name: 'selectAuthInsMsg',
      desc: 'selectAuthInsMsg',
      args: [],
    );
  }

  /// `Select File`
  String get selectFile {
    return Intl.message(
      'Select File',
      name: 'selectFile',
      desc: 'selectFile',
      args: [],
    );
  }

  /// `Select songs`
  String get selectSongs {
    return Intl.message(
      'Select songs',
      name: 'selectSongs',
      desc: 'selectSongs',
      args: [],
    );
  }

  /// `The selected file was not found.`
  String get selectedFileNotFound {
    return Intl.message(
      'The selected file was not found.',
      name: 'selectedFileNotFound',
      desc: 'selectedFileNotFound',
      args: [],
    );
  }

  /// `Your session has expired. `
  String get sessionExpiredLoginAgain {
    return Intl.message(
      'Your session has expired. ',
      name: 'sessionExpiredLoginAgain',
      desc: 'sessionExpiredLoginAgain',
      args: [],
    );
  }

  /// `Set discover content`
  String get setDiscoverContent {
    return Intl.message(
      'Set discover content',
      name: 'setDiscoverContent',
      desc: 'setDiscoverContent',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'settings',
      args: [],
    );
  }

  /// `About Estrella Music`
  String get settings_about_desc {
    return Intl.message(
      'About Estrella Music',
      name: 'settings_about_desc',
      desc: 'settings_about_desc',
      args: [],
    );
  }

  /// `Version, open source project and GitHub.`
  String get settings_about_sub {
    return Intl.message(
      'Version, open source project and GitHub.',
      name: 'settings_about_sub',
      desc: 'settings_about_sub',
      args: [],
    );
  }

  /// `Account and Sync`
  String get settings_account_desc {
    return Intl.message(
      'Account and Sync',
      name: 'settings_account_desc',
      desc: 'settings_account_desc',
      args: [],
    );
  }

  /// `Cloud mode, backups, friends list and migrations.`
  String get settings_account_sub {
    return Intl.message(
      'Cloud mode, backups, friends list and migrations.',
      name: 'settings_account_sub',
      desc: 'settings_account_sub',
      args: [],
    );
  }

  /// `Theme, language and interface animations.`
  String get settings_appearance_desc {
    return Intl.message(
      'Theme, language and interface animations.',
      name: 'settings_appearance_desc',
      desc: 'settings_appearance_desc',
      args: [],
    );
  }

  /// `Cloud backup`
  String get settings_cloud_backup {
    return Intl.message(
      'Cloud backup',
      name: 'settings_cloud_backup',
      desc: 'settings_cloud_backup',
      args: [],
    );
  }

  /// `Upload, restore and manage...`
  String get settings_cloud_backup_desc {
    return Intl.message(
      'Upload, restore and manage...',
      name: 'settings_cloud_backup_desc',
      desc: 'settings_cloud_backup_desc',
      args: [],
    );
  }

  /// `Upload a .hmb backup to the server and restore any saved backups if needed.`
  String get settings_cloud_backup_dialog_desc {
    return Intl.message(
      'Upload a .hmb backup to the server and restore any saved backups if needed.',
      name: 'settings_cloud_backup_dialog_desc',
      desc: 'settings_cloud_backup_dialog_desc',
      args: [],
    );
  }

  /// `Discover filters, integration with Piped and caches.`
  String get settings_content_desc {
    return Intl.message(
      'Discover filters, integration with Piped and caches.',
      name: 'settings_content_desc',
      desc: 'settings_content_desc',
      args: [],
    );
  }

  /// `Downloads and Storage`
  String get settings_downloads_desc {
    return Intl.message(
      'Downloads and Storage',
      name: 'settings_downloads_desc',
      desc: 'settings_downloads_desc',
      args: [],
    );
  }

  /// `Audio formats, folders and automatic downloads.`
  String get settings_downloads_sub {
    return Intl.message(
      'Audio formats, folders and automatic downloads.',
      name: 'settings_downloads_sub',
      desc: 'settings_downloads_sub',
      args: [],
    );
  }

  /// `General`
  String get settings_general_section {
    return Intl.message(
      'General',
      name: 'settings_general_section',
      desc: 'settings_general_section',
      args: [],
    );
  }

  /// `Choose, migrate or review the synchronization status with Joss Red.`
  String get settings_local_cloud_desc {
    return Intl.message(
      'Choose, migrate or review the synchronization status with Joss Red.',
      name: 'settings_local_cloud_desc',
      desc: 'settings_local_cloud_desc',
      args: [],
    );
  }

  /// `Local Mode / EMusic Cloud`
  String get settings_local_cloud_title {
    return Intl.message(
      'Local Mode / EMusic Cloud',
      name: 'settings_local_cloud_title',
      desc: 'settings_local_cloud_title',
      args: [],
    );
  }

  /// `Log out`
  String get settings_logout {
    return Intl.message(
      'Log out',
      name: 'settings_logout',
      desc: 'settings_logout',
      args: [],
    );
  }

  /// `Import playlists, songs...`
  String get settings_migration_desc {
    return Intl.message(
      'Import playlists, songs...',
      name: 'settings_migration_desc',
      desc: 'settings_migration_desc',
      args: [],
    );
  }

  /// `Migrate from Joss Music Kotlin`
  String get settings_migration_title {
    return Intl.message(
      'Migrate from Joss Music Kotlin',
      name: 'settings_migration_title',
      desc: 'settings_migration_title',
      args: [],
    );
  }

  /// `my friends`
  String get settings_my_friends {
    return Intl.message(
      'my friends',
      name: 'settings_my_friends',
      desc: 'settings_my_friends',
      args: [],
    );
  }

  /// `Manage your Joss Red friends directly.`
  String get settings_my_friends_desc {
    return Intl.message(
      'Manage your Joss Red friends directly.',
      name: 'settings_my_friends_desc',
      desc: 'settings_my_friends_desc',
      args: [],
    );
  }

  /// `Streaming quality, normalization, silences and battery.`
  String get settings_playback_desc {
    return Intl.message(
      'Streaming quality, normalization, silences and battery.',
      name: 'settings_playback_desc',
      desc: 'settings_playback_desc',
      args: [],
    );
  }

  /// `Regenerate your Online Music ID if Discover content doesn't load.`
  String get settings_refresh_visitor_desc {
    return Intl.message(
      'Regenerate your Online Music ID if Discover content doesn\'t load.',
      name: 'settings_refresh_visitor_desc',
      desc: 'settings_refresh_visitor_desc',
      args: [],
    );
  }

  /// `Refresh ID (Visitor ID)`
  String get settings_refresh_visitor_title {
    return Intl.message(
      'Refresh ID (Visitor ID)',
      name: 'settings_refresh_visitor_title',
      desc: 'settings_refresh_visitor_title',
      args: [],
    );
  }

  /// `Mistake`
  String get settings_visitor_error {
    return Intl.message(
      'Mistake',
      name: 'settings_visitor_error',
      desc: 'settings_visitor_error',
      args: [],
    );
  }

  /// `A new identifier could not be generated. `
  String get settings_visitor_error_desc {
    return Intl.message(
      'A new identifier could not be generated. ',
      name: 'settings_visitor_error_desc',
      desc: 'settings_visitor_error_desc',
      args: [],
    );
  }

  /// `An error occurred while regenerating: {error}`
  String settings_visitor_exception(String error) {
    return Intl.message(
      'An error occurred while regenerating: $error',
      name: 'settings_visitor_exception',
      desc: 'settings_visitor_exception',
      args: [error],
    );
  }

  /// `Updated identifier`
  String get settings_visitor_updated {
    return Intl.message(
      'Updated identifier',
      name: 'settings_visitor_updated',
      desc: 'settings_visitor_updated',
      args: [],
    );
  }

  /// `A new Visitor ID was generated successfully.`
  String get settings_visitor_updated_desc {
    return Intl.message(
      'A new Visitor ID was generated successfully.',
      name: 'settings_visitor_updated_desc',
      desc: 'settings_visitor_updated_desc',
      args: [],
    );
  }

  /// `Share album`
  String get shareAlbum {
    return Intl.message(
      'Share album',
      name: 'shareAlbum',
      desc: 'shareAlbum',
      args: [],
    );
  }

  /// `Share playlist`
  String get sharePlaylist {
    return Intl.message(
      'Share playlist',
      name: 'sharePlaylist',
      desc: 'sharePlaylist',
      args: [],
    );
  }

  /// `Share this song`
  String get shareSong {
    return Intl.message(
      'Share this song',
      name: 'shareSong',
      desc: 'shareSong',
      args: [],
    );
  }

  /// `Searching the Shazam database for matches...`
  String get shazamSearching {
    return Intl.message(
      'Searching the Shazam database for matches...',
      name: 'shazamSearching',
      desc: 'shazamSearching',
      args: [],
    );
  }

  /// `Shuffle`
  String get shuffle {
    return Intl.message('Shuffle', name: 'shuffle', desc: 'shuffle', args: []);
  }

  /// `Shuffle Queue`
  String get shuffleQueue {
    return Intl.message(
      'Shuffle Queue',
      name: 'shuffleQueue',
      desc: 'shuffleQueue',
      args: [],
    );
  }

  /// `Similar to {title}`
  String similarToTitle(String title) {
    return Intl.message(
      'Similar to $title',
      name: 'similarToTitle',
      desc: 'similarToTitle',
      args: [title],
    );
  }

  /// `Singles`
  String get singles {
    return Intl.message('Singles', name: 'singles', desc: 'singles', args: []);
  }

  /// `Skip silence`
  String get skipSilence {
    return Intl.message(
      'Skip silence',
      name: 'skipSilence',
      desc: 'skipSilence',
      args: [],
    );
  }

  /// `Silence will be skipped in music playback`
  String get skipSilenceDes {
    return Intl.message(
      'Silence will be skipped in music playback',
      name: 'skipSilenceDes',
      desc: 'skipSilenceDes',
      args: [],
    );
  }

  /// `Your sleep timer is set`
  String get sleepTimeSetAlert {
    return Intl.message(
      'Your sleep timer is set',
      name: 'sleepTimeSetAlert',
      desc: 'sleepTimeSetAlert',
      args: [],
    );
  }

  /// `Sleep Timer`
  String get sleepTimer {
    return Intl.message(
      'Sleep Timer',
      name: 'sleepTimer',
      desc: 'sleepTimer',
      args: [],
    );
  }

  /// `Step {current} of 3`
  String slide_indicator(String current) {
    return Intl.message(
      'Step $current of 3',
      name: 'slide_indicator',
      desc: 'slide_indicator',
      args: [current],
    );
  }

  /// `Song added to playlist!`
  String get songAddedToPlaylistAlert {
    return Intl.message(
      'Song added to playlist!',
      name: 'songAddedToPlaylistAlert',
      desc: 'songAddedToPlaylistAlert',
      args: [],
    );
  }

  /// `Song already exists!`
  String get songAlreadyExists {
    return Intl.message(
      'Song already exists!',
      name: 'songAlreadyExists',
      desc: 'songAlreadyExists',
      args: [],
    );
  }

  /// `Song already offline in cache`
  String get songAlreadyOfflineAlert {
    return Intl.message(
      'Song already offline in cache',
      name: 'songAlreadyOfflineAlert',
      desc: 'songAlreadyOfflineAlert',
      args: [],
    );
  }

  /// `Song enqueued!`
  String get songEnqueueAlert {
    return Intl.message(
      'Song enqueued!',
      name: 'songEnqueueAlert',
      desc: 'songEnqueueAlert',
      args: [],
    );
  }

  /// `Song Found!`
  String get songFound {
    return Intl.message(
      'Song Found!',
      name: 'songFound',
      desc: 'songFound',
      args: [],
    );
  }

  /// `Song Info`
  String get songInfo {
    return Intl.message(
      'Song Info',
      name: 'songInfo',
      desc: 'songInfo',
      args: [],
    );
  }

  /// `Song is not playable due to server restriction!`
  String get songNotPlayable {
    return Intl.message(
      'Song is not playable due to server restriction!',
      name: 'songNotPlayable',
      desc: 'songNotPlayable',
      args: [],
    );
  }

  /// `song tone`
  String get songPitch {
    return Intl.message(
      'song tone',
      name: 'songPitch',
      desc: 'songPitch',
      args: [],
    );
  }

  /// `Removed from`
  String get songRemovedAlert {
    return Intl.message(
      'Removed from',
      name: 'songRemovedAlert',
      desc: 'songRemovedAlert',
      args: [],
    );
  }

  /// `Removed from queue!`
  String get songRemovedfromQueue {
    return Intl.message(
      'Removed from queue!',
      name: 'songRemovedfromQueue',
      desc: 'songRemovedfromQueue',
      args: [],
    );
  }

  /// `You can't remove currently playing song`
  String get songRemovedfromQueueCurrSong {
    return Intl.message(
      'You can\'t remove currently playing song',
      name: 'songRemovedfromQueueCurrSong',
      desc: 'songRemovedfromQueueCurrSong',
      args: [],
    );
  }

  /// `Songs`
  String get songs {
    return Intl.message('Songs', name: 'songs', desc: 'songs', args: []);
  }

  /// `Songs imported from Joss Music Kotlin`
  String get songsImportedFromJossMusic {
    return Intl.message(
      'Songs imported from Joss Music Kotlin',
      name: 'songsImportedFromJossMusic',
      desc: 'songsImportedFromJossMusic',
      args: [],
    );
  }

  /// `Sort ascending/descending`
  String get sortAscendNDescend {
    return Intl.message(
      'Sort ascending/descending',
      name: 'sortAscendNDescend',
      desc: 'sortAscendNDescend',
      args: [],
    );
  }

  /// `Sort by Date`
  String get sortByDate {
    return Intl.message(
      'Sort by Date',
      name: 'sortByDate',
      desc: 'sortByDate',
      args: [],
    );
  }

  /// `Sort by Duration`
  String get sortByDuration {
    return Intl.message(
      'Sort by Duration',
      name: 'sortByDuration',
      desc: 'sortByDuration',
      args: [],
    );
  }

  /// `Sort by Name`
  String get sortByName {
    return Intl.message(
      'Sort by Name',
      name: 'sortByName',
      desc: 'sortByName',
      args: [],
    );
  }

  /// `Speed ​​and Pitch`
  String get speedAndPitch {
    return Intl.message(
      'Speed ​​and Pitch',
      name: 'speedAndPitch',
      desc: 'speedAndPitch',
      args: [],
    );
  }

  /// `Standard`
  String get standard {
    return Intl.message(
      'Standard',
      name: 'standard',
      desc: 'standard',
      args: [],
    );
  }

  /// `Start radio`
  String get startRadio {
    return Intl.message(
      'Start radio',
      name: 'startRadio',
      desc: 'startRadio',
      args: [],
    );
  }

  /// `Open on startup`
  String get startupScreen {
    return Intl.message(
      'Open on startup',
      name: 'startupScreen',
      desc: 'startupScreen',
      args: [],
    );
  }

  /// `Choose the section that Estrella Music opens first`
  String get startupScreenDescription {
    return Intl.message(
      'Choose the section that Estrella Music opens first',
      name: 'startupScreenDescription',
      desc: 'startupScreenDescription',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: 'status', args: []);
  }

  /// `Stop music on task clear`
  String get stopMusicOnTaskClear {
    return Intl.message(
      'Stop music on task clear',
      name: 'stopMusicOnTaskClear',
      desc: 'stopMusicOnTaskClear',
      args: [],
    );
  }

  /// `Music playback will stop when App being swiped away from the task manager`
  String get stopMusicOnTaskClearDes {
    return Intl.message(
      'Music playback will stop when App being swiped away from the task manager',
      name: 'stopMusicOnTaskClearDes',
      desc: 'stopMusicOnTaskClearDes',
      args: [],
    );
  }

  /// `Streaming quality`
  String get streamingQuality {
    return Intl.message(
      'Streaming quality',
      name: 'streamingQuality',
      desc: 'streamingQuality',
      args: [],
    );
  }

  /// `Quality of music stream`
  String get streamingQualityDes {
    return Intl.message(
      'Quality of music stream',
      name: 'streamingQualityDes',
      desc: 'streamingQualityDes',
      args: [],
    );
  }

  /// `subscribers`
  String get subscribers {
    return Intl.message(
      'subscribers',
      name: 'subscribers',
      desc: 'subscribers',
      args: [],
    );
  }

  /// `Swipe to explore options`
  String get swipe_prompt {
    return Intl.message(
      'Swipe to explore options',
      name: 'swipe_prompt',
      desc: 'swipe_prompt',
      args: [],
    );
  }

  /// `{count} changes committed.`
  String syncChangesConfirmed(int count) {
    return Intl.message(
      '$count changes committed.',
      name: 'syncChangesConfirmed',
      desc: 'syncChangesConfirmed',
      args: [count],
    );
  }

  /// `{count} synchronized changes.`
  String syncChangesSynced(int count) {
    return Intl.message(
      '$count synchronized changes.',
      name: 'syncChangesSynced',
      desc: 'syncChangesSynced',
      args: [count],
    );
  }

  /// `Cloud mode activated. `
  String get syncCloudDownloadingExisting {
    return Intl.message(
      'Cloud mode activated. ',
      name: 'syncCloudDownloadingExisting',
      desc: 'syncCloudDownloadingExisting',
      args: [],
    );
  }

  /// `Cloud mode activated. `
  String get syncCloudMigrationComplete {
    return Intl.message(
      'Cloud mode activated. ',
      name: 'syncCloudMigrationComplete',
      desc: 'syncCloudMigrationComplete',
      args: [],
    );
  }

  /// `Cloud mode active`
  String get syncCloudModeActive {
    return Intl.message(
      'Cloud mode active',
      name: 'syncCloudModeActive',
      desc: 'syncCloudModeActive',
      args: [],
    );
  }

  /// `Cloud mode active. `
  String get syncCloudPending {
    return Intl.message(
      'Cloud mode active. ',
      name: 'syncCloudPending',
      desc: 'syncCloudPending',
      args: [],
    );
  }

  /// `Failed to download sync.`
  String get syncDownloadFailed {
    return Intl.message(
      'Failed to download sync.',
      name: 'syncDownloadFailed',
      desc: 'syncDownloadFailed',
      args: [],
    );
  }

  /// `Downloading EMusic changes...`
  String get syncDownloading {
    return Intl.message(
      'Downloading EMusic changes...',
      name: 'syncDownloading',
      desc: 'syncDownloading',
      args: [],
    );
  }

  /// `Recovery backup: {path}`
  String syncForceReplaceBackupSaved(String path) {
    return Intl.message(
      'Recovery backup: $path',
      name: 'syncForceReplaceBackupSaved',
      desc: '',
      args: [path],
    );
  }

  /// `Replace and upload`
  String get syncForceReplaceConfirmAction {
    return Intl.message(
      'Replace and upload',
      name: 'syncForceReplaceConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `A recovery backup will be created first. Then playlists, favorites, history, albums, artists, and music settings in EMusic Cloud will be replaced with this device's current data. This cannot be undone from the server.`
  String get syncForceReplaceConfirmBody {
    return Intl.message(
      'A recovery backup will be created first. Then playlists, favorites, history, albums, artists, and music settings in EMusic Cloud will be replaced with this device\'s current data. This cannot be undone from the server.',
      name: 'syncForceReplaceConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Replace the remote music library?`
  String get syncForceReplaceConfirmTitle {
    return Intl.message(
      'Replace the remote music library?',
      name: 'syncForceReplaceConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `The uploaded counts do not match the local library. Remote replacement could not be confirmed.`
  String get syncForceReplaceCountMismatch {
    return Intl.message(
      'The uploaded counts do not match the local library. Remote replacement could not be confirmed.',
      name: 'syncForceReplaceCountMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Creating a recovery backup before replacing cloud data...`
  String get syncForceReplaceCreatingBackup {
    return Intl.message(
      'Creating a recovery backup before replacing cloud data...',
      name: 'syncForceReplaceCreatingBackup',
      desc: '',
      args: [],
    );
  }

  /// `Pauses pending sync and forcefully replaces your remote music library with the data currently on this device. Downloads stay local.`
  String get syncForceReplaceDescription {
    return Intl.message(
      'Pauses pending sync and forcefully replaces your remote music library with the data currently on this device. Downloads stay local.',
      name: 'syncForceReplaceDescription',
      desc: '',
      args: [],
    );
  }

  /// `EMusic Cloud could not replace the remote library.`
  String get syncForceReplaceFailed {
    return Intl.message(
      'EMusic Cloud could not replace the remote library.',
      name: 'syncForceReplaceFailed',
      desc: '',
      args: [],
    );
  }

  /// `The remote replacement failed. Your local data and recovery backup were preserved.`
  String get syncForceReplaceFailedLocalPreserved {
    return Intl.message(
      'The remote replacement failed. Your local data and recovery backup were preserved.',
      name: 'syncForceReplaceFailedLocalPreserved',
      desc: '',
      args: [],
    );
  }

  /// `Upload not completed`
  String get syncForceReplaceFailedTitle {
    return Intl.message(
      'Upload not completed',
      name: 'syncForceReplaceFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pausing sync, creating a backup, and uploading the local library...`
  String get syncForceReplaceInProgress {
    return Intl.message(
      'Pausing sync, creating a backup, and uploading the local library...',
      name: 'syncForceReplaceInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Current synchronization could not be paused safely. Try again in a moment.`
  String get syncForceReplacePauseFailed {
    return Intl.message(
      'Current synchronization could not be paused safely. Try again in a moment.',
      name: 'syncForceReplacePauseFailed',
      desc: '',
      args: [],
    );
  }

  /// `The remote music library was replaced with this device's current data.`
  String get syncForceReplaceSuccess {
    return Intl.message(
      'The remote music library was replaced with this device\'s current data.',
      name: 'syncForceReplaceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upload completed`
  String get syncForceReplaceSuccessTitle {
    return Intl.message(
      'Upload completed',
      name: 'syncForceReplaceSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel sync and upload this database`
  String get syncForceReplaceTitle {
    return Intl.message(
      'Cancel sync and upload this database',
      name: 'syncForceReplaceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Validating the uploaded library before replacing cloud data...`
  String get syncForceReplaceValidating {
    return Intl.message(
      'Validating the uploaded library before replacing cloud data...',
      name: 'syncForceReplaceValidating',
      desc: '',
      args: [],
    );
  }

  /// `Synchronized library.`
  String get syncLibrarySynced {
    return Intl.message(
      'Synchronized library.',
      name: 'syncLibrarySynced',
      desc: 'syncLibrarySynced',
      args: [],
    );
  }

  /// `Library up to date.`
  String get syncLibraryUpToDate {
    return Intl.message(
      'Library up to date.',
      name: 'syncLibraryUpToDate',
      desc: 'syncLibraryUpToDate',
      args: [],
    );
  }

  /// `There are new local changes. `
  String get syncLocalChangesFirst {
    return Intl.message(
      'There are new local changes. ',
      name: 'syncLocalChangesFirst',
      desc: 'syncLocalChangesFirst',
      args: [],
    );
  }

  /// `Your data is kept only on this device.`
  String get syncLocalDeviceOnly {
    return Intl.message(
      'Your data is kept only on this device.',
      name: 'syncLocalDeviceOnly',
      desc: 'syncLocalDeviceOnly',
      args: [],
    );
  }

  /// `Local mode active`
  String get syncLocalModeActive {
    return Intl.message(
      'Local mode active',
      name: 'syncLocalModeActive',
      desc: 'syncLocalModeActive',
      args: [],
    );
  }

  /// `Offline. `
  String get syncOfflinePending {
    return Intl.message(
      'Offline. ',
      name: 'syncOfflinePending',
      desc: 'syncOfflinePending',
      args: [],
    );
  }

  /// `Offline. `
  String get syncOfflineRetry {
    return Intl.message(
      'Offline. ',
      name: 'syncOfflineRetry',
      desc: 'syncOfflineRetry',
      args: [],
    );
  }

  /// `Sync playlist songs`
  String get syncPlaylistSongs {
    return Intl.message(
      'Sync playlist songs',
      name: 'syncPlaylistSongs',
      desc: 'syncPlaylistSongs',
      args: [],
    );
  }

  /// `EMusic did not confirm all the changes. `
  String get syncUnconfirmedRetry {
    return Intl.message(
      'EMusic did not confirm all the changes. ',
      name: 'syncUnconfirmedRetry',
      desc: 'syncUnconfirmedRetry',
      args: [],
    );
  }

  /// `Could not get up. `
  String get syncUploadRetry {
    return Intl.message(
      'Could not get up. ',
      name: 'syncUploadRetry',
      desc: 'syncUploadRetry',
      args: [],
    );
  }

  /// `Changes uploaded correctly.`
  String get syncUploadSuccess {
    return Intl.message(
      'Changes uploaded correctly.',
      name: 'syncUploadSuccess',
      desc: 'syncUploadSuccess',
      args: [],
    );
  }

  /// `Changes uploaded successfully (WS).`
  String get syncUploadSuccessWs {
    return Intl.message(
      'Changes uploaded successfully (WS).',
      name: 'syncUploadSuccessWs',
      desc: 'syncUploadSuccessWs',
      args: [],
    );
  }

  /// `Could not upload using WS. `
  String get syncUploadWsRetry {
    return Intl.message(
      'Could not upload using WS. ',
      name: 'syncUploadWsRetry',
      desc: 'syncUploadWsRetry',
      args: [],
    );
  }

  /// `Uploading changes to EMusic...`
  String get syncUploading {
    return Intl.message(
      'Uploading changes to EMusic...',
      name: 'syncUploading',
      desc: 'syncUploading',
      args: [],
    );
  }

  /// `Synced`
  String get synced {
    return Intl.message('Synced', name: 'synced', desc: 'synced', args: []);
  }

  /// `Synced lyrics not available!`
  String get syncedLyricsNotAvailable {
    return Intl.message(
      'Synced lyrics not available!',
      name: 'syncedLyricsNotAvailable',
      desc: 'syncedLyricsNotAvailable',
      args: [],
    );
  }

  /// `System default`
  String get systemDefault {
    return Intl.message(
      'System default',
      name: 'systemDefault',
      desc: 'systemDefault',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message(
      'Theme Mode',
      name: 'themeMode',
      desc: 'themeMode',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: 'title', args: []);
  }

  /// `Top music videos`
  String get topMusicVid {
    return Intl.message(
      'Top music videos',
      name: 'topMusicVid',
      desc: 'topMusicVid',
      args: [],
    );
  }

  /// `Top Music Videos`
  String get topmusicvideos {
    return Intl.message(
      'Top Music Videos',
      name: 'topmusicvideos',
      desc: 'topmusicvideos',
      args: [],
    );
  }

  /// `Trending`
  String get trending {
    return Intl.message(
      'Trending',
      name: 'trending',
      desc: 'trending',
      args: [],
    );
  }

  /// `Unlink`
  String get unLink {
    return Intl.message('Unlink', name: 'unLink', desc: 'unLink', args: []);
  }

  /// `Unlinked successfully!`
  String get unlinkAlert {
    return Intl.message(
      'Unlinked successfully!',
      name: 'unlinkAlert',
      desc: 'unlinkAlert',
      args: [],
    );
  }

  /// `Untitled song`
  String get untitledSong {
    return Intl.message(
      'Untitled song',
      name: 'untitledSong',
      desc: 'untitledSong',
      args: [],
    );
  }

  /// `Up Next`
  String get upNext {
    return Intl.message('Up Next', name: 'upNext', desc: 'upNext', args: []);
  }

  /// `Update Application`
  String get updateApp {
    return Intl.message(
      'Update Application',
      name: 'updateApp',
      desc: 'updateApp',
      args: [],
    );
  }

  /// `Url detected click on it to open/play associated content`
  String get urlSearchDes {
    return Intl.message(
      'Url detected click on it to open/play associated content',
      name: 'urlSearchDes',
      desc: 'urlSearchDes',
      args: [],
    );
  }

  /// `Use this metadata`
  String get useThisMetadata {
    return Intl.message(
      'Use this metadata',
      name: 'useThisMetadata',
      desc: 'Button for selecting a metadata candidate',
      args: [],
    );
  }

  /// `Blocked user`
  String get userBlocked {
    return Intl.message(
      'Blocked user',
      name: 'userBlocked',
      desc: 'userBlocked',
      args: [],
    );
  }

  /// `The response does not contain a list of users.`
  String get userListMissing {
    return Intl.message(
      'The response does not contain a list of users.',
      name: 'userListMissing',
      desc: 'userListMissing',
      args: [],
    );
  }

  /// `Could not search for users ({statusCode}).`
  String userSearchFailed(int statusCode) {
    return Intl.message(
      'Could not search for users ($statusCode).',
      name: 'userSearchFailed',
      desc: 'userSearchFailed',
      args: [statusCode],
    );
  }

  /// `Unlocked user`
  String get userUnblocked {
    return Intl.message(
      'Unlocked user',
      name: 'userUnblocked',
      desc: 'userUnblocked',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: 'username',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: 'video', args: []);
  }

  /// `Videos`
  String get videos {
    return Intl.message('Videos', name: 'videos', desc: 'videos', args: []);
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: 'viewAll', args: []);
  }

  /// `View Artist`
  String get viewArtist {
    return Intl.message(
      'View Artist',
      name: 'viewArtist',
      desc: 'viewArtist',
      args: [],
    );
  }

  /// `We have modernized our platform. `
  String get welcome_intro {
    return Intl.message(
      'We have modernized our platform. ',
      name: 'welcome_intro',
      desc: 'welcome_intro',
      args: [],
    );
  }

  /// `Choose how you want to experience Estrella Music from now on.`
  String get welcome_subtitle {
    return Intl.message(
      'Choose how you want to experience Estrella Music from now on.',
      name: 'welcome_subtitle',
      desc: 'welcome_subtitle',
      args: [],
    );
  }

  /// `Your music, your way`
  String get welcome_title {
    return Intl.message(
      'Your music, your way',
      name: 'welcome_title',
      desc: 'welcome_title',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'be'),
      Locale.fromSubtags(languageCode: 'bg'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'or'),
      Locale.fromSubtags(languageCode: 'pa'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
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
