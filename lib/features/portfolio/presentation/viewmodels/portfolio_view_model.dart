import 'package:flutter/foundation.dart';

import '../../domain/entities/asset.dart';
import '../../domain/usecases/get_assets.dart';

/// Presentation state for the Carteira screen (MVVM).
class PortfolioViewModel extends ChangeNotifier {
  PortfolioViewModel({required GetAssets getAssets}) : _getAssets = getAssets;

  final GetAssets _getAssets;

  List<Asset> _assets = const <Asset>[];
  AssetCategory? _selectedCategory; // null == "Todos"
  bool _isLoading = false;

  AssetCategory? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  List<Asset> get assets => _selectedCategory == null
      ? _assets
      : _assets
          .where((Asset a) => a.category == _selectedCategory)
          .toList(growable: false);

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _assets = await _getAssets();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(AssetCategory? category) {
    if (category == _selectedCategory) return;
    _selectedCategory = category;
    notifyListeners();
  }
}
