import 'package:flutter/material.dart';

import 'package:analytics/analytics.dart';
import 'package:design_system/design_system.dart';

import 'app/di/app_dependencies.dart';
import 'app/router/app_router.dart';
import 'app/router/app_routes.dart';

// Amplitude ingestion key — public by design; move to an env var when you set up environments.
const String _amplitudeApiKey = '4858fdb1a4454c832835596686fa5fc7';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AnalyticsService.init(_amplitudeApiKey);
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
