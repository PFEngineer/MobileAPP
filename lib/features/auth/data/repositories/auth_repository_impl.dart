import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

/// Data-layer implementation of [AuthRepository]. O data source concreto (fake
/// local ou Galena API) é injetado pelo composition root.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<void> login(LoginCredentials credentials) =>
      _dataSource.authenticate(credentials);
}
