import 'package:flutter/material.dart';

import 'package:mobile_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import 'app/di/app_dependencies.dart';
import 'app/router/app_router.dart';
import 'app/router/app_routes.dart';
import 'core/telemetry/app_telemetry.dart';

// Amplitude ingestion key — public by design; move to an env var when you set up environments.
const String _amplitudeApiKey = '4858fdb1a4454c832835596686fa5fc7';

// Sentry DSN — cliente-side por design (só permite enviar eventos, não ler).
// Override por ambiente com --dart-define=SENTRY_DSN=...
const String _sentryDsn = String.fromEnvironment(
  'SENTRY_DSN',
  defaultValue:
      'https://b23cfcf5c97db8ed0648d4e8df12e178@o4511824815521792.ingest.us.sentry.io/4511825946935296',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AnalyticsService.init(_amplitudeApiKey);
  // LGPD: core_analytics é opt-out por padrão. TODO(LGPD): mover para a tela de consentimento real.
  AnalyticsService.setConsent(true);
  await AppTelemetry.init(serviceVersion: '1.0.0', sentryDsn: _sentryDsn);
  AppTelemetry.info('app_start');
  // TODO(remover): smoke test — deve aparecer em Sentry → Issues em segundos.
  AppTelemetry.recordError(
    Exception('sentry smoke test'),
    stackTrace: StackTrace.current,
  );
  runApp(MobileApp(router: AppRouter(AppDependencies())));
}

class MobileApp extends StatelessWidget {
  const MobileApp({required this.router, super.key});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      debugShowCheckedModeBanner: false,
      theme: DsTheme.light(),
      // Single-entry initial stack. Without this, MaterialApp would expand
      // the "/login" path into ['/', '/login'] and mount the shell beneath
      // the login screen.
      onGenerateInitialRoutes: (_) => <Route<dynamic>>[
        router.onGenerateRoute(
          const RouteSettings(name: AppRoutes.login),
        )!,
      ],
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
