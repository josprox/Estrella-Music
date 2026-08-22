// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bg locale. All the
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
  String get localeName => 'bg';

  static String m0(songTitle) => "Изтегляне: ${songTitle}";

  static String m1(count) => "Албуми: ${count}";

  static String m2(count) => "Изпълнители: ${count}";

  static String m3(count) => "Любими: ${count}";

  static String m4(count) => "Плейлисти: ${count}";

  static String m5(count) => "Песни: ${count}";

  static String m6(source) => "Миграцията е завършена от ${source}.";

  static String m7(error) => "Възникна грешка при регенерирането: ${error}";

  static String m8(title) => "Подобно на ${title}";

  static String m9(current) => "Стъпка ${current} от 3";

  static String m10(count) => "${count} извършени промени.";

  static String m11(count) => "${count} синхронизирани промени.";

  static String m12(statusCode) =>
      "Не може да се търсят потребители (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Създай нов плейлист",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("За"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Добави 5 минути"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Добави песни към плейлист",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Добавяне към библиотеката",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Добави към плейлист",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Албум"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Албумът е маркиран!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Отметката за албума е премахната!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Албуми"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Според вашите вкусове",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Всички полета са задължителни",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Не е тествано: Маркирането на квадратчето за отметка след изтегляне на повече от 60 файла, процесът може да изразходва голямо количество памет и може да доведе до срив на телефона или приложението. Продължете на свой собствен риск.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Информация за приложението",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Изпълнителят е маркиран!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Отметката за изпълнител е премахната!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Описанието не е налично!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Изпълнители"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Според вашите вкусове",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Аудио кодек"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Код за удостоверяване",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Въведете валиден 6-цифрен код или влезте отново.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Въведете 6-цифрения код от вашето приложение за удостоверяване. Този достъп изтича след 5 минути.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Двуфакторна автентификация",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Проверете и продължете",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar mis datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Донесохме вход, регистрация и възстановяване на парола от предишния проект, адаптиран за това музикално приложение.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Вашата сесия се съхранява в защитено хранилище и се валидира със същия бекенд, който вече сте използвали.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Файлът .env трябва да бъде конфигуриран за свързване на бекенда за удостоверяване.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Вход"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage(
      "Регистрирайте се",
    ),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Изпращане на поща",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Потвърдете паролата",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Неправилен имейл или парола.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Въведете валиден имейл.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Липсва бекендът за удостоверяване, за да бъде конфигуриран в .env файла.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Вашият акаунт все още не е потвърден.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Не беше възможно да се завърши операцията.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Първо име"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Забравих паролата си",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ще ви изпратим инструкциите на имейла на вашия акаунт.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("име@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Успешно влизане",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Не беше възможно изпращането на имейла.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Имейлът е изпратен.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Акаунтът не можа да бъде създаден.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Акаунтът е създаден успешно.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Добре дошли в Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Добре дошли в Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Автоматично изтегляне на любими песни",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Автоматично изтегляне на любими песни, когато бъдат добавени към любими",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Автоматично отваряне на екрана на плейъра",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Активиране/деактивиране на автоматичното отваряне на плейъра на цял екран при избор на песен за изпълнение",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Връщане"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "открита бази данни",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Изпълни музика във фонов режим",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Активиране/Деактивиране изпълнение на музика във фонов режим (Приложението може да бъде достъпно от системната област, когато приложението работи във фонов режим)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Архивиране"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Архивирай данни от приложението",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Извършва се архивиране...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Архивирането е успешно запазено!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Архивиране на настройки и плейлисти",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Запазва всички настройки, плейлисти и данни за вход в архивен файл",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Имате нужда от активна сесия...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Рестартирайте приложението",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Качете резервно копие сега",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Искате ли да направите резервно копие?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Резервното копие е изтрито.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Все още няма резервни копия...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Резервното копие е възстановено. Рестартирайте приложението.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Изберете папката за архивиране",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Изберете кои данни да архивирате",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Резервното копие е качено правилно.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Въз основа на последното взаимодействие",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Скорост на предаване"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Плейлист черен списък",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Нулирането е успешно!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("от"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Кеш на данни за съдържание на началния екран",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Активиране на кеширане на данни за съдържание на началния екран, Началният екран ще се зареди незабавно, ако тази опция е разрешена",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Кеш на песни"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Кеширане на песни по време на изпълнение за бъдещо/офлайн възпроизвеждане, това ще отнеме допълнително място на вашето устройство",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Кеширано/Офлайн"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отказ"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Отмени таймера"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Таймерът за заспиване е отменен",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Изчисти кеша на изображения",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Кешът на изображения е изчистен успешно",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Натиснете тук, за да изчистите кеширани миниатюри/изображения. (Не се препоръчва, освен ако не искате да обновите данните от кеширани изображения)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("затвори"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Затвори приложението"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Намерена е облачна библиотека.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Намерена е облачна библиотека. Това устройство ще го изтегли, без да го презаписва.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Облачният режим е готов. Това устройство ще работи като офлайн кеш.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Влезте сигурно с вашия акаунт в Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Достъп до вашите плейлисти, любими и история от всяко устройство (Windows, Android и т.н.) незабавно.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Интелигентно синхронизиране: Работете офлайн и качвайте промени автоматично, когато възстановите интернет.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Активирайте облачната синхронизация",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Синхронизация в реално време с Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Облачен режим (препоръчително)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Съвместен плейлист",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Изберете приятелите, които ще могат да виждат и редактират този плейлист:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Сътрудниците са актуализирани правилно.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Плейлисти на Общността",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Съдържание"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. GPL лиценз v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Създай"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Създай и добави"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Персонализирана инстанция",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Моля, изберете потребителска инстанция",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Ежедневно откритие"),
    "dark": MessageLookupByLibrary.simpleMessage("Тъмна"),
    "delete": MessageLookupByLibrary.simpleMessage("Изтриване"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Премахни от изтеглени",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Успешно премахване от изтеглени!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Разработено и поддържано от Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Деактивирай анимация на прехода",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Активирайте тази опция, за да деактивирате анимация на прехода към раздели",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Деактивирано"),
    "discover": MessageLookupByLibrary.simpleMessage("Открийте"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Отхвърли"),
    "done": MessageLookupByLibrary.simpleMessage("Готови"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Не показвай тази информация отново",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "намерени изтеглени файлове",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Изтегляне"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Изтегляне на песни от албума",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Заявената песен не може да бъде изтеглена поради ограничение на сървъра. Можете да опитате отново",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Неуспешно изтегляне поради грешка в мрежата/потока! Моля, опитайте отново",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Местоположение за изтегляне",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Поддържа вашите изтегляния на музика активни във фонов режим.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "изтегляне на музика",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Изтеглянията ви се подготвят...",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Изтегляне на музика",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Изтегляне на плейлист",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Файлов формат при изтегляне",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Изберете файлов формат при изтегляне. \"Opus\" ще осигури най-доброто качество",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Изтеглени"),
    "duration": MessageLookupByLibrary.simpleMessage("Продължителност"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Динамична"),
    "email": MessageLookupByLibrary.simpleMessage("Имейл"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Празен плейлист!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Долна навигационна лента",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Превключване към долна навигационна лента",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Активирай плъзгащи действия",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Активиране на плъзгащи действия върху плочка на песен",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Активирано"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Край на тази песен"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Добавете песни от албума към опашката",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Добави всички към опашката",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("Добави към опашката"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Добавете песни към опашката",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("епизоди"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Еквалайзер"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Отваряне на системния еквалайзер",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Възникна някаква грешка!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Възникна грешка"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Грешка при игра:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Изнеси"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Изнеси изтеглени файлове",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Натиснете тук, за да изнесете изтегления файл от директорията на приложението във външна директория",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Грешка при изнасянето на плейлист",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Грешка при форматиране на данните от плейлиста",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешението е отказано при изнасяне",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Няма достатъчно място за съхранение",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Файловете са изнесени успешно",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Изнасяне на Плейлист",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Изнасяне на плейлиста като CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Не може да бъде внесен тук",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Изнасяне на плейлиста в JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Този формат може да бъде внесен",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Изнасяне в Youtube музика",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Това ще премести плейлиста ви (песни < 50) в текущата опашка, не забравяйте да добавите към плейлиста/запазите след отваряне в YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Местоположение за изнасяне на изтегления файл",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Изнасяне..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Изнасяне на плейлист...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Любими"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Представени Плейлисти",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Файлът не е намерен"),
    "follow": MessageLookupByLibrary.simpleMessage("Продължи"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("последван"),
    "following": MessageLookupByLibrary.simpleMessage("Следване"),
    "for1": MessageLookupByLibrary.simpleMessage("за"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "забравени любими",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("приятел"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Молбата за приятелство е приета",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Молбата за приятелство е изпратена",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("приятели"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Влезте, за да намерите приятели.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Приятелството премахнато",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Албум"),
    "genericError": MessageLookupByLibrary.simpleMessage("Грешка"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("електроника"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("хип хоп"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Джаз"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("латински"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Поп"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Рок"),
    "gesture": MessageLookupByLibrary.simpleMessage("Жестове"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Вижте изходния код в GitHub. \nАко ви харесва този проект, не забравяйте да дарите ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Отиди на албум"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Натиснете тук за да отидете на страницата за изтегляне",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("здравей свят"),
    "high": MessageLookupByLibrary.simpleMessage("Високо"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL към Piped инстанция",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Начало"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Брой начално съдържание",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Изберете броя на първоначалното съдържание на началния екран (приблизително). По-малко резултати, по-бързо зареждане",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Идентификация"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Игнорирай оптимизация на батерията",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Ако имате проблем с известието или възпроизвеждането е спряно от системна оптимизация моля, активирайте тази опция",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Грешка при внасянето на плейлист",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Грешка при запазване в базата данни",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Неуспешен достъп до избрания файл",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Невалиден файлов формат",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Забележка: Внасянето на големи плейлисти може да отнеме повече време",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Внасяне на Плейлист",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Изберете предварително изнесен JSON файл с плейлист, който да внесете",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Внесени"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Внесено от Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Импортиран плейлист",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Внасяне на плейлист...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Вътрешна директория за съхранение",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Включи изтеглени файлове с песни",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Няма налична информация",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Невалидна файлова структура на плейлиста",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Невалиден отговор на сървъра.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Сесията не съдържа валиден токен.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("елементи"),
    "keepListening": MessageLookupByLibrary.simpleMessage(
      "продължавай да слушаш",
    ),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Запази екрана включен по време на възпроизвеждане",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Ако е активирано, екранът на устройството ще остане включен по време на възпроизвеждане на музика",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Език"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Задай език на приложението",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Последна версия"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Налична последна версия",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Да започваме.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Библиотека Албуми"),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Библиотека Изпълнители",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Библиотека Плейлисти",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Библиотека Песни"),
    "library": MessageLookupByLibrary.simpleMessage("Библиотека"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Плейлист от библиотеката",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Светла"),
    "link": MessageLookupByLibrary.simpleMessage("Връзка"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Свързан успешно!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Връзката е копирана в клипборда",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Връзка с Piped за плейлисти",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Слушай сега"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Вслушване в околната среда...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Неуспешно зареждане на информация за актуализация",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Локално"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Работи без да е необходимо влизане.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Цялата ви библиотека остава строго на този компютър.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Забележка: Без ръчно архивиране в облак. Ако загубите устройството си или деинсталирате приложението, вашите данни не могат да бъдат възстановени.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Използвайте само на това устройство",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Абсолютна поверителност на вашето устройство",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Локален режим"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Сила на звука dB"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Нормализиране силата на звука",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Задава едно и също ниво на силата на звука за всички песни (Експериментално) (Няма да работи с песни, изтеглени на предишна версия (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Ниско"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Писма"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Текстовете не са налични!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Управление на сътрудници (приятели)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Уверете се, че музиката се възпроизвежда достатъчно силно близо до вашия микрофон.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Мигриран албум"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Мигрирана библиотека",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Мигриран плейлист",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Вече е в ход миграция.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Анализ на местната библиотека...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Проверява се дали EMusic Cloud вече има библиотека...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Миграцията е завършена.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Създаване на локално архивиране преди свързване на облак...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Миграцията е неуспешна. Вашите локални данни не са променени.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Влезте в Joss Red преди мигриране.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Подготвя се миграцията в EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud не можа да стартира миграцията.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Не всички данни могат да бъдат качени. Поддържаме вашата местна подкрепа.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Качват се плейлисти, любими и история...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud не можа да потвърди миграцията.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Проверка на целостта в EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Изберете файл и импортирайте",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Изберете song.db или резервно копие .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Миграцията завърши успешно.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("минути"),
    "misc": MessageLookupByLibrary.simpleMessage("Разни"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Най-слушаната песен",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Музика и Възпроизвеждане",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Разпознаване на музика",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Мрежова грешка! Проверете вашата мрежова връзка.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Ами сега, грешка в мрежата!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Налична е нова версия!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Приложение Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("разбрах"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Web"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% синхронизация с Joss Red, плейлисти с приятели и много други. Докоснете, за да видите какво е новото.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music се разви!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "За да добавяте приятели, да приемате заявки или да управлявате профила си за сигурност, моля, използвайте Joss Red на неговите официални платформи:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Приятели и управление на акаунти:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music News",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Създавайте плейлисти с приятелите си! Когато създавате списък за изпълнение, поставете отметка в квадратчето Collaborative и изберете вашите приятели, които да редактирате заедно.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Съвместни плейлисти",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Вашите плейлисти и любими вече се запазват и синхронизират в облака автоматично с основния ви акаунт в Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Пълна интеграция с Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Вече не е необходимо да щракнете върху бутоните за ръчно синхронизиране; Новият мотор отговаря за автоматичното превключване нагоре и надолу.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Прозрачна синхронизация",
    ),
    "no": MessageLookupByLibrary.simpleMessage("не"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Няма отметки!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Нямате добавени приятели в Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Нямате плейлист в библиотеката!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Не можах да намеря никакви песни в записания звук",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Няма съвпадения"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("Няма офлайн песни!"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "В тази колекция няма песни",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Няма намерени съвпадения за",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Не е удостоверено",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Не е Песен/Музикален видеоклип!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Невалидна връзка!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Отвори в"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Операцията се провали",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Парола"),
    "password_text": MessageLookupByLibrary.simpleMessage("Парола"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Разрешението е отказано",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Разрешете"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music се нуждае от тези разрешения, за да управлява вашата музика и да предлага всички функции за възпроизвеждане.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Разрешения, за да започнете",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Дайте необходимите разрешения",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Използва се само когато изберете да идентифицирате песен, която се изпълнява около вас.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Микрофон",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Показва контроли за възпроизвеждане, прогрес на изтегляне и важни бележки за приложения.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Известия",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "И трите разрешителни са необходими, за да продължите. Можете да ги промените по-късно в системните настройки.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Тя ви позволява да възпроизвеждате музика, да запазвате изтегляния, да експортирате плейлисти и да подготвяте актуализации.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Музика и съхранение",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Персонализиране"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Списък за възпроизвеждане",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped плейлист е синхронизиран!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Обикновен"),
    "play": MessageLookupByLibrary.simpleMessage("Играйте"),
    "playNext": MessageLookupByLibrary.simpleMessage("Изпълни като следваща"),
    "playNow": MessageLookupByLibrary.simpleMessage("Играйте сега"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Скорост на възпроизвеждане",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Интерфейс на плейър"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Избери потребителски интерфейс на плейъра",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Играя:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "ИЗПЪЛНЕНИЕ ОТ АЛБУМ",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "ИЗПЪЛНЕНИЕ ОТ ИЗПЪЛНИТЕЛ",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "ИЗПЪЛНЕНИЕ ОТ ПЛЕЙЛИСТ",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "ИЗПЪЛНЕНИЕ ОТ ИЗБОР",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Плейлист"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлиста е в черен списък!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлистът е маркиран!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Отметката за плейлиста е премахната!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Сътрудници на плейлисти",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Създаден плейлист!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Създаден плейлист и добавена песен!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Плейлистът е изнесен успешно в",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Плейлистът е внесен успешно",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлистът е премахнат!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Преименувано успешно!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Плейлисти"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Следваща"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Подкасти"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Популярни песни"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Файловете се обработват...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Аудиото се обработва...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профили"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Повтори опашката"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Режимът повторение на опашката не може да бъде деактивиран, когато режимът на разбъркване е активиран.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Режимът повторение на опашката не може да бъде активиран в радио режим.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Опашката не може да бъде разбъркана, когато режимът на разбъркване е активиран",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Опашката не може да бъде пренаредена, когато режимът на разбъркване е активиран",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Бърз избор"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Бърз избор"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Радиото не е достъпно за този изпълнител!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Случайно радио"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Случаен избор"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Пренареди плейлист",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Пренареди песните"),
    "readMore": MessageLookupByLibrary.simpleMessage("Прочетете повече"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Последни търсения"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Последно изпълнявани",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Препоръчваме да активирате облачен режим за изживяване, подобно на Spotify: синхронизация в реално време между всичките ви устройства и автоматично архивиране, без да се налага да правите нищо.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Препоръчва се"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Препоръчва се"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Премахване от кеша",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Премахни песни от библиотеката",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Изтриване от библиотеката",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Премахни от плейлист",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Премахни от опашката",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Премахни няколко песни",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Премахни плейлист"),
    "rename": MessageLookupByLibrary.simpleMessage("Преименувай"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Преименувай плейлист",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Възпроизведено от"),
    "reset": MessageLookupByLibrary.simpleMessage("Нулирай"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Възстанови настройките по подразбиране",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Възстановяване на настройките на приложението по подразбиране (Необходимо е рестартиране)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Възстановяване на настройките по подразбиране завърши, Моля, рестартирайте приложението",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Нулирай плейлисти в черен списък",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Нулирай всички piped плейлисти в черен списък",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Рестартирай приложението",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Възстановяване"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Възстанови данни от приложението",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Възстанови последната сесия на възпроизвеждане",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Автоматично възстановяване на последната сесия на възпроизвеждане при стартиране на приложението",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Успешно възстановено!\nПромените се прилагат при рестартиране",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Възстанови настройки и плейлисти",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Възстановява всички настройки, данни за вход и плейлисти от архивен файл. Презаписва всички текущи данни",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Изберете архивния файл",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Възстановява се..."),
    "results": MessageLookupByLibrary.simpleMessage("Резултати"),
    "retry": MessageLookupByLibrary.simpleMessage("Опитайте отново!"),
    "save": MessageLookupByLibrary.simpleMessage("Запазете"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Запазено"),
    "scanning": MessageLookupByLibrary.simpleMessage("Сканиране..."),
    "search": MessageLookupByLibrary.simpleMessage("Търсене"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Песни, Плейлист, Албум или Изпълнител",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Търсене в библиотеката",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Резултати от търсенето"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Последни търсения",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Избери всички"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Изберете инстанция за удостоверяване",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Моля, изберете инстанция за удостоверяване!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Изберете файл"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Избери песни"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Избраният файл не е намерен.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Вашата сесия е изтекла. Влезте отново.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Задай съдържание за откриване",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Относно Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Версия, проект с отворен код и GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Акаунт и синхронизиране",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Облачен режим, архивиране, списък с приятели и миграции.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Тема, език и анимации на интерфейса.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Облачно архивиране",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Качете, възстановете и управлявайте...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Качете .hmb резервно копие на приложението на сървъра и, ако е необходимо, възстановете някое от запазените архиви.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Открийте филтри, интеграция с Piped и кешове.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Изтегляния и съхранение",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Аудио формати, папки и автоматично изтегляне.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("генерал"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Изберете, мигрирайте или прегледайте състоянието на синхронизация с Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Локален режим / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Излезте"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Импортиране на плейлисти, песни...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Мигрирайте от Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "моите приятели",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Управлявайте директно приятелите си от Joss Red.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Качество на стрийминг, нормализиране, тишина и батерия.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Генерирайте отново вашия YouTube Music ID, ако съдържанието на Discover не се зареди.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Опресняване на ID (ID на посетител)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Грешка"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Нов идентификатор не можа да бъде генериран. Моля, опитайте отново по-късно.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Актуализиран идентификатор",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Нов идентификатор на посетител беше генериран успешно.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Споделяне на албум"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Споделяне на плейлист",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Сподели тази песен"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Търсене в базата данни на Shazam за съвпадения...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Случаен"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Разбъркай опашката"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Сингли"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Пропусни тишината"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Тишината ще бъде пропусната при възпроизвеждане на музика",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Вашият таймер за заспиване е зададен",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Таймер за заспиване"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Песента е добавена към плейлист!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Песента вече съществува!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Песента вече е офлайн в кеша",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Песента е в опашката!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Песента е намерена!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Информация за песен"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Песента не може да се изпълни поради ограничение на сървъра!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("тон на песента"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Премахнато от"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Премахнато от опашката!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Не можете да премахнете изпълняваната в момента песен",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Песни"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Песни, импортирани от Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Сортиране възходящо/низходящо",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Сортиране по дата"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Сортиране по продължителност",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Сортиране по име"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Скорост и височина"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартен"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Стартирай радиото"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Отворете при стартиране",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Изберете секцията, която Estrella Music отваря първа",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Спри музиката при изчистване на задачата",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Възпроизвеждането на музика ще спре, когато приложението се плъзне от диспечера на задачи",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Качество на потока",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Качество на музикалния поток",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("абонати"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Плъзнете, за да разгледате опциите ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Облачен режим е активиран. Изтегляне на съществуващата библиотека.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Облачен режим е активиран. Мигрирана библиотека.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Облачен режим е активен",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Облачен режим е активен. Чакащо синхронизиране.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Неуспешно изтегляне на синхрон.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Промените в EMusic се изтеглят...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Синхронизирана библиотека.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Библиотеката е актуална.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Има нови местни промени. Те ще бъдат качени преди изтегляне.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Вашите данни се съхраняват само на това устройство.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Локален режим активен",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Офлайн. Предстоят промени.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Офлайн. Промените са запазени за повторен опит.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Синхронизиране на песни от плейлист",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic не потвърди всички промени. Те ще бъдат съдени повторно.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Не можах да стана. Ще се опита повторно по-късно.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Промените са качени правилно.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Промените са качени успешно (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Не може да се качи чрез WS. Ще се опита повторно по-късно.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Промените се качват в EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Синхронизирано"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Синхронизираните текстове не са налични!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "Система по подразбиране",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим на тема"),
    "title": MessageLookupByLibrary.simpleMessage("Заглавие"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Топ музикални видеоклипове",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Водещи музикални видеоклипове",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Набиращи популярност"),
    "unLink": MessageLookupByLibrary.simpleMessage("Прекрати връзката"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Връзката е прекратена успешно!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Песен без заглавие"),
    "upNext": MessageLookupByLibrary.simpleMessage("Следва"),
    "updateApp": MessageLookupByLibrary.simpleMessage(
      "Актуализиране на приложението",
    ),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Открит URL адрес натиснете върху него, за да отворите/изпълните свързано съдържание",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Блокиран потребител"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Отговорът не съдържа списък с потребители.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Отключен потребител",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Потребителско име"),
    "video": MessageLookupByLibrary.simpleMessage("видео"),
    "videos": MessageLookupByLibrary.simpleMessage("Видеоклипове"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Виж всички"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Преглед на изпълнител"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Модернизирахме нашата платформа. Старата система за качване на ръчни архиви е деактивирана. Вече имате два ясни начина за управление на вашата музикална библиотека.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Изберете как искате да изживеете Estrella Music от сега нататък.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Вашата музика, вашият начин",
    ),
  };
}
