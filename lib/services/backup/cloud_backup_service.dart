import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

class CloudBackupFile {
  CloudBackupFile({
    required this.appName,
    required this.fileName,
    required this.fileId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  final dynamic id;
  final String appName;
  final String fileName;
  final String fileId;
  final String? createdAt;
  final String? updatedAt;

  factory CloudBackupFile.fromJson(Map<String, dynamic> json) {
    return CloudBackupFile(
      id: json['id'],
      appName: json['app_name']?.toString() ?? '',
      fileName: json['file_name']?.toString() ?? json['name']?.toString() ?? '',
      fileId: json['file_id']?.toString() ?? '',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  DateTime? get createdAtDate {
    // 1. Intentar parsear el campo created_at del servidor
    if (createdAt != null) {
      final parsed = DateTime.tryParse(createdAt!);
      if (parsed != null) return parsed;
    }

    // 2. Fallback: extraer la fecha del nombre del archivo
    // Soporta el formato propio: estrellamusic_2024-05-08T143022123456.hmb
    // y patrones genéricos como: backup_20240508_143022.dat
    final name = fileIdFileName.isNotEmpty ? fileIdFileName : fileName;

    // Patrón ISO reducido: YYYY-MM-DDTHH (ej: 2024-05-08T143022)
    final isoPattern = RegExp(r'(\d{4})-(\d{2})-(\d{2})T(\d{2})(\d{2})(\d{2})');
    final isoMatch = isoPattern.firstMatch(name);
    if (isoMatch != null) {
      return DateTime.tryParse(
        '${isoMatch.group(1)}-${isoMatch.group(2)}-${isoMatch.group(3)}'
        'T${isoMatch.group(4)}:${isoMatch.group(5)}:${isoMatch.group(6)}',
      );
    }

    // Patrón compacto: YYYYMMDD_HHmmss o YYYYMMDD-HHmmss
    final compactPattern =
        RegExp(r'(\d{4})(\d{2})(\d{2})[_\-T](\d{2})(\d{2})(\d{2})');
    final compactMatch = compactPattern.firstMatch(name);
    if (compactMatch != null) {
      return DateTime.tryParse(
        '${compactMatch.group(1)}-${compactMatch.group(2)}-${compactMatch.group(3)}'
        'T${compactMatch.group(4)}:${compactMatch.group(5)}:${compactMatch.group(6)}',
      );
    }

    // Patrón solo fecha: YYYYMMDD
    final dateOnlyPattern = RegExp(r'(\d{4})(\d{2})(\d{2})');
    final dateOnlyMatch = dateOnlyPattern.firstMatch(name);
    if (dateOnlyMatch != null) {
      return DateTime.tryParse(
        '${dateOnlyMatch.group(1)}-${dateOnlyMatch.group(2)}-${dateOnlyMatch.group(3)}',
      );
    }

    return null;
  }

  List<String> get _fileIdParts => fileId
      .split('/')
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .toList();

  String get fileIdAppName {
    if (_fileIdParts.length >= 2) {
      return _fileIdParts[_fileIdParts.length - 2];
    }
    return '';
  }

  String get fileIdFileName {
    if (_fileIdParts.isNotEmpty) {
      return _fileIdParts.last;
    }
    return '';
  }
}

class CloudBackupService extends GetxService {
  static const defaultAppName = 'estrellamusic_backup';
  static const legacyMusicAppName = 'jossmusic_backup';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      validateStatus: (_) => true,
    ),
  );

  AuthService get _authService => Get.find<AuthService>();

  String _normalizedBaseUrl() {
    var base = _authService.baseUrl?.trim() ?? '';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    return '$base/';
  }

  Future<Map<String, String>> _headers() async {
    final token = await _authService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw StateError('Tu sesión expiró. Vuelve a iniciar sesión.');
    }
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  Future<List<CloudBackupFile>> listBackups({
    String appName = defaultAppName,
  }) async {
    final response = await _dio.get(
      '${_normalizedBaseUrl()}api/listfiles',
      options: Options(headers: await _headers()),
    );

    if (response.statusCode != 200) {
      throw StateError('No fue posible consultar los backups en la nube.');
    }

    final data = response.data;
    final files = data is Map ? (data['files'] as List? ?? const []) : const [];
    final backups = files
        .whereType<Map>()
        .map((raw) => CloudBackupFile.fromJson(
              raw.map((key, value) => MapEntry(key.toString(), value)),
            ))
        .where((backup) => backup.appName == appName)
        .toList();

    backups.sort((a, b) {
      final aDate = a.createdAtDate;
      final bDate = b.createdAtDate;
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return bDate.compareTo(aDate);
    });

    return backups;
  }

  Future<void> uploadBackupBytes({
    required Uint8List bytes,
    required String fileName,
    String appName = defaultAppName,
  }) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes, filename: fileName),
    });

    final response = await _dio.post(
      '${_normalizedBaseUrl()}api/backup/$appName',
      data: formData,
      options: Options(headers: await _headers()),
    );

    if (response.statusCode == 200) {
      // Actualizar el timestamp para el control de frecuencia (4h/12h)
      final appPrefs = SqliteStore.box('AppPrefs');
      await appPrefs.put(
          'last_cloud_backup_timestamp', DateTime.now().toIso8601String());
    } else {
      throw StateError('No fue posible subir el backup a la nube.');
    }
  }

  Future<Uint8List> downloadBackupBytes(CloudBackupFile backup) async {
    final attempts = <({String appName, String fileName})>[];
    final pathAppName = backup.fileIdAppName;
    final pathFileName = backup.fileIdFileName;

    if (pathAppName.isNotEmpty && pathFileName.isNotEmpty) {
      attempts.add((appName: pathAppName, fileName: pathFileName));
    }
    if (backup.appName.trim().isNotEmpty &&
        backup.fileName.trim().isNotEmpty &&
        (backup.appName.trim() != pathAppName ||
            backup.fileName.trim() != pathFileName)) {
      attempts.add((
        appName: backup.appName.trim(),
        fileName: backup.fileName.trim(),
      ));
    }

    if (attempts.isEmpty) {
      throw StateError('El backup no trae una ruta valida para descargarse.');
    }

    DioException? lastNetworkError;
    int? lastStatusCode;
    String? lastUrl;
    String? lastBodyPreview;

    for (final attempt in attempts) {
      final encodedFileName = Uri.encodeComponent(attempt.fileName);
      final url =
          '${_normalizedBaseUrl()}api/backup/${attempt.appName}/$encodedFileName';
      try {
        final response = await _dio.get<List<int>>(
          url,
          options: Options(
            headers: await _headers(),
            responseType: ResponseType.bytes,
          ),
        );

        if (response.statusCode == 200 && response.data != null) {
          return Uint8List.fromList(response.data!);
        }

        lastStatusCode = response.statusCode;
        lastUrl = url;
        lastBodyPreview = _bodyPreview(response.data);
      } on DioException catch (e) {
        lastNetworkError = e;
        lastStatusCode = e.response?.statusCode;
        lastUrl = url;
        lastBodyPreview = _bodyPreview(e.response?.data);
      }
    }

    printERROR(
      'Fallo al descargar backup. status=$lastStatusCode url=$lastUrl body=$lastBodyPreview error=${lastNetworkError?.message}',
    );

    if (lastNetworkError != null) {
      throw StateError(
        'No fue posible descargar el backup seleccionado (${lastStatusCode ?? 'sin status'}).',
      );
    }
    throw StateError(
      'No fue posible descargar el backup seleccionado (${lastStatusCode ?? 'sin status'}).',
    );
  }

  Future<void> deleteBackup(CloudBackupFile backup) async {
    if (backup.id == null) {
      throw StateError('Este backup no puede eliminarse porque no trae id.');
    }

    final response = await _dio.delete(
      '${_normalizedBaseUrl()}api/backup/${backup.id}',
      options: Options(headers: await _headers()),
    );

    if (response.statusCode != 200) {
      throw StateError('No fue posible eliminar el backup.');
    }
  }

  String _bodyPreview(dynamic data) {
    if (data == null) {
      return 'null';
    }
    if (data is List<int>) {
      final decoded = utf8.decode(data, allowMalformed: true).trim();
      if (decoded.isEmpty) {
        return '<bytes:${data.length}>';
      }
      return decoded.length > 180 ? '${decoded.substring(0, 180)}...' : decoded;
    }
    final text = data.toString().trim();
    if (text.isEmpty) {
      return '<empty>';
    }
    return text.length > 180 ? '${text.substring(0, 180)}...' : text;
  }
}
