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

  static String m1(count) => "专辑： ${count}";

  static String m2(count) => "艺术家： ${count}";

  static String m3(count) => "收藏夹：${count}";

  static String m4(count) => "播放列表：${count}";

  static String m5(count) => "歌曲：${count}";

  static String m6(source) => "迁移从 ${source} 完成。";

  static String m7(error) => "重新生成时发生错误：${error}";

  static String m8(title) => "类似于 ${title}";

  static String m9(current) => "步骤 ${current}（共 3 步）";

  static String m10(count) => "${count} 已提交更改。";

  static String m11(count) => "${count} 同步更改。";

  static String m12(statusCode) => "无法搜索用户 (${statusCode})。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage("创建新的播放列表"),
    "Piped": MessageLookupByLibrary.simpleMessage("管道式"),
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("添加 5 分钟"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage("将歌曲添加到播放列表"),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("添加到库"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("添加到播放列表"),
    "album": MessageLookupByLibrary.simpleMessage("专辑"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage("相册已添加至书签！"),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "专辑书签已删除！",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("专辑"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage("所有字段均为必填"),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "未经测试：下载超过 60 个文件后选中该复选框可能会导致进程消耗大量内存，并可能导致手机或应用程序崩溃。请自行承担风险。",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("申请信息"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "艺术家已添加到书签！",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "艺术家标记已删除！",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage("描述不可用！"),
    "artists": MessageLookupByLibrary.simpleMessage("艺术家"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("音频编解码器"),
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
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "我们从之前的项目中引入了登录、注册和密码恢复功能，适用于这个音乐应用程序。",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "您的会话位于安全存储中，并使用您已使用的相同后端进行验证。",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "需要配置 .env 文件以连接身份验证后端。",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("登录"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("登记"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("发送邮件"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage("确认密码"),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "电子邮件或密码不正确。",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "输入有效的电子邮件。",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      ".env 文件中缺少配置身份验证后端。",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "您的帐户尚未验证。",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage("无法完成该操作。"),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("名"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage("我忘记了密码"),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "我们会将说明发送到您的帐户电子邮件中。",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("姓名@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("姓"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage("登录成功"),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "无法发送电子邮件。",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "电子邮件已发送。",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage("无法创建该帐户。"),
    "auth_register_success": MessageLookupByLibrary.simpleMessage("帐户创建成功。"),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "欢迎来到埃斯特雷拉音乐",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage("欢迎来到埃斯特雷拉音乐"),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage("自动下载喜爱的歌曲"),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "添加到收藏夹后自动下载喜爱的歌曲",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage("自动打开播放器屏幕"),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "选择要播放的歌曲时激活/停用播放器自动打开全屏",
    ),
    "back": MessageLookupByLibrary.simpleMessage("返回"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("找到数据库"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage("在后台播放音乐"),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "启用/禁用背景音乐播放（当应用程序在后台运行时，可以从系统托盘访问该应用程序）",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("备份"),
    "backupAppData": MessageLookupByLibrary.simpleMessage("备份应用程序数据"),
    "backupInProgress": MessageLookupByLibrary.simpleMessage("备份正在进行中..."),
    "backupMsg": MessageLookupByLibrary.simpleMessage("备份保存成功！"),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "备份设置和播放列表",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "将所有设置、播放列表和登录数据保存到备份文件",
    ),
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
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "选择要备份的文件夹",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage("选择要备份的数据"),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage("备份已正确上传。"),
    "basedOnLast": MessageLookupByLibrary.simpleMessage("基于上次交互"),
    "bitrate": MessageLookupByLibrary.simpleMessage("比特率"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage("播放列表黑名单"),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage("重置成功！"),
    "by": MessageLookupByLibrary.simpleMessage("通过"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage("存储主屏幕内容数据"),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "启用主屏幕内容数据存储，如果启用此选项，主屏幕将立即加载",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("缓存歌曲"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "在播放歌曲时缓存歌曲以供将来/离线播放将占用您设备上的额外空间",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("缓存/离线"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("取消定时器"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage("睡眠定时器已取消"),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("清除图像缓存"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage("图片缓存清除成功"),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "单击此处清除缓存的缩略图/图像。 （不推荐，除非您想更新缓存的图像数据）",
    ),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "closeApp": MessageLookupByLibrary.simpleMessage("关闭申请"),
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
    "communityplaylists": MessageLookupByLibrary.simpleMessage("社区播放列表"),
    "content": MessageLookupByLibrary.simpleMessage("内容"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX。 GPL 许可证 v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("创建"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("创建并添加"),
    "customIns": MessageLookupByLibrary.simpleMessage("自定义实例"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage("请选择自定义实例"),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("每日发现"),
    "dark": MessageLookupByLibrary.simpleMessage("黑暗"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage("从下载中删除"),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "已成功从下载中删除！",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "由 Joss Estrada (JOSPROX) 开发和维护",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "禁用过渡动画",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "激活此选项以禁用选项卡过渡动画",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("残疾人"),
    "discover": MessageLookupByLibrary.simpleMessage("发现"),
    "dismiss": MessageLookupByLibrary.simpleMessage("丢弃"),
    "done": MessageLookupByLibrary.simpleMessage("准备好"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage("不再显示该信息"),
    "downFilesFound": MessageLookupByLibrary.simpleMessage("找到下载的文件"),
    "download": MessageLookupByLibrary.simpleMessage("下载"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage("下载专辑中的歌曲"),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "由于服务器限制，无法下载请求的歌曲。您可以再试一次",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "由于网络/传输错误，下载失败！请重试",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("下载位置"),
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
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage("下载播放列表"),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage("下载文件格式"),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "选择下载文件格式。 “Opus”将提供最好的品质",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("下载"),
    "duration": MessageLookupByLibrary.simpleMessage("持续时间"),
    "dynamic": MessageLookupByLibrary.simpleMessage("动态"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮件"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("播放列表为空！"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage("底部导航栏"),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage("切换到底部导航栏"),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage("激活滑块操作"),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "激活歌曲图块上的滑动操作",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("已激活"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("这首歌结束"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage("将专辑歌曲添加到队列"),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("将全部添加到队列中"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("将这首歌添加到队列中"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage("将歌曲添加到队列"),
    "episodes": MessageLookupByLibrary.simpleMessage("剧集数"),
    "equalizer": MessageLookupByLibrary.simpleMessage("均衡器"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage("打开系统均衡器"),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage("发生错误！"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("发生错误"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("播放时出错："),
    "export": MessageLookupByLibrary.simpleMessage("出口"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage("导出下载的文件"),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "点击这里将下载的文件从应用程序目录导出到外部目录",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage("导出播放列表时出错"),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage("格式化播放列表数据时出错"),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage("导出时权限被拒绝"),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage("存储空间不足"),
    "exportMsg": MessageLookupByLibrary.simpleMessage("文件导出成功"),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("导出播放列表"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage("将播放列表导出为 CSV"),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage("这里无法导入"),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage("将播放列表导出为 JSON"),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "这个格式可以导入",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "导出到 Online 音乐",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "它将把您的播放列表（歌曲 < 50）推送到当前队列，在 MusicService 中打开它后不要忘记将其添加到播放列表/保存",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage("下载文件的导出位置"),
    "exporting": MessageLookupByLibrary.simpleMessage("正在导出..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage("正在导出播放列表..."),
    "favorites": MessageLookupByLibrary.simpleMessage("收藏夹"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage("精选播放列表"),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("找不到文件"),
    "follow": MessageLookupByLibrary.simpleMessage("继续"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("已关注"),
    "following": MessageLookupByLibrary.simpleMessage("下列的"),
    "for1": MessageLookupByLibrary.simpleMessage("为了"),
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
    "gesture": MessageLookupByLibrary.simpleMessage("手势"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "查看 GitHub 源代码 \n如果你喜欢这个项目，别忘了给它一个⭐！",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("前往相册"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage("点击此处进入下载页面"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("你好世界"),
    "high": MessageLookupByLibrary.simpleMessage("高"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage("管道实例的 API URL"),
    "home": MessageLookupByLibrary.simpleMessage("首页"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage("启动内容计数"),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "选择初始主屏幕内容的数量（大约）。结果更少加载速度更快",
    ),
    "id": MessageLookupByLibrary.simpleMessage("身份证号"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage("忽略电池优化"),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "如果您因系统优化而遇到通知问题或播放停止，请激活此选项",
    ),
    "importError": MessageLookupByLibrary.simpleMessage("导入播放列表时出错"),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage("保存到数据库时出错"),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage("无法访问所选文件"),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage("文件格式无效"),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "注意：导入大型播放列表可能需要更长的时间",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("导入播放列表"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "选择之前导出的播放列表 JSON 文件进行导入",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("进口"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 导入",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage("导入的播放列表"),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage("正在导入播放列表..."),
    "in_app_storage": MessageLookupByLibrary.simpleMessage("内部存储目录"),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage("包括下载的歌曲文件"),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage("信息不可用"),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage("播放列表文件结构无效"),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage("服务器响应无效。"),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage("会话不包含有效令牌。"),
    "items": MessageLookupByLibrary.simpleMessage("元素"),
    "keepListening": MessageLookupByLibrary.simpleMessage("继续听"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "播放时保持屏幕常亮",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "如果启用，设备屏幕将在播放音乐时保持唤醒状态",
    ),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "languageDes": MessageLookupByLibrary.simpleMessage("设置应用语言"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("最新发布"),
    "latestVersion": MessageLookupByLibrary.simpleMessage("最新版本可用"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("让我们开始吧.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("图书馆相册"),
    "libArtists": MessageLookupByLibrary.simpleMessage("图书馆艺术家"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("图书馆播放列表"),
    "libSongs": MessageLookupByLibrary.simpleMessage("图书馆歌曲"),
    "library": MessageLookupByLibrary.simpleMessage("图书馆"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "图书馆播放列表",
    ),
    "light": MessageLookupByLibrary.simpleMessage("当然"),
    "link": MessageLookupByLibrary.simpleMessage("链接"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("链接成功！"),
    "linkCopied": MessageLookupByLibrary.simpleMessage("链接已复制到剪贴板"),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage("与播放列表的 Piped 链接"),
    "listenNow": MessageLookupByLibrary.simpleMessage("现在听"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage("聆听环境..."),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage("无法加载更新信息"),
    "local": MessageLookupByLibrary.simpleMessage("本地"),
    "local_b1": MessageLookupByLibrary.simpleMessage("它无需登录即可工作。"),
    "local_b2": MessageLookupByLibrary.simpleMessage("您的整个图书馆都严格保留在这台计算机上。"),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "注意：没有手动云备份。如果您丢失设备或卸载应用程序，您的数据将无法恢复。",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage("仅在此设备上使用"),
    "local_subtitle": MessageLookupByLibrary.simpleMessage("您设备上的绝对隐私"),
    "local_title": MessageLookupByLibrary.simpleMessage("本地模式"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("响度Db"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage("响度归一化"),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "为所有歌曲设置相同的响度级别（实验）（不适用于旧版本 (< v1.10.0) 下载的歌曲）",
    ),
    "low": MessageLookupByLibrary.simpleMessage("低"),
    "lyrics": MessageLookupByLibrary.simpleMessage("信件"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage("歌词不可用！"),
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
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "选择song.db或备份.backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage("迁移成功完成。"),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("分钟"),
    "misc": MessageLookupByLibrary.simpleMessage("各种"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage("听次数最多的歌曲"),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage("音乐和播放"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("音乐识别"),
    "networkError": MessageLookupByLibrary.simpleMessage("网络错误！检查您的互联网连接。"),
    "networkError1": MessageLookupByLibrary.simpleMessage("糟糕，网络错误！"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage("新版本上线！"),
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
    "no": MessageLookupByLibrary.simpleMessage("否"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("没有书签！"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "您在 Joss Red 上还没有添加好友。",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage("您的媒体库中没有任何播放列表！"),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "在录制的音频中找不到任何歌曲",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("没有匹配项"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("没有离线歌曲！"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage("该专辑中没有歌曲"),
    "nomatch": MessageLookupByLibrary.simpleMessage("没有找到匹配项"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("未经过身份验证"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage("这不是歌曲/音乐视频！"),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("这不是有效链接！"),
    "openIn": MessageLookupByLibrary.simpleMessage("打开于"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("操作失败"),
    "password": MessageLookupByLibrary.simpleMessage("密码"),
    "password_text": MessageLookupByLibrary.simpleMessage("密码"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("权限被拒绝"),
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
    "personalisation": MessageLookupByLibrary.simpleMessage("个性化"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage("管道播放列表"),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage("管道播放列表已同步！"),
    "plain": MessageLookupByLibrary.simpleMessage("简单"),
    "play": MessageLookupByLibrary.simpleMessage("玩"),
    "playNext": MessageLookupByLibrary.simpleMessage("播放下一个"),
    "playNow": MessageLookupByLibrary.simpleMessage("立即播放"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("播放速度"),
    "playerUi": MessageLookupByLibrary.simpleMessage("玩家界面"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage("选择播放器用户界面"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("播放："),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage("从专辑中播放"),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage("艺术家演奏"),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage("从播放列表中播放"),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage("从选择中播放"),
    "playlist": MessageLookupByLibrary.simpleMessage("播放列表"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "列入黑名单的播放列表！",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "播放列表已添加到书签！",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "播放列表书签已删除！",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "播放列表贡献者",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage("播放列表已创建！"),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "创建播放列表并添加歌曲！",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage("播放列表已成功导出到"),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage("播放列表导入成功"),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage("播放列表已删除！"),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage("品牌更名成功！"),
    "playlists": MessageLookupByLibrary.simpleMessage("播放列表"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("即将推出"),
    "podcasts": MessageLookupByLibrary.simpleMessage("播客"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("热门曲目"),
    "processFiles": MessageLookupByLibrary.simpleMessage("正在处理文件..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage("处理音频..."),
    "profiles": MessageLookupByLibrary.simpleMessage("型材"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("尾环"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "当启用 shuffle 模式时，无法禁用队列循环模式。",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "在无线电模式下无法激活尾循环模式。",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "随机模式已激活。您无法手动混合队列。",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "当随机模式开启时，队列无法重新排序",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("快速选择"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("快速精选"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage("该艺术家无法收听广播！"),
    "randomRadio": MessageLookupByLibrary.simpleMessage("随机广播"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("随机选择"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage("重新排序播放列表"),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("重新排序歌曲"),
    "readMore": MessageLookupByLibrary.simpleMessage("阅读更多"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("最近玩过"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "我们建议激活云模式以获得类似 Spotify 的体验：所有设备之间的实时同步和自动备份，无需您执行任何操作。",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("受到推崇的"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("受到推崇的"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("从缓存中删除"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage("从库中删除歌曲"),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage("从库中删除"),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage("从播放列表中删除"),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("从队列中删除"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage("删除多首歌曲"),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("删除播放列表"),
    "rename": MessageLookupByLibrary.simpleMessage("重命名"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("重命名播放列表"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("转载者"),
    "reset": MessageLookupByLibrary.simpleMessage("重置"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage("恢复默认设置"),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "将应用程序设置重置为默认值（需要重新启动）",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "设置重置为默认完成，请重新启动应用程序",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "重置黑名单播放列表",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "重置所有列入黑名单的管道播放列表",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("重新启动应用程序"),
    "restore": MessageLookupByLibrary.simpleMessage("恢复"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage("恢复应用程序数据"),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "恢复上次播放会话",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "启动应用程序时自动恢复上次播放会话",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage("恢复成功！\n更改将在重新启动后应用"),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "恢复设置和播放列表",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "从备份文件恢复所有设置、登录数据和播放列表。覆盖所有当前数据",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "选择备份文件",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("正在恢复..."),
    "results": MessageLookupByLibrary.simpleMessage("结果"),
    "retry": MessageLookupByLibrary.simpleMessage("重试！"),
    "save": MessageLookupByLibrary.simpleMessage("保持"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("已保存"),
    "scanning": MessageLookupByLibrary.simpleMessage("正在扫描..."),
    "search": MessageLookupByLibrary.simpleMessage("搜索"),
    "searchDes": MessageLookupByLibrary.simpleMessage("歌曲、播放列表、专辑或艺术家"),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("在图书馆中搜索"),
    "searchRes": MessageLookupByLibrary.simpleMessage("搜索结果"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "selectAll": MessageLookupByLibrary.simpleMessage("选择全部"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("选择认证实例"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage("请选择认证实例！"),
    "selectFile": MessageLookupByLibrary.simpleMessage("选择文件"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("选择歌曲"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage("未找到所选文件。"),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "您的会话已过期。再次登录。",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage("设置发现内容"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
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
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "将应用程序的 .hmb 备份上传到服务器，并根据需要恢复任何已保存的备份。",
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
      "如果发现内容未加载，请重新生成您的 Online 音乐 ID。",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "刷新ID（访客ID）",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("错误"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "无法生成新的标识符。请稍后重试。",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage("更新的标识符"),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "新的访客 ID 已成功生成。",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("分享相册"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("分享播放列表"),
    "shareSong": MessageLookupByLibrary.simpleMessage("分享这首歌"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "正在 Shazam 数据库中搜索匹配项...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("随机"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("混合尾巴"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("简单"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("跳过沉默"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage("播放音乐时将跳过静音"),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage("您的睡眠定时器已设置"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("睡眠定时器"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "歌曲已添加到播放列表！",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage("这首歌已经存在了！"),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage("该歌曲已在缓存中"),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage("歌曲已添加到队列中！"),
    "songFound": MessageLookupByLibrary.simpleMessage("歌曲找到了！"),
    "songInfo": MessageLookupByLibrary.simpleMessage("歌曲信息"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage("由于服务器限制，歌曲无法播放！"),
    "songPitch": MessageLookupByLibrary.simpleMessage("歌声"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("删除自"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage("已从队列中删除！"),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "您无法删除当前播放的歌曲",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("歌曲"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 导入的歌曲",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage("升序/降序排序"),
    "sortByDate": MessageLookupByLibrary.simpleMessage("按日期排序"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage("按持续时间排序"),
    "sortByName": MessageLookupByLibrary.simpleMessage("按名称排序"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("速度和音调"),
    "standard": MessageLookupByLibrary.simpleMessage("标准型"),
    "startRadio": MessageLookupByLibrary.simpleMessage("启动收音机"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("启动时打开"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "选择 Estrella Music 首先打开的部分",
    ),
    "status": MessageLookupByLibrary.simpleMessage("状态"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage("关闭应用程序时停止音乐"),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "从任务管理器关闭应用程序时音乐播放将停止",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("流媒体质量"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage("音乐流媒体质量"),
    "subscribers": MessageLookupByLibrary.simpleMessage("订户"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage("滑动以探索选项 ➔"),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
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
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación。Después, las playlists, favoritos, historicalial, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo.没有se puede deshacer desde el servidor。",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca musical remota ？",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen loces.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "取消sincronización y subir esta base",
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
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage("同步播放列表歌曲"),
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
    "synced": MessageLookupByLibrary.simpleMessage("同步"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage("无法同步歌词！"),
    "systemDefault": MessageLookupByLibrary.simpleMessage("系统默认值"),
    "themeMode": MessageLookupByLibrary.simpleMessage("主题模式"),
    "title": MessageLookupByLibrary.simpleMessage("标题"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("热门音乐视频"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("最佳音乐视频"),
    "trending": MessageLookupByLibrary.simpleMessage("趋势"),
    "unLink": MessageLookupByLibrary.simpleMessage("取消链接"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("解除链接成功！"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("无题歌曲"),
    "upNext": MessageLookupByLibrary.simpleMessage("下一页"),
    "updateApp": MessageLookupByLibrary.simpleMessage("更新应用程序"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "检测到的 URL 单击它可打开/播放相关内容",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("被阻止的用户"),
    "userListMissing": MessageLookupByLibrary.simpleMessage("响应不包含用户列表。"),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("解锁用户"),
    "username": MessageLookupByLibrary.simpleMessage("用户名"),
    "video": MessageLookupByLibrary.simpleMessage("视频"),
    "videos": MessageLookupByLibrary.simpleMessage("视频"),
    "viewAll": MessageLookupByLibrary.simpleMessage("查看全部"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("查看艺术家"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "我们对我们的平台进行了现代化改造。旧的手动上传备份系统已被禁用。您现在有两种清晰的方式来管理您的音乐库。",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "从现在开始选择您想要体验 Estrella Music 的方式。",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage("你的音乐，你的方式"),
  };
}
