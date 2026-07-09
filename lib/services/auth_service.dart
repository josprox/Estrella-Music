import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'sync_service.dart';

class AuthService extends GetxService {
  static const _jwtTokenKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenExpirationKey = 'token_expiration';
  static const _cachedProfileKey = 'cached_user_profile';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 40),
      validateStatus: (_) => true,
    ),
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final isAuthenticated = false.obs;
  final isLoadingSession = true.obs;
  final userProfile = Rxn<Map<String, dynamic>>();

  String? get baseUrl {
    final isDebugEnv = dotenv.env['DEBUG']?.toLowerCase() == 'true';
    if (kDebugMode && isDebugEnv) {
      if (GetPlatform.isWindows) {
        return 'http://127.0.0.1:9000';
      } else if (GetPlatform.isAndroid) {
        return 'http://10.0.2.2:9000';
      }
    }
    return dotenv.env['JOSSRED'];
  }

  String? get apiToken => dotenv.env['JOSSRED_API'];
  bool get isConfigured =>
      (baseUrl?.trim().isNotEmpty ?? false) &&
      (apiToken?.trim().isNotEmpty ?? false);

  String get displayName {
    final user = userProfile.value;
    if (user == null) return 'Sin sesión';
    final firstName = user['first_name']?.toString().trim();
    final lastName = user['last_name']?.toString().trim();
    final fullName = [firstName, lastName]
        .where((value) => value != null && value.isNotEmpty)
        .join(' ');
    if (fullName.isNotEmpty) return fullName;
    final username = user['username']?.toString().trim();
    if (username != null && username.isNotEmpty) return username;
    final email = user['email']?.toString().trim();
    if (email != null && email.isNotEmpty) return email;
    return 'Usuario';
  }

  String get emailLabel =>
      userProfile.value?['email']?.toString().trim().isNotEmpty == true
          ? userProfile.value!['email'].toString().trim()
          : 'Sin correo visible';

  Uri _buildUri(String endpoint) {
    var base = baseUrl?.trim() ?? '';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    return Uri.parse('$base/api/$endpoint');
  }

  Map<String, String> get _publicHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${apiToken ?? ''}',
      };

  Map<String, String> _jwtHeaders(String token) => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    if (value is String && value.isNotEmpty) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          return decoded.map((key, val) => MapEntry(key.toString(), val));
        }
      } catch (_) {}
    }
    return <String, dynamic>{};
  }

  Map<String, dynamic> _flattenUser(dynamic user) {
    final data = _asMap(user);
    if (data.containsKey('Fields') && data['Fields'] is Map) {
      return _asMap(data['Fields']);
    }
    return data;
  }

  Future<void> _saveTokenData(
    String token,
    String refreshToken,
    int expiresInSeconds,
  ) async {
    final expirationEpoch = DateTime.now()
            .add(Duration(seconds: expiresInSeconds))
            .millisecondsSinceEpoch ~/
        1000;

    await _storage.write(key: _jwtTokenKey, value: token);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(
      key: _tokenExpirationKey,
      value: expirationEpoch.toString(),
    );
  }

  Future<void> _clearTokenData() async {
    await _storage.delete(key: _jwtTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _tokenExpirationKey);
    await _storage.delete(key: _cachedProfileKey);
  }

  Future<bool> _isTokenExpiringSoon({int daysThreshold = 15}) async {
    final expirationRaw = await _storage.read(key: _tokenExpirationKey);
    if (expirationRaw == null || expirationRaw.isEmpty) {
      return true;
    }

    final expirationEpoch = int.tryParse(expirationRaw);
    if (expirationEpoch == null) {
      return true;
    }

    final expirationDate =
        DateTime.fromMillisecondsSinceEpoch(expirationEpoch * 1000);
    return expirationDate.difference(DateTime.now()).inDays <= daysThreshold;
  }

  Future<String?> getAccessToken() async {
    final token = await _storage.read(key: _jwtTokenKey);
    if (token == null || token.isEmpty) return null;

    if (await _isTokenExpiringSoon()) {
      final refreshResult = await refreshToken();
      if (!(refreshResult['success'] == true)) {
        return null;
      }
    }

    return _storage.read(key: _jwtTokenKey);
  }

  Future<void> restoreSession() async {
    isLoadingSession.value = true;

    if (!isConfigured) {
      isAuthenticated.value = false;
      userProfile.value = null;
      isLoadingSession.value = false;
      return;
    }

    final token = await _storage.read(key: _jwtTokenKey);
    if (token == null || token.isEmpty) {
      isAuthenticated.value = false;
      userProfile.value = null;
      isLoadingSession.value = false;
      return;
    }

    if (await _isTokenExpiringSoon()) {
      final refreshResult = await refreshToken();
      if (!(refreshResult['success'] == true)) {
        if (refreshResult['isNetworkError'] == true) {
          // Keep session active for offline mode
          await _loadCachedProfile();
          isLoadingSession.value = false;
          return;
        } else {
          await _clearTokenData();
          isAuthenticated.value = false;
          userProfile.value = null;
          isLoadingSession.value = false;
          return;
        }
      }
    }

    final profileResult = await fetchUserProfile();
    if (profileResult['success'] == true) {
      isAuthenticated.value = true;
      final profileData = Map<String, dynamic>.from(
        profileResult['user'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );
      userProfile.value = profileData;
      await _storage.write(
        key: _cachedProfileKey,
        value: jsonEncode(profileData),
      );
      final hasPending =
          Hive.box('AppPrefs').get('hasPendingSync', defaultValue: false) ==
              true;
      if (hasPending) {
        Get.find<SyncService>().push().then((success) {
          if (success) {
            Get.find<SyncService>().pull();
          }
        });
      } else {
        Get.find<SyncService>().pull();
      }
    } else {
      if (profileResult['isNetworkError'] == true) {
        // Fallback to offline cached profile
        await _loadCachedProfile();
      } else {
        await _clearTokenData();
        isAuthenticated.value = false;
        userProfile.value = null;
      }
    }

    isLoadingSession.value = false;
  }

  Future<void> _loadCachedProfile() async {
    try {
      final cachedProfileData = await _storage.read(key: _cachedProfileKey);
      if (cachedProfileData != null && cachedProfileData.isNotEmpty) {
        userProfile.value = Map<String, dynamic>.from(
          jsonDecode(cachedProfileData),
        );
      }
      isAuthenticated.value = true; // Still assume authenticated offline
    } catch (_) {
      // Ignore cache load errors
      isAuthenticated.value = true;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    if (!isConfigured) {
      return {'success': false, 'message': 'AUTH_NOT_CONFIGURED'};
    }

    try {
      final response = await _dio.postUri(
        _buildUri('login'),
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
        options: Options(headers: _publicHeaders),
      );

      final data = _asMap(response.data);
      if (response.statusCode == 200 &&
          data['status']?.toString() == 'success' &&
          data['token'] != null) {
        await _saveTokenData(
          data['token'].toString(),
          data['refresh_token']?.toString() ?? '',
          _asInt(data['expires_in']) ?? 7776000,
        );
        await restoreSession();
        // The user override logic was here, handled by restoreSession cache now
        return {
          'success': true,
          'user': userProfile.value ?? _flattenUser(data['user']),
        };
      }

      final message = data['message']?.toString() ?? 'Error desconocido';
      if (message == 'Invalid credentials') {
        return {'success': false, 'message': 'INVALID_CREDENTIALS'};
      }
      if (message.contains('Account not verified')) {
        return {'success': false, 'message': 'ACCOUNT_NOT_VERIFIED'};
      }
      return {'success': false, 'message': message};
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    if (!isConfigured) {
      return {'success': false, 'message': 'AUTH_NOT_CONFIGURED'};
    }

    try {
      final response = await _dio.postUri(
        _buildUri('register'),
        data: {
          'username': username.trim(),
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'email': email.trim(),
          'phone': '',
          'password': password.trim(),
        },
        options: Options(headers: _publicHeaders),
      );

      final data = _asMap(response.data);
      if (data['status']?.toString() == 'success') {
        return {
          'success': true,
          'message': data['message']?.toString() ??
              'Cuenta creada. Revisa tu correo si aplica.',
        };
      }

      return {
        'success': false,
        'message': data['message']?.toString() ?? 'No fue posible registrarte.',
        'errors': data['errors'] ?? const <String, dynamic>{},
      };
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendRecoveryEmail({
    required String email,
  }) async {
    if (!isConfigured) {
      return {'success': false, 'message': 'AUTH_NOT_CONFIGURED'};
    }

    try {
      final response = await _dio.postUri(
        _buildUri('password/email'),
        data: {'email': email.trim()},
        options: Options(headers: _publicHeaders),
      );

      final data = _asMap(response.data);
      return {
        'success': response.statusCode == 200,
        'message': data['message']?.toString() ??
            (response.statusCode == 200
                ? 'Te enviamos las instrucciones.'
                : 'No fue posible enviar el correo.'),
      };
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final token = await _storage.read(key: _jwtTokenKey);
    if (token == null || token.isEmpty) {
      return {'success': false, 'message': 'No hay token activo.'};
    }

    try {
      final response = await _dio.getUri(
        _buildUri('profile'),
        options: Options(headers: _jwtHeaders(token)),
      );

      final data = _asMap(response.data);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'user': _flattenUser(data['user']),
        };
      }

      return {
        'success': false,
        'message':
            data['message']?.toString() ?? 'No fue posible obtener el perfil.',
      };
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
        'isNetworkError': true,
      };
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) {
      return {
        'success': false,
        'message': 'No hay refresh token disponible.',
      };
    }

    try {
      final response = await _dio.postUri(
        _buildUri('refresh'),
        options: Options(
          headers: {
            ..._publicHeaders,
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );

      final data = _asMap(response.data);
      if (response.statusCode == 200 && data['token'] != null) {
        await _saveTokenData(
          data['token'].toString(),
          data['refresh_token']?.toString() ?? refreshToken,
          _asInt(data['expires_in']) ?? 7776000,
        );
        return {'success': true, 'token': data['token']};
      }

      return {
        'success': false,
        'message': data['message']?.toString() ??
            'No fue posible refrescar la sesión.',
      };
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
        'isNetworkError': true,
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    final token = await _storage.read(key: _jwtTokenKey);
    try {
      if (token != null && token.isNotEmpty) {
        await _dio.postUri(
          _buildUri('logout'),
          options: Options(headers: _jwtHeaders(token)),
        );
      }
    } catch (_) {
      // Local logout continues even if the network request fails.
    } finally {
      await _clearTokenData();
      userProfile.value = null;
      isAuthenticated.value = false;
      isLoadingSession.value = false;
    }

    return {'success': true, 'message': 'Sesión cerrada.'};
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  Map<String, dynamic> _handleError(DioException error) {
    if (kDebugMode) {
      debugPrint('[AuthService] ${error.type}: ${error.message}');
      debugPrint('[AuthService] response: ${error.response?.data}');
    }

    final isNetworkError = error.type != DioExceptionType.badResponse ||
        (error.response?.statusCode != 401 &&
            error.response?.statusCode != 403);

    final responseData = _asMap(error.response?.data);
    return {
      'success': false,
      'isNetworkError': isNetworkError,
      'message': responseData['message']?.toString() ??
          error.message ??
          'Error de conexión.',
    };
  }
}
