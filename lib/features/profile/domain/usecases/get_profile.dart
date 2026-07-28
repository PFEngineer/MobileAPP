import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Fetches the signed-in user's profile.
class GetProfile {
  const GetProfile(this._repository);

  final ProfileRepository _repository;

  Future<UserProfile> call() => _repository.getProfile();
}
