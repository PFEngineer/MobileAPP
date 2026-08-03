import 'package:core_telemetry/core_telemetry.dart';
import 'package:flutter/foundation.dart';

/// Facade estático do app sobre o pacote corporativo `core_telemetry`
/// (Sentry — Logs/Erros/Performance — + Crashlytics opcional).
///
/// Centraliza a observabilidade e captura automaticamente os erros não
/// tratados do Flutter/Dart. Para código novo, prefira injetar o
/// `TelemetryService` via construtor (DI); este shim é a ponte de baixo atrito.
class AppTelemetry {
  AppTelemetry._();

  static final CoreTelemetryService _service = CoreTelemetryService();
  static bool _disabled = false;

  /// Transforma tudo em no-op. Para testes de widget/unit (sem SDKs nativos).
  static void disableForTesting() => _disabled = true;

  /// Inicializa no boot (antes de `runApp`) e passa a capturar erros não
  /// tratados. `sentryDsn` vazio desliga o envio (telemetria fica inerte).
  static Future<void> init({
    required String serviceVersion,
    String? sentryDsn,
    bool enableCrashlytics = false,
  }) async {
    if (_disabled) return;
    await _service.initialize(
      options: TelemetryOptions(
        serviceName: 'invest_app',
        serviceVersion: serviceVersion,
        environment: 'prod',
        sentry: (sentryDsn == null || sentryDsn.isEmpty)
            ? null
            : SentryOptions(dsn: sentryDsn),
        enableCrashlytics: enableCrashlytics,
      ),
    );
    _captureUncaughtErrors();
  }

  static void _captureUncaughtErrors() {
    final FlutterExceptionHandler? previous = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      recordError(details.exception, stackTrace: details.stack, fatal: true);
      previous?.call(details);
    };
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      recordError(error, stackTrace: stack, fatal: true);
      return true;
    };
  }

  /// Vincula (ou desvincula, com `null`) o hash do usuário.
  static void setUser(String? id) {
    if (!_disabled) _service.setUser(id: id);
  }

  /// Log estruturado com severidade.
  static void log(
    TelemetryLevel level,
    String message, {
    Map<String, Object?>? attributes,
  }) {
    if (!_disabled) _service.log(level, message, attributes: attributes);
  }

  static void info(String message, {Map<String, Object?>? attributes}) =>
      log(TelemetryLevel.info, message, attributes: attributes);

  static void warn(String message, {Map<String, Object?>? attributes}) =>
      log(TelemetryLevel.warn, message, attributes: attributes);

  /// Registra um erro/exceção (crash quando [fatal]).
  static void recordError(
    Object error, {
    StackTrace? stackTrace,
    bool fatal = false,
    Map<String, Object?>? attributes,
  }) {
    if (!_disabled) {
      _service.recordError(
        error,
        stackTrace: stackTrace,
        fatal: fatal,
        attributes: attributes,
      );
    }
  }

  /// Inicia um span (trace). Finalize com `end()`.
  static TelemetrySpan startSpan(String name) =>
      _disabled ? const NoopSpan() : _service.startSpan(name);
}
