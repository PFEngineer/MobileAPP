import '../entities/login_credentials.dart';

/// Domain contract for authentication.
abstract interface class AuthRepository {
  /// Resolves on success, throws [AuthException] on failure.
  Future<void> login(LoginCredentials credentials);
}

/// Raised when authentication fails (bad credentials, network, …).
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
