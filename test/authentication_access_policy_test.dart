import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/services/auth/authentication_access_policy.dart';

void main() {
  const policy = AuthenticationAccessPolicy();

  test('guest mode never enters the application', () {
    expect(policy.canEnterApplication(isAuthenticated: false), isFalse);
  });

  test('a valid session enters and logout returns to authentication', () {
    var authenticated = true;
    expect(policy.canEnterApplication(isAuthenticated: authenticated), isTrue);
    authenticated = false;
    expect(policy.canEnterApplication(isAuthenticated: authenticated), isFalse);
  });
}
