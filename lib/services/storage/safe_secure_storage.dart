import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Un envoltorio seguro alrededor de [FlutterSecureStorage] para prevenir cierres
/// inesperados de la aplicación provocados por corrupción o fallos en las llaves
/// de almacenamiento del sistema operativo (Android Keystore, Windows DPAPI, etc.).
class SafeSecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Lee un valor de forma segura. Si ocurre una excepción de plataforma,
  /// la captura, registra el log y retorna null.
  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e, stack) {
      debugPrint('[SafeSecureStorage] Error leyendo clave "$key": $e');
      if (kDebugMode) {
        debugPrint(stack.toString());
      }
      return null;
    }
  }

  /// Escribe un valor de forma segura. Retorna `true` si la operación tuvo éxito
  /// o `false` si falló, registrando el error en los logs.
  static Future<bool> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (e, stack) {
      debugPrint('[SafeSecureStorage] Error escribiendo clave "$key": $e');
      if (kDebugMode) {
        debugPrint(stack.toString());
      }
      return false;
    }
  }

  /// Elimina una clave de forma segura. Retorna `true` si tuvo éxito.
  static Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e, stack) {
      debugPrint('[SafeSecureStorage] Error eliminando clave "$key": $e');
      if (kDebugMode) {
        debugPrint(stack.toString());
      }
      return false;
    }
  }

  /// Elimina todas las claves de forma segura.
  static Future<bool> deleteAll() async {
    try {
      await _storage.deleteAll();
      return true;
    } catch (e, stack) {
      debugPrint('[SafeSecureStorage] Error borrando todo el almacenamiento: $e');
      if (kDebugMode) {
        debugPrint(stack.toString());
      }
      return false;
    }
  }

  /// Verifica si una clave existe de forma segura.
  static Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e, stack) {
      debugPrint('[SafeSecureStorage] Error verificando clave "$key": $e');
      if (kDebugMode) {
        debugPrint(stack.toString());
      }
      return false;
    }
  }
}
