import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateService {
  static Future<bool> checkForUpdate() async {
    try {
      final String? checkUpdates = dotenv.env["UPDATE_CHECK_URL"];
      if (checkUpdates == null) {
        if (kDebugMode) print("Update check URL not found in .env");
        return false;
      }

      final dio = Dio();
      final response = await dio.get(checkUpdates);
      
      if (response.statusCode != 200) return false;

      final data = response.data;
      if (data == null || data['Version'] == null) return false;
      
      String latestVersion = data['Version'].toString();

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      if (kDebugMode) {
        print("Checking updates: Latest=$latestVersion, Current=$currentVersion");
      }

      return _isVersionGreater(latestVersion, currentVersion);
    } catch (e) {
      if (kDebugMode) print("Error checking updates: $e");
      return false;
    }
  }

  static bool _isVersionGreater(String latestVersion, String currentVersion) {
    // Limpiar strings: quitar 'v', espacios y separar por '.'
    List<String> latestParts = latestVersion.toLowerCase().replaceAll('v', '').split('.');
    List<String> currentParts = currentVersion.toLowerCase().replaceAll('v', '').split('.');

    // Normalizar longitudes (ej: 1.0 vs 1.0.1 -> 1.0.0 vs 1.0.1)
    while (latestParts.length < currentParts.length) {
      latestParts.add('0');
    }
    while (currentParts.length < latestParts.length) {
      currentParts.add('0');
    }

    for (int i = 0; i < latestParts.length; i++) {
      // Extraer solo números de cada parte (por si hay +63 o texto adicional)
      int latestPart = int.tryParse(latestParts[i].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      int currentPart = int.tryParse(currentParts[i].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

      if (latestPart > currentPart) return true;
      if (latestPart < currentPart) return false;
    }
    return false;
  }
}
