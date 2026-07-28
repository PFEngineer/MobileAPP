import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

/// Data-layer implementation of [AuthRepository], backed by the fake source.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthLocalDataSource _dataSource;

  @override
  Future<void> login(LoginCredentials credentials) =>
      _dataSource.authenticate(credentials);
}
