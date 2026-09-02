import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

/// Neutral service to resolve the device's public IP address.
///
/// Designed to be non-blocking, cached in-memory, and resilient against network
/// failures without exposing or requiring any provider-specific logic.
class PublicIpResolver {
  PublicIpResolver({
    Dio? client,
    this.endpointUrl = defaultEndpointUrl,
    this.cacheTtl = defaultCacheTtl,
    this.timeout = defaultTimeout,
  }) : _client = client ??
            Dio(
              BaseOptions(
                connectTimeout: timeout,
                receiveTimeout: timeout,
                sendTimeout: timeout,
              ),
            );

  static const String defaultEndpointUrl = 'https://api.ipify.org?format=json';
  static const Duration defaultCacheTtl = Duration(minutes: 10);
  static const Duration defaultTimeout = Duration(seconds: 5);

  final Dio _client;
  final String endpointUrl;
  final Duration cacheTtl;
  final Duration timeout;

  String? _cachedIp;
  DateTime? _cachedAt;
  Future<String?>? _inFlight;

  /// Returns the current public IP address or null if unreachable / invalid.
  Future<String?> getPublicIp({bool forceRefresh = false}) async {
    final cached = _cachedIp;
    final cachedAt = _cachedAt;
    if (!forceRefresh &&
        cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < cacheTtl) {
      return cached;
    }

    final currentInFlight = _inFlight;
    if (currentInFlight != null && !forceRefresh) {
      return currentInFlight;
    }

    final request = _fetchPublicIp();
    _inFlight = request;
    try {
      final ip = await request;
      if (ip != null) {
        _cachedIp = ip;
        _cachedAt = DateTime.now();
      }
      return ip;
    } finally {
      _inFlight = null;
    }
  }

  Future<String?> _fetchPublicIp() async {
    try {
      final response = await _client.get<dynamic>(
        endpointUrl,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );

      final dynamic data = response.data;
      String? extracted;
      if (data is Map) {
        extracted = data['ip']?.toString().trim();
      } else if (data is String) {
        extracted = data.trim();
      }

      if (extracted != null && isValidPublicIp(extracted)) {
        return extracted;
      }

      printINFO(
          '[PublicIpResolver] Received invalid or non-public IP: ${maskIp(extracted)}');
      return null;
    } on DioException catch (error) {
      printINFO(
          '[PublicIpResolver] Failed to resolve public IP: ${error.type}');
      return null;
    } catch (error) {
      printINFO(
          '[PublicIpResolver] Unexpected error resolving public IP: $error');
      return null;
    }
  }

  /// Clears the in-memory cached IP address.
  void clearCache() {
    _cachedIp = null;
    _cachedAt = null;
  }

  /// Validates whether [ip] is a valid, publicly routable IPv4 or IPv6 address.
  static bool isValidPublicIp(String? ip) {
    if (ip == null) return false;
    final clean = ip.trim();
    if (clean.isEmpty ||
        clean.contains(',') ||
        clean.contains(' ') ||
        clean.contains('\n') ||
        clean.contains('\r')) {
      return false;
    }

    final address = InternetAddress.tryParse(clean);
    if (address == null) return false;

    if (address.isLoopback || address.isLinkLocal || address.isMulticast) {
      return false;
    }

    if (address.type == InternetAddressType.IPv4) {
      final raw = address.rawAddress;
      if (raw.length != 4) return false;
      final first = raw[0];
      final second = raw[1];

      // 0.0.0.0/8 (Current network)
      if (first == 0) return false;

      // 10.0.0.0/8 (Private)
      if (first == 10) return false;

      // 100.64.0.0/10 (Shared address space / Carrier-Grade NAT)
      if (first == 100 && (second >= 64 && second <= 127)) return false;

      // 127.0.0.0/8 (Loopback)
      if (first == 127) return false;

      // 169.254.0.0/16 (Link-local)
      if (first == 169 && second == 254) return false;

      // 172.16.0.0/12 (Private)
      if (first == 172 && (second >= 16 && second <= 31)) return false;

      // 192.168.0.0/16 (Private)
      if (first == 192 && second == 168) return false;

      // 224.0.0.0/4 (Multicast) & 240.0.0.0/4 (Reserved)
      if (first >= 224) return false;

      return true;
    }

    if (address.type == InternetAddressType.IPv6) {
      final raw = address.rawAddress;
      if (raw.length != 16) return false;

      // fc00::/7 (Unique Local Address)
      if ((raw[0] & 0xfe) == 0xfc) return false;

      // fe80::/10 (Link-Local Unicast)
      if (raw[0] == 0xfe && (raw[1] & 0xc0) == 0x80) return false;

      // ff00::/8 (Multicast)
      if (raw[0] == 0xff) return false;

      // :: (Unspecified)
      if (raw.every((b) => b == 0)) return false;

      return true;
    }

    return false;
  }

  /// Returns a masked representation of [ip] safe for diagnostic logging.
  static String maskIp(String? ip) {
    if (ip == null || ip.trim().isEmpty) return 'none';
    final clean = ip.trim();
    if (clean.contains('.')) {
      final parts = clean.split('.');
      if (parts.length == 4) {
        return '${parts[0]}.${parts[1]}.***.***';
      }
    } else if (clean.contains(':')) {
      final parts = clean.split(':');
      if (parts.length >= 2) {
        return '${parts[0]}:${parts[1]}:***';
      }
    }
    return 'present';
  }
}
