import 'package:flutter/foundation.dart';

import '../../domain/entities/goal.dart';
import '../../domain/usecases/get_goals.dart';

/// Presentation state for the Metas screen (MVVM).
class GoalsViewModel extends ChangeNotifier {
  GoalsViewModel({required GetGoals getGoals}) : _getGoals = getGoals;

  final GetGoals _getGoals;

  List<Goal> _goals = const <Goal>[];
  bool _isLoading = false;

  List<Goal> get goals => _goals;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _goals = await _getGoals();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
