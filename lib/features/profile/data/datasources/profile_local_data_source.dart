import '../../domain/entities/user_profile.dart';

/// In-memory fixture source — the user from Figma 10. Perfil.
class ProfileLocalDataSource {
  const ProfileLocalDataSource();

  Future<UserProfile> fetchProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const UserProfile(
      name: 'Paulo Souza',
      email: 'paulo.souza@email.com',
      initials: 'PS',
      isPremium: true,
    );
  }
}
