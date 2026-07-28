import 'package:flutter/foundation.dart';

import '../../domain/entities/discover_content.dart';
import '../../domain/usecases/get_discover_feed.dart';

/// Presentation state for the Descobrir screen (MVVM).
class DiscoverViewModel extends ChangeNotifier {
  DiscoverViewModel({
    required GetInsights getInsights,
    required GetRecommendedContent getRecommendedContent,
  })  : _getInsights = getInsights,
        _getRecommendedContent = getRecommendedContent;

  final GetInsights _getInsights;
  final GetRecommendedContent _getRecommendedContent;

  List<DiscoverInsight> _insights = const <DiscoverInsight>[];
  List<DiscoverContent> _contents = const <DiscoverContent>[];
  bool _isLoading = false;

  List<DiscoverInsight> get insights => _insights;
  List<DiscoverContent> get contents => _contents;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final List<Object> results = await Future.wait(<Future<Object>>[
        _getInsights(),
        _getRecommendedContent(),
      ]);
      _insights = results[0] as List<DiscoverInsight>;
      _contents = results[1] as List<DiscoverContent>;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
