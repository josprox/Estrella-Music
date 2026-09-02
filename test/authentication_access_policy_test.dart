import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/services/auth/authentication_access_policy.dart';

void main() {
  const policy = AuthenticationAccessPolicy();

  test('unauthenticated users are required to login before entering application', () {
    expect(policy.canEnterApplication(isAuthenticated: false), isFalse);
  });

  test('authenticated sessions enter the application', () {
    expect(policy.canEnterApplication(isAuthenticated: true), isTrue);
  });
}
