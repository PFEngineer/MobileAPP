import 'package:flutter/foundation.dart';

/// Personalized insight card (Figma 77:412).
@immutable
class DiscoverInsight {
  const DiscoverInsight({
    required this.title,
    required this.subtitle,
    required this.emoji,
  });

  final String title;
  final String subtitle;
  final String emoji;
}

/// Thumbnail tone of a recommended-content card.
enum ContentTone { purple, blue, green }

/// Recommended article (Figma 77:419/425/431).
@immutable
class DiscoverContent {
  const DiscoverContent({
    required this.title,
    required this.readMinutes,
    required this.tone,
  });

  final String title;
  final int readMinutes;
  final ContentTone tone;
}
