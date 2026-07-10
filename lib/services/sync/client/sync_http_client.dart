import 'package:dio/dio.dart';

class SyncHttpClient {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 45),
      validateStatus: (_) => true,
    ),
  );

  Map<String, String> _headers(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> checkConnection(String baseUrl, String token) async {
    try {
      final response = await _dio.get(
        '${baseUrl}api/sync/status',
        options: Options(headers: _headers(token)),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> pull(String baseUrl, String token) async {
    final response = await _dio.get(
      '${baseUrl}api/sync/pull',
      options: Options(headers: _headers(token)),
    );

    if (response.statusCode != 200 || response.data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Sync HTTP pull failed with status ${response.statusCode}',
      );
    }

    if (response.data is Map) {
      return Map<String, dynamic>.from(response.data);
    }
    return null;
  }

  Future<bool> push(String baseUrl, String token, Map<String, dynamic> payload) async {
    final response = await _dio.post(
      '${baseUrl}api/sync/push',
      options: Options(headers: _headers(token)),
      data: payload,
    );

    if (response.statusCode == 200) {
      return true;
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Sync HTTP push failed with status ${response.statusCode}',
    );
  }

  Future<bool> pushCollaborative(String baseUrl, String token, Map<String, dynamic> playlistPayload) async {
    final response = await _dio.post(
      '${baseUrl}api/sync/push-collaborative',
      options: Options(headers: _headers(token)),
      data: {'playlist': playlistPayload},
    );
    return response.statusCode == 200;
  }

  Future<List<Map<String, dynamic>>> searchUsers(String baseUrl, String token, String query) async {
    try {
      final response = await _dio.get(
        '${baseUrl}api/friends/search',
        queryParameters: {'query': query},
        options: Options(headers: _headers(token)),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List users = response.data['users'] as List? ?? [];
        return users.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (_) {}
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchFriends(String baseUrl, String token) async {
    try {
      final response = await _dio.get(
        '${baseUrl}api/friends',
        options: Options(headers: _headers(token)),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List friends = response.data['friends'] as List? ?? [];
        return friends.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (_) {}
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchPublicPlaylists(String baseUrl, String token) async {
    try {
      final response = await _dio.get(
        '${baseUrl}api/playlists/public',
        options: Options(headers: _headers(token)),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List playlists = response.data['playlists'] as List? ?? [];
        return playlists.map((p) => Map<String, dynamic>.from(p)).toList();
      }
    } catch (_) {}
    return [];
  }
}
