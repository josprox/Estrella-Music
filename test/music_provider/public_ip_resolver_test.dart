import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/providers/public_ip_resolver.dart';

void main() {
  group('PublicIpResolver', () {
    test('fetches and returns a valid public IPv4 address', () async {
      final adapter = _MockIpAdapter(responseBody: {'ip': '198.51.100.42'});
      final dio = Dio()..httpClientAdapter = adapter;
      final resolver = PublicIpResolver(client: dio);

      final ip = await resolver.getPublicIp();
      expect(ip, '198.51.100.42');
      expect(adapter.requestCount, 1);
    });

    test('fetches and returns a valid public IPv6 address', () async {
      final adapter = _MockIpAdapter(
        responseBody: {'ip': '2001:4860:4860::8888'},
      );
      final dio = Dio()..httpClientAdapter = adapter;
      final resolver = PublicIpResolver(client: dio);

      final ip = await resolver.getPublicIp();
      expect(ip, '2001:4860:4860::8888');
      expect(adapter.requestCount, 1);
    });

    test('reutilizes memory cache within TTL and does not repeat queries',
        () async {
      final adapter = _MockIpAdapter(responseBody: {'ip': '198.51.100.42'});
      final dio = Dio()..httpClientAdapter = adapter;
      final resolver = PublicIpResolver(
        client: dio,
        cacheTtl: const Duration(minutes: 10),
      );

      final first = await resolver.getPublicIp();
      final second = await resolver.getPublicIp();
      expect(first, '198.51.100.42');
      expect(second, '198.51.100.42');
      expect(adapter.requestCount, 1);

      // Force refresh bypasses cache
      final refreshed = await resolver.getPublicIp(forceRefresh: true);
      expect(refreshed, '198.51.100.42');
      expect(adapter.requestCount, 2);
    });

    test('coalesces concurrent requests into a single network call', () async {
      final adapter = _MockIpAdapter(
        responseBody: {'ip': '198.51.100.42'},
        delay: const Duration(milliseconds: 50),
      );
      final dio = Dio()..httpClientAdapter = adapter;
      final resolver = PublicIpResolver(client: dio);

      final results = await Future.wait([
        resolver.getPublicIp(),
        resolver.getPublicIp(),
        resolver.getPublicIp(),
      ]);

      expect(results, ['198.51.100.42', '198.51.100.42', '198.51.100.42']);
      expect(adapter.requestCount, 1);
    });

    test('rejects private, loopback, and invalid IPs returning null', () async {
      final invalidIps = [
        '127.0.0.1',
        '10.0.0.1',
        '192.168.1.1',
        '172.16.5.4',
        '169.254.1.1',
        '100.64.0.1',
        '::1',
        'fe80::1',
        'fc00::1',
        '256.1.2.3',
        'not-an-ip',
        '1.2.3.4, 5.6.7.8',
        '1.2.3.4\r\nHeader: Injection',
        '',
      ];

      for (final badIp in invalidIps) {
        expect(
          PublicIpResolver.isValidPublicIp(badIp),
          isFalse,
          reason: 'Expected "$badIp" to be rejected as public IP',
        );

        final adapter = _MockIpAdapter(responseBody: {'ip': badIp});
        final dio = Dio()..httpClientAdapter = adapter;
        final resolver = PublicIpResolver(client: dio);

        final resolved = await resolver.getPublicIp();
        expect(
          resolved,
          isNull,
          reason: 'Resolver should return null for "$badIp"',
        );
      }
    });

    test('gracefully returns null on network failure without throwing',
        () async {
      final adapter = _FailingIpAdapter();
      final dio = Dio()..httpClientAdapter = adapter;
      final resolver = PublicIpResolver(client: dio);

      final ip = await resolver.getPublicIp();
      expect(ip, isNull);
    });

    test('masks IP addresses correctly for logging', () {
      expect(PublicIpResolver.maskIp('198.51.100.42'), '198.51.***.***');
      expect(PublicIpResolver.maskIp('2001:4860:4860::8888'), '2001:4860:***');
      expect(PublicIpResolver.maskIp(null), 'none');
      expect(PublicIpResolver.maskIp(''), 'none');
    });
  });
}

class _MockIpAdapter implements HttpClientAdapter {
  _MockIpAdapter({
    required this.responseBody,
    this.delay,
  });

  final dynamic responseBody;
  final Duration? delay;
  int requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    if (delay != null) {
      await Future<void>.delayed(delay!);
    }
    final encoded = utf8.encode(jsonEncode(responseBody));
    return ResponseBody.fromBytes(
      encoded,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FailingIpAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      error: 'Network unreachable',
    );
  }

  @override
  void close({bool force = false}) {}
}
