// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fa locale. All the
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
  String get localeName => 'fa';

  static String m0(songTitle) => "در حال دانلود: ${songTitle}";

  static String m1(count) => "آلبوم ها: ${count}";

  static String m2(count) => "هنرمندان: ${count}";

  static String m3(count) => "موارد دلخواه: ${count}";

  static String m4(count) => "لیست های پخش: ${count}";

  static String m5(count) => "آهنگ ها: ${count}";

  static String m6(source) => "انتقال از ${source} انجام شد.";

  static String m7(error) => "هنگام ایجاد مجدد خطایی روی داد: ${error}";

  static String m8(title) => "مشابه ${title}";

  static String m9(current) => "مرحله ${current} از 3";

  static String m10(count) => "${count} تغییرات انجام شده است.";

  static String m11(count) => "${count} تغییرات همگام شده.";

  static String m12(path) => "پشتیبان گیری بازیابی: ${path}";

  static String m13(statusCode) =>
      "جستجو برای کاربران امکان‌پذیر نیست (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "ساختن لیست پخش جدید",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("لوله شده"),
    "about": MessageLookupByLibrary.simpleMessage("درباره"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("افزودن 5 دقیقه"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "افزودن موسیقی ها به لیست پخش",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "به کتابخانه اضافه کنید",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("افزودن به لیست پخش"),
    "album": MessageLookupByLibrary.simpleMessage("آلبوم"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "آلبوم به نشانک ها اضافه شد!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "نشانک آلبوم حذف شد!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("آلبوم ها"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "با توجه به سلیقه شما",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "همه فیلدها الزامی است",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "تست نشده: انتخاب کادر انتخاب پس از دانلود بیش از 60 فایل ممکن است باعث شود که این فرآیند مقدار زیادی از حافظه را مصرف کند و باعث از کار افتادن گوشی یا برنامه شود. با مسئولیت خود ادامه دهید.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("داده های برنامه"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "هنرمند به نشانک ها اضافه شد!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "نشانگر هنرمند حذف شد!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "توضیحات موجود نیست!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("خواننده ها"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "با توجه به سلیقه شما",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("کدک صوتی"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("کد احراز هویت"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "یک کد 6 رقمی معتبر وارد کنید یا دوباره وارد شوید.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "کد 6 رقمی را از برنامه احراز هویت خود وارد کنید. این دسترسی 5 دقیقه دیگر منقضی می شود.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "احراز هویت دو مرحله ای",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "بررسی کنید و ادامه دهید",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Acepto usar mis datos...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "ما لاگین، ثبت نام و بازیابی رمز عبور را از پروژه قبلی که برای این برنامه موسیقی اقتباس شده بود آورده ایم.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "جلسه شما در فضای ذخیره سازی امن زندگی می کند و با همان Backendی که قبلاً استفاده می کردید تأیید می شود.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "فایل .env باید پیکربندی شود تا به پشتیبان احراز هویت متصل شود.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("وارد شوید"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("ثبت نام کنید"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("ارسال نامه"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "رمز عبور را تایید کنید",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "ایمیل یا رمز عبور نادرست",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "یک ایمیل معتبر وارد کنید.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "پشتیبان احراز هویت برای پیکربندی در فایل .env وجود ندارد.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "حساب شما هنوز تایید نشده است.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "امکان تکمیل عملیات وجود نداشت.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("نام کوچک"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "رمز عبورم را فراموش کردم",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "ما دستورالعمل‌ها را به ایمیل حسابتان ارسال می‌کنیم.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("name@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("نام خانوادگی"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "با موفقیت وارد سیستم شد",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "امکان ارسال ایمیل وجود نداشت.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "ایمیل ارسال شد.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "حساب ایجاد نشد.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "حساب با موفقیت ایجاد شد.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "به Estrella Music خوش آمدید",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "به Estrella Music خوش آمدید",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "دانلود خودکار موسیقی های مورد علاقه",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "دانلود خودکار موسیقی های مورد علاقه وقتی به مورد علاقه ها افزوده می‌شوند",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "باز کردن خودکار صفحه پخش",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "فعال/غیرفعال کردن باز شدن خودکار به صورت تمام صفحه با انتخاب آهنگ برای پخش",
    ),
    "back": MessageLookupByLibrary.simpleMessage("بازگشت"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "پایگاه های داده یافت شد",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "موزیک پخش شده در پس زمینه",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "فعال/غیرفعال کردن پخش موسیقی در پس‌زمینه (هنگامی که برنامه در پس‌زمینه اجرا می‌شود، می‌توان به برنامه از طریق سینی سیستم دسترسی داشت)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("پشتیبان گیری"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "پشتیبان گیری از داده های برنامه",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "پشتیبان گیری در حال انجام است...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "پشتیبان گیری با موفقیت ذخیره شد!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "از تنظیمات و لیست پخش نسخه پشتیبان تهیه کنید",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "تمام تنظیمات، لیست های پخش و داده های ورود به سیستم را در یک فایل پشتیبان ذخیره کنید",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "شما نیاز به یک جلسه فعال دارید...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "برنامه را مجددا راه اندازی کنید",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "اکنون نسخه پشتیبان را آپلود کنید",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "آیا می خواهید یک نسخه پشتیبان تهیه کنید؟",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "بکاپ حذف شد",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "هنوز هیچ نسخه پشتیبان وجود ندارد ...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "نسخه پشتیبان بازیابی شد. برنامه را مجددا راه اندازی کنید.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "پوشه را برای پشتیبان گیری انتخاب کنید",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "انتخاب کنید از کدام داده ها نسخه پشتیبان تهیه شود",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "بک آپ به درستی آپلود شد.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage("بر اساس آخرین تعامل"),
    "bitrate": MessageLookupByLibrary.simpleMessage("نرخ بیت"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "لیست پخش لیست سیاه",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "با موفقیت بازنشانی شد!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("توسط"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "داده‌های محتوای صفحه اصلی را ذخیره کنید",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "ذخیره سازی داده‌های محتوای صفحه اصلی را فعال کنید، اگر این گزینه فعال باشد، صفحه اصلی فوراً بارگیری می‌شود",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("ذخیره پنهان موسیقی ها"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "ذخیره کردن پنهان موسیقی ها در زمان پخش برای بازپخش آفلاین یا در آینده. فضای اضافی روی دستگاه شما اشغال خواهد کرد",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "ذخیره پنهان شده / آفلاین",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("لغو"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("لغو زمان‌سنج"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "تایمر خواب لغو شد",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "کش تصویر را پاک کنید",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "حافظه پنهان تصویر با موفقیت پاک شد",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "برای پاک کردن ریز عکسها/تصاویر ذخیره شده اینجا را کلیک کنید. (توصیه نمی شود مگر اینکه بخواهید داده های تصویر کش شده را به روز کنید)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("بستن"),
    "closeApp": MessageLookupByLibrary.simpleMessage("برنامه را ببندید"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "کتابخانه ابری پیدا شد.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "یک کتابخانه ابری پیدا شد. این دستگاه بدون بازنویسی آن را دانلود می کند.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "حالت ابری آماده است. این دستگاه به عنوان یک کش آفلاین کار خواهد کرد.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "با استفاده از حساب Joss Red خود به صورت ایمن وارد شوید.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "فوراً از هر دستگاهی (ویندوز، اندروید و غیره) به لیست های پخش، موارد دلخواه و تاریخچه خود دسترسی داشته باشید.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "همگام سازی هوشمند: به صورت آفلاین کار کنید و با بازیابی اینترنت، تغییرات را به طور خودکار آپلود کنید.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "همگام سازی ابری را فعال کنید",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "همگام سازی بلادرنگ با جاس رد",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "حالت ابری (توصیه می شود)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "لیست پخش مشترک",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "دوستانی را انتخاب کنید که می توانند این لیست پخش را ببینند و ویرایش کنند:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "همکاران به درستی به روز شدند.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "لیست پخش های عمومی",
    ),
    "content": MessageLookupByLibrary.simpleMessage("محتوا"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. مجوز GPL نسخه 3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("ساختن"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("ساختن و افزودن"),
    "customIns": MessageLookupByLibrary.simpleMessage("نمونه سفارشی"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "لطفاً یک نمونه سفارشی انتخاب کنید",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("کشف روزانه"),
    "dark": MessageLookupByLibrary.simpleMessage("تیره"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف کنید"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "حذف از دانلود ها",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "با موفقیت از دانلودها حذف شد!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "توسعه و نگهداری توسط Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "غیرفعال کردن انیمیشن انتقال",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "برای غیرفعال کردن انیمیشن انتقال تب این گزینه را فعال کنید",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("از کار افتاده است"),
    "discover": MessageLookupByLibrary.simpleMessage("کشف"),
    "dismiss": MessageLookupByLibrary.simpleMessage("دور انداختن"),
    "done": MessageLookupByLibrary.simpleMessage("آماده است"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "این اطلاعات را دیگر نشان ندهید",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "فایل های دانلود شده پیدا شد",
    ),
    "download": MessageLookupByLibrary.simpleMessage("دانلود"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "دانلود آهنگ های آلبوم",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "موسیقی موردنظر به دلیل محدودیت سرور قابل دانلود نمی‌باشد. می‌توانید دوباره تلاش کنید",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "دانلود به علت خطای شبکه/سترین شکست خورد! لطفا دوباره تلاش کنید",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("دانلود محل فایل"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "دانلودهای موسیقی شما را در پس زمینه فعال نگه می دارد.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "دانلود های موسیقی",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "در حال آماده سازی دانلودهای شما…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "دانلود موسیقی",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage("دانلود لیست پخش"),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "فرمت فایل دانلود کنید",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "فرمت فایل دانلودی را انتخاب کنید. \"Opus\" بهترین کیفیت را ارائه خواهد کرد",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("دانلود ها"),
    "duration": MessageLookupByLibrary.simpleMessage("مدت زمان"),
    "dynamic": MessageLookupByLibrary.simpleMessage("پویا"),
    "email": MessageLookupByLibrary.simpleMessage("ایمیل"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("لیست پخش خالی !"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "نوار ناوبری پایین",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "تغییر به نوار ناوبری پایین",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "فعال کردن اکشن‌های کشویی",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "فعال کردن اکشن‌های کشویی در عنوان آهنگ",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("فعال شد"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("پایان این موسیقی"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "آهنگ های آلبوم را به صف اضافه کنید",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("افزودن کردن همه به صف"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "افزودن این موسیقی به صف",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "آهنگ ها را به صف اضافه کنید",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("اپیزودها"),
    "equalizer": MessageLookupByLibrary.simpleMessage("اکولایزر"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "اکولایزر سیستم را باز کنید",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "خطایی رخ داده است!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("خطایی رخ داد"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "خطا هنگام بازی:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("صادرات"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "فایل های دانلود شده را صادر کنید",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "اینجا را کلیک کنید تا فایل های دانلود شده از دایرکتوری برنامه به دایرکتوری خارجی صادر شود",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage("خطا در صدور لیست پخش"),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "خطا در قالب‌بندی داده‌های فهرست پخش",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "مجوز هنگام صادرات رد شد",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "فضای ذخیره سازی ناکافی",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "فایل ها با موفقیت صادر شدند",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "صادر کردن لیست پخش",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "لیست پخش را به عنوان CSV صادر کنید",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "نمی توان اینجا وارد کرد",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "لیست پخش را به JSON صادر کنید",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "این قالب را می توان وارد کرد",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "صادرات به موسیقی یوتیوب",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "این لیست پخش شما (آهنگ های کمتر از 50) را به صف فعلی می برد، فراموش نکنید که پس از باز کردن آن در MusicService آن را به لیست پخش اضافه کنید/ذخیره کنید.",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "صادرات محل فایل های دانلود شده",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("صادرات..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "در حال صادر کردن لیست پخش...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("مورد علاقه ها"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "لیست پخش های برگزیده",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("فایل پیدا نشد"),
    "follow": MessageLookupByLibrary.simpleMessage("ادامه دهید"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("دنبال کرد"),
    "following": MessageLookupByLibrary.simpleMessage("دنبال کردن"),
    "for1": MessageLookupByLibrary.simpleMessage("برای"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "مورد علاقه های فراموش شده",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("دوست"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "درخواست دوستی پذیرفته شد",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "درخواست دوستی ارسال شد",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("دوستان"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "برای یافتن دوستان وارد شوید.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage("دوستی حذف شد"),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("آلبوم"),
    "genericError": MessageLookupByLibrary.simpleMessage("اشتباه"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("الکترونیک"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("هیپ هاپ"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("جاز"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("لاتین"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("پاپ"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("سنگ"),
    "gesture": MessageLookupByLibrary.simpleMessage("علامت"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "کد منبع GitHub را مشاهده کنید \nاگر این پروژه را دوست دارید، فراموش نکنید که به آن ⭐ بدهید!",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("رفتن به آلبوم"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "برای رفتن به صفحه دانلود اینجا کلیک کنید",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("سلام دنیا"),
    "high": MessageLookupByLibrary.simpleMessage("بالا"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL API به نمونه Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("خانه"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "تعداد محتوای خانه",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "تعداد محتوای اولیه خانه را مشخص کنید (حدودی). عدد کمتر باعث بارگذاری سریعتر می‌شود",
    ),
    "id": MessageLookupByLibrary.simpleMessage("شناسه"),
    "identifySongMetadata": MessageLookupByLibrary.simpleMessage(
      "شناسایی metadata",
    ),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "بهینه سازی باتری را نادیده بگیرید",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "اگر به دلیل بهینه سازی سیستم با اعلان ها یا توقف پخش مشکل دارید، این گزینه را فعال کنید",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "خطا در وارد کردن لیست پخش",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "خطا در ذخیره در پایگاه داده",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "فایل انتخابی قابل دسترسی نیست",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "فرمت فایل نامعتبر است",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "توجه: فهرست‌های پخش بزرگ ممکن است بیشتر طول بکشد تا وارد شوند",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "لیست پخش را وارد کنید",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "یک فایل JSON لیست پخش صادر شده قبلی را برای وارد کردن انتخاب کنید",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("وارداتی"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "وارد شده از Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "لیست پخش وارد شده",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "در حال وارد کردن لیست پخش...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "فهرست ذخیره سازی داخلی",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "شامل فایل های آهنگ دانلود شده",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "اطلاعات در دسترس نیست",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "ساختار فایل لیست پخش نامعتبر است",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "پاسخ سرور نامعتبر است.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "جلسه حاوی یک رمز معتبر نیست.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("مورد ها"),
    "keepListening": MessageLookupByLibrary.simpleMessage(
      "به گوش دادن ادامه بده",
    ),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "روشن نگه داشتن صفحه هنگام پخش",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "در صورت فعال بودن، صفحه دستگاه هنگام پخش موسیقی روشن خواهد ماند",
    ),
    "language": MessageLookupByLibrary.simpleMessage("زبان"),
    "languageDes": MessageLookupByLibrary.simpleMessage("تنظیم زبان نرم افزار"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("آخرین نسخه"),
    "latestVersion": MessageLookupByLibrary.simpleMessage("آخرین نسخه موجود"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("شروع کنیم.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("آلبوم های کتابخانه"),
    "libArtists": MessageLookupByLibrary.simpleMessage("هنرمندان کتابخانه"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "لیست پخش های کتابخانه",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("آهنگ های کتابخانه"),
    "library": MessageLookupByLibrary.simpleMessage("کتابخانه"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "لیست پخش کتابخانه",
    ),
    "light": MessageLookupByLibrary.simpleMessage("روشن"),
    "link": MessageLookupByLibrary.simpleMessage("پیوند"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("با موفقیت پیوند خورد!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "پیوند در کلیپ بورد کپی شد",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "پیوند با Piped برای لیست های پخش",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("حالا گوش کن"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "گوش دادن به محیط ...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "اطلاعات به‌روزرسانی بارگیری نشد",
    ),
    "local": MessageLookupByLibrary.simpleMessage("محلی"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "بدون نیاز به ورود کار می کند.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "کل کتابخانه شما کاملاً روی این رایانه می ماند.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "توجه: بدون پشتیبان گیری دستی ابری. اگر دستگاه خود را گم کنید یا برنامه را حذف نصب کنید، اطلاعات شما قابل بازیابی نیست.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "فقط در این دستگاه استفاده کنید",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "حریم خصوصی مطلق در دستگاه شما",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("حالت محلی"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("LoudnessDb"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "عادی سازی بلندی صدا",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "سطح صدای یکسانی را برای همه آهنگ ها تنظیم می کند (تجربی) (روی آهنگ های دانلود شده در نسخه های قبلی کار نمی کند (قبل از v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("کم"),
    "lyrics": MessageLookupByLibrary.simpleMessage("نامه ها"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "متن آهنگ در دسترس نیست!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "مدیریت همکاران (دوستان)",
    ),
    "metadataApplySuccess": MessageLookupByLibrary.simpleMessage(
      "متاداده در فایل محلی جاسازی شده است.",
    ),
    "metadataNoResults": MessageLookupByLibrary.simpleMessage(
      "هیچ مسابقه ای پیدا نشد. یک جستجوی متفاوت را امتحان کنید.",
    ),
    "metadataOperationFailed": MessageLookupByLibrary.simpleMessage(
      "عملیات ابرداده شکست خورد.",
    ),
    "metadataOverwriteWarning": MessageLookupByLibrary.simpleMessage(
      "این عنوان جاسازی شده، هنرمند، آلبوم و پوشش را در حالی که حفظ هر زمینه ای که بازی ارائه نمی دهد، بازنویسی می کند.",
    ),
    "metadataSearchDescription": MessageLookupByLibrary.simpleMessage(
      "بازی صحیح را برای جاسازی عنوان، هنرمند، آلبوم و پوشش در فایل محلی انتخاب کنید.",
    ),
    "metadataSearchHint": MessageLookupByLibrary.simpleMessage(
      "نام آهنگ یا هنرمند",
    ),
    "metadataSearchTitle": MessageLookupByLibrary.simpleMessage("نام آهنگ"),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "مطمئن شوید که موسیقی با صدای کافی در نزدیکی میکروفون شما پخش می شود.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("آلبوم مهاجرت کرد"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "کتابخانه مهاجرت کرد",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "لیست پخش منتقل شد",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "در حال حاضر یک مهاجرت در حال انجام است.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "تجزیه و تحلیل کتابخانه محلی ...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "بررسی اینکه آیا EMusic Cloud قبلاً کتابخانه دارد یا خیر...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "مهاجرت به پایان رسید.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "ایجاد یک نسخه پشتیبان محلی قبل از اتصال ابر...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "مهاجرت شکست خورد. داده های محلی شما اصلاح نشده است.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "قبل از مهاجرت وارد Joss Red شوید.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "در حال آماده سازی مهاجرت در EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud نمی تواند مهاجرت را شروع کند.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "همه داده ها را نمی توان آپلود کرد. ما حمایت محلی شما را حفظ می کنیم.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "در حال آپلود لیست پخش، موارد دلخواه و سابقه...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud نتوانست این انتقال را تأیید کند.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "تایید یکپارچگی در EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "فایل را انتخاب کرده و وارد کنید",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "song.db یا یک نسخه پشتیبان را انتخاب کنید",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "مهاجرت با موفقیت انجام شد.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("دقیقه"),
    "misc": MessageLookupByLibrary.simpleMessage("قیره"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "پر شنیده ترین آهنگ",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage("موسیقی و پخش"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("تشخیص موسیقی"),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "خطای شبکه! اتصال شبکه خود را بررسی کنید.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("خطای اینترنت!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "نسخه جدید موجود است!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "برنامه جاس رد (فروشگاه پلی)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("فهمیده شد"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("جاس رد وب"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "همگام سازی 100٪ با Joss Red، لیست های پخش با دوستان و بسیاری موارد دیگر. برای دیدن موارد جدید ضربه بزنید.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "موسیقی Estrella تکامل یافته است!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "برای افزودن دوستان، پذیرش درخواست ها یا مدیریت نمایه امنیتی خود، لطفاً از Joss Red در پلتفرم های رسمی آن استفاده کنید:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "دوستان و مدیریت حساب کاربری:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "اخبار موسیقی استرلا",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "لیست پخش با دوستان خود ایجاد کنید! هنگام ایجاد یک لیست پخش، کادر اشتراکی را انتخاب کنید و دوستان خود را برای ویرایش با هم انتخاب کنید.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "لیست های پخش مشترک",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "لیست‌های پخش و موارد دلخواه شما اکنون به طور خودکار با حساب اصلی Joss Red در فضای ابری ذخیره و همگام‌سازی می‌شوند.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "ادغام کامل با جاس رد",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "دیگر نیازی به کلیک روی دکمه های همگام سازی دستی ندارید. موتور جدید وظیفه تعویض خودکار دنده ها را بر عهده دارد.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "همگام سازی شفاف",
    ),
    "no": MessageLookupByLibrary.simpleMessage("خیر"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("بدون نشانک"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "شما هیچ دوستی در Joss Red ندارید.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "شما هیچ لیست پخشی در کتابخانه ندارید!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "هیچ آهنگی در صدای ضبط شده یافت نشد",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "هیچ مسابقه ای وجود ندارد",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "آهنگ آفلاینی وجود ندارد!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "هیچ آهنگی در این مجموعه وجود ندارد",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("هیچ منطبقی برای پیدا نشد"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "احراز هویت نشده است",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "این یک آهنگ / موزیک ویدیو نیست!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "این یک لینک معتبر نیست!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("باز کردن در"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("عملیات ناموفق"),
    "password": MessageLookupByLibrary.simpleMessage("رمز عبور"),
    "password_text": MessageLookupByLibrary.simpleMessage("رمز عبور"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("اجازه رد شد"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("اجازه دهید"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music برای مدیریت موسیقی شما و ارائه تمام ویژگی های پخش به این مجوزها نیاز دارد.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "مجوز برای شروع",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "مجوزهای لازم را اعطا کنید",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "فقط زمانی استفاده می شود که بخواهید آهنگی را که در اطراف شما پخش می شود شناسایی کنید.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "میکروفون",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "کنترل‌های بازپخش، پیشرفت بارگیری و اطلاعیه‌های مهم برنامه را نشان می‌دهد.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "اطلاعیه ها",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "برای ادامه هر سه مجوز لازم است. بعداً می توانید آنها را در تنظیمات سیستم تغییر دهید.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "این به شما امکان می دهد موسیقی پخش کنید، بارگیری ها را ذخیره کنید، لیست های پخش را صادر کنید و به روز رسانی ها را آماده کنید.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "موسیقی و ذخیره سازی",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("شخصی سازی"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "لیست پخش لوله شده",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش لوله شده همگام سازی شد!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("ساده"),
    "play": MessageLookupByLibrary.simpleMessage("بازی کنید"),
    "playNext": MessageLookupByLibrary.simpleMessage("پخش بعدی"),
    "playNow": MessageLookupByLibrary.simpleMessage("بازی کن"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("سرعت پخش"),
    "playerUi": MessageLookupByLibrary.simpleMessage("رابط کاربری پخش کننده"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "رابط کاربری پخش کننده را انتخاب کنید",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage(
      "در حال پخش:",
    ),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage("پخش از آلبوم"),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage("پخش از ارتیست"),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "پخش از لیست پخش",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "پخش از انتخاب شده ها",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("لیست پخش"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش لیست سیاه!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش به نشانک ها اضافه شد!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "نشانک لیست پخش حذف شد!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "مشارکت کنندگان لیست پخش",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش ایجاد شد!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش ایجاد شد و آهنگ اضافه شد!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "لیست پخش با موفقیت به صادر شد",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "لیست پخش با موفقیت وارد شد",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "لیست پخش حذف شد!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "با موفقیت تغییر نام داد!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("لیست پخش"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("پس از این"),
    "podcasts": MessageLookupByLibrary.simpleMessage("پادکست ها"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("آهنگ های محبوب"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "در حال پردازش فایل ها...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "در حال پردازش صدا...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("پروفایل ها"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("حلقه زنی صف"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "حالت حلقه زنی صف نمی‌تواند زمانی که حالت بُر زدن فعال است غیرفعال شود.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "حالت حلقه زنی صف نمی‌تواند در حالت رادیو فعال شود.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "صف نمیتواند زمانی که بُر زدن فعال است، به هم زده شود",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "صف نمیتواند زمانی که بُر زدن فعال است، بازمرتب سازی شود",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("انتخاب سریع"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("انتخاب های سریع"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "رادیو برای این هنرمند در دسترس نیست!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("رادیو تصادفی"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("انتخاب تصادفی"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "بازمرتب سازی لیست پخش",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "تنظیم مجدد آهنگ‌ ها",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("ادامه مطلب"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("جستجوهای اخیر"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("اخیرا پخش شده"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "توصیه می‌کنیم برای تجربه‌ای شبیه به Spotify، حالت ابری را فعال کنید: همگام‌سازی بی‌درنگ بین همه دستگاه‌هایتان و پشتیبان‌گیری خودکار بدون نیاز به انجام کاری.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("توصیه می شود"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("توصیه می شود"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "حذف از حافظه پنهان",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "حذف از موسیقی های کتابخانه",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "حذف از کتابخانه",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "حذف از لیست پخش",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("حذف از صف"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage("حذف چند موسیقی"),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("حذف لیست پخش"),
    "rename": MessageLookupByLibrary.simpleMessage("تغییر نام"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "تغییر نام لیست پخش",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("تکثیر شده توسط"),
    "reset": MessageLookupByLibrary.simpleMessage("بازنشانی کنید"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "تنظیمات پیش فرض را بازیابی کنید",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "بازنشانی تنظیمات برنامه به پیش فرض (نیاز به راه اندازی مجدد)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "بازنشانی تنظیمات به پیش‌فرض کامل شد، لطفاً برنامه را مجدداً راه‌اندازی کنید",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "بازنشانی لیست های پخش لیست سیاه",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "همه لیست‌های پخش Piped را بازنشانی کنید",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "برنامه را مجدداً راه اندازی کنید",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("بازیابی کنید"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "بازیابی اطلاعات برنامه",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "بازگرداندن آخرین نشست پخش",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "به طور خودکار آخرین نشست پخش در آغاز برنامه بازیابی شود",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "با موفقیت بازیابی شد!\nتغییرات پس از راه اندازی مجدد اعمال می شود",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "تنظیمات و لیست های پخش را بازیابی کنید",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "تمام تنظیمات، داده های ورود به سیستم و لیست های پخش را از یک فایل پشتیبان بازیابی می کند. همه داده های فعلی را بازنویسی می کند",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "فایل پشتیبان را انتخاب کنید",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("در حال بازیابی..."),
    "results": MessageLookupByLibrary.simpleMessage("نتایج"),
    "retry": MessageLookupByLibrary.simpleMessage("دوباره امتحان کنید!"),
    "save": MessageLookupByLibrary.simpleMessage("نگه دارید"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("ذخیره شد"),
    "scanning": MessageLookupByLibrary.simpleMessage("در حال اسکن..."),
    "search": MessageLookupByLibrary.simpleMessage("جستجو کنید"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "آهنگ ها، لیست های پخش، آلبوم ها یا هنرمندان",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "جستجو در کتابخانه",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("نتایج جستجو"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "جستجوهای اخیر",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("انتخاب همه"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "نمونه احراز هویت را انتخاب کنید",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "لطفاً نمونه احراز هویت را انتخاب کنید!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("فایل را انتخاب کنید"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("انتخاب اهنگ ها"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "فایل انتخابی یافت نشد.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "جلسه شما تمام شده است. دوباره وارد شوید.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "تنظیم محتوای کشف",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "درباره موسیقی استرلا",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "نسخه، پروژه منبع باز و GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "حساب و همگام سازی",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "حالت ابری، پشتیبان گیری، لیست دوستان و مهاجرت.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "تم، زبان و انیمیشن های رابط.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "پشتیبان گیری ابری",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "آپلود، بازیابی و مدیریت...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "یک نسخه پشتیبان .hmb از برنامه را در سرور آپلود کنید و در صورت نیاز، هر یک از نسخه های پشتیبان ذخیره شده را بازیابی کنید.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "کشف فیلترها، ادغام با Piped و حافظه پنهان.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "دانلودها و ذخیره سازی",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "فرمت های صوتی، پوشه ها و دانلود خودکار.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("ژنرال"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "وضعیت همگام سازی را با Joss Red انتخاب کنید، انتقال دهید یا مرور کنید.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "حالت محلی / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage(
      "از سیستم خارج شوید",
    ),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "وارد کردن لیست های پخش، آهنگ ها...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "مهاجرت از Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("دوستان من"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "دوستان Joss Red خود را مستقیماً مدیریت کنید.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "کیفیت پخش، عادی سازی، سکوت و باتری.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "اگر محتوای Discover بارگیری نشد، شناسه موسیقی Online خود را دوباره ایجاد کنید.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "شناسه بازخوانی (شناسه بازدیدکننده)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("اشتباه"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "یک شناسه جدید ایجاد نشد. لطفاً بعداً دوباره امتحان کنید.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "شناسه به روز شد",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "شناسه بازدیدکننده جدید با موفقیت ایجاد شد.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage(
      "آلبوم را به اشتراک بگذارید",
    ),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "لیست پخش را به اشتراک بگذارید",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage(
      "به اشتراک گذاری این موسیقی",
    ),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "جستجو در پایگاه داده Shazam برای موارد مشابه...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("تصادفی"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("بُر زدن صف"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("تکی"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("رد کردن سکوت"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "سکوت در زمان پخش موسیقی رد خواهد شد",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "تایمر خواب شما تنظیم شده است",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("زمان‌سنج خواب"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "آهنگ به لیست پخش اضافه شد",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "آهنگ از قبل وجود دارد!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "آهنگ از قبل در حافظه پنهان است",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "آهنگ به صف اضافه شد",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("آهنگ پیدا شد"),
    "songInfo": MessageLookupByLibrary.simpleMessage("اطلاعات آهنگ"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "موسیقی به علت محدودیت سرور، قابل پخش نیست!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("لحن آهنگ"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("حذف شده از"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "از صف حذف شد!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "شما نمی توانید آهنگ در حال پخش را حذف کنید",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("آهنگ"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "آهنگ های وارد شده از Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "مرتب سازی صعودی/نزولی",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage(
      "مرتب سازی بر اساس تاریخ",
    ),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "مرتب سازی بر اساس مدت",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("مرتب سازی بر اساس نام"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("سرعت و پیچ"),
    "standard": MessageLookupByLibrary.simpleMessage("استاندارد"),
    "startRadio": MessageLookupByLibrary.simpleMessage("آغاز رادیو"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "در هنگام راه اندازی باز کنید",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "ابتدا قسمتی را که Estrella Music باز می کند انتخاب کنید",
    ),
    "status": MessageLookupByLibrary.simpleMessage("وضعیت"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "هنگام بستن برنامه، موسیقی را متوقف کنید",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "وقتی برنامه از مدیر وظیفه بسته شود، پخش موسیقی متوقف می شود",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("کیفیت استریم"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "کیفیت استریم (پخش) موسیقی",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("مشترکین"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "برای کاوش گزینه ها تند بکشید ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "حالت ابری فعال شد. در حال دانلود کتابخانه موجود",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "حالت ابری فعال شد. کتابخانه مهاجرت کرد.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "حالت ابری فعال است",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "حالت ابری فعال است. در انتظار همگام سازی",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "همگام‌سازی دانلود نشد.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "در حال دانلود تغییرات EMusic...",
    ),
    "syncForceReplaceBackupSaved": m12,
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "ریمپلازار و سابیر",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "نخستين بار براي بازيافتن. مظلومانه، لیست‌های پخش، برگزیده‌ها، تاریخی، آلبوم‌ها، هنرمندان و موسیقی‌دانان موسیقی EMusic Cloud به‌منظور بازخوانی داده‌های واقعی این دیسپوزیتیو. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca musical remota؟",
    ),
    "syncForceReplaceCountMismatch": MessageLookupByLibrary.simpleMessage(
      "تعداد آپلود شده با کتابخانه محلی مطابقت ندارد. جایگزینی از راه دور را نمی توان تایید کرد.",
    ),
    "syncForceReplaceCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "ایجاد یک پشتیبان بازیابی قبل از جایگزینی داده های ابر",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud نمی تواند جایگزین کتابخانه از راه دور شود.",
    ),
    "syncForceReplaceFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "جایگزینی از راه دور شکست خورد. اطلاعات محلی و پشتیبان گیری بازیابی شما حفظ شده است.",
    ),
    "syncForceReplaceFailedTitle": MessageLookupByLibrary.simpleMessage(
      "آپلود نکردن تکمیل نشده",
    ),
    "syncForceReplaceInProgress": MessageLookupByLibrary.simpleMessage(
      "استفاده از همگام سازی، ایجاد پشتیبان و آپلود کتابخانه محلی",
    ),
    "syncForceReplacePauseFailed": MessageLookupByLibrary.simpleMessage(
      "هماهنگی فعلی نمی تواند با خیال راحت متوقف شود. دوباره در یک لحظه امتحان کنید.",
    ),
    "syncForceReplaceSuccess": MessageLookupByLibrary.simpleMessage(
      "کتابخانه موسیقی از راه دور با داده های فعلی این دستگاه جایگزین شد.",
    ),
    "syncForceReplaceSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "آپلود تکمیل شده",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "لغو sincronización y subir esta base",
    ),
    "syncForceReplaceValidating": MessageLookupByLibrary.simpleMessage(
      "اعتبار کتابخانه آپلود شده قبل از جایگزینی داده های ابر",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "کتابخانه همگام شده",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "کتابخانه به روز",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "تغییرات محلی جدیدی وجود دارد. آنها قبل از دانلود آپلود خواهند شد.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "اطلاعات شما فقط در این دستگاه نگهداری می شود.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "حالت محلی فعال است",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "آفلاین. تغییرات در انتظار است.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "آفلاین. تغییرات برای تلاش مجدد ذخیره شد.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "همگام سازی آهنگ های لیست پخش",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic همه تغییرات را تایید نکرد. آنها دوباره محاکمه خواهند شد.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "نتوانست بلند شود. بعداً دوباره امتحان خواهد شد.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "تغییرات به درستی آپلود شد.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "تغییرات با موفقیت آپلود شد (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "با استفاده از WS آپلود نشد. بعداً دوباره امتحان خواهد شد.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "در حال آپلود تغییرات در EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("همگام شده است"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "اشعار همگام شده در دسترس نیست!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("پیشفرض سیستم"),
    "themeMode": MessageLookupByLibrary.simpleMessage("حالت تم"),
    "title": MessageLookupByLibrary.simpleMessage("عنوان"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("موزیک ویدیوهای برتر"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("نماهنگ های برتر"),
    "trending": MessageLookupByLibrary.simpleMessage("ترند"),
    "unLink": MessageLookupByLibrary.simpleMessage("لغو پیوند"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("با موفقیت لغو شد!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("آهنگ بدون عنوان"),
    "upNext": MessageLookupByLibrary.simpleMessage("بعد از این"),
    "updateApp": MessageLookupByLibrary.simpleMessage("به روز رسانی برنامه"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL شناسایی شده روی آن کلیک کنید تا محتوای مرتبط باز شود/باز شود",
    ),
    "useThisMetadata": MessageLookupByLibrary.simpleMessage(
      "استفاده از این متاداده",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("کاربر مسدود شده"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "پاسخ شامل لیستی از کاربران نیست.",
    ),
    "userSearchFailed": m13,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("کاربر آنلاک شده"),
    "username": MessageLookupByLibrary.simpleMessage("نام کاربری"),
    "video": MessageLookupByLibrary.simpleMessage("ویدئو"),
    "videos": MessageLookupByLibrary.simpleMessage("ویدیوها"),
    "viewAll": MessageLookupByLibrary.simpleMessage("همه را ببینید"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("دیدن هنرمند"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "ما پلتفرم خود را مدرن کرده ایم. سیستم قدیمی آپلود نسخه پشتیبان دستی غیرفعال شده است. اکنون دو راه روشن برای مدیریت کتابخانه موسیقی خود دارید.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "نحوه تجربه موسیقی Estrella را از این پس انتخاب کنید.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "موسیقی شما، روش شما",
    ),
  };
}
