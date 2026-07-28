import '../entities/login_credentials.dart';
import '../repositories/auth_repository.dart';

/// Authenticates the user with their CPF and password.
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<void> call(LoginCredentials credentials) =>
      _repository.login(credentials);
}
