import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

/// Data-layer implementation of [ProfileRepository], backed by fixtures.
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._dataSource);

  final ProfileLocalDataSource _dataSource;

  @override
  Future<UserProfile> getProfile() => _dataSource.fetchProfile();
}
