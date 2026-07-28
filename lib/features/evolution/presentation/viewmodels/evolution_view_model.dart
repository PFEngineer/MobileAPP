import 'package:flutter/foundation.dart';

import '../../domain/entities/evolution_summary.dart';
import '../../domain/usecases/get_evolution.dart';

/// Presentation state for the Evolução screen (MVVM).
class EvolutionViewModel extends ChangeNotifier {
  EvolutionViewModel({required GetEvolution getEvolution})
      : _getEvolution = getEvolution;

  final GetEvolution _getEvolution;

  EvolutionSummary? _summary;
  EvolutionRange _selectedRange = EvolutionRange.oneYear;
  bool _isLoading = false;

  EvolutionSummary? get summary => _summary;
  EvolutionRange get selectedRange => _selectedRange;
  bool get isLoading => _isLoading;

  Future<void> load() => _loadRange(_selectedRange);

  Future<void> selectRange(EvolutionRange range) {
    if (range == _selectedRange && _summary != null) {
      return Future<void>.value();
    }
    _selectedRange = range;
    return _loadRange(range);
  }

  Future<void> _loadRange(EvolutionRange range) async {
    _isLoading = true;
    notifyListeners();
    try {
      _summary = await _getEvolution(range);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
