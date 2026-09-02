// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(songTitle) => "Mengunduh: _${songTitle}";

  static String m1(count) => "Album: ${count}";

  static String m2(count) => "Artis: ${count}";

  static String m3(count) => "Favorit: ${count}";

  static String m4(count) => "Daftar Putar: ${count}";

  static String m5(count) => "Lagu: ${count}";

  static String m6(source) => "Migrasi selesai dari ${source}.";

  static String m7(error) => "Terjadi kesalahan saat membuat ulang: ${error}";

  static String m8(title) => "Mirip dengan _${title}";

  static String m9(current) => "Langkah _${current} dari 3";

  static String m10(count) => "_${count} perubahan dilakukan.";

  static String m11(count) => "_${count} perubahan yang disinkronkan.";

  static String m12(path) => "Backup Pemulihan: ${path}";

  static String m13(statusCode) =>
      "Tidak dapat mencari pengguna (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Buat Daftar Putar Baru",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Disalurkan"),
    "about": MessageLookupByLibrary.simpleMessage("Tentang"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Tambah 5 menit"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Tambahkan ke daftar putar",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Tambahkan ke perpustakaan",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Tambah ke daftar putar",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album ditandai!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Penanda album dihapus!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Album"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Sesuai selera Anda"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Semua bidang wajib diisi",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Belum dites: Memilih kotak centang setelah mengunduh lebih dari 60 file, prosesnya mungkin dapat menghabiskan banyak memori dan bisa menyebabkan perangkat seluler atau aplikasi crash. Lanjutkan dengan risiko Anda sendiri.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage("Informasi Aplikasi"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artis ditandai!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Bookmark artis dihapus!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Deskripsi tidak tersedia!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artis"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "Sesuai selera Anda",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Codec Audio"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("Kode otentikasi"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Masukkan kode 6 digit yang valid atau masuk lagi.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Masukkan kode 6 digit dari aplikasi autentikator Anda. Akses ini berakhir dalam 5 menit.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Otentikasi dua faktor",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Periksa dan lanjutkan",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Terima penggunaan data yang salah...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Kami menghadirkan login, registrasi, dan pemulihan kata sandi dari proyek sebelumnya, yang diadaptasi untuk aplikasi musik ini.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Sesi Anda berada di penyimpanan aman dan divalidasi dengan backend yang sama dengan yang sudah Anda gunakan.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "File .env perlu dikonfigurasi untuk menghubungkan backend otentikasi.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Login"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Daftar"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage("Kirim email"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi Kata Sandi",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Email atau kata sandi salah.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Masukkan email yang valid.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Backend autentikasi tidak ada untuk dikonfigurasi dalam file .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Akun Anda belum diverifikasi.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Operasi tersebut tidak dapat diselesaikan.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Nama depan"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Saya lupa kata sandi saya",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Kami akan mengirimkan petunjuknya ke email akun Anda.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nama@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Nama belakang"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Berhasil masuk",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Tidak mungkin mengirim email.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "Email terkirim.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Akun tidak dapat dibuat.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Akun berhasil dibuat.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Selamat datang di Musik Estrella",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Selamat datang di Musik Estrella",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Unduh otomatis lagu favorit",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Unduh lagu favorit secara otomatis saat ditambahkan ke favorit",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Otomatis membuka layar pemutaran",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Mengaktifkan/menonaktifkan pembukaan otomatis layar pemutaran secara penuh pada pilihan lagu yang akan diputar",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Kembali"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "Database ditemukan",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Pemutaran lagu di latar belakang",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Nyalakan/Matikan pemutaran musik di latar belakang (Aplikasi bisa diakses dari baki sistem ketika aplikasi sedang berjalan di latar belakang)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Cadangan"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Cadangkan data Aplikasi",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Pencadangan diproses...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Cadangan berhasil disimpan!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Pengaturan cadangan dan daftar putar",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Menyimpan semua pengaturan, daftar putar, dan data masuk ke file cadangan",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Anda memerlukan sesi aktif...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Mulai ulang aplikasi",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Unggah cadangan sekarang",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Apakah Anda ingin melakukan pencadangan?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Cadangan dihapus.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Belum ada cadangan...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Cadangan dipulihkan. Mulai ulang aplikasi.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Pilih folder untuk cadangan",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Pilih data mana yang akan dicadangkan",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Cadangan diunggah dengan benar.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Berdasarkan interaksi terakhir",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Daftar hitam daftar putar",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Setel ulang berhasil!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("Oleh"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Buat cache untuk data konten Beranda",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Aktifkan pembuatan cache data konten layar Beranda, layar Beranda bisa memuat lebih cepat jika opsi ini diaktifkan",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Cache lagu"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Menyimpan lagu sementara saat diputar untuk pemutaran di masa depan/offline, ini akan memakan ruang tambahan di perangkat Anda",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("Di-cache/Offline"),
    "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Batalkan pengatur waktu",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Timer tidur dibatalkan",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Bersihkan cache gambar",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Cache gambar telah dibersihkan",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Klik disini untuk menghapus cache dari thumbnail/gambar. (Tidak direkomendasikan kecuali ingin memperbahaui data cache dari gambar)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Menutup"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Tutup Aplikasi"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Perpustakaan awan ditemukan.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Perpustakaan cloud ditemukan. Perangkat ini akan mengunduhnya tanpa menimpanya.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Mode awan sudah siap. Perangkat ini akan berfungsi sebagai cache offline.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Masuk dengan aman menggunakan akun Joss Red Anda.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Akses daftar putar, favorit, dan riwayat Anda dari perangkat apa pun (Windows, Android, dll.) secara instan.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi Cerdas: Bekerja offline dan unggah perubahan secara otomatis saat Anda memulihkan internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Aktifkan sinkronisasi Cloud",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi waktu nyata dengan Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Mode Cloud (Disarankan)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar Kolaboratif",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Pilih teman yang dapat melihat dan mengedit playlist ini:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Kolaborator diperbarui dengan benar.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar Komunitas",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Konten"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026JOSPROX. Lisensi GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Buat"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Buat & Tambah"),
    "customIns": MessageLookupByLibrary.simpleMessage("Mesin Virtual Khusus"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Silakan pilih Instans Khusus",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Penemuan harian"),
    "dark": MessageLookupByLibrary.simpleMessage("Gelap"),
    "delete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Hapus dari unduhan",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Berhasil dihapus dari unduhan!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Dikembangkan dan Dikelola oleh Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Matikan animasi transisi",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Aktifkan opsi ini untuk menonaktifkan animasi transisi antar tab",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Dimatikan"),
    "discover": MessageLookupByLibrary.simpleMessage("Temukan"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Biarkan"),
    "done": MessageLookupByLibrary.simpleMessage("Siap"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Jangan tampilkan info ini lagi",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "file yang terunduh ditemukan",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Unduh"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Unduh lagu dari album",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Lagu yang diminta tidak dapat diunduh karena pembatasan server. Anda bisa mencoba lagi",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Unduhan gagal karena jaringan/stream sedang gangguan! Silakan coba periksa kembali.",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Lokasi download"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Menjaga unduhan musik Anda tetap aktif di latar belakang.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "unduhan musik",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Mempersiapkan unduhan Anda…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Mengunduh musik",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Unduh daftar putar",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Mengunduh Format File",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Pilih format file pengunduhan. \"Opus\" akan memberikan kualitas terbaik",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Unduhan"),
    "duration": MessageLookupByLibrary.simpleMessage("Durasi"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinamis"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar Kosong!",
    ),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Bar navigasi bawah",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Ganti ke bar navigasi bawah",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Aktifkan aksi geser",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Aktifkan aksi geser pada ubin lagu",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Diaktifkan"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage(
      "Akhir dari lagu ini",
    ),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Tambahkan lagu album ke antrean",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Antrikan semua"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Tambahkan lagu ini ke antrian",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Tambahkan lagu ke antrean",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episode"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Ekualizer"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Buka ekualizer sistem",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Terjadi kesalahan"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Kesalahan saat bermain:",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Ekspor"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Ekspor file yang diunduh",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Klik disini untuk mengekspor file yang diunduh dari direktori inApp menuju direktori eksternal",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Kesalahan saat mengekspor daftar putar",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Kesalahan pemformatan data daftar putar",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Perizinan dilarang ketika mengekspor",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Ruang penyimpanan tidak cukup",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Ekspor file telah sukses",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ekspor Daftar Putar",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Ekspor daftar putar sebagai CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat mengimpor ke sini",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Ekspor daftar putar ke JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Format ini dapat diimpor",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "Ekspor ke musik Online",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ini akan mendorong playlist Anda (lagu <50) ke antrian saat ini, jangan lupa untuk menambahkannya ke playlist/simpan setelah membukanya di MusicService",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Lokasi ekspor file yang terunduh",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Mengekspor..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Mengekspor Daftar Putar...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorit"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar yang Difiturkan",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "File tidak ditemukan",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Melanjutkan"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("diikuti"),
    "following": MessageLookupByLibrary.simpleMessage("Mengikuti"),
    "for1": MessageLookupByLibrary.simpleMessage("Untuk"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "favorit yang terlupakan",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Teman"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Permintaan pertemanan diterima",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Permintaan pertemanan terkirim",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Teman-teman"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Masuk untuk mencari teman.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Persahabatan dihapus",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Kesalahan"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Elektronik"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("Latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Batu"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gerakan"),
    "github": MessageLookupByLibrary.simpleMessage("Github"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Lihat kode sumber GitHub \njika anda suka proyek ini, jangan lupa berikan⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Ke album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Klik di sini untuk pergi ke halaman unduh",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Halo dunia"),
    "high": MessageLookupByLibrary.simpleMessage("Tinggi"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL API ke instance yang disalurkan",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Beranda"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Jumlah konten beranda",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Pilih jumlah konten beranda awal (perkiraan). Hasil yang lebih sedikit mempercepat pemuatan",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Id"),
    "identifySongMetadata": MessageLookupByLibrary.simpleMessage(
      "Mengidentifikasi metadata",
    ),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Abaikan pengoptimalan baterai",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Jika Anda menghadapi masalah notifikasi atau pemutaran dihentikan karena pengoptimalan sistem, aktifkan opsi ini",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Kesalahan saat mengimpor daftar putar",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Kesalahan menyimpan ke database",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat mengakses file yang dipilih",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "format file tidak valid",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Catatan: Daftar putar berukuran besar mungkin akan memakan waktu lama saat mengimpor",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Impor Daftar Putar",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Pilih file JSON daftar putar yang diekspor sebelumnya untuk diimpor",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Diimpor"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Diimpor dari Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Daftar putar yang diimpor",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Mengimpor daftar putar...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Direktori penyimpanan internal",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Sertakan file lagu-lagu yang diunduh",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informasi tidak tersedia",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "struktur file daftar putar tidak valid",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Respons server tidak valid.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "Sesi ini tidak berisi token yang valid.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("Item"),
    "keepListening": MessageLookupByLibrary.simpleMessage("terus mendengarkan"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Pertahankan layar tetap hidup saat memutar",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Jika diaktifkan, layar perangkat akan tetap menyala saat musik sedang diputar",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Bahasa"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Setel bahasa Aplikasi",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Rilis terbaru"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Versi Terbaru Tersedia",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Mari mulai.."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Pustaka Album"),
    "libArtists": MessageLookupByLibrary.simpleMessage("Pustaka Artis"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Pustaka Daftar Putar",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Pustaka Lagu"),
    "library": MessageLookupByLibrary.simpleMessage("Pustaka"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar Perpustakaan",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Terang"),
    "link": MessageLookupByLibrary.simpleMessage("Tautan"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Berhasil ditautkan!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Tautan disalin ke papan klip",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Tautan dengan saluran untuk daftar putar",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Dengarkan sekarang"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Mendengarkan lingkungan...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memuat informasi pembaruan",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Lokal"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Ini berfungsi tanpa perlu masuk.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Seluruh perpustakaan Anda tetap ada di komputer ini.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Catatan: Tidak ada pencadangan cloud manual. Jika Anda kehilangan perangkat atau mencopot pemasangan aplikasi, data Anda tidak dapat dipulihkan.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Gunakan hanya di perangkat ini",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Privasi mutlak di perangkat Anda",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Modus Lokal"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Kekerasan Suara dB"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisasi kekerasan suara",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Atur level kekerasan suara yang sama untuk semua lagu (Eksperimental) (Tidak akan berfungsi pada lagu yang diunduh di versi sebelumnya (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Rendah"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Surat"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Lirik tidak tersedia!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Kelola kolaborator (teman)",
    ),
    "metadataApplySuccess": MessageLookupByLibrary.simpleMessage(
      "Metadata tertanam dalam berkas lokal.",
    ),
    "metadataNoResults": MessageLookupByLibrary.simpleMessage(
      "Tak ada yang cocok. Cobalah pencarian yang berbeda.",
    ),
    "metadataOperationFailed": MessageLookupByLibrary.simpleMessage(
      "Operasi metadata gagal.",
    ),
    "metadataOverwriteWarning": MessageLookupByLibrary.simpleMessage(
      "Ini akan menimpa judul, artis, dan sampul yang tertanam saat mempertahankan ruas yang cocok tidak menyediakan.",
    ),
    "metadataSearchDescription": MessageLookupByLibrary.simpleMessage(
      "Pilih yang benar untuk memasukkan judul, artis, album, dan sampul dalam berkas lokal.",
    ),
    "metadataSearchHint": MessageLookupByLibrary.simpleMessage(
      "Nama artis atau lagu",
    ),
    "metadataSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Identifikasi lagu",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Pastikan musik diputar cukup keras di dekat mikrofon Anda.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage(
      "Album yang dimigrasi",
    ),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Perpustakaan yang dimigrasi",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar yang Dimigrasi",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Sudah ada migrasi yang sedang berlangsung.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Menganalisis perpustakaan lokal...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Memeriksa apakah EMusic Cloud sudah memiliki perpustakaan...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migrasi selesai.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Membuat cadangan lokal sebelum menghubungkan cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Migrasi gagal. Data lokal Anda tidak diubah.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Masuk ke Joss Red sebelum bermigrasi.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Mempersiapkan migrasi di EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud tidak dapat memulai migrasi.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Tidak semua data dapat diunggah. Kami menjaga dukungan lokal Anda.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Mengunggah daftar putar, favorit, dan riwayat...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud tidak dapat memvalidasi migrasi.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Memverifikasi integritas di EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Pilih file dan impor",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Pilih song.db atau cadangan .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migrasi berhasil diselesaikan.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("menit"),
    "misc": MessageLookupByLibrary.simpleMessage("Lain-lain"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "Lagu yang paling banyak didengarkan",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musik & Pemutaran",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Pengenalan Musik",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Jaringan bermasalah! Periksa koneksi jaringan anda.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Ups, ada kesalahan jaringan!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Versi baru tersedia!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplikasi Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Dipahami"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Web Merah"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi 100% dengan Joss Red, playlist dengan teman, dan banyak lagi. Ketuk untuk melihat apa yang baru.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Musik Estrella telah berevolusi!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Untuk menambah teman, menerima permintaan, atau mengelola profil keamanan Anda, silakan gunakan Joss Red di platform resminya:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Teman dan Manajemen Akun:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Berita Musik Estrella",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Buat daftar putar dengan teman-teman Anda! Saat membuat daftar putar, pilih kotak centang Kolaboratif dan pilih teman Anda untuk diedit bersama.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar Kolaboratif",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Daftar putar dan favorit Anda kini disimpan dan disinkronkan di cloud secara otomatis dengan akun utama Joss Red Anda.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integrasi Penuh dengan Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Anda tidak perlu lagi mengklik tombol sinkronisasi manual; Motor baru bertanggung jawab untuk berpindah ke atas dan ke bawah secara otomatis.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi Transparan",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Tidak"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Tidak ada penanda!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Anda tidak memiliki teman tambahan di Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Anda tidak memiliki pustaka daftar putar!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menemukan lagu apa pun dalam rekaman audio",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Tidak Ada Kecocokan",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Tidak ada lagu offline!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Tidak ada lagu dalam koleksi ini",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Tidak ditemukan kecocokan untuk",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Tidak diautentikasi",
    ),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Bukan Lagu/Video Musik!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Bukan tautan yang valid!",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Buka di"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operasi gagal"),
    "password": MessageLookupByLibrary.simpleMessage("Sandi"),
    "password_text": MessageLookupByLibrary.simpleMessage("Kata sandi"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("Izin ditolak"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Mengizinkan"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music memerlukan izin ini untuk mengelola musik Anda dan menawarkan semua fitur pemutaran.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Izin untuk memulai",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Berikan izin yang diperlukan",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Ini hanya digunakan ketika Anda memilih untuk mengidentifikasi lagu yang diputar di sekitar Anda.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Mikropon",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Menampilkan kontrol pemutaran, kemajuan pengunduhan, dan pemberitahuan aplikasi penting.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Pemberitahuan",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Pengaturan",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Ketiga izin tersebut diperlukan untuk melanjutkan. Anda dapat mengubahnya nanti di pengaturan sistem.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Ini memungkinkan Anda memutar musik, menyimpan unduhan, mengekspor daftar putar, dan menyiapkan pembaruan.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musik dan penyimpanan",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalisasi"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar yang Disalurkan",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar putar yang disalurkan tersinkronkan!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Polos"),
    "play": MessageLookupByLibrary.simpleMessage("Mainkan"),
    "playNext": MessageLookupByLibrary.simpleMessage("Putar berikutnya"),
    "playNow": MessageLookupByLibrary.simpleMessage("Mainkan Sekarang"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Kecepatan pemutaran",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Antarmuka Pengguna"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Pilih antarmuka pengguna",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Bermain:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "MEMUTAR LAGU DARI ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "MEMUTAR LAGU DARI ARTIS",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "MEMUTAR LAGU DARI DAFTAR PUTAR",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "MEMUTAR LAGU YANG DI-SELEKSI",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Daftar putar"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar putar masuk daftar hitam!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar putar ditandai!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Bookmark daftar putar dihapus!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Kontributor daftar putar",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar dibuat!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar dibuat & lagu ditambahkan!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar sukses diekspor ke",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Daftar putar sukses diimpor",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Daftar Putar di hapus!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Berhasil mengganti nama!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Daftar Putar"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Selanjutnya"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcast"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Lagu populer"),
    "processFiles": MessageLookupByLibrary.simpleMessage("Memproses file..."),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Memproses audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profil"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Ulangi Antrean"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "Mode ulangi antrean tidak dapat dinonaktifkan saat mode acak diaktifkan.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "Mode ulangi antrean tidak dapat diaktifkan dalam mode radio.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Antrian tidak bisa diacak ketika mode acak diaktifkan",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "Antrian tidak bisa diatur ulang ketika mode acak diaktifkan",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Seleksi cepat"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Pilihan Cepat"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio tidak tersedia untuk artis ini!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Radio acak"),
    "randomSelection": MessageLookupByLibrary.simpleMessage("Pilihan acak"),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Menyusun ulang daftar putar",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Atur ulang lagu"),
    "readMore": MessageLookupByLibrary.simpleMessage("Baca selengkapnya"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("Pencarian terkini"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Baru Dimainkan"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Kami merekomendasikan untuk mengaktifkan Mode Cloud untuk pengalaman seperti Spotify: sinkronisasi waktu nyata antara semua perangkat Anda dan pencadangan otomatis tanpa Anda harus melakukan apa pun.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage(
      "Direkomendasikan",
    ),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage(
      "Direkomendasikan",
    ),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("Hapus dari cache"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Hapus dari Pustaka Lagu",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Hapus dari perpustakaan",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Hapus dari daftar putar",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Hapus dari antrian",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Hapus beberapa lagu",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Hapus Daftar Putar",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Ganti Nama"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Ganti Nama Daftar Putar",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Direproduksi oleh"),
    "reset": MessageLookupByLibrary.simpleMessage("Setel ulang"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Kembalikan pengaturan ke semula",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Setel ulang pengaturan aplikasi ke semula (Diperlukan restart)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Pengaturan telah direset ke semula, silakan restart aplikasi",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Setel ulang daftar putar yang masuk daftar hitam",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Setel ulang semua daftar putar yang masuk daftar hitam",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Mulai ulang Aplikasi"),
    "restore": MessageLookupByLibrary.simpleMessage("Pulihkan"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Pulihkan data Aplikasi",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Pulihkan sesi pemutaran terakhir",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Secara otomatis memulihkan sesi pemutaran terakhir saat aplikasi dibuka",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Berhasil dipulihkan!\nPerubahan akan diterapkan setelah dimulai ulang",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Pulihkan pengaturan dan daftar putar",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Pulihkan semua pengaturan, data masuk, dan daftar putar dari file cadangan. Akan menimpa seluruh data saat ini",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Pilih file cadangan",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Memulihkan..."),
    "results": MessageLookupByLibrary.simpleMessage("Hasil"),
    "retry": MessageLookupByLibrary.simpleMessage("Coba Lagi!"),
    "save": MessageLookupByLibrary.simpleMessage("Menyimpan"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Disimpan"),
    "scanning": MessageLookupByLibrary.simpleMessage("Memindai..."),
    "search": MessageLookupByLibrary.simpleMessage("Cari"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Lagu, Daftar Putar, Album atau Artis",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Cari di Perpustakaan",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Hasil pencarian"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Pencarian terkini",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Pilih semua"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("Pilih Instans Auth"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Silakan pilih Contoh autentikasi!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Pilih File"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Pilih lagu"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "File yang dipilih tidak ditemukan.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Sesi Anda telah berakhir. Masuk lagi.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Tetapkan konten yang dapat ditemukan",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Tentang Musik Estrella",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versi, proyek sumber terbuka, dan GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Akun dan Sinkronisasi",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Mode cloud, pencadangan, daftar teman, dan migrasi.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Animasi tema, bahasa, dan antarmuka.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Cadangan awan",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Unggah, pulihkan, dan kelola...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Unggah cadangan aplikasi .hmb ke server dan, jika perlu, pulihkan cadangan yang disimpan.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Temukan filter, integrasi dengan Piped dan cache.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Unduhan dan Penyimpanan",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Format audio, folder dan unduhan otomatis.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Umum"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Pilih, migrasikan, atau tinjau status sinkronisasi dengan Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Mode Lokal / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Keluar"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Impor daftar putar, lagu...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Bermigrasi dari Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage(
      "teman-teman saya",
    ),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Kelola teman Joss Red Anda secara langsung.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Kualitas streaming, normalisasi, senyap, dan baterai.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Buat ulang ID Online Music Anda jika konten Discover tidak dapat dimuat.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Segarkan ID (ID Pengunjung)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Kesalahan"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Pengidentifikasi baru tidak dapat dibuat. Silakan coba lagi nanti.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Pengidentifikasi yang diperbarui",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "ID Pengunjung baru berhasil dibuat.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Bagikan album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Bagikan daftar putar",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Bagikan lagu ini"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Mencari kecocokan di database Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Acak"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage("Acak Antrean"),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Single"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Lewati keheningan"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Keheningan akan dilewati dalam pemutaran musik",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Timer tidur Anda telah diatur",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Pengatur Waktu Tidur"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Lagu ditambahkan ke daftar putar!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Lagu sudah ada!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Lagu sudah offline di cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Lagu masuk dalam antrean!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Lagu Ditemukan!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Info Lagu"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Lagu ini tidak dapat diputar karena pembatasan server!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("nada lagu"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Dihapus dari"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Dihapus dari antrean!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Anda tidak dapat menghapus lagu yang sedang diputar",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Lagu"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Lagu diimpor dari Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Urutkan naik/turun",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan tanggal",
    ),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan durasi",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan nama",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage(
      "Kecepatan dan Pitch",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standar"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Mulai radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("Buka saat startup"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Pilih bagian yang pertama kali dibuka oleh Estrella Music",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Hentikan musik saat tugas selesai",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "Pemutaran musik akan berhenti ketika Aplikasi dihapus dari pengelola tugas",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Kualitas streaming",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Kualitas streaming musik",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("pelanggan"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Geser untuk menjelajahi opsi ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Mode awan diaktifkan. Mengunduh perpustakaan yang ada.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Mode awan diaktifkan. Perpustakaan yang dimigrasi.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Mode awan aktif",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Mode awan aktif. Sinkronisasi tertunda.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Gagal mengunduh sinkronisasi.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Mengunduh perubahan EMusic...",
    ),
    "syncForceReplaceBackupSaved": m12,
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las playlist, favoritos, historial, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Remota musikal Reemplazar la biblioteca?",
    ),
    "syncForceReplaceCountMismatch": MessageLookupByLibrary.simpleMessage(
      "Jumlah yang diunggah tidak cocok dengan perpustakaan lokal. Pengganti jarak jauh tidak dapat dikonfirmasi.",
    ),
    "syncForceReplaceCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Membuat backup pemulihan sebelum mengganti data awan...",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa laầronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceFailed": MessageLookupByLibrary.simpleMessage(
      "Awan EMusic tidak dapat menggantikan pustaka jarak jauh.",
    ),
    "syncForceReplaceFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "Pengganti remote gagal. Data lokal dan bala bantuan pemulihanmu dijaga.",
    ),
    "syncForceReplaceFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Upload tidak selesai",
    ),
    "syncForceReplaceInProgress": MessageLookupByLibrary.simpleMessage(
      "Menahan sinkronisasi, membuat cadangan, dan mengunggah pustaka lokal...",
    ),
    "syncForceReplacePauseFailed": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi saat ini tidak dapat diistirahatkan dengan aman. Coba lagi sebentar lagi.",
    ),
    "syncForceReplaceSuccess": MessageLookupByLibrary.simpleMessage(
      "Pustaka musik jauh diganti dengan data perangkat saat ini.",
    ),
    "syncForceReplaceSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Upload selesai",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Basis Cancelar;ronización y subir esta",
    ),
    "syncForceReplaceValidating": MessageLookupByLibrary.simpleMessage(
      "Validasi perpustakaan upload sebelum mengganti data awan...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Perpustakaan yang disinkronkan.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Perpustakaan terkini.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Ada perubahan lokal baru. Mereka akan diunggah sebelum diunduh.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Data Anda hanya disimpan di perangkat ini.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Mode lokal aktif",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Luring. Perubahan masih menunggu keputusan.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Luring. Perubahan disimpan untuk dicoba lagi.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sinkronkan lagu daftar putar",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic tidak mengkonfirmasi semua perubahan tersebut. Mereka akan diadili ulang.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Tidak bisa bangun. Ini akan dicoba lagi nanti.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Perubahan diunggah dengan benar.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Perubahan berhasil diunggah (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat mengunggah menggunakan WS. Ini akan dicoba lagi nanti.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Mengunggah perubahan ke EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Tersinkronkan"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "lirik yang tersinkron tidak ada!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Bawaan sistem"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Mode Tema"),
    "title": MessageLookupByLibrary.simpleMessage("Judul"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage("Video musik teratas"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage(
      "Video Musik Teratas",
    ),
    "trending": MessageLookupByLibrary.simpleMessage("Sedang tren"),
    "unLink": MessageLookupByLibrary.simpleMessage("Putuskan tautan"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Tautan berhasil dibatalkan!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Lagu tanpa judul"),
    "upNext": MessageLookupByLibrary.simpleMessage("Selanjutnya"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Perbarui Aplikasi"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "Url terdeteksi, klik untuk membuka/memutar konten terkait",
    ),
    "useThisMetadata": MessageLookupByLibrary.simpleMessage(
      "Gunakan metadata ini",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage(
      "Pengguna yang diblokir",
    ),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "Responsnya tidak berisi daftar pengguna.",
    ),
    "userSearchFailed": m13,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Pengguna tidak terkunci",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nama belakang"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "videos": MessageLookupByLibrary.simpleMessage("Video"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Lihat semua"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Lihat Artis"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Kami telah memodernisasi platform kami. Sistem lama yang mengunggah cadangan manual telah dinonaktifkan. Anda sekarang memiliki dua cara yang jelas untuk mengelola perpustakaan musik Anda.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Pilih bagaimana Anda ingin menikmati Estrella Music mulai sekarang.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Musik Anda, cara Anda",
    ),
  };
}
