import 'dart:io';

class DownloadIntegrityService {
  static const int minimumAudioBytes = 4096;

  static String? pathFromRecord(dynamic record) {
    if (record is! Map) return null;
    final rawPath = record['url']?.toString().trim();
    if (rawPath == null || rawPath.isEmpty) return null;
    return rawPath.startsWith('file:')
        ? Uri.tryParse(rawPath)?.toFilePath()
        : rawPath;
  }

  static int expectedSizeFromRecord(dynamic record) {
    if (record is! Map) return 0;
    final streamInfo = record['streamInfo'];
    if (streamInfo is! List || streamInfo.length < 2 || streamInfo[1] is! Map) {
      return 0;
    }
    final value = streamInfo[1]['size'];
    return value is int ? value : int.tryParse('$value') ?? 0;
  }

  static Future<bool> isValidRecord(dynamic record) async {
    final path = pathFromRecord(record);
    if (path == null) return false;
    return isPlausibleAudioFile(
      File(path),
      expectedSize: expectedSizeFromRecord(record),
    );
  }

  static Future<bool> isPlausibleAudioFile(
    File file, {
    int expectedSize = 0,
  }) async {
    try {
      if (!await file.exists()) return false;
      final length = await file.length();
      if (length < minimumAudioBytes) return false;
      if (expectedSize > 0 && length < (expectedSize * 0.85).floor()) {
        return false;
      }

      final bytes = await file.openRead(0, 16).fold<List<int>>(
        <int>[],
        (buffer, chunk) => buffer..addAll(chunk),
      );
      return _hasKnownAudioContainer(bytes);
    } catch (_) {
      return false;
    }
  }

  static bool _hasKnownAudioContainer(List<int> bytes) {
    if (bytes.length < 4) return false;
    final isOgg = _ascii(bytes, 0, 'OggS');
    final isMp4 = bytes.length >= 8 && _ascii(bytes, 4, 'ftyp');
    final isWebM = bytes[0] == 0x1A &&
        bytes[1] == 0x45 &&
        bytes[2] == 0xDF &&
        bytes[3] == 0xA3;
    final isId3 = _ascii(bytes, 0, 'ID3');
    final isMpegOrAac = bytes[0] == 0xFF && (bytes[1] & 0xE0) == 0xE0;
    return isOgg || isMp4 || isWebM || isId3 || isMpegOrAac;
  }

  static bool _ascii(List<int> bytes, int offset, String value) {
    if (bytes.length < offset + value.length) return false;
    for (var index = 0; index < value.length; index++) {
      if (bytes[offset + index] != value.codeUnitAt(index)) return false;
    }
    return true;
  }
}
