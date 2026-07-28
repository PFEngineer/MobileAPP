import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/auth_repository.dart';

/// Fake auth backend until a real API exists. Accepts any structurally valid
/// CPF with a password of at least 6 characters; everything else throws
/// [AuthException].
class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<void> authenticate(LoginCredentials credentials) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (credentials.password.length < 6) {
      throw const AuthException('CPF ou senha incorretos');
    }
    // Success — a real implementation would persist the returned token here
    // (and honor credentials.rememberMe).
  }
}
