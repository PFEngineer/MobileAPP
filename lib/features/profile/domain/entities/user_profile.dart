import 'package:flutter/foundation.dart';

/// The signed-in user (Figma 10. Perfil hero).
@immutable
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.initials,
    required this.isPremium,
  });

  final String name;
  final String email;
  final String initials;
  final bool isPremium;
}
