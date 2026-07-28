import 'package:flutter/foundation.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile.dart';

/// Presentation state for the Perfil screen (MVVM).
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({required GetProfile getProfile})
      : _getProfile = getProfile;

  final GetProfile _getProfile;

  UserProfile? _profile;
  bool _isLoading = false;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await _getProfile();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
