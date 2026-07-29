// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(songTitle) => "下载：${songTitle}";

  static String m1(error) => "重新生成时发生错误：${error}";

  static String m2(title) => "类似于 ${title}";

  static String m3(current) => "步骤 ${current}（共 3 步）";

  static String m4(count) => "${count} 已提交更改。";

  static String m5(count) => "${count} 同步更改。";

  static String m6(statusCode) => "无法搜索用户 (${statusCode})。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("验证码"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "输入有效的 6 位数代码或重新登录。",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "输入验证器应用程序中的 6 位数代码。此访问权限将在 5 分钟后过期。",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage("双因素身份验证"),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage("检查并继续"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "可爱的小兔子矢量素材 素材中国 素材网...",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("登录"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("登记"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage("确认密码"),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("名"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage("我忘记了密码"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("姓"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage("登录成功"),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "欢迎来到埃斯特雷拉音乐",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage("欢迎来到埃斯特雷拉音乐"),
    "back": MessageLookupByLibrary.simpleMessage("返回"),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "您需要一个活跃的会话...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage("重新启动应用程序"),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage("立即上传备份"),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage("您想执行备份吗？"),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage("备份已删除。"),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage("还没有备份..."),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "备份已恢复。重新启动应用程序。",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage("选择要备份的数据"),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage("备份已正确上传。"),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage("找到云图书馆。"),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "找到了云图书馆。该设备将下载它而不覆盖它。",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "云模式已准备就绪。该设备将用作离线缓存。",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage("使用您的 Joss Red 帐户安全登录。"),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "立即从任何设备（Windows、Android 等）访问您的播放列表、收藏夹和历史记录。",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "智能同步：离线工作并在恢复互联网时自动上传更改。",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage("激活云同步"),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage("与Joss Red实时同步"),
    "cloud_title": MessageLookupByLibrary.simpleMessage("云模式（推荐）"),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "协作播放列表",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "选择能够查看和编辑此播放列表的好友：",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage("协作者已正确更新。"),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("每日发现"),
    "done": MessageLookupByLibrary.simpleMessage("准备好"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage("让您的音乐下载在后台保持活跃。"),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "音乐下载",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "正在准备您的下载...",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage("下载音乐"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮件"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("发生错误"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("播放时出错："),
    "follow": MessageLookupByLibrary.simpleMessage("继续"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("已关注"),
    "following": MessageLookupByLibrary.simpleMessage("下列的"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage("忘记收藏夹"),
    "friendFallback": MessageLookupByLibrary.simpleMessage("朋友"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage("已接受好友请求"),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage("好友请求已发送"),
    "friends": MessageLookupByLibrary.simpleMessage("朋友们"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage("登录寻找朋友。"),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage("友谊已移除"),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("专辑"),
    "genericError": MessageLookupByLibrary.simpleMessage("错误"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("电子产品"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("嘻哈"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("爵士乐"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("拉丁"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("流行音乐"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("岩石"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 导入",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage("服务器响应无效。"),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage("会话不包含有效令牌。"),
    "keepListening": MessageLookupByLibrary.simpleMessage("继续听"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("最新发布"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "图书馆播放列表",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("现在听"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage("聆听环境..."),
    "local_b1": MessageLookupByLibrary.simpleMessage("它无需登录即可工作。"),
    "local_b2": MessageLookupByLibrary.simpleMessage("您的整个图书馆都严格保留在这台计算机上。"),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "注意：没有手动云备份。如果您丢失设备或卸载应用程序，您的数据将无法恢复。",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage("仅在此设备上使用"),
    "local_subtitle": MessageLookupByLibrary.simpleMessage("您设备上的绝对隐私"),
    "local_title": MessageLookupByLibrary.simpleMessage("本地模式"),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage("管理合作者（朋友）"),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "确保麦克风附近的音乐播放声音足够大。",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("迁移相册"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage("迁移的库"),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage("迁移的播放列表"),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "迁移已经在进行中。",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "分析当地图书馆...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "正在检查 EMusic Cloud 是否已有曲库...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage("迁移完成。"),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "连接云端之前创建本地备份...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "迁移失败。您的本地数据未被修改。",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "迁移前登录 Joss Red。",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "正在准备迁移到 EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud 无法开始迁移。",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "并非所有数据都可以上传。我们保留您当地的支持。",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "正在上传播放列表、收藏夹和历史记录...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud 无法验证迁移。",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "正在验证 EMusic Cloud 中的完整性...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage("选择文件并导入"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage("听次数最多的歌曲"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("音乐识别"),
    "news_btn_app": MessageLookupByLibrary.simpleMessage("乔斯红应用程序（Play 商店）"),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("明白了"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("乔斯红网"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "与 Joss Red 100% 同步、与朋友播放列表等等。点击即可查看新内容。",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella 音乐已经进化了！",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "要添加好友、接受请求或管理您的安全配置文件，请在其官方平台上使用 Joss Red：",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "好友和帐户管理：",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage("埃斯特雷拉音乐新闻"),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "与您的朋友一起创建播放列表！创建播放列表时，选中“协作”复选框并选择要一起编辑的朋友。",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage("协作播放列表"),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "您的播放列表和收藏夹现在已自动保存在云中，并与您的 Joss Red 主帐户同步。",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage("与乔斯·红全面融合"),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "您不再需要点击手动同步按钮；新电机负责自动升档和降档。",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage("透明同步"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "您在 Joss Red 上还没有添加好友。",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "在录制的音频中找不到任何歌曲",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("没有匹配项"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage("该专辑中没有歌曲"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("未经过身份验证"),
    "password_text": MessageLookupByLibrary.simpleMessage("密码"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("允许"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music 需要这些权限来管理您的音乐并提供所有播放功能。",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage("开始的权限"),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "授予所需的权限",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "仅当您选择识别您周围正在播放的歌曲时才使用它。",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage("麦克风"),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "显示播放控件、下载进度和重要的应用程序通知。",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage("通知"),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("设置"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "需要所有三项许可证才能继续。您可以稍后在系统设置中更改它们。",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "它允许您播放音乐、保存下载、导出播放列表和准备更新。",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage("音乐和存储"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage("管道播放列表"),
    "playNow": MessageLookupByLibrary.simpleMessage("立即播放"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("播放速度"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("播放："),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "播放列表贡献者",
    ),
    "popularTracks": MessageLookupByLibrary.simpleMessage("热门曲目"),
    "processingAudio": MessageLookupByLibrary.simpleMessage("处理音频..."),
    "readMore": MessageLookupByLibrary.simpleMessage("阅读更多"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "我们建议激活云模式以获得类似 Spotify 的体验：所有设备之间的实时同步和自动备份，无需您执行任何操作。",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("受到推崇的"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("受到推崇的"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("转载者"),
    "save": MessageLookupByLibrary.simpleMessage("保持"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("已保存"),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("在图书馆中搜索"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage("未找到所选文件。"),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "您的会话已过期。再次登录。",
    ),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage("关于埃斯特雷拉音乐"),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "版本、开源项目和 GitHub。",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage("帐户和同步"),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "云模式、备份、好友列表和迁移。",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "主题、语言和界面动画。",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage("云备份"),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "上传、恢复和管理...",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "发现过滤器、与管道和缓存的集成。",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage("下载和存储"),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "音频格式、文件夹和自动下载。",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("一般的"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "使用 Joss Red 选择、迁移或查看同步状态。",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "本地模式/EMusic云",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("退出"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "导入播放列表、歌曲...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 迁移",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("我的朋友们"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "直接管理您的 Joss Red 好友。",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "流媒体质量、标准化、静音和电池。",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "如果发现内容未加载，请重新生成您的 YouTube 音乐 ID。",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "刷新ID（访客ID）",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("错误"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "无法生成新的标识符。请稍后重试。",
    ),
    "settings_visitor_exception": m1,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage("更新的标识符"),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "新的访客 ID 已成功生成。",
    ),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "正在 Shazam 数据库中搜索匹配项...",
    ),
    "similarToTitle": m2,
    "slide_indicator": m3,
    "songFound": MessageLookupByLibrary.simpleMessage("歌曲找到了！"),
    "songPitch": MessageLookupByLibrary.simpleMessage("歌声"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 导入的歌曲",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("速度和音调"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("启动时打开"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "选择 Estrella Music 首先打开的部分",
    ),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage("滑动以探索选项 ➔"),
    "syncChangesConfirmed": m4,
    "syncChangesSynced": m5,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "云模式已启动。下载现有的库。",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "云模式已启动。迁移的库。",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage("云模式已激活"),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage("云模式已激活。等待同步。"),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage("下载同步失败。"),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "正在下载 EMusic 更改...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage("同步库。"),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage("图书馆是最新的。"),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "局部有新的变化。它们将在下载之前上传。",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "您的数据仅保存在此设备上。",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage("本地模式已激活"),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage("离线。更改正在等待中。"),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage("离线。保存更改以供重试。"),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic 并未确认所有更改。他们将被重审。",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage("起不来。稍后将重试。"),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage("更改已正确上传。"),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "更改已成功上传 (WS)。",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "无法使用 WS 上传。稍后将重试。",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage("正在将更改上传到 EMusic..."),
    "untitledSong": MessageLookupByLibrary.simpleMessage("无题歌曲"),
    "userBlocked": MessageLookupByLibrary.simpleMessage("被阻止的用户"),
    "userListMissing": MessageLookupByLibrary.simpleMessage("响应不包含用户列表。"),
    "userSearchFailed": m6,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("解锁用户"),
    "username": MessageLookupByLibrary.simpleMessage("用户名"),
    "video": MessageLookupByLibrary.simpleMessage("视频"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "我们对我们的平台进行了现代化改造。旧的手动上传备份系统已被禁用。您现在有两种清晰的方式来管理您的音乐库。",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "从现在开始选择您想要体验 Estrella Music 的方式。",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage("你的音乐，你的方式"),
  };
}
