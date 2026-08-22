// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(songTitle) => "التنزيل: ${songTitle}";

  static String m1(count) => "الألبومات: ${count}";

  static String m2(count) => "الفنانين: ${count}";

  static String m3(count) => "المفضلة: ${count}";

  static String m4(count) => "قوائم التشغيل: ${count}";

  static String m5(count) => "الأغاني: ${count}";

  static String m6(source) => "اكتمل الترحيل من ${source}.";

  static String m7(error) => "حدث خطأ أثناء إعادة الإنشاء: ${error}";

  static String m8(title) => "مشابهة لـ ${title}";

  static String m9(current) => "الخطوة ${current} من 3";

  static String m10(count) => "${count} التغييرات التي تم تنفيذها.";

  static String m11(count) => "${count} التغييرات المتزامنة.";

  static String m12(statusCode) =>
      "تعذر البحث عن المستخدمين (_${statusCode}_).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "إنشاء قائمة تشغيل جديدة",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("منقولة"),
    "about": MessageLookupByLibrary.simpleMessage("عن"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("إضافة 5 دقائق"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "إضافة الأغاني إلى قائمة التشغيل",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage("أضف إلى المكتبة"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "إضافة إلى قائمة التشغيل",
    ),
    "album": MessageLookupByLibrary.simpleMessage("البوم"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "تم وضع إشارة مرجعية للألبوم!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة الإشارة المرجعية للألبوم!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("البومات"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("حسب ذوقك"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "جميع الحقول مطلوبة",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "غير مجرب: عند تحديد خانة الاختيار بعد تنزيل أكثر من 60 ملفًا، قد تستهلك العملية كمية كبيرة من الذاكرة وقد تؤدي إلى تعطل الهاتف أو التطبيق. المتابعة على مسؤوليتك الخاصة.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("معلومات التطبيق"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "تم وضع إشارة مرجعية للفنان!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة الإشارة المرجعية للفنان!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "الوصف غير متوفر!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("فنانين"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("حسب ذوقك"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("ترميز الصوت"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("رمز المصادقة"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "أدخل رمزًا صالحًا مكونًا من 6 أرقام أو قم بتسجيل الدخول مرة أخرى.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "أدخل الرمز المكون من 6 أرقام من تطبيق المصادقة الخاص بك. تنتهي صلاحية هذا الوصول خلال 5 دقائق.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage("المصادقة الثنائية"),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage("تحقق واستمر"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "قبول استخدام بيانات خاطئة...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "لقد أحضرنا تسجيل الدخول والتسجيل واستعادة كلمة المرور من المشروع السابق، وتم تكييفه ليناسب تطبيق الموسيقى هذا.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "تعيش جلستك في مساحة تخزين آمنة ويتم التحقق من صحتها بنفس الواجهة الخلفية التي كنت تستخدمها بالفعل.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "يجب تكوين ملف .env لتوصيل الواجهة الخلفية للمصادقة.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("يسجل"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("إرسال البريد"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني أو كلمة المرور غير صحيحة.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدًا إلكترونيًا صالحًا.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "الواجهة الخلفية للمصادقة مفقودة ليتم تكوينها في ملف .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "لم يتم التحقق من حسابك بعد.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "لم يكن من الممكن إكمال العملية.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "لقد نسيت كلمة المرور الخاصة بي",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "سنرسل لك التعليمات إلى البريد الإلكتروني الخاص بحسابك.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("name@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("اسم العائلة"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "لم يكن من الممكن إرسال البريد الإلكتروني.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال البريد الإلكتروني.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إنشاء الحساب.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب بنجاح.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "مرحبا بكم في استريلا الموسيقى",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "مرحبا بكم في استريلا الموسيقى",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "تنزيل الأغاني المفضلة تلقائيًا",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "تحميل الأغاني المفضلة تلقائيًا عند إضافتها إلى قائمة الاغاني المفضلة",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "فتح شاشة المشغل تلقائيًا",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "تنشيط/إلغاء تنشيط الفتح التلقائي للمشغل إلى وضع ملء الشاشة عند اختيار أغنية لتشغيلها",
    ),
    "back": MessageLookupByLibrary.simpleMessage("يعود"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "تم العثور على قواعد البيانات",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "تشغيل الموسيقى الخلفية",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "تمكين/تعطيل تشغيل الموسيقى في الخلفية (يمكن الوصول إلى التطبيق من واجهة النظام عندما يكون التطبيق قيد التشغيل في الخلفية)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("نسخة احتياطية"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "نسخ احتياطي لبيانات التطبيق",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "جاري إنشاء النسخة الاحتياطية...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "تم حفظ النسخة الاحتياطية بنجاح!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "إعدادات النسخ الاحتياطي وقوائم التشغيل",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "حفظ جميع الإعدادات، وقوائم التشغيل، وبيانات تسجيل الدخول في ملف نسخة احتياطية",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "تحتاج إلى جلسة نشطة..",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "أعد تشغيل التطبيق",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "تحميل النسخة الاحتياطية الآن",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "هل تريد إجراء نسخة احتياطية؟",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "تم حذف النسخة الاحتياطية.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "لا توجد نسخ احتياطية حتى الآن ...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "تمت استعادة النسخة الاحتياطية. أعد تشغيل التطبيق.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "حدد المجلد للنسخ الاحتياطي",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "اختر البيانات التي تريد نسخها احتياطيًا",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "تم تحميل النسخة الاحتياطية بشكل صحيح.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "بناء على تفاعلاتك الأخيرة",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("معدّل البتات"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "القائمة السوداء لقائمة التشغيل",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إعادة الضبط بنجاح!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("من قبل"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "تخزين بيانات محتوى الشاشة الرئيسية مؤقتًا",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "تمكين التخزين المؤقت لبيانات محتوى الشاشة الرئيسية، سيتم تحميل الشاشة الرئيسية على الفور إذا تم تمكين هذا الخيار",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage(
      "أغاني ذاكرة التخزين المؤقت",
    ),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "سيؤدي تخزين الأغاني مؤقتًا أثناء التشغيل للتشغيل في المستقبل/دون الاتصال بالإنترنت إلى استهلاك مساحة إضافية على جهازك",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("متاح بدون انترنت"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("إلغاء الموقت"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء مؤقت النوم",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "مسح ذاكرة التخزين المؤقت للصور",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "تم مسح ذاكرة التخزين المؤقت للصور بنجاح",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "انقر هنا لمسح الصور المصغرة/الصور المخزنة مؤقتًا. (غير مستحسن إلا إذا كنت ترغب في تحديث بيانات الصور المخزنة مؤقتًا)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("يغلق"),
    "closeApp": MessageLookupByLibrary.simpleMessage("إغلاق التطبيق"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "تم العثور على مكتبة سحابية.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "تم العثور على مكتبة سحابية. سيقوم هذا الجهاز بتنزيله دون الكتابة فوقه.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "الوضع السحابي جاهز. سيعمل هذا الجهاز كذاكرة تخزين مؤقت غير متصلة بالإنترنت.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "قم بتسجيل الدخول بشكل آمن باستخدام حساب Joss Red الخاص بك.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "يمكنك الوصول إلى قوائم التشغيل والمفضلات والسجل من أي جهاز (Windows وAndroid وما إلى ذلك) على الفور.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "المزامنة الذكية: العمل دون اتصال بالإنترنت وتحميل التغييرات تلقائيًا عند استعادة الإنترنت.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "تفعيل المزامنة السحابية",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "المزامنة في الوقت الحقيقي مع جوس ريد",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "الوضع السحابي (مستحسن)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "قائمة التشغيل التعاونية",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "حدد الأصدقاء الذين سيتمكنون من رؤية قائمة التشغيل هذه وتعديلها:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث المتعاونين بشكل صحيح.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "قوائم تشغيل الاخرين",
    ),
    "content": MessageLookupByLibrary.simpleMessage("المحتوى"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 جوسبروكس. ترخيص GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("إنشاء"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("إنشاء وإضافة"),
    "customIns": MessageLookupByLibrary.simpleMessage("نسخة مخصصة"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "الرجاء تحديد نسخة مخصصة",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("الاكتشاف اليومي"),
    "dark": MessageLookupByLibrary.simpleMessage("مظلم"),
    "delete": MessageLookupByLibrary.simpleMessage("اِسْتَبْعَد"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "إزالة من التنزيلات",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "تمت الإزالة من التنزيلات بنجاح!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "تم تطويره وصيانته بواسطة جوس استرادا (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "إيقاف الرسوم المتحركة الانتقالية",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "قم بتمكين هذا الخيار لتعطيل الرسوم المتحركة الانتقالية بين الصفحات",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("معطل"),
    "discover": MessageLookupByLibrary.simpleMessage("اكتشف"),
    "dismiss": MessageLookupByLibrary.simpleMessage("اهمال"),
    "done": MessageLookupByLibrary.simpleMessage("مستعد"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "لا تظهر هذه المعلومات مرة أخرى",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "تم العثور على الملفات التي تم تنزيلها",
    ),
    "download": MessageLookupByLibrary.simpleMessage("تحميل"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "تحميل الأغاني من الألبوم",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "الأغنية المطلوبة غير قابلة للتحميل بسبب قيود النظام. يمكنك المحاولة مرة أخرى",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "فشل التحميل بسبب خطأ في الشبكة! يرجى المحاولة مرة أخرى",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("موقع التحميل"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "يبقي تنزيلات الموسيقى الخاصة بك نشطة في الخلفية.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "تنزيلات الموسيقى",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "جارٍ تحضير التنزيلات…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "تنزيل الموسيقى",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "تحميل قائمة التشغيل",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "صيغة تحميل الملفات",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "حدد تنزيل تنسيق الملف. سوف توفر \"Opus\" أعلى جودة",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("التنزيلات"),
    "duration": MessageLookupByLibrary.simpleMessage("مدة"),
    "dynamic": MessageLookupByLibrary.simpleMessage("ديناميكي"),
    "email": MessageLookupByLibrary.simpleMessage("بريد إلكتروني"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("قائمة فارغة!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "شريط التنقل السفلي",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "التبديل إلى أزرار شريط التنقل",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "تمكين الإجراءات القابلة للسحب",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "تمكين الإجراءات القابلة للسحب على لوحة الأغنية",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("ممكّن"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("نهاية هذه الأغنية"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "أضف أغاني الألبوم إلى قائمة الانتظار",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("إدراج الكل"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "قم بإدراج هذه الأغنية",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "إضافة الأغاني إلى قائمة الانتظار",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("الحلقات"),
    "equalizer": MessageLookupByLibrary.simpleMessage("المعادل"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "فتح المعادل الخاص بالنظام",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "لقد حدث خطأ ما!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("حدث خطأ"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "خطأ أثناء اللعب:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("تصدير"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "تصدير الملفات التي تم تنزيلها",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "انقر هنا لتصدير الملف الذي تم تنزيله من دليل التطبيق إلى مكان خارجي",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء تصدير قائمة التشغيل",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "خطأ في تنسيق بيانات قائمة التشغيل",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "تم رفض الإذن عند التصدير",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "مساحة تخزين غير كافية",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage("تم تصدير الملفات بنجاح"),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "تصدير قائمة التشغيل",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "تصدير قائمة التشغيل كملف CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "لا يمكن الاستيراد هنا",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "تصدير قائمة التشغيل إلى JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "يمكن استيراد هذا التنسيق",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "تصدير إلى موسيقى يوتيوب",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "سيؤدي ذلك إلى دفع قائمة التشغيل الخاصة بك (الأغاني <50) إلى قائمة الانتظار الحالية، لا تنس إضافتها إلى قائمة التشغيل/الحفظ بعد فتحها في YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "موقع تصدير الملف الذي تم تنزيله",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("جار التصدير..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "جارٍ تصدير قائمة التشغيل...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage("قوائم مقترحة"),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على الملف",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("يكمل"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("يتبع"),
    "following": MessageLookupByLibrary.simpleMessage("التالي"),
    "for1": MessageLookupByLibrary.simpleMessage("لأجل"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "المفضلة المنسية",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("صديق"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "تم قبول طلب الصداقة",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال طلب الصداقة",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("أصدقاء"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "قم بتسجيل الدخول للعثور على الأصدقاء.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة الصداقة",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("الألبوم"),
    "genericError": MessageLookupByLibrary.simpleMessage("خطأ"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("إلكترونيات"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("الهيب هوب"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("موسيقى الجاز"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("اللاتينية"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("البوب"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("صخر"),
    "gesture": MessageLookupByLibrary.simpleMessage("إيماءة"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "عرض كود مصدر على GitHub\nإذا أعجبك هذا المشروع، فلا تنسى أن تعطي ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("انتقل إلى الألبوم"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "انقر هنا للذهاب إلى صفحة التحميل",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("مرحبا بالعالم"),
    "high": MessageLookupByLibrary.simpleMessage("عالي"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage("عنوان URL لطلب النقل"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "عدد محتوى القائمة الرئيسية",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "حدد عدد محتوى الشاشة الرئيسية الأولي (تقريبًا). عدد أقل تحميل أسرع",
    ),
    "id": MessageLookupByLibrary.simpleMessage("رقم"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "تجاهل تحسين البطارية",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "إذا كنت تواجه مشكلات في الإشعارات أو توقف التشغيل عن طريق تحسين النظام، فيرجى تمكين هذا الخيار",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء استيراد قائمة التشغيل",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء الحفظ في قاعدة البيانات",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "لا يمكن الوصول إلى الملف المحدد",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "تنسيق الملف غير صالح",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "ملاحظة: قد يستغرق استيراد قوائم التشغيل الكبيرة وقتًا أطول",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "استيراد قائمة التشغيل",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "حدد ملف JSON لقائمة التشغيل التي تم تصديرها مسبقًا لاستيرادها",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("مستورد"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "مستورد من جوس ميوزيك كوتلين",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "قائمة التشغيل المستوردة",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "جارٍ استيراد قائمة التشغيل...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "دليل التخزين الداخلي",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "تضمين ملفات الأغاني المحملة",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "المعلومات غير متوفرة",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "بنية ملف قائمة التشغيل غير صالحة",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "استجابة الخادم غير صالحة.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "لا تحتوي الجلسة على رمز مميز صالح.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("عناصر"),
    "keepListening": MessageLookupByLibrary.simpleMessage("استمر في الاستماع"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "ابقِ الشاشة مضاءة أثناء التشغيل",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "إذا تم التفعيل، ستبقى شاشة الجهاز مضاءة أثناء تشغيل الموسيقى",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "languageDes": MessageLookupByLibrary.simpleMessage("ضبط لغة التطبيق"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("أحدث إصدار"),
    "latestVersion": MessageLookupByLibrary.simpleMessage("أحدث إصدار متاح"),
    "letsStrart": MessageLookupByLibrary.simpleMessage("لنبدأ.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("البومات المكتبة"),
    "libArtists": MessageLookupByLibrary.simpleMessage("فنانين المكتبة"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("مكتبة قوائم التشغيل"),
    "libSongs": MessageLookupByLibrary.simpleMessage("مكتبة الأغاني"),
    "library": MessageLookupByLibrary.simpleMessage("المكتبة"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "قائمة تشغيل المكتبة",
    ),
    "light": MessageLookupByLibrary.simpleMessage("مضيء"),
    "link": MessageLookupByLibrary.simpleMessage("ربط"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("تم ربطه بنجاح!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "تم نسخ الرابط إلى الحافظة",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "رابط مع Piped للقوائم التشغيل",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("استمع الآن"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "الاستماع إلى البيئة...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل معلومات التحديث",
    ),
    "local": MessageLookupByLibrary.simpleMessage("محلي"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "يعمل دون الحاجة لتسجيل الدخول.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "مكتبتك بأكملها تبقى بشكل صارم على هذا الكمبيوتر.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "ملحوظة: لا توجد نسخ احتياطية سحابية يدوية. إذا فقدت جهازك أو قمت بإلغاء تثبيت التطبيق، فلن تتمكن من استرداد بياناتك.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "استخدم فقط على هذا الجهاز",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "الخصوصية المطلقة على جهازك",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("الوضع المحلي"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("شدة الصوت بالديسيبل"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "معايرة شدة الصوت",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "تعيين نفس مستوى شدة الصوت لجميع الأغاني (تجريبي) (لن يعمل على الأغاني التي تم تحميلها في النسخ السابقة (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("منخفض"),
    "lyrics": MessageLookupByLibrary.simpleMessage("رسائل"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "كلمات غير متوفرة!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "إدارة المتعاونين (الأصدقاء)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "تأكد من تشغيل الموسيقى بصوت عالٍ بدرجة كافية بالقرب من الميكروفون.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("الألبوم المنقول"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage("المكتبة المهاجرة"),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "قائمة التشغيل المنقولة",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "هناك بالفعل عملية ترحيل قيد التقدم.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "تحليل المكتبة المحلية...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "التحقق مما إذا كان EMusic Cloud يحتوي بالفعل على مكتبة...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "اكتملت الهجرة.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "إنشاء نسخة احتياطية محلية قبل الاتصال بالسحابة...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "فشلت عملية الترحيل. لم يتم تعديل بياناتك المحلية.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "قم بتسجيل الدخول إلى Joss Red قبل الترحيل.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "تحضير الترحيل في EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "تعذر على EMusic Cloud بدء الترحيل.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "لا يمكن تحميل كافة البيانات. نحن نحافظ على دعمكم المحلي.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "جارٍ تحميل قوائم التشغيل والمفضلات والتاريخ...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "تعذر على EMusic Cloud التحقق من صحة الترحيل.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "جارٍ التحقق من التكامل في EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "حدد الملف والاستيراد",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "حدد أغنية.db أو نسخة احتياطية",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "تمت عملية الترحيل بنجاح.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("دقائق"),
    "misc": MessageLookupByLibrary.simpleMessage("عديد"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "الأكثر استماعا للأغنية",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "الموسيقى والتشغيل",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "التعرف على الموسيقى",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "خطأ في الشبكة! يرجى التأكد من الاتصال بالإنترنت.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage("خطأ في الشبكة!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "إصدار جديد متاح!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "تطبيق جوس ريد (متجر Play)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("مفهوم"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("جوس ريد ويب"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "مزامنة بنسبة 100% مع Joss Red وقوائم التشغيل مع الأصدقاء وغير ذلك الكثير. انقر لمعرفة ما هو الجديد.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "لقد تطورت موسيقى استريلا!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "لإضافة أصدقاء أو قبول الطلبات أو إدارة ملف تعريف الأمان الخاص بك، يرجى استخدام Joss Red على منصاته الرسمية:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "الأصدقاء وإدارة الحسابات:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "أخبار الموسيقى استريلا",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "إنشاء قوائم التشغيل مع أصدقائك! عند إنشاء قائمة تشغيل، حدد مربع الاختيار التعاوني واختر أصدقائك لتحريرها معًا.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "قوائم التشغيل التعاونية",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "يتم الآن حفظ قوائم التشغيل والمفضلات الخاصة بك ومزامنتها في السحابة تلقائيًا باستخدام حساب Joss Red الرئيسي الخاص بك.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "التكامل الكامل مع جوس ريد",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "لم تعد بحاجة إلى النقر فوق أزرار المزامنة اليدوية؛ المحرك الجديد مسؤول عن التحول لأعلى ولأسفل تلقائيًا.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "مزامنة شفافة",
    ),
    "no": MessageLookupByLibrary.simpleMessage("لا"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage(
      "لا الإشارات المرجعية!",
    ),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "ليس لديك أصدقاء مضافين في Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "ليس لديك أي قائمة تشغيل!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "تعذر العثور على أي أغاني في الصوت المسجل",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("لا يوجد مباريات"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "لا يوجد أغاني بدون إنترنت!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "لا توجد أغاني في هذه المجموعة",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("لايوجد مطابق"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "لم تتم المصادقة عليها",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "ليست أغنية /فيديو موسيقي!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("الرابط ليس صالحا!"),
    "openIn": MessageLookupByLibrary.simpleMessage("فتح في"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("فشلت العملية"),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "password_text": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("تم رفض الإذن"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("يسمح"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "تحتاج Estrella Music إلى هذه الأذونات لإدارة الموسيقى الخاصة بك وتقديم جميع ميزات التشغيل.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "أذونات للبدء",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "منح الأذونات المطلوبة",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "يتم استخدامه فقط عندما تختار التعرف على الأغنية التي يتم تشغيلها من حولك.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "ميكروفون",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "يعرض عناصر التحكم في التشغيل وتقدم التنزيل وإشعارات التطبيق المهمة.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "إشعارات",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("إعدادات"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "جميع التصاريح الثلاثة مطلوبة للمتابعة. ويمكنك تغييرها لاحقًا في إعدادات النظام.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "يسمح لك بتشغيل الموسيقى وحفظ التنزيلات وتصدير قوائم التشغيل وإعداد التحديثات.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "الموسيقى والتخزين",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("تخصيص"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "قائمة التشغيل عبر الأنابيب",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "تمت مزامنة قائمة التشغيل المنقولة!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("عادي"),
    "play": MessageLookupByLibrary.simpleMessage("إعادة إنتاج"),
    "playNext": MessageLookupByLibrary.simpleMessage("تشغيل التالي"),
    "playNow": MessageLookupByLibrary.simpleMessage("العب الآن"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("سرعة التشغيل"),
    "playerUi": MessageLookupByLibrary.simpleMessage("واجهة مشغل الاغاني"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage("اختر واجهة للمشغل"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("اللعب:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "اللعب من الألبوم",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "اللعب من الفنان",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "التشغيل من قائمة التشغيل",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "اللعب من المختارة",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("قائمة التشغيل"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "قائمة التشغيل في القائمة السوداء!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "تم وضع إشارة مرجعية لقائمة التشغيل!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة الإشارة المرجعية لقائمة التشغيل!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "المساهمين في قائمة التشغيل",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء قائمة التشغيل!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء قائمة التشغيل وإضافة الأغنية!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "تم تصدير قائمة التشغيل إلى",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "تم استيراد قائمة التشغيل بنجاح",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إزالة قائمة التشغيل!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إعادة التسمية بنجاح!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("قوائم التشغيل"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("ألتالي"),
    "podcasts": MessageLookupByLibrary.simpleMessage("البودكاست"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("المسارات الشعبية"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "جاري معالجة الملفات...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage("معالجة الصوت..."),
    "profiles": MessageLookupByLibrary.simpleMessage("الملفات الشخصية"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("تكرار قائمة الانتظار"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "لا يمكن ايقاف وضع تكرار قائمة الانتظار عند تفعيل وضع التبديل.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "لا يمكن تفعيل وضع تكرار قائمة الانتظار في وضع الراديو.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "لا يمكن خلط قائمة الانتظار عند تفعيل وضع التبديل",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إعادة ترتيب قائمة الانتظار عند تفعيل وضع التبديل",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("اختيار سريع"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("اختيارات سريعة"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "الراديو غير متوفر لهذا الفنان!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("راديو عشوائي"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("اختيار عشوائي"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "إعادة ترتيب قوائم التشغيل",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "إعادة ترتيب الأغاني",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("اقرأ المزيد"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "عمليات البحث الأخيرة",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("استمعت مؤخرا"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "نوصي بتنشيط الوضع السحابي للاستمتاع بتجربة تشبه تجربة Spotify: المزامنة في الوقت الفعلي بين جميع أجهزتك والنسخ الاحتياطي التلقائي دون الحاجة إلى القيام بأي شيء.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("مُستَحسَن"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("مُستَحسَن"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage(
      "إزالة من ذاكرة التخزين المؤقت",
    ),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "إزالة من مكتبة الأغاني",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage("حذف من المكتبة"),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "إزالة من قائمة التشغيل",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "إزالة من قائمة الانتظار",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "إزالة أغاني متعددة",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "إزالة قائمة التشغيل",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("إعادة تسمية"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "إعادة تسمية قائمة التشغيل",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("مستنسخة بواسطة"),
    "reset": MessageLookupByLibrary.simpleMessage("إعادة ضبط"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "استعادة الإعدادات الافتراضية",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "إعادة ضبط إعدادات التطبيق على الوضع الافتراضي (يتطلب إعادة التشغيل)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "اكتملت عملية إعادة تعيين الإعدادات إلى الوضع الافتراضي، يرجى إعادة تشغيل التطبيق",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين قوائم التشغيل المدرجة في القائمة السوداء",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كافة قوائم التشغيل المدرجة في القائمة السوداء",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("إعادة تشغيل التطبيق"),
    "restore": MessageLookupByLibrary.simpleMessage("استعادة"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "استعادة بيانات التطبيق",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "استعادة جلسة التشغيل الأخيرة",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "استعادة جلسة التشغيل الأخيرة تلقائيًا عند بدء التطبيق",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "تمت الاستعادة بنجاح!\n سيتم تطبيق التغييرات عند إعادة التشغيل",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "استعادة الإعدادات وقوائم التشغيل",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "استعادة كافة الإعدادات، وبيانات تسجيل الدخول وقوائم التشغيل من ملف النسخ الاحتياطي. سيتم استبدال جميع البيانات الحالية",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "حدد ملف النسخ الاحتياطي",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("جار استعادة..."),
    "results": MessageLookupByLibrary.simpleMessage("النتائج"),
    "retry": MessageLookupByLibrary.simpleMessage("حاول مجددا!"),
    "save": MessageLookupByLibrary.simpleMessage("يحفظ"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("أنقذ"),
    "scanning": MessageLookupByLibrary.simpleMessage("جارٍ المسح..."),
    "search": MessageLookupByLibrary.simpleMessage("بحث"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "الأغاني، قائمة التشغيل، الألبوم، أو الفنان",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("ابحث في المكتبة"),
    "searchRes": MessageLookupByLibrary.simpleMessage("نتائج البحث"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "عمليات البحث الأخيرة",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("حدد الكل"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("اختر نسخة المصادقة"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "الرجاء تحديد نسخة المصادقة!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("حدد ملف"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("اختر الأغاني"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على الملف المحدد.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "لقد انتهت صلاحية جلستك. قم بتسجيل الدخول مرة أخرى.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "تعيين اكتشاف المحتوى",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("إعدادات"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "حول موسيقى استريلا",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "الإصدار، مشروع مفتوح المصدر وGitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "الحساب والمزامنة",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "الوضع السحابي والنسخ الاحتياطية وقائمة الأصدقاء وعمليات الترحيل.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "الرسوم المتحركة للموضوع واللغة والواجهة.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "النسخ الاحتياطي السحابي",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "تحميل واستعادة وإدارة...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "قم بتحميل نسخة احتياطية ‎.hmb من التطبيق إلى الخادم، وإذا لزم الأمر، قم باستعادة أي من النسخ الاحتياطية المحفوظة.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "اكتشف عوامل التصفية والتكامل مع الأنابيب وذاكرة التخزين المؤقت.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "التنزيلات والتخزين",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "تنسيقات الصوت والمجلدات والتنزيلات التلقائية.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("عام"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "اختر حالة المزامنة أو قم بترحيلها أو مراجعتها مع Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "الوضع المحلي / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "استيراد قوائم التشغيل والأغاني...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "الهجرة من Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(".أصدقائي"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "إدارة أصدقائك Joss Red مباشرة.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "جودة البث والتطبيع والصمت والبطارية.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "قم بإعادة إنشاء معرف YouTube Music الخاص بك إذا لم يتم تحميل محتوى Discover.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "معرف التحديث (معرف الزائر)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إنشاء معرف جديد. يرجى المحاولة مرة أخرى في وقت لاحق.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "المعرف المحدث",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء معرف زائر جديد بنجاح.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("مشاركة الألبوم"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "مشاركة قائمة التشغيل",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("مشاركة هذه الأغنية"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "جارٍ البحث في قاعدة بيانات Shazam عن التطابقات...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("عشوائي"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("خلط قائمة الانتظار"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("منفردة"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("تخطي الصمت"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "سيتم تخطي الصمت أثناء تشغيل الموسيقى",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "تم ضبط مؤقت نوم",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("مؤقت النوم"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة الأغنية إلى قائمة التشغيل!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "الأغنية موجودة بالفعل!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "الأغنية غير متصلة بالإنترنت بالفعل في ذاكرة التخزين المؤقت",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "أغنية في قائمة الانتظار!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("تم العثور على الأغنية!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("معلومات الأغنية"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "الأغنية غير قابلة للتشغيل بسبب قيود النظام!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("نغمة الأغنية"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("تمت الإزالة من"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "تمت إزالتها من قائمة الانتظار!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "لا يمكنك إزالة الأغنية التي يتم تشغيلها حاليًا",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("أغاني"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "الأغاني المستوردة من Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "فرز تصاعدي / تنازلي",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("الترتيب حسب التاريخ"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage("الترتيب حسب المدة"),
    "sortByName": MessageLookupByLibrary.simpleMessage("الترتيب حسب الاسم"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("السرعة والملعب"),
    "standard": MessageLookupByLibrary.simpleMessage("الافتراضي"),
    "startRadio": MessageLookupByLibrary.simpleMessage("تشغيل الراديو"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "فتح عند بدء التشغيل",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "اختر القسم الذي تفتحه Estrella Music أولاً",
    ),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "ايقاف الموسيقى عند مسح تطبيقات التي تعمل بالخلفية",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "سيتوقف تشغيل الموسيقى عندما يتم اغلاق التطبيق عن طريق مدير المهام",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("جودة البث"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "جودة بث الموسيقى",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("متابعون"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "اسحب لاستكشاف الخيارات ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "تم تفعيل الوضع السحابي. تنزيل المكتبة الموجودة.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "تم تفعيل الوضع السحابي. المكتبة المهاجرة.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "الوضع السحابي نشط",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "الوضع السحابي نشط. في انتظار المزامنة.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "فشل تنزيل المزامنة.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "جارٍ تنزيل تغييرات EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage("مكتبة متزامنة"),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "المكتبة محدثة.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "هناك تغييرات محلية جديدة. سيتم تحميلها قبل التنزيل.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "يتم الاحتفاظ ببياناتك على هذا الجهاز فقط.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "الوضع المحلي نشط",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "غير متصل. التغييرات معلقة.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "غير متصل. تم حفظ التغييرات لإعادة المحاولة.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "مزامنة أغاني قائمة التشغيل",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "لم يؤكد EMusic كافة التغييرات. ستتم إعادة محاكمتهم.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "لم أستطع النهوض. سيتم إعادة المحاولة لاحقا.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تحميل التغييرات بشكل صحيح.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "تم تحميل التغييرات بنجاح (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "تعذر التحميل باستخدام WS. سيتم إعادة المحاولة لاحقا.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "جارٍ تحميل التغييرات إلى EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("مزامنة"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "كلمات متزامنة غير متوفرة!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("الافتراضي للنظام"),
    "themeMode": MessageLookupByLibrary.simpleMessage("وضع السمة"),
    "title": MessageLookupByLibrary.simpleMessage("عنوان"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "أعلى مقاطع الفيديو الموسيقية",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "اشهر مقاطع الفيديو الموسيقية",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("الأكثر رواجا"),
    "unLink": MessageLookupByLibrary.simpleMessage("الغاء الربط"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء الربط بنجاح!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("أغنية بلا عنوان"),
    "upNext": MessageLookupByLibrary.simpleMessage("التالي"),
    "updateApp": MessageLookupByLibrary.simpleMessage("تحديث التطبيق"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "تم العثور على رابط، انقر عليه لفتح/تشغيل المحتوى المرتبط",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("مستخدم محظور"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "لا يحتوي الرد على قائمة المستخدمين.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("مستخدم غير مقفل"),
    "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "video": MessageLookupByLibrary.simpleMessage("فيديو"),
    "videos": MessageLookupByLibrary.simpleMessage("فيديو"),
    "viewAll": MessageLookupByLibrary.simpleMessage("رؤية الكل"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("عرض الفنان"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "لقد قمنا بتحديث منصتنا. تم تعطيل النظام القديم لتحميل النسخ الاحتياطية اليدوية. لديك الآن طريقتان واضحتان لإدارة مكتبة الموسيقى الخاصة بك.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "اختر الطريقة التي تريد بها تجربة موسيقى Estrella من الآن فصاعدًا.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "الموسيقى الخاصة بك، طريقك",
    ),
  };
}
