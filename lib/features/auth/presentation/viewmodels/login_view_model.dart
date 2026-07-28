import 'package:flutter/foundation.dart';

import '../../../../core/format/cpf.dart';
import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';

/// Presentation state + validation for the Login screen (MVVM).
class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required Login login}) : _login = login;

  final Login _login;

  String _cpf = '';
  String _password = '';
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  /// Field errors are shown only after a field has been touched (or after a
  /// submit attempt), so the form doesn't scream at a user still typing.
  bool _cpfTouched = false;
  bool _passwordTouched = false;
  bool _submitAttempted = false;

  String? _formError;

  bool get rememberMe => _rememberMe;
  bool get obscurePassword => _obscurePassword;
  bool get isSubmitting => _isSubmitting;
  String? get formError => _formError;

  /// Masked value to display, e.g. `529.982.247-25`.
  String get maskedCpf => Cpf.format(_cpf);

  String? get cpfError =>
      (_cpfTouched || _submitAttempted) ? Cpf.validationError(_cpf) : null;

  String? get passwordError {
    if (!_passwordTouched && !_submitAttempted) return null;
    if (_password.isEmpty) return 'Informe sua senha';
    if (_password.length < 6) {
      return 'A senha deve ter ao menos 6 caracteres';
    }
    return null;
  }

  bool get isValid =>
      Cpf.validationError(_cpf) == null && _password.length >= 6;

  void setCpf(String value) {
    _cpf = Cpf.strip(value);
    _cpfTouched = true;
    _formError = null;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _passwordTouched = true;
    _formError = null;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Attempts login. Returns true on success so the view can navigate.
  Future<bool> submit() async {
    _submitAttempted = true;
    _formError = null;
    if (!isValid) {
      notifyListeners();
      return false;
    }

    _isSubmitting = true;
    notifyListeners();
    try {
      await _login(
        LoginCredentials(
          cpf: _cpf,
          password: _password,
          rememberMe: _rememberMe,
        ),
      );
      return true;
    } on AuthException catch (e) {
      _formError = e.message;
      return false;
    } catch (_) {
      _formError = 'Não foi possível entrar. Tente novamente.';
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
