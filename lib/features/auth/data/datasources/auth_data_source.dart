import '../../domain/entities/login_credentials.dart';

/// Fonte de dados de autenticação — implementada pela fake local
/// (`AuthLocalDataSource`) ou pela API remota (`AuthRemoteDataSource`).
abstract interface class AuthDataSource {
  /// Resolve em sucesso; lança `AuthException` em falha.
  Future<void> authenticate(LoginCredentials credentials);
}
