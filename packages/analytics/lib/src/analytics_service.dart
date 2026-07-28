import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:flutter/foundation.dart';

/// Client usability analytics, backed by Amplitude.
///
/// Event names follow Google's naming convention for standard interaction
/// events (`screen_view`, `click`) so the taxonomy reads the same as
/// GA4/Firebase Analytics.
class AnalyticsService {
  AnalyticsService._();

  static Amplitude? _amplitude;
  static bool _disabled = false;

  /// Turns every track call into a no-op. For widget/unit tests, where the
  /// native Amplitude channel does not exist.
  @visibleForTesting
  static void disableForTesting() {
    _disabled = true;
  }

  /// Initializes the Amplitude client. Must be called exactly once — before
  /// any track call — typically in `main()`.
  static Future<void> init(String apiKey) async {
    if (_amplitude != null || _disabled) return;
    final Amplitude amplitude = Amplitude(Configuration(apiKey: apiKey));
    await amplitude.isBuilt;
    _amplitude = amplitude;
  }

  /// Logs a `screen_view` event for [screenName].
  static void trackScreenView(
    String screenName, {
    Map<String, Object?>? properties,
  }) {
    trackEvent(
      'screen_view',
      properties: <String, Object?>{
        'screen_name': screenName,
        ...?properties,
      },
    );
  }

  /// Logs a `click` event for [elementName].
  static void trackClick(
    String elementName, {
    Map<String, Object?>? properties,
  }) {
    trackEvent(
      'click',
      properties: <String, Object?>{
        'element_name': elementName,
        ...?properties,
      },
    );
  }

  /// Logs an arbitrary event. Prefer [trackScreenView] / [trackClick] for the
  /// standard taxonomy; use this only for events outside that pattern.
  static void trackEvent(String eventName, {Map<String, Object?>? properties}) {
    if (_disabled) return;
    final Amplitude? amplitude = _amplitude;
    assert(
      amplitude != null,
      'AnalyticsService.init() must be called before tracking events.',
    );
    if (amplitude == null) return;
    amplitude.track(
      BaseEvent(eventName, eventProperties: properties),
    );
  }
}
