import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Estados posibles del proceso de descarga/instalación.
enum DownloadState { idle, downloading, done, installing, error }

class UpdateController extends GetxController {
  final updateInfo = Rxn<Map<String, dynamic>>();
  final isLoading = true.obs;
  final error = ''.obs;

  // — Descarga —
  final downloadProgress = 0.0.obs;
  final downloadState = DownloadState.idle.obs;
  final downloadError = ''.obs;

  String? _localFilePath;

  final _notifications = FlutterLocalNotificationsPlugin();

  // ──────────────────────────────────────────────
  // Ciclo de vida
  // ──────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
    fetchUpdateInfo();
  }

  Future<void> _initNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
    );
    await _notifications.initialize(initSettings);
  }

  // ──────────────────────────────────────────────
  // Datos de actualización
  // ──────────────────────────────────────────────

  Future<void> fetchUpdateInfo() async {
    try {
      isLoading(true);
      error('');

      final String? checkUpdates = dotenv.env['UPDATE_CHECK_URL'];
      if (checkUpdates == null) {
        error('Update check URL not found in .env');
        return;
      }

      final dio = Dio();
      final response = await dio.get(checkUpdates);

      if (response.statusCode == 200) {
        updateInfo.value = Map<String, dynamic>.from(response.data as Map);
      } else {
        error('Error fetching update info: ${response.statusCode}');
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // ──────────────────────────────────────────────
  // URLs y nombres por plataforma
  // ──────────────────────────────────────────────

  /// Extrae la URL de descarga correcta según la plataforma actual.
  /// Usa el campo [Descarga] de la API como base para derivar el path de releases.
  String? get platformDownloadUrl {
    final data = updateInfo.value;
    if (data == null) return null;

    final baseUrl = _extractDownloadBase(data['Descarga'] as String?);
    if (baseUrl == null) return null;

    if (GetPlatform.isAndroid) {
      return '${baseUrl}EstrellaMusic-android-universal.apk';
    }
    if (GetPlatform.isWindows) {
      return '${baseUrl}EstrellaMusic-windows-installer.exe';
    }
    if (GetPlatform.isLinux) return '${baseUrl}EstrellaMusic-linux-x64.tar.gz';
    if (GetPlatform.isMacOS) return '${baseUrl}EstrellaMusic-macos.zip';

    // iOS: la URL original sirve para abrir la guía de instalación
    return data['Descarga'] as String?;
  }

  /// Nombre del archivo que se descargará en la plataforma actual.
  String get platformFileName {
    if (GetPlatform.isAndroid) return 'EstrellaMusic-android-universal.apk';
    if (GetPlatform.isWindows) return 'EstrellaMusic-windows-installer.exe';
    if (GetPlatform.isLinux) return 'EstrellaMusic-linux-x64.tar.gz';
    if (GetPlatform.isMacOS) return 'EstrellaMusic-macos.zip';
    return 'EstrellaMusic';
  }

  /// Etiqueta legible del botón de acción principal según plataforma.
  String get platformActionLabel {
    if (GetPlatform.isIOS) return 'Guía de instalación iOS';
    if (GetPlatform.isLinux || GetPlatform.isMacOS) {
      return 'Descargar desde GitHub';
    }
    return 'Actualizar';
  }

  /// Devuelve el directorio base de GitHub Releases terminado en '/'.
  /// Ejemplo: https://github.com/josprox/Estrella-Music/releases/latest/download/
  String? _extractDownloadBase(String? rawUrl) {
    if (rawUrl == null) return null;
    try {
      final uri = Uri.parse(rawUrl);
      final segments = uri.pathSegments.toList();
      final idx = segments.indexOf('download');
      if (idx < 0) return '$rawUrl/';
      final base = uri.replace(pathSegments: segments.sublist(0, idx + 1));
      return '${base.toString()}/';
    } catch (_) {
      return null;
    }
  }

  // ──────────────────────────────────────────────
  // Acción principal según plataforma
  // ──────────────────────────────────────────────

  Future<void> startUpdate() async {
    // Android e iOS → abre el navegador o tienda de aplicaciones
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      final data = updateInfo.value;
      final url = data?['Descarga'] as String? ??
          'https://github.com/josprox/Estrella-Music/releases/latest';
      await _openBrowser(url);
      return;
    }

    // Linux / macOS → descarga desde el navegador
    if (GetPlatform.isLinux || GetPlatform.isMacOS) {
      final url = platformDownloadUrl;
      if (url != null) await _openBrowser(url);
      return;
    }

    // Windows → descarga dentro de la app
    await _downloadInApp();
  }

  /// Lanza la instalación del archivo ya descargado (Windows).
  Future<void> installUpdate() async {
    if (_localFilePath == null) return;

    try {
      downloadState.value = DownloadState.installing;

      if (GetPlatform.isWindows) {
        // En Windows ejecutamos directamente el .exe descargado
        await Process.start(
          _localFilePath!,
          [],
          runInShell: false,
          mode: ProcessStartMode.detached,
        );
        downloadState.value = DownloadState.idle;
      }
    } catch (e) {
      downloadError(e.toString());
      downloadState.value = DownloadState.error;
    }
  }

  /// Reinicia el estado de descarga para permitir reintentar.
  void retryDownload() {
    downloadState.value = DownloadState.idle;
    downloadError('');
    downloadProgress.value = 0.0;
    _localFilePath = null;
  }

  // ──────────────────────────────────────────────
  // Descarga in-app (Android y Windows)
  // ──────────────────────────────────────────────

  Future<void> _downloadInApp() async {
    final url = platformDownloadUrl;
    if (url == null) {
      downloadError('URL de descarga no disponible.');
      downloadState.value = DownloadState.error;
      return;
    }

    try {
      downloadState.value = DownloadState.downloading;
      downloadProgress.value = 0.0;
      downloadError('');

      // Elegir directorio de guardado
      final Directory saveDir;
      if (GetPlatform.isAndroid) {
        // Android permite escribir aquí sin pedir almacenamiento: es el
        // directorio externo privado de la app.
        saveDir = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      } else {
        saveDir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${saveDir.path}/$platformFileName';
      _localFilePath = filePath;

      final dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            downloadProgress.value = received / total;
          }
        },
      );

      downloadState.value = DownloadState.done;

      // Notificación al terminar en Android
      if (GetPlatform.isAndroid) {
        await _showDownloadCompleteNotification();
      }
    } on DioException catch (e) {
      downloadError('Error de red: ${e.message}');
      downloadState.value = DownloadState.error;
    } catch (e) {
      downloadError(e.toString());
      downloadState.value = DownloadState.error;
    }
  }

  // ──────────────────────────────────────────────
  // Notificaciones
  // ──────────────────────────────────────────────

  Future<void> _showDownloadCompleteNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'em_update_channel',
      'Actualizaciones de Estrella Music',
      channelDescription:
          'Notifica cuando hay una actualización lista para instalar',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
    );
    const notifDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(
      1001,
      '¡Actualización lista!',
      'Toca "Instalar" en la app para completar la actualización de Estrella Music.',
      notifDetails,
    );
  }

  // ──────────────────────────────────────────────
  // Helpers
  // ──────────────────────────────────────────────

  Future<void> _openBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
