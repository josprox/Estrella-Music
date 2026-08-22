// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(songTitle) => "正在下載：${songTitle}";

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
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage("建立新的播放清單"),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("關於"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("延長 5 分鐘"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage("增加歌曲到播放清單"),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("添加到库"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("新增至播放清單"),
    "album": MessageLookupByLibrary.simpleMessage("專輯"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage("專輯已加入收藏！"),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "專輯已從收藏中移除！",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("專輯"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage("所有欄位皆為必填"),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "尚未測試：下載超過 60 個檔案後點選核取方塊可能會消耗大量記憶體，並可能導致手機或應用程式當機。請自行評估風險後進行。",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("應用程式資訊"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage("藝人已加入收藏！"),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "藝人已從收藏中移除！",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage("暫無描述！"),
    "artists": MessageLookupByLibrary.simpleMessage("藝人"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("根据你的口味"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("音訊轉碼器"),
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
      "我同意使用我的数据...",
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
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("注册"),
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
    "auth_first_name": MessageLookupByLibrary.simpleMessage("名字"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage("我忘记了密码"),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "我们会将说明发送到您的帐户电子邮件中。",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("姓名@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("姓氏"),
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
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage("自動下載最愛歌曲"),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "將歌曲加入最愛時，自動下載最愛歌曲",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage("自動開啟播放器螢幕"),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "啟用/停用在選擇要播放的歌曲時自動全螢幕開啟播放器",
    ),
    "back": MessageLookupByLibrary.simpleMessage("返回"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage("找到資料庫"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage("背景音樂播放"),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "開啟/關閉背景音樂播放（當應用程式在背景執行時，可以從系統匣存取應用程式）",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("備份"),
    "backupAppData": MessageLookupByLibrary.simpleMessage("備份應用程式資料"),
    "backupInProgress": MessageLookupByLibrary.simpleMessage("備份中..."),
    "backupMsg": MessageLookupByLibrary.simpleMessage("成功儲存備份！"),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "备份设置和播放列表",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "將所有設定、播放清單和登入資料儲存至備份檔案中",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "您需要一个活跃的会话...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage("重新启动应用程序"),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage("立即上传备份"),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage("您想进行备份吗？"),
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
    "basedOnLast": MessageLookupByLibrary.simpleMessage("根據上次互動"),
    "bitrate": MessageLookupByLibrary.simpleMessage("位元率"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage("播放列表黑名单"),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage("重設成功！"),
    "by": MessageLookupByLibrary.simpleMessage("開發者"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage("快取首頁內容資料"),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "開啟首頁內容資料快取，若啟用此選項，首頁將立即加載",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("快取歌曲"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "在播放歌曲時進行快取以供未來或離線播放，這將佔用您設備的額外空間",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("快取/離線"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("取消計時器"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage("睡眠計時器已取消"),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("清除圖片快取"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage("圖片快取已清除成功"),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "按一下此處清除快取的縮圖/圖片。 （不推薦，除非想要更新快取的圖片資料）",
    ),
    "close": MessageLookupByLibrary.simpleMessage("關閉"),
    "closeApp": MessageLookupByLibrary.simpleMessage("關閉程式"),
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
    "communityplaylists": MessageLookupByLibrary.simpleMessage("社群播放清單"),
    "content": MessageLookupByLibrary.simpleMessage("內容"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX。 GPL 许可证 v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("建立"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("建立並新增"),
    "customIns": MessageLookupByLibrary.simpleMessage("自訂實例"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage("請選擇自訂實例"),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("每日发现"),
    "dark": MessageLookupByLibrary.simpleMessage("深色"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage("從「下載」中移除"),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "已成功從下載中刪除！",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "由 Joss Estrada (JOSPROX) 开发和维护",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "關閉過渡動畫",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "啟用此選項以關閉分頁過渡時的動畫",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("停用"),
    "discover": MessageLookupByLibrary.simpleMessage("探索"),
    "dismiss": MessageLookupByLibrary.simpleMessage("忽略"),
    "done": MessageLookupByLibrary.simpleMessage("准备好"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage("不再顯示此資訊"),
    "downFilesFound": MessageLookupByLibrary.simpleMessage("找到已下載的檔案"),
    "download": MessageLookupByLibrary.simpleMessage("下載"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage("下载专辑中的歌曲"),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "由於伺服器限制，請求的歌曲無法下載。您可以再試一次",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "由於網路/串流錯誤，下載失敗！請再試一次",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("下載位置"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage("讓音樂下載在背景持續執行。"),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "音樂下載",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "正在準備下載…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage("正在下載音樂"),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage("下载播放列表"),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage("下載檔案格式"),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "選擇下載的檔案格式。「Opus」將提供最佳品質",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("下載"),
    "duration": MessageLookupByLibrary.simpleMessage("長度"),
    "dynamic": MessageLookupByLibrary.simpleMessage("動態"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮件"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("撥放清單是空的！"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage("底部導航列"),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage("切換到底部導航列"),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage("啟用滑動動作"),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "在歌曲區塊上啟用滑動動作",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("啟用"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("這首歌的結尾"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage("将专辑歌曲添加到队列"),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("將全部新增至佇列"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("將這首歌加入播放佇列"),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage("将歌曲添加到队列"),
    "episodes": MessageLookupByLibrary.simpleMessage("剧集数"),
    "equalizer": MessageLookupByLibrary.simpleMessage("等化器"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage("開啟系統等化器"),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage("發生一些錯誤！"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("发生错误"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("播放时出错："),
    "export": MessageLookupByLibrary.simpleMessage("匯出"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage("匯出已下載的檔案"),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "點擊這裡將已下載的檔案從應用程式匯出至外部目錄",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage("輸出播放清單時發生錯誤"),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage("格式化播放清單資料時出錯"),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage("匯出時權限被拒絕"),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage("儲存空間不足"),
    "exportMsg": MessageLookupByLibrary.simpleMessage("檔案順利匯出"),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("輸出播放清單"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage("将播放列表导出为 CSV"),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage("这里无法导入"),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage("将播放列表导出为 JSON"),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "这个格式可以导入",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "导出到 YouTube 音乐",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "它将把您的播放列表（歌曲 < 50）推送到当前队列，在 YtMusic 中打开它后不要忘记将其添加到播放列表/保存",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage("已下載檔案的匯出位置"),
    "exporting": MessageLookupByLibrary.simpleMessage("正在匯出…"),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage("正在輸出播放清單……"),
    "favorites": MessageLookupByLibrary.simpleMessage("我的最愛"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage("精選播放清單"),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("無法找到檔案"),
    "follow": MessageLookupByLibrary.simpleMessage("关注"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("已关注"),
    "following": MessageLookupByLibrary.simpleMessage("正在关注"),
    "for1": MessageLookupByLibrary.simpleMessage("為"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage("忘记收藏夹"),
    "friendFallback": MessageLookupByLibrary.simpleMessage("朋友"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage("已接受好友请求"),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage("好友请求已发送"),
    "friends": MessageLookupByLibrary.simpleMessage("朋友"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage("登录寻找朋友。"),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage("友谊已移除"),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("专辑"),
    "genericError": MessageLookupByLibrary.simpleMessage("错误"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("电子产品"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("嘻哈"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("爵士乐"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("拉丁语"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("流行音乐"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("摇滚"),
    "gesture": MessageLookupByLibrary.simpleMessage("手勢"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "檢視 GitHub 原始碼。\n如果您喜歡這個專案，別忘了給我們一顆⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("前往專輯"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage("點擊此處進入下載頁面"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("你好世界"),
    "high": MessageLookupByLibrary.simpleMessage("高"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage("Piped 實例的 API URL"),
    "home": MessageLookupByLibrary.simpleMessage("首頁"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage("首頁內容數量"),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "選擇初始首頁內容的數量（大約）。較少的結果可以加快載入速度",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage("忽略電池最佳化"),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "如果您遇到通知問題或播放因系統最佳化而停止，請啟用此選項",
    ),
    "importError": MessageLookupByLibrary.simpleMessage("匯入播放清單時發生錯誤"),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage("儲存到資料庫時出錯"),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage("無法存取播放清單"),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage("文件格式無效"),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "注意：匯入大型播放清單可能需要更長的時間",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("匯入播放清單"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "選擇先前匯出的播放清單 JSON 檔案進行匯入",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("进口"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "从 Joss Music Kotlin 导入",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage("导入的播放列表"),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage("正在匯入播放清單……"),
    "in_app_storage": MessageLookupByLibrary.simpleMessage("内部存储目录"),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "包含已下載的歌曲檔案",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage("信息不可用"),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage("播放清單檔案結構無效"),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage("服务器响应无效。"),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage("会话不包含有效令牌。"),
    "items": MessageLookupByLibrary.simpleMessage("項目"),
    "keepListening": MessageLookupByLibrary.simpleMessage("继续听"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "播放時保持螢幕常亮",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "啟用後，播放音樂時設備螢幕將保持亮起",
    ),
    "language": MessageLookupByLibrary.simpleMessage("語言"),
    "languageDes": MessageLookupByLibrary.simpleMessage("設定應用程式語言"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("最新发布"),
    "latestVersion": MessageLookupByLibrary.simpleMessage("最新版本可用"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("讓我們開始吧..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("資料庫中的專輯"),
    "libArtists": MessageLookupByLibrary.simpleMessage("資料庫中的藝人"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("資料庫中的播放清單"),
    "libSongs": MessageLookupByLibrary.simpleMessage("資料庫中的歌曲"),
    "library": MessageLookupByLibrary.simpleMessage("資料庫"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "图书馆播放列表",
    ),
    "light": MessageLookupByLibrary.simpleMessage("淺色"),
    "link": MessageLookupByLibrary.simpleMessage("連接"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("成功連接！"),
    "linkCopied": MessageLookupByLibrary.simpleMessage("链接已复制到剪贴板"),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage("連結Piped以管理播放清單"),
    "listenNow": MessageLookupByLibrary.simpleMessage("现在听"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage("聆听环境..."),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage("无法加载更新信息"),
    "local": MessageLookupByLibrary.simpleMessage("本機"),
    "local_b1": MessageLookupByLibrary.simpleMessage("它无需登录即可工作。"),
    "local_b2": MessageLookupByLibrary.simpleMessage("您的整个图书馆都严格保留在这台计算机上。"),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "注意：没有手动云备份。如果您丢失设备或卸载应用程序，您的数据将无法恢复。",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage("仅在此设备上使用"),
    "local_subtitle": MessageLookupByLibrary.simpleMessage("您设备上的绝对隐私"),
    "local_title": MessageLookupByLibrary.simpleMessage("本地模式"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("響度（分貝）"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage("音量標準化"),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "將所有歌曲調整成相同的音量（實驗性功能，不適用於在舊版本（< v1.10.0）下載的歌曲）",
    ),
    "low": MessageLookupByLibrary.simpleMessage("低"),
    "lyrics": MessageLookupByLibrary.simpleMessage("信件"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage("暫無歌詞！"),
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
    "minutes": MessageLookupByLibrary.simpleMessage("分鐘"),
    "misc": MessageLookupByLibrary.simpleMessage("其他選項"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage("听次数最多的歌曲"),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage("音樂&播放"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("音乐识别"),
    "networkError": MessageLookupByLibrary.simpleMessage("網路錯誤！請檢查您的網路連線。"),
    "networkError1": MessageLookupByLibrary.simpleMessage("歐歐~網路錯誤！"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage("新版本已發布！"),
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
    "noBookmarks": MessageLookupByLibrary.simpleMessage("沒有收藏！"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "您在 Joss Red 上还没有添加好友。",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage("您目前沒有任何播放清單！"),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "在录制的音频中找不到任何歌曲",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("没有匹配项"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("沒有可離線存取的音樂！"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage("该专辑中没有歌曲"),
    "nomatch": MessageLookupByLibrary.simpleMessage("未找到符合以下搜尋內容的結果"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("未经过身份验证"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage("這不是歌曲或MV！"),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("連結無效！"),
    "openIn": MessageLookupByLibrary.simpleMessage("在...中開啟"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("操作失敗"),
    "password": MessageLookupByLibrary.simpleMessage("密碼"),
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
    "personalisation": MessageLookupByLibrary.simpleMessage("個人化"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage("管道播放列表"),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage("已同步Piped播放清單！"),
    "plain": MessageLookupByLibrary.simpleMessage("普通"),
    "play": MessageLookupByLibrary.simpleMessage("玩"),
    "playNext": MessageLookupByLibrary.simpleMessage("播放下一首"),
    "playNow": MessageLookupByLibrary.simpleMessage("立即播放"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("播放速度"),
    "playerUi": MessageLookupByLibrary.simpleMessage("播放器介面"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage("選擇播放器介面"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("播放："),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage("從專輯撥放"),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage("從藝人撥放"),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage("從播放清單撥放"),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage("從精選撥放"),
    "playlist": MessageLookupByLibrary.simpleMessage("播放列表"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "播放清單已被列入黑名單！",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "播放清單已加入收藏！",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "播放清單已從收藏中移除！",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "播放列表贡献者",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage("已建立播放清單！"),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "播放清單已建立，歌曲也已經加入！",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage("播放清單成功輸出至"),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage("成功匯入播放清單"),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage("播放清單已刪除！"),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage("重新命名成功！"),
    "playlists": MessageLookupByLibrary.simpleMessage("撥放清單"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("下一首"),
    "podcasts": MessageLookupByLibrary.simpleMessage("播客"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("热门曲目"),
    "processFiles": MessageLookupByLibrary.simpleMessage("檔案處理中..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage("处理音频..."),
    "profiles": MessageLookupByLibrary.simpleMessage("型材"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("播放佇列循環"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "當隨機播放模式啟用時，無法關閉播放佇列循環模式。",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "在收音機模式下，無法啟用播放佇列循環模式。",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "當隨機播放模式已啟用時，無法打亂播放佇列",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "當隨機播放模式已啟用時，無法重新排列播放佇列",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("快速选择"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("快速選擇"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage("收音機不適用於此藝人！"),
    "randomRadio": MessageLookupByLibrary.simpleMessage("隨機廣播"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("隨機選擇"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage("重新排列播放清單"),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("重新排列歌曲"),
    "readMore": MessageLookupByLibrary.simpleMessage("了解更多"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("最近播放"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "我们建议激活云模式以获得类似 Spotify 的体验：所有设备之间的实时同步和自动备份，无需您执行任何操作。",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("推荐"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("推荐"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("从缓存中删除"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage("從資料庫中移除歌曲"),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage("从库中删除"),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage("從播放清單移除"),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("從播放佇列中移除"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage("刪除多首歌曲"),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("移除撥放清單"),
    "rename": MessageLookupByLibrary.simpleMessage("重新命名"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("重新命名播放清單"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("转载者"),
    "reset": MessageLookupByLibrary.simpleMessage("重設"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage("還原預設值"),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "將應用程式設定重設為預設值 （需要重新啟動）",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "已重設為預設值，請重新啟動應用程式",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "重設加入黑名單的播放清單",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "重設所有被Piped列入黑名單的播放清單",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("重新啟動程式"),
    "restore": MessageLookupByLibrary.simpleMessage("還原"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage("還原應用程式資料"),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "恢復上次的播放",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "在應用程式啟動時，自動延續上次的播放內容",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage("成功還原！\n變更將在重新啟動後產生"),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "恢复设置和播放列表",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "從備份檔案還原所有設定、登入資訊和播放清單。將覆蓋所有目前的資料",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "选择备份文件",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("還原中..."),
    "results": MessageLookupByLibrary.simpleMessage("結果"),
    "retry": MessageLookupByLibrary.simpleMessage("請重試！"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("已保存"),
    "scanning": MessageLookupByLibrary.simpleMessage("掃描中..."),
    "search": MessageLookupByLibrary.simpleMessage("搜尋"),
    "searchDes": MessageLookupByLibrary.simpleMessage("歌曲、播放清單、專輯或藝人"),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("在图书馆中搜索"),
    "searchRes": MessageLookupByLibrary.simpleMessage("搜尋結果"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage("最近的搜索"),
    "selectAll": MessageLookupByLibrary.simpleMessage("全選"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("選擇認證實例"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage("請選擇認證實例！"),
    "selectFile": MessageLookupByLibrary.simpleMessage("選擇檔案"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("選擇歌曲"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage("未找到所选文件。"),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "您的会话已过期。再次登录。",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage("設定探索頁面內容"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
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
    "settings_general_section": MessageLookupByLibrary.simpleMessage("一般"),
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
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage("更新的标识符"),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "新的访客 ID 已成功生成。",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("分享相册"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage("分享播放列表"),
    "shareSong": MessageLookupByLibrary.simpleMessage("分享這首歌"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "正在 Shazam 数据库中搜索匹配项...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("随机"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("打亂播放佇列"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("單曲"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("跳過靜音部分"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage("在音樂播放時，靜音部分將被跳過"),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage("您的睡眠計時器已設定"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("睡眠計時器"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "歌曲已新增至播放清單！",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage("歌曲已經在這裡了！"),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "歌曲已經儲存在離線快取中",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage("歌曲已加入佇列！"),
    "songFound": MessageLookupByLibrary.simpleMessage("歌曲找到了！"),
    "songInfo": MessageLookupByLibrary.simpleMessage("歌曲資訊"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage("由於伺服器限制，這首歌無法播放！"),
    "songPitch": MessageLookupByLibrary.simpleMessage("歌声"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("已刪除自"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage("已從播放佇列中刪除！"),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "您無法刪除目前正在播放的歌曲",
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
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "startRadio": MessageLookupByLibrary.simpleMessage("開啟收音機"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("启动时打开"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "选择 Estrella Music 首先打开的部分",
    ),
    "status": MessageLookupByLibrary.simpleMessage("狀態"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "清除背景任務時停止播放音樂",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "應用程式在任務管理員中被滑掉後，音樂將會停止播放",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("串流品質"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage("音樂串流時的品質"),
    "subscribers": MessageLookupByLibrary.simpleMessage("訂閱者"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage("滑动以探索选项"),
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
    "synced": MessageLookupByLibrary.simpleMessage("已同步"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage("暫無同步歌詞！"),
    "systemDefault": MessageLookupByLibrary.simpleMessage("系統預設"),
    "themeMode": MessageLookupByLibrary.simpleMessage("主題"),
    "title": MessageLookupByLibrary.simpleMessage("標題"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("热门音乐视频"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("熱門音樂影片"),
    "trending": MessageLookupByLibrary.simpleMessage("熱門趨勢"),
    "unLink": MessageLookupByLibrary.simpleMessage("解除連接"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("成功取消連接！"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("无题歌曲"),
    "upNext": MessageLookupByLibrary.simpleMessage("接下來播放"),
    "updateApp": MessageLookupByLibrary.simpleMessage("更新应用程序"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "已檢測到網址，按一下即可開啟/播放相關內容",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("被阻止的用户"),
    "userListMissing": MessageLookupByLibrary.simpleMessage("响应不包含用户列表。"),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("解锁用户"),
    "username": MessageLookupByLibrary.simpleMessage("用戶名稱"),
    "video": MessageLookupByLibrary.simpleMessage("视频"),
    "videos": MessageLookupByLibrary.simpleMessage("影片"),
    "viewAll": MessageLookupByLibrary.simpleMessage("檢視全部"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("檢視藝人"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "我们对我们的平台进行了现代化改造。旧的手动上传备份系统已被禁用。您现在有两种清晰的方式来管理您的音乐库。",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "从现在开始选择您想要体验 Estrella Music 的方式。",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage("你的音乐，你的方式"),
  };
}
