import 'package:flutter/foundation.dart';

/// User-entered login credentials (Figma 11. Login).
@immutable
class LoginCredentials {
  const LoginCredentials({
    required this.cpf,
    required this.password,
    required this.rememberMe,
  });

  /// Digits only (no mask), e.g. `52998224725`.
  final String cpf;
  final String password;
  final bool rememberMe;
}
