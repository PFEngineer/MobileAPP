import 'package:core_analytics/core_analytics.dart';

/// Facade estático do app sobre o pacote corporativo `core_analytics`.
///
/// Mantém a ergonomia estática usada nas telas (`trackScreenView` /
/// `trackClick`) enquanto centraliza no módulo LGPD: consentimento (opt-out por
/// padrão) e multiplexação Amplitude/Firebase. Para código novo, prefira injetar
/// o `AnalyticsService` do `core_analytics` via construtor (DI).
class AnalyticsService {
  AnalyticsService._();

  static final CoreAnalyticsService _service = CoreAnalyticsService();
  static bool _disabled = false;

  /// Transforma tudo em no-op. Para testes de widget/unit (canal nativo ausente).
  static void disableForTesting() => _disabled = true;

  /// Registra a chave de API. Chame uma vez, no boot (antes de `runApp`).
  static Future<void> init(String amplitudeApiKey) async {
    if (_disabled) return;
    await _service.initialize(
      options: AnalyticsOptions(amplitudeApiKey: amplitudeApiKey),
    );
  }

  /// LGPD: define o consentimento. Nenhum evento é enviado enquanto for `false`.
  static void setConsent(bool isOptedIn) {
    if (_disabled) return;
    _service.setConsent(isOptedIn);
  }

  /// Vincula (ou desvincula, com `null`) o hash do usuário na sessão.
  static void setUserId(String? userId) {
    if (_disabled) return;
    _service.setUserId(userId);
  }

  /// Registra a navegação do usuário (`screen_viewed`).
  static void trackScreenView(String screenName) {
    if (_disabled) return;
    _service.trackScreenViewed(screenName: screenName);
  }

  /// Registra um clique/interação (`ui_clicked`).
  static void trackClick(String elementName) {
    if (_disabled) return;
    _service.trackClicked(elementName: elementName);
  }
}
