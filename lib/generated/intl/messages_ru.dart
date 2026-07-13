// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(error) => "Произошла ошибка при регенерации: ${error}.";

  static String m1(title) => "Похоже на: ${title}";

  static String m2(current) => "Шаг ${current} из 3";

  static String m3(count) => "Зафиксировано ${count}_ изменений.";

  static String m4(count) => "${count}_ синхронизированных изменений.";

  static String m5(statusCode) =>
      "Не удалось найти пользователей (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Создать новый плейлист",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("О"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Добавить 5 минут"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Добавить песни в плейлист",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Добавить в плейлист",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Альбом"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Альбом в закладках!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Альбом удален из закладок!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Альбомы"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("По вашему вкусу"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Все поля обязательны",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Не проверено: при установке флажка после загрузки более 60 файлов процесс может занять большой объем памяти и привести к крашу телефона или приложения. Действуйте на свой страх и риск.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Справка"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Исполнитель в закладках!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Исполнитель удален из закладок!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Описание недоступно!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Исполнители"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("По вашему вкусу"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Кодек"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Примите использовать неправильные данные...",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Авторизоваться"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage(
      "Зарегистрироваться",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Имя"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Я забыл свой пароль",
    ),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Успешно авторизован",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Добро пожаловать в Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Добро пожаловать в Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Автоматическая загрузка любимых песен",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Автоматически загружать избранные песни при добавлении в избранное",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Автоматически открывать экран проигрывателя",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Включить/выключить автоматическое открытие плеера на весь экран при выборе песни для воспроизведения",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Возвращаться"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "база данных найдена",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Фоновое проигрывание музыки",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Включает/отключает проигрывание музыки на заднем фоне (Когда приложение работает на заднем фоне, оно может быть вызвано из системного трея)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Бэкап"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Сделать бэкап приложения",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Бэкап в процессе...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Бэкап успешно сохранён!",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Сохраняет все настройки, плейлисты и логин в файл бэкапа",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Вам нужна активная сессия...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Перезапустить приложение",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Загрузите резервную копию сейчас",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Вы хотите выполнить резервное копирование?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Резервная копия удалена.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Резервных копий пока нет...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Резервная копия восстановлена. Перезапустите приложение.",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Выберите, какие данные для резервного копирования",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Резервная копия загружена правильно.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "На основе последнего взаимодействия",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Битрейт"),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Сброс выполнен успешно!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("от"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Кэшировать контент с главной страницы",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Включает кэширование контента с главного экрана, главный экран будет загружаться мгновенно, если эта опция включена",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Кэш песен"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Кэширование песен во время игры на будущее / оффлайн воспроизведение, это займет дополнительное пространство на вашем устройстве",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Кэшированные/Офлайн",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Отменить таймер"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Таймер сна отключен",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Очистить кэш изображений",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Кэш изображений успешно очищен",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Нажмите здесь чтобы очистить кэшированные миниатюры/изображения. (Не рекомендуется, если только вы не хотите обновить кэшированные изображения)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрывать"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Закрыть приложение"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Облачная библиотека найдена.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Облачная библиотека была найдена. Это устройство загрузит его, не перезаписывая.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Облачный режим готов. Это устройство будет работать как автономный кэш.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Безопасно войдите в систему, используя свою учетную запись Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Получите мгновенный доступ к своим плейлистам, избранному и истории с любого устройства (Windows, Android и т. д.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Умная синхронизация: работайте в автономном режиме и автоматически загружайте изменения при восстановлении доступа к Интернету.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Активировать облачную синхронизацию",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Синхронизация в реальном времени с Джоссом Редом",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Облачный режим (рекомендуется)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Совместный плейлист",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Выберите друзей, которые смогут просматривать и редактировать этот плейлист:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Соавторы обновлены правильно.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Плейлисты сообщества",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Содержание"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Создать и добавить"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Пользовательский сервер",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите пользовательский сервер",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Ежедневное открытие",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Тёмный"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Удалить из загруженных",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Успешно удалено из загруженных!",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Отключить анимацию перехода",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Включите эту опцию, чтобы отключить анимацию перехода между вкладками",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Отключено"),
    "discover": MessageLookupByLibrary.simpleMessage("Обнаружить"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Скрыть"),
    "done": MessageLookupByLibrary.simpleMessage("Готовый"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Не показывать эту информацию снова",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "скачанных файлов найдено",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Скачать"),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Запрошенная песня не может быть скачана из-за ограничений сервера. Попробуйте снова",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Загрузка не удалась из-за ошибки сети/потока! Попробуйте ещё раз",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Папка для загрузок",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Загрузка формата файла",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Выберите формат файла загрузки. «Opus» обеспечит лучшее качество",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Загрузки"),
    "duration": MessageLookupByLibrary.simpleMessage("Длина"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Динамический"),
    "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Пустой плейлист!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Панель навигации снизу",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Переключится на расположение навигационной панели снизу",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Включить скользящие действия",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Включить скользящие действия на плитке песни",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Включено"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Конец песни"),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Добавить всё в очередь",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Добавить эту песню в очередь",
    ),
    "equalizer": MessageLookupByLibrary.simpleMessage("Эквалайзер"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Открыть системный эквалайзер",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Произошла ошибка!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Произошла ошибка"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Ошибка при воспроизведении:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Экспортировать"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Экспортировать скачанные файлы",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Нажмите сюда, чтобы экспортировать скачанные файлы из папки приложения во внешнюю папку",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Ошибка при экспорте плейлиста",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Ошибка форматирования данных плейлиста",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение отказано при экспорте",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Недостаточно места для хранения",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Файлы успешно экспортированы",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Экспортировать плейлист",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Экспортировать плейлист как CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Импорт здесь недоступен",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Экспортировать плейлист в JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Этот формат можно импортировать",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Экспортировать в YouTube Music",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваш плейлист (до 50 песен) будет добавлен в текущую очередь. Не забудьте добавить его в плейлист или сохранить после открытия в YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Место экспортирования скачанных файлов",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Экспортирование..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Экспортируем плейлист...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Избранное"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Избранные плейлисты",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Файл не найден"),
    "follow": MessageLookupByLibrary.simpleMessage("Продолжать"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("подписан"),
    "following": MessageLookupByLibrary.simpleMessage("Следующий"),
    "for1": MessageLookupByLibrary.simpleMessage("для"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "забытое избранное",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Друг"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Запрос на добавление в друзья принят",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Запрос на добавление в друзья отправлен",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Друзья"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Войдите, чтобы найти друзей.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage("Дружба удалена"),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Альбом"),
    "genericError": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Электроника"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("хип-хоп"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Джаз"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("латинский"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Поп"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Камень"),
    "gesture": MessageLookupByLibrary.simpleMessage("Жест"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Посмотреть исходный код на GitHub\nесли вам нравится этот проект, не забудьте поставить ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Перейти в альбом"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Нажмите здесь, чтобы перейти на страницу загрузки",
    ),
    "high": MessageLookupByLibrary.simpleMessage("Высокое"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL-адрес API сервера Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Главная"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Количество контента на главной странице",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Выберите примерное число изначального контента на главном экране. Меньше число - быстрее загрузка",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Игнорировать оптимизацию батареи",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Если вы столкнулись с проблемами уведомлений или воспроизведение остановлено оптимизацией системы, пожалуйста, включите эту опцию",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Ошибка при импорте списка воспроизведения",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Ошибка при сохранении в базе данных",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить доступ к выбранному файлу",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Недопустимый формат файла",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Примечание: импорт больших плейлистов может занять больше времени",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Импортировать плейлист",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Выберите ранее экспортированный файл JSON с плейлистом для импорта",
    ),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Импортировано из Joss Music Kotlin.",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Импорт списка воспроизведения...",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Включать загруженные песни",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Недопустимая структура файла плейлиста",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Неверный ответ сервера.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Сеанс не содержит допустимого токена.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("объекты"),
    "keepListening": MessageLookupByLibrary.simpleMessage("продолжай слушать"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Держать экран включенным во время воспроизведения",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Если включено, экран устройства будет оставаться включенным во время воспроизведения музыки",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "languageDes": MessageLookupByLibrary.simpleMessage("Язык приложения"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Последний выпуск"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Давайте начнём..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Библиотека альбомов"),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Библиотека исполнителей",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Библиотека плейлистов",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Библиотека песен"),
    "library": MessageLookupByLibrary.simpleMessage("Библиотека"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Плейлист библиотеки",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Светлый"),
    "link": MessageLookupByLibrary.simpleMessage("Привязать"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Успешно привязано!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Ссылка скопирована в буфер обмена",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Связать с Piped для плейлистов",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Слушай сейчас"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Слушаем окружающую среду...",
    ),
    "local": MessageLookupByLibrary.simpleMessage("На устройстве"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Работает без необходимости входа в систему.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Вся ваша библиотека остается строго на этом компьютере.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Примечание. Резервное копирование в облако вручную не допускается. Если вы потеряете свое устройство или удалите приложение, ваши данные не смогут быть восстановлены.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Использовать только на этом устройстве",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Абсолютная конфиденциальность на вашем устройстве",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Локальный режим"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Громкость (Db)"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Нормализация громкости",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Устанавливает одинаковый уровень громкости на всех песнях (Экспериментально) (Не будет работать с песнями, скачанными на версии 1.10.0 и ниже)",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Низкое"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Слова песни не доступны!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Управление соавторами (друзьями)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Убедитесь, что музыка рядом с микрофоном играет достаточно громко.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage(
      "Перенесенный альбом",
    ),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Перенесенная библиотека",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Перенесенный плейлист",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Уже идет миграция.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Анализ местной библиотеки...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Проверка наличия библиотеки в EMusic Cloud...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Миграция завершена.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Создание локальной резервной копии перед подключением облака...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Миграция не удалась. Ваши локальные данные не были изменены.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Прежде чем переходить к миграции, войдите в систему Joss Red.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Подготовка миграции в EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud не удалось начать миграцию.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Не все данные удалось загрузить. Мы сохраняем вашу местную поддержку.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Загрузка плейлистов, избранного и истории...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud не удалось проверить миграцию.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Проверка целостности в EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Выбрать файл и импортировать",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("минуты"),
    "misc": MessageLookupByLibrary.simpleMessage("Разное"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Самая прослушиваемая песня",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Музыка и Воспроизведение",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Распознавание музыки",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Ошибка сети! Проверьте подключение к сети.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("Упс, ошибка сети!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Доступна новая версия!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Приложение Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Понял"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Джосс Ред Веб"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "100% синхронизация с Joss Red, плейлисты с друзьями и многое другое. Нажмите, чтобы увидеть, что нового.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music изменилась!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Чтобы добавлять друзей, принимать запросы или управлять своим профилем безопасности, используйте Joss Red на его официальных платформах:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Друзья и управление аккаунтом:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Музыкальные новости Эстреллы",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Создавайте плейлисты с друзьями! При создании плейлиста установите флажок «Совместная работа» и выберите друзей, которые будут редактировать его вместе.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Совместные плейлисты",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Ваши плейлисты и избранное теперь автоматически сохраняются и синхронизируются в облаке с вашей основной учетной записью Joss Red.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Полная интеграция с Джоссом Редом",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Вам больше не нужно нажимать кнопки ручной синхронизации; Новый мотор отвечает за автоматическое переключение передач вверх и вниз.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Прозрачная синхронизация",
    ),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Нет закладок!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "У вас нет добавленных друзей на Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "У вас нет плейлистов в библиотеке!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Не удалось найти ни одной песни в записанном аудио.",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("Нет совпадений"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("Нет офлайн-песен!"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "В этом сборнике нет песен",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("Совпадений не найдено"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Не аутентифицирован",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage("Не является видео!"),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Некорректная ссылка!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Открыть в"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "Операция не удалась",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "password_text": MessageLookupByLibrary.simpleMessage("Пароль"),
    "personalisation": MessageLookupByLibrary.simpleMessage("Персонализация"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Трубчатый плейлист",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист Piped синхронизирован!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Обычно"),
    "playNext": MessageLookupByLibrary.simpleMessage("Включить следующим"),
    "playNow": MessageLookupByLibrary.simpleMessage("Играть сейчас"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Скорость воспроизведения",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Интерфейс плеера"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Выберите интерфейс плеера",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Играю:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "Воспроизвести из альбома",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "Воспроизвести исполнителя",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Воспроизвести плейлист",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "Воспроизвести выбранное",
    ),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист занесен в черный список!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист добавлен в закладки!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист удален из закладок!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Авторы плейлиста",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист создан!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист создан и песня добавлена!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Плейлист успешно экспортирован в",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Плейлист импортирован успешно",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Плейлист удален!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Переименовано успешно!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Плейлисты"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Предстоящие"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Популярные треки"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Обработка файлов..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Обработка звука...",
    ),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Цикл очереди"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Режим цикла очереди нельзя отключить, если включен режим перемешивания.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Режим цикла очереди нельзя включить в режиме радио.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Очередь нельзя перемешать, когда включен режим перемешивания",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Очередь воспроизведения нельзя переупорядочить при включённом режиме перемешивания",
    ),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Быстрый выбор"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Радио недоступно для этого исполнителя!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Случайное радио"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Случайный выбор"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Упорядочить плейлист",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Переставить песни"),
    "readMore": MessageLookupByLibrary.simpleMessage("Читать далее"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Недавние поиски"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Недавно проигранные",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Мы рекомендуем активировать облачный режим, чтобы получить возможности, подобные Spotify: синхронизация в реальном времени между всеми вашими устройствами и автоматическое резервное копирование без необходимости каких-либо действий.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Рекомендуется"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Рекомендуется"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Удалить из библиотеки",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Удалить из плейлиста",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Удалить из очереди",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Убрать несколько песен",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Удалить плейлист"),
    "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Переименовать плейлист",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Воспроизведено"),
    "reset": MessageLookupByLibrary.simpleMessage("Сбросить"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Восстановить настройки по умолчанию",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Сбросить настройки приложения по умолчанию (требуется перезапуск)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Сброс настроек до значений по умолчанию завершен. Пожалуйста, перезапустите приложение",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Сбросить плейлисты из черного списка",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Сбросить все плейлисты Piped из черного списка",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Перезапустить"),
    "restore": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Восстановить данные приложения",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Восстановливать последнюю сессию прослушивания",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Автоматически восстанавливает последнюю сессию прослушивания при запуске приложения",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Восстановлено успешно!\nИзменения войду в силу после перезапуска",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Восстановляет все настройки, логин, плейлисты из бэкапа. Стирает все текущие данные",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Восстановляем..."),
    "results": MessageLookupByLibrary.simpleMessage("Результаты"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторите попытку!"),
    "save": MessageLookupByLibrary.simpleMessage("Держать"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Сохранено"),
    "scanning": MessageLookupByLibrary.simpleMessage("Сканирование..."),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Песни, плейлист, альбом или исполнитель",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Искать в библиотеке",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Результаты поиска"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Недавние поиски",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать всё"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Выберите сервер аутентификации",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите сервер аутентификации!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Выбрать файл"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Выбрать песни"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Выбранный файл не найден.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Срок вашей сессии истек. Войдите снова.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Настроить контент на вкладке открытий",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "О музыке Эстрелла",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Версия, проект с открытым исходным кодом и GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Аккаунт и синхронизация",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Облачный режим, резервное копирование, список друзей и миграция.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Анимация темы, языка и интерфейса.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Облачное резервное копирование",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Загружайте, восстанавливайте и управляйте...",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Откройте для себя фильтры, интеграцию с Piped и кэши.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Загрузки и хранение",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Аудиоформаты, папки и автоматические загрузки.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Общий"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Выберите, перенесите или проверьте статус синхронизации с Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Локальный режим / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Импортируйте плейлисты, песни...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Миграция с Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("мои друзья"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Управляйте своими друзьями Джосс Ред напрямую.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Качество потоковой передачи, нормализация, тишина и батарея.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Восстановите свой идентификатор YouTube Music ID, если контент Discover не загружается.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Обновить идентификатор (идентификатор посетителя)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать новый идентификатор. Пожалуйста, повторите попытку позже.",
    ),
    "settings_visitor_exception": m0,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Обновленный идентификатор",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Новый идентификатор посетителя был успешно создан.",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Поделиться этой песней"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Поиск совпадений в базе данных Shazam...",
    ),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Перемешать очередь"),
    "similarToTitle": m1,
    "singles": MessageLookupByLibrary.simpleMessage("Синглы"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Пропускать тишину"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Тишина будет пропущена при воспроизведении музыки",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Ваш таймер сна установлен",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Таймер сна"),
    "slide_indicator": m2,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Песня добавлена в плейлист!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Песня уже существует!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Песня уже офлайн в кэше",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Песня добавлена в очередь!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Песня найдена!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Информация"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Воспроизведение песни невозможно из-за ограничений сервера!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("тон песни"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Удалено из"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Удалено из очереди!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Вы не можете удалить проигрываемую песню",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Песни"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Песни, импортированные из Joss Music Kotlin",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Скорость и шаг"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандарт"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Запустить радио"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Открыть при запуске",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Выберите раздел, который Estrella Music откроет первым.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Остановить музыку после выполнения задач",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Воспроизведение музыки остановится, когда приложение будет удалено из диспетчера задач",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Потоковое качество",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Качество музыкального потока",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("подписчики"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Проведите пальцем, чтобы просмотреть варианты ➔",
    ),
    "syncChangesConfirmed": m3,
    "syncChangesSynced": m4,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Облачный режим активирован. Скачиваем существующую библиотеку.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Облачный режим активирован. Перенесенная библиотека.",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Облачный режим активен. Ожидается синхронизация.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить синхронизацию.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Загрузка изменений EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Синхронизированная библиотека.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Библиотека в актуальном состоянии.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Есть новые локальные изменения. Они будут загружены перед загрузкой.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Ваши данные хранятся только на этом устройстве.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Локальный режим активен",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Офлайн. Изменения ожидаются.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Офлайн. Изменения сохранены для повторной попытки.",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic не подтвердил все изменения. Они будут рассмотрены повторно.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Не мог встать. Позже будет повторена попытка.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Изменения загружены правильно.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Изменения успешно загружены (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить с помощью WS. Позже будет повторена попытка.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Загрузка изменений в EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Синхронизировано"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Синхронизированные слова песни недоступны!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage(
      "По умолчанию системы",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим темы"),
    "title": MessageLookupByLibrary.simpleMessage("Название"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Лучшие музыкальные клипы",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("В тренде"),
    "unLink": MessageLookupByLibrary.simpleMessage("Отвязать"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("Успешно отвязано!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Песня без названия"),
    "upNext": MessageLookupByLibrary.simpleMessage("Следующий"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Клик по Url открывает\\проигрывает контент",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Заблокированный пользователь",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Ответ не содержит списка пользователей.",
    ),
    "userSearchFailed": m5,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Разблокированный пользователь",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "video": MessageLookupByLibrary.simpleMessage("Видео"),
    "videos": MessageLookupByLibrary.simpleMessage("Видео"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Показать все"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Показать исполнителя"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Мы модернизировали нашу платформу. Старая система загрузки резервных копий вручную отключена. Теперь у вас есть два понятных способа управления вашей музыкальной библиотекой.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Выберите, как вы хотите теперь слушать Estrella Music.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Ваша музыка, ваш путь",
    ),
  };
}
