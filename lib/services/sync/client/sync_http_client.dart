import 'package:dio/dio.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

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
      printINFO("[SyncHttpClient] searchUsers: baseUrl=$baseUrl, tokenLength=${token.length}, query=$query");
      final response = await _dio.get(
        '${baseUrl}api/friends/search',
        queryParameters: {'query': query},
        options: Options(headers: _headers(token)),
      );
      printINFO("[SyncHttpClient] searchUsers: status=${response.statusCode}, data=${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        final List users = response.data['users'] as List? ?? response.data['data'] as List? ?? [];
        return users.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR("[SyncHttpClient] searchUsers failed: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchFriends(String baseUrl, String token) async {
    try {
      printINFO("[SyncHttpClient] fetchFriends: baseUrl=$baseUrl, tokenLength=${token.length}");
      final response = await _dio.get(
        '${baseUrl}api/friends',
        options: Options(headers: _headers(token)),
      );
      printINFO("[SyncHttpClient] fetchFriends: status=${response.statusCode}, data=${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        final List friends = response.data['friends'] as List? ?? response.data['data'] as List? ?? [];
        return friends.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR("[SyncHttpClient] fetchFriends failed: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchRequests(String baseUrl, String token) async {
    try {
      printINFO("[SyncHttpClient] fetchRequests: baseUrl=$baseUrl, tokenLength=${token.length}");
      final response = await _dio.get(
        '${baseUrl}api/friends/requests',
        options: Options(headers: _headers(token)),
      );
      printINFO("[SyncHttpClient] fetchRequests: status=${response.statusCode}, data=${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        final List requests = response.data['requests'] as List? ?? response.data['data'] as List? ?? [];
        return requests.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR("[SyncHttpClient] fetchRequests failed: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchBlocked(String baseUrl, String token) async {
    try {
      printINFO("[SyncHttpClient] fetchBlocked: baseUrl=$baseUrl, tokenLength=${token.length}");
      final response = await _dio.get(
        '${baseUrl}api/friends/blocked',
        options: Options(headers: _headers(token)),
      );
      printINFO("[SyncHttpClient] fetchBlocked: status=${response.statusCode}, data=${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        final List blocked = response.data['blocked'] as List? ?? response.data['data'] as List? ?? [];
        return blocked.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR("[SyncHttpClient] fetchBlocked failed: $e");
    }
    return [];
  }

  Future<Map<String, dynamic>> sendFriendRequest(String baseUrl, String token, int friendId) async {
    try {
      final response = await _dio.post(
        '${baseUrl}api/friends/request',
        options: Options(headers: _headers(token)),
        data: {'friend_id': friendId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'message': response.data?['message'] ?? 'Solicitud enviada'};
      }
      return {'success': false, 'message': response.data?['error'] ?? response.data?['message'] ?? 'Error'};
    } catch (e) {
      if (e is DioException && e.response != null) {
        return {
          'success': false,
          'message': e.response?.data?['error'] ?? e.response?.data?['message'] ?? e.message ?? e.toString()
        };
      }
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> acceptFriendRequest(String baseUrl, String token, int friendId) async {
    try {
      final response = await _dio.post(
        '${baseUrl}api/friends/accept',
        options: Options(headers: _headers(token)),
        data: {'friend_id': friendId},
      );
      if (response.statusCode == 200) {
        return {'success': true, 'message': response.data?['message'] ?? 'Solicitud aceptada'};
      }
      return {'success': false, 'message': response.data?['error'] ?? response.data?['message'] ?? 'Error'};
    } catch (e) {
      if (e is DioException && e.response != null) {
        return {
          'success': false,
          'message': e.response?.data?['error'] ?? e.response?.data?['message'] ?? e.message ?? e.toString()
        };
      }
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> removeFriendship(String baseUrl, String token, int friendId) async {
    try {
      final response = await _dio.post(
        '${baseUrl}api/friends/remove',
        options: Options(headers: _headers(token)),
        data: {'friend_id': friendId},
      );
      if (response.statusCode == 200) {
        return {'success': true, 'message': response.data?['message'] ?? 'Amistad eliminada'};
      }
      return {'success': false, 'message': response.data?['error'] ?? response.data?['message'] ?? 'Error'};
    } catch (e) {
      if (e is DioException && e.response != null) {
        return {
          'success': false,
          'message': e.response?.data?['error'] ?? e.response?.data?['message'] ?? e.message ?? e.toString()
        };
      }
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> blockUser(String baseUrl, String token, int friendId) async {
    try {
      final response = await _dio.post(
        '${baseUrl}api/friends/block',
        options: Options(headers: _headers(token)),
        data: {'friend_id': friendId},
      );
      if (response.statusCode == 200) {
        return {'success': true, 'message': response.data?['message'] ?? 'Usuario bloqueado'};
      }
      return {'success': false, 'message': response.data?['error'] ?? response.data?['message'] ?? 'Error'};
    } catch (e) {
      if (e is DioException && e.response != null) {
        return {
          'success': false,
          'message': e.response?.data?['error'] ?? e.response?.data?['message'] ?? e.message ?? e.toString()
        };
      }
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> unblockUser(String baseUrl, String token, int friendId) async {
    try {
      final response = await _dio.post(
        '${baseUrl}api/friends/unblock',
        options: Options(headers: _headers(token)),
        data: {'friend_id': friendId},
      );
      if (response.statusCode == 200) {
        return {'success': true, 'message': response.data?['message'] ?? 'Usuario desbloqueado'};
      }
      return {'success': false, 'message': response.data?['error'] ?? response.data?['message'] ?? 'Error'};
    } catch (e) {
      if (e is DioException && e.response != null) {
        return {
          'success': false,
          'message': e.response?.data?['error'] ?? e.response?.data?['message'] ?? e.message ?? e.toString()
        };
      }
      return {'success': false, 'message': e.toString()};
    }
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
