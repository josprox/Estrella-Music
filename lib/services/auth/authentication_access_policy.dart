class AuthenticationAccessPolicy {
  const AuthenticationAccessPolicy();

  bool canEnterApplication({required bool isAuthenticated}) => isAuthenticated;
}
