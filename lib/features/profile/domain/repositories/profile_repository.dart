import '../entities/user_profile.dart';

/// Domain contract for the user profile.
abstract interface class ProfileRepository {
  Future<UserProfile> getProfile();
}
