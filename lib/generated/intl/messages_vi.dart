// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(songTitle) => "Đang tải xuống: ${songTitle}";

  static String m1(count) => "Album: ${count}";

  static String m2(count) => "Nghệ sĩ: ${count}";

  static String m3(count) => "Yêu thích: ${count}";

  static String m4(count) => "Danh sách phát: ${count}";

  static String m5(count) => "Bài hát: ${count}";

  static String m6(source) => "Quá trình di chuyển đã hoàn tất từ ${source}.";

  static String m7(error) => "Đã xảy ra lỗi khi tạo lại: ${error}";

  static String m8(title) => "Tương tự như ${title}";

  static String m9(current) => "Bước ${current} trên 3";

  static String m10(count) => "${count} thay đổi đã được cam kết.";

  static String m11(count) => "${count} thay đổi được đồng bộ hóa.";

  static String m12(statusCode) =>
      "Không thể tìm kiếm người dùng (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tạo danh sách phát mới",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Kết nối Piped"),
    "about": MessageLookupByLibrary.simpleMessage("Về"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Thêm 5 phút"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Thêm bài hát vào danh sách phát",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("Thêm vào thư viện"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Thêm vào danh sách phát",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Tập nhạc"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Đã đánh dấu tập nhạc!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Đã xóa đánh dấu tập nhạc!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Tập nhạc"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "Theo sở thích của bạn",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Tất cả các trường bắt buộc",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Chưa thử nghiệm: Chọn hộp kiểm sau khi tải xuống hơn 60 tệp, quá trình này có thể tiêu tốn một lượng lớn bộ nhớ và có thể khiến điện thoại hoặc ứng dụng bị sập. Tiến hành theo rủi ro của riêng bạn.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Thông Tin Ứng Dụng"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Đã đánh dấu nghệ sỹ!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Đã xóa đánh dấu nghệ sỹ!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Mô tả không có sẵn!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Nghệ sỹ"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Theo sở thích của bạn",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Mã hoá tiếng"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Mã xác thực"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Nhập mã gồm 6 chữ số hợp lệ hoặc đăng nhập lại.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Nhập mã gồm 6 chữ số từ ứng dụng xác thực của bạn. Quyền truy cập này sẽ hết hạn sau 5 phút.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Xác thực hai yếu tố",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra và tiếp tục",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Chấp nhận sử dụng dữ liệu sai...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi đã mang thông tin đăng nhập, đăng ký và khôi phục mật khẩu từ dự án trước, được điều chỉnh cho ứng dụng âm nhạc này.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Phiên của bạn được lưu trữ an toàn và được xác thực bằng chính chương trình phụ trợ mà bạn đang sử dụng.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Tệp .env cần được cấu hình để kết nối phần phụ trợ xác thực.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Gửi thư"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Xác nhận mật khẩu",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Email hoặc mật khẩu không chính xác.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Nhập một email hợp lệ.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Thiếu phần phụ trợ xác thực để định cấu hình trong tệp .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Tài khoản của bạn chưa được xác minh.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Không thể hoàn thành hoạt động.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Tên"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Tôi quên mật khẩu",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi sẽ gửi cho bạn hướng dẫn tới email tài khoản của bạn.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("tên@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Họ"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập thành công",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Không thể gửi email.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Đã gửi email.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Không thể tạo tài khoản.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Tài khoản được tạo thành công.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Chào mừng đến với Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Chào mừng đến với Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Tự động tải xuống những bài hát được thích",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Tự động tải xuống bài hát khi được thêm vào danh sách yêu thích",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Tự động mở màn hình phát nhạc",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Bật/Tắt chức năng tự động mở màn hình phát nhạc sau khi chọn bài hát",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Trở lại"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "Tìm thấy cơ sở dữ liệu",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Phát nhạc dưới nền",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Cho phép/Không cho phép chơi nhạc dưới nền (Ứng dụng có thể được truy cập từ khay hệ thống khi ứng dụng đang chạy ở chế độ nền)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sao lưu"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Sao lưu dữ liệu ứng dụng",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage("Đang sao lưu..."),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Bản sao lưu được lưu thành công!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Sao lưu cài đặt và đánh sách phát",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Lưu tất cả cài đặt, đánh sách phát, và dữ liệu đăng nhập vào một tệp sao lưu",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Bạn cần một phiên hoạt động...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Khởi động lại ứng dụng",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Tải lên bản sao lưu ngay bây giờ",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Bạn có muốn thực hiện sao lưu?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Đã xóa bản sao lưu.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Chưa có bản sao lưu nào...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Đã khôi phục bản sao lưu. Khởi động lại ứng dụng.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Chọn thư mục để sao lưu",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Chọn dữ liệu để sao lưu",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Bản sao lưu được tải lên chính xác.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Dựa vào tương tác gần nhất",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Thông số bit"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Danh sách đen danh sách phát",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Cài lại thành công!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("bởi"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Lưu nội dung màn hình chính và bộ nhớ đệm",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Bật tính năng lưu nội dung màn hình chính vào bộ nhớ đệm, màn hình chính sẽ hiện thị ngay lập tức khi bật tính năng này",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "Lưu nhạc vào bộ nhớ đệm",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Lưu bài hát vào bộ nhớ đệm trong khi phát để phát trong tương lai/ngoại tuyến, nó sẽ chiếm thêm bộ nhớ trên thiết bị",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Bộ nhớ đệm"),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Hủy hẹn giờ"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Đã hủy hẹn giờ tắt",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Xóa hình trong bộ nhớ đệm",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Xóa hình trong bộ nhớ đệm thành công",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Bấm vào đây để xóa hình trong bộ nhớ đệm. (Không khuyến khích trừ khi bạn muốn làm mới dữ liệu hình ảnh)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Đóng"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Đóng ứng dụng"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Đã tìm thấy thư viện đám mây.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Một thư viện đám mây đã được tìm thấy. Thiết bị này sẽ tải xuống mà không ghi đè lên.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Chế độ đám mây đã sẵn sàng. Thiết bị này sẽ hoạt động như một bộ nhớ đệm ngoại tuyến.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập an toàn bằng tài khoản Joss Red của bạn.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Truy cập danh sách phát, mục yêu thích và lịch sử của bạn từ bất kỳ thiết bị nào (Windows, Android, v.v.) ngay lập tức.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Đồng bộ hóa thông minh: Làm việc ngoại tuyến và tự động tải lên các thay đổi khi bạn khôi phục Internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Kích hoạt đồng bộ hóa đám mây",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Đồng bộ hóa thời gian thực với Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Chế độ đám mây (Được khuyến nghị)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát cộng tác",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Chọn những người bạn có thể xem và chỉnh sửa danh sách phát này:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Cộng tác viên được cập nhật chính xác.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát cộng đồng",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Nội dung"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. Giấy phép GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Tạo"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Tạo & Thêm"),
    "customIns": MessageLookupByLibrary.simpleMessage("Phiên bản tùy chỉnh"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Vui lòng chọn Phiên bản tùy chỉnh",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Khám phá hàng ngày"),
    "dark": MessageLookupByLibrary.simpleMessage("Tối"),
    "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi tải về",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Đã xóa thành công khỏi nội dung tải xuống!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Được phát triển và duy trì bởi Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Tắt hoạt ảnh chuyển tiếp",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Bật tùy chọn này để tắt hoạt ảnh chuyển tiếp trang",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Đã tắt"),
    "discover": MessageLookupByLibrary.simpleMessage("Khám phá"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Hủy"),
    "done": MessageLookupByLibrary.simpleMessage("Sẵn sàng"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Không hiển thị thông tin này lần nữa",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "bài hát tải về đã được tìm thấy",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Tải về"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Tải bài hát từ album",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Bài hát bạn yêu cầu không thể tải xuống được vì giới hạn của máy chủ. Bạn có thể thử lại",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Tải xuống thất bại do lỗi mạng/truyền phát. Vui lòng thử lại",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Vị trí tải xuống",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Giữ tải nhạc của bạn hoạt động trong nền.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "tải nhạc",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Đang chuẩn bị nội dung tải xuống của bạn…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Đang tải nhạc",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tải xuống danh sách phát",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Định dạng tệp tải về",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Chọn định dạng tệp tải về. \"Opus\" sẽ cho chất lượng âm thanh tốt nhất",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Tải về"),
    "duration": MessageLookupByLibrary.simpleMessage("Thời gian bài hát"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Động"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát trống!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Thanh điều hướng ở dưới cùng",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Chuyển thanh điều hướng xuống dưới cùng",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Bật hành động trượt",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Bật chế độ trượt trên tiêu đề bài hát",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Đã bật"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Kết thúc bài hát"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Thêm bài hát trong album vào hàng đợi",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Thêm tất cả vào hàng đợi",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Thêm bài hát vào hàng đợi",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Thêm bài hát vào hàng đợi",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("tập phim"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Bộ chỉnh âm"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Mở bộ chỉnh âm của hệ thống",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Có vài lỗi xảy ra!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Đã xảy ra lỗi"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("Lỗi khi chơi:"),
    "export": MessageLookupByLibrary.simpleMessage("Xuất"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Xuất bài hát đã tải xuống",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Bấm vào đây để sao chép tệp đã tải về sang thư mục khác",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Lỗi khi xuất danh sách phát",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Lỗi định dạng dữ liệu danh sách phát",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Quyền bị từ chối khi xuất",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Không đủ bộ nhớ",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Tệp đã được xuất thành công",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Xuất danh sách phát",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Xuất danh sách phát dạng CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Không thể nhập ở đây",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Xuất danh sách phát dạng JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Không thể nhập bằng định dạng này",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Xuất ra Youtube Nhạc",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nó sẽ đẩy danh sách phát của bạn (bài hát < 50) vào hàng đợi hiện tại, đừng quên thêm vào danh sách phát/lưu sau khi mở trong YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Vị trí xuất tệp đã tải về",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Đang xuất..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Đang xuất danh sách phát...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Yêu thích"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát nổi bật",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Không tìm thấy tệp"),
    "follow": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("đã theo dõi"),
    "following": MessageLookupByLibrary.simpleMessage("Tiếp theo"),
    "for1": MessageLookupByLibrary.simpleMessage("cho"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "lãng quên yêu thích",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Bạn bè"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Yêu cầu kết bạn đã được chấp nhận",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Đã gửi yêu cầu kết bạn",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Bạn"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập để tìm bạn bè.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Đã xóa tình bạn",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Sai lầm"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Điện tử"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("nhạc jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("tiếng Latinh"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Nhạc pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Đá"),
    "gesture": MessageLookupByLibrary.simpleMessage("Cử chỉ"),
    "github": MessageLookupByLibrary.simpleMessage("Github"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Xem mã nguồn GitHub.\nNếu bạn thích dự án này, đừng quên cho một ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Đi đến tập nhạc"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Bấm vào đây để đến trang tải về",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Xin chào thế giới"),
    "high": MessageLookupByLibrary.simpleMessage("Cao"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL API tới phiên bản đường ống",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Số lượng nội dung trên trang chủ",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Chọn số lượng nội dung trên màn hình chính (tương đối). Số lượng ít sẽ tải nhanh hơn",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Khoá"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Bỏ qua tối ưu hóa pin",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Nếu bạn đang gặp phải sự cố thông báo hoặc quá trình phát lại bị dừng do tối ưu hóa hệ thống, vui lòng bật tùy chọn này",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Lỗi khi nhập danh sách phát",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Lỗi khi lưu vào cơ sở dữ liệu",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Không thể truy cập tệp đã chọn",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Định dạng tệp không hợp lệ",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Lưu ý: Danh sách phát lớn có thể tốn nhiều thời gian hơn để nhập",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Nhập danh sách phát",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Chọn một tệp JSON danh sách phát đã xuất để nhập",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Đã nhập"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Được nhập từ Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát đã nhập",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Đang nhập danh sách phát...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Thư mục lưu trữ nội bộ",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Bao gồm các bài hát đã tải về",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Thông tin không có sẵn",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Cấu trúc tệp danh sách phát không hợp lệ",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Phản hồi của máy chủ không hợp lệ.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Phiên không chứa mã thông báo hợp lệ.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("danh mục"),
    "keepListening": MessageLookupByLibrary.simpleMessage("tiếp tục lắng nghe"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Giữ màn hình sáng khi phát nhạc",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Nếu được bật, màn hình thiết bị sẽ giữ sáng trong khi nhạc đang phát",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Cài đặt ngôn ngữ ứng dụng",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage(
      "Bản phát hành mới nhất",
    ),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Phiên bản mới nhất có sẵn",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Bắt đầu.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Thư viện tập nhạc"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Thư viện nghệ sỹ"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Thư viện danh sách phát",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Thư viện bài hát"),
    "library": MessageLookupByLibrary.simpleMessage("Thư viện"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát thư viện",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Sáng"),
    "link": MessageLookupByLibrary.simpleMessage("Liên kết"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Liên kết thành công!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Liên kết đã được sao chép vào bảng tạm",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Liên kết với đường ống cho danh sách phát",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Nghe bây giờ"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Lắng nghe môi trường...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Không thể tải thông tin cập nhật",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Địa phương"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Nó hoạt động mà không cần phải đăng nhập.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Toàn bộ thư viện của bạn nằm hoàn toàn trên máy tính này.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Lưu ý: Không sao lưu đám mây thủ công. Nếu bạn mất thiết bị hoặc gỡ cài đặt ứng dụng, dữ liệu của bạn sẽ không thể khôi phục được.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Chỉ sử dụng trên thiết bị này",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Quyền riêng tư tuyệt đối trên thiết bị của bạn",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Chế độ cục bộ"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Độ ồn Db"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Cân bằng âm lượng",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Cài đặt cùng một mức độ lớn cho tất cả bài hát (Thử nghiệm) (Không hoạt động đối với các bài hát đã tải về trong phiên bản trước (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Thấp"),
    "lyrics": MessageLookupByLibrary.simpleMessage("chữ cái"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Lời bài hát không có sẵn!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Quản lý cộng tác viên (bạn bè)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Đảm bảo nhạc đang phát đủ lớn ở gần micrô của bạn.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Album đã di chuyển"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Thư viện đã di chuyển",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát đã di chuyển",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Hiện đã có quá trình di chuyển đang diễn ra.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Phân tích thư viện địa phương...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra xem EMusic Cloud đã có thư viện chưa...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Quá trình di chuyển đã hoàn tất.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Tạo bản sao lưu cục bộ trước khi kết nối đám mây...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Việc di chuyển không thành công. Dữ liệu cục bộ của bạn không được sửa đổi.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập vào Joss Red trước khi di chuyển.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Đang chuẩn bị di chuyển trong EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud không thể bắt đầu di chuyển.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Không phải tất cả dữ liệu có thể được tải lên. Chúng tôi giữ sự hỗ trợ địa phương của bạn.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Đang tải lên danh sách phát, mục yêu thích và lịch sử...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud không thể xác thực quá trình di chuyển.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Đang xác minh tính toàn vẹn trong EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Chọn tệp và nhập",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Chọn song.db hoặc bản sao lưu .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Quá trình di chuyển đã hoàn tất thành công.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("phút"),
    "misc": MessageLookupByLibrary.simpleMessage("Khác"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Bài hát được nghe nhiều nhất",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Âm nhạc & Phát nhạc",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Nhận dạng âm nhạc",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Lỗi mạng! Kiểm tra kết nối mạng của bạn.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Kết nối mạng bị lỗi!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Đã có phiên bản mới!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Ứng dụng Joss Red (Cửa hàng Play)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("đã hiểu"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Web đỏ Joss"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Đồng bộ hóa 100% với Joss Red, danh sách phát với bạn bè và hơn thế nữa. Nhấn để xem có gì mới.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Âm nhạc Estrella đã phát triển!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Để thêm bạn bè, chấp nhận yêu cầu hoặc quản lý hồ sơ bảo mật của bạn, vui lòng sử dụng Joss Red trên các nền tảng chính thức của nó:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Quản lý bạn bè và tài khoản:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Tin tức âm nhạc Estrella",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Tạo danh sách phát với bạn bè của bạn! Khi tạo danh sách phát, hãy chọn hộp kiểm Cộng tác và chọn bạn bè của bạn để cùng chỉnh sửa.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát cộng tác",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát và mục yêu thích của bạn hiện được lưu và đồng bộ hóa tự động trên đám mây với tài khoản Joss Red chính của bạn.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Tích hợp đầy đủ với Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Bạn không cần phải nhấp vào nút đồng bộ hóa thủ công nữa; Động cơ mới có nhiệm vụ chuyển số lên xuống tự động.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Đồng bộ hóa minh bạch",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Không"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Không có đánh dấu!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa có thêm bạn bè nào trên Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Bạn không có danh sách phát nào!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Không thể tìm thấy bất kỳ bài hát nào trong âm thanh đã ghi",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Không có kết quả phù hợp",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Không có bài hát ngoại tuyến!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Không có bài hát nào trong bộ sưu tập này",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy kết quả cho",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Chưa được xác thực",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Không phải bài hát/Videos âm nhạc!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Không phải là liên kết hợp lệ!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Mở trong"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Lỗi hệ thống"),
    "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "password_text": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Quyền bị từ chối",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Cho phép"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music cần những quyền này để quản lý nhạc của bạn và cung cấp tất cả các tính năng phát lại.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Quyền để bắt đầu",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Cấp quyền cần thiết",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Nó chỉ được sử dụng khi bạn chọn xác định một bài hát đang phát xung quanh bạn.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage("Micrô"),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Hiển thị các điều khiển phát lại, tiến trình tải xuống và các thông báo ứng dụng quan trọng.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Thông báo",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Tất cả ba giấy phép được yêu cầu để tiếp tục. Bạn có thể thay đổi chúng sau trong cài đặt hệ thống.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Nó cho phép bạn phát nhạc, lưu tải xuống, xuất danh sách phát và chuẩn bị cập nhật.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Âm nhạc và lưu trữ",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Cá nhân hoá"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát theo đường ống",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát đã được đồng bộ hóa!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Lời"),
    "play": MessageLookupByLibrary.simpleMessage("Chơi"),
    "playNext": MessageLookupByLibrary.simpleMessage("Phát kế tiếp"),
    "playNow": MessageLookupByLibrary.simpleMessage("Chơi ngay"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Tốc độ phát lại"),
    "playerUi": MessageLookupByLibrary.simpleMessage("Giao diện phát nhạc"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Chọn giao diện phát nhạc",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "Đang chơi:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "Phát từ tập nhạc",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "Phát theo nghệ sỹ",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Phát từ danh sách phát",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "Phát từ danh sách chọn",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Danh sách phát"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát bị liệt vào danh sách đen!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Đã đánh dấu danh sách phát!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Đã xóa đánh dấu trang danh sách phát!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Người đóng góp danh sách phát",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát đã được tạo!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát được tạo và thêm bài hát!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát đã được xuất thành công đến",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Danh sách phát được nhập thành công",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Đã xóa dánh sách phát!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Đổi tên thành công!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Danh sách phát"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Tiếp theo"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcast"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Bài hát phổ biến"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Đang xử lý tập tin...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Đang xử lý âm thanh...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Hồ sơ"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Lặp lại hàng đợi"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Không thể tắt lặp lại hàng đợi khi chế độ ngẫu nhiên được bật.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Không thể bật lặp lại hàng đợi trong chế độ đài phát.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Không thể xáo trộn ngẫu nhiên hàng đợi khi chế độ ngẫu nhiên được bật",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Không thể sắp xếp lại hàng đợi khi chế độ ngẫu nhiên được bật",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Lựa chọn nhanh"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Chọn nhanh"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio không có sẵn cho nghệ sĩ này!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Đài phát ngẫu nhiên"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Chọn ngẫu nhiên"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Sắp xếp lại danh sách phát",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Sắp xếp lại bài hát",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Đọc thêm"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Tìm kiếm gần đây"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Đã phát gần đây"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi khuyên bạn nên kích hoạt Chế độ đám mây để có trải nghiệm giống như Spotify: đồng bộ hóa thời gian thực giữa tất cả các thiết bị của bạn và sao lưu tự động mà bạn không cần phải làm gì cả.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Khuyến khích"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Khuyến khích"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi bộ nhớ đệm",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi thư viện bài hát",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi thư viện",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi danh sách phát",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Xóa khỏi hàng đợi",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage("Xóa nhiều bài"),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Xóa danh sách phát",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Đổi tên"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Đổi tên danh sách phát",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Được sao chép bởi"),
    "reset": MessageLookupByLibrary.simpleMessage("Cài lại"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Khôi phục cài đặt mặc định",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Khôi phục cài đặt ứng dụng về mặc định ( cần khởi động lại ứng dụng)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Hoàn tất khôi phục cài đặt ứng dụng về mặc định, vui lòng khởi động lại ứng dụng",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Đặt lại danh sách phát bị liệt vào danh sách đen",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Đặt lại tất cả danh sách phát trong danh sách đen",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Khởi động lại ứng dụng",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Khôi phục"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Khôi phục dữ liệu ứng dụng",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Khôi phục lần phát gần nhất",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Tự khôi phục lần phát gần nhất khi mở ứng dụng",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Khôi phục thành công! \nThay đổi sẽ có hiệu lực khi khởi động lại ứng dụng",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Khôi phục cài đặt và đánh sách phát",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Khôi phục tất cả cài đặt, dữ liệu đăng nhập và đánh sách phát từ file sao lưu. Ghi đè tất cả dữ liệu hiện tại",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Chọn tập tin sao lưu",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Đang khôi phục..."),
    "results": MessageLookupByLibrary.simpleMessage("Kết quả"),
    "retry": MessageLookupByLibrary.simpleMessage("Thử lại!"),
    "save": MessageLookupByLibrary.simpleMessage("Giữ"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Đã lưu"),
    "scanning": MessageLookupByLibrary.simpleMessage("Đang quét..."),
    "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Bài hát, Danh sách phát, Tập nhạc hoặc Nghệ sỹ",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Tìm kiếm trong Thư viện",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Kết quả tìm kiếm"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Tìm kiếm gần đây",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Chọn tất cả"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Chọn phiên bản xác thực",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Vui lòng chọn phiên bản xác thực!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Chọn tệp"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Chọn bài hát"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy tập tin đã chọn.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Phiên của bạn đã hết hạn. Đăng nhập lại.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Cài đặt nội dung khám phá",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Giới thiệu về Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Phiên bản, dự án nguồn mở và GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Tài khoản và đồng bộ hóa",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Chế độ đám mây, sao lưu, danh sách bạn bè và di chuyển.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Hình ảnh động chủ đề, ngôn ngữ và giao diện.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Sao lưu đám mây",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Tải lên, khôi phục và quản lý...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Tải bản sao lưu .hmb của ứng dụng lên máy chủ và nếu cần, hãy khôi phục mọi bản sao lưu đã lưu.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Khám phá các bộ lọc, tích hợp với Piped và bộ nhớ đệm.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Tải xuống và lưu trữ",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Định dạng âm thanh, thư mục và tải xuống tự động.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Tổng quan",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Chọn, di chuyển hoặc xem lại trạng thái đồng bộ hóa với Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Chế độ cục bộ / Đám mây EMusic",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Nhập danh sách phát, bài hát...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Di chuyển từ Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "bạn bè của tôi",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Quản lý trực tiếp bạn bè Joss Red của bạn.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Chất lượng phát trực tuyến, chuẩn hóa, im lặng và pin.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Tạo lại ID nhạc YouTube của bạn nếu nội dung Khám phá không tải.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Làm mới ID (ID khách truy cập)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Sai lầm"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Không thể tạo mã định danh mới. Vui lòng thử lại sau.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Mã định danh đã cập nhật",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "ID khách truy cập mới đã được tạo thành công.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Chia sẻ album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Chia sẻ danh sách phát",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Chia sẻ bài hát này"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Đang tìm kiếm cơ sở dữ liệu Shazam để tìm kết quả phù hợp...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Ngẫu nhiên"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Xáo trộn hàng đợi"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Đĩa đơn"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Bỏ qua khoảng lặng"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Khoảng lặng sẽ bị bỏ qua khi chơi nhạc",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Bộ hẹn giờ tắt của bạn đã được đặt",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Hẹn giờ tắt"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Bài hát đã được thêm vào danh sách phát!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Bài hát đã tồn tại!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Bài hát đã ngoại tuyến trong bộ nhớ đệm",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Đã thêm bài hát vào hàng đợi!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Đã tìm thấy bài hát!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Thông tin bài hát"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Bài hát không thể phát vì giới hạn của máy chủ!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("giai điệu bài hát"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Xóa khỏi"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Đã xóa khỏi hàng đợi!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Bạn không thể xóa bài hát đang phát",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Bài hát"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Bài hát được nhập từ Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Sắp xếp tăng dần/giảm dần",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Sắp xếp theo ngày"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Sắp xếp theo thời lượng",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Sắp xếp theo tên"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Tốc độ và cao độ"),
    "standard": MessageLookupByLibrary.simpleMessage("Tiêu Chuẩn"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Bắt đầu đài phát"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Mở khi khởi động"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Chọn phần Estrella Music mở đầu tiên",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Trạng thái"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Dừng nhạc khi xóa khỏi tác vụ gần đây",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Quá trình phát nhạc sẽ dừng khi ứng dụng bị xóa khỏi trình quản lý tác vụ",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Chất lượng truyền tải",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Chất lượng truyền tải nhạc qua internet",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("người đăng ký"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Vuốt để khám phá các tùy chọn ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Đã kích hoạt chế độ đám mây. Đang tải xuống thư viện hiện có.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Đã kích hoạt chế độ đám mây. Thư viện đã di chuyển.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Chế độ đám mây đang hoạt động",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Chế độ đám mây đang hoạt động. Đang chờ đồng bộ hóa.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể tải xuống đồng bộ hóa.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Đang tải xuống các thay đổi của EMusic...",
    ),
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las playlists, favoritos, historial, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca âm nhạc remota?",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa laruxureronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Cơ sở Cancelarruxureronización y subir esta",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Thư viện đồng bộ.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Thư viện cập nhật.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Có những thay đổi mới ở địa phương. Chúng sẽ được tải lên trước khi tải xuống.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Dữ liệu của bạn chỉ được lưu giữ trên thiết bị này.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Chế độ cục bộ đang hoạt động",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Ngoại tuyến. Những thay đổi đang chờ xử lý.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Ngoại tuyến. Đã lưu các thay đổi để thử lại.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Đồng bộ danh sách bài hát",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic không xác nhận tất cả những thay đổi. Họ sẽ được thử lại.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Không thể đứng dậy được. Nó sẽ được thử lại sau.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Các thay đổi được tải lên chính xác.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Các thay đổi đã được tải lên thành công (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Không thể tải lên bằng WS. Nó sẽ được thử lại sau.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Đang tải các thay đổi lên EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Đã đồng bộ hóa"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Lời bài hát được đồng bộ hóa không có!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Theo hệ thống"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Chủ đề"),
    "title": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Video ca nhạc hàng đầu",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Video âm nhạc hàng đầu",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Xu hướng"),
    "unLink": MessageLookupByLibrary.simpleMessage("Hủy liên kết"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Hủy liên kết thành công!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Bài hát không tên"),
    "upNext": MessageLookupByLibrary.simpleMessage("Kế tiếp"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Cập nhật ứng dụng"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Nhấn vào liên kết được phát hiện để mở nội dung",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Người dùng bị chặn"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Phản hồi không chứa danh sách người dùng.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Người dùng đã được mở khóa",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Tên người dùng"),
    "video": MessageLookupByLibrary.simpleMessage("Băng hình"),
    "videos": MessageLookupByLibrary.simpleMessage("Phim ảnh"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Xem tất cả"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Xem Nghệ sĩ"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi đã hiện đại hóa nền tảng của mình. Hệ thống tải lên bản sao lưu thủ công cũ đã bị vô hiệu hóa. Bây giờ bạn có hai cách rõ ràng để quản lý thư viện nhạc của mình.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Chọn cách bạn muốn trải nghiệm Estrella Music kể từ bây giờ.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Âm nhạc của bạn, theo cách của bạn",
    ),
  };
}
