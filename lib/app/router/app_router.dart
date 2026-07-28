import 'package:flutter/material.dart';

import '../../features/ai_assistant/presentation/pages/assistant_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dividends/presentation/pages/dividends_page.dart';
import '../../features/evolution/presentation/pages/evolution_page.dart';
import '../../features/goals/presentation/pages/goals_page.dart';
import '../../features/new_operation/presentation/pages/new_operation_page.dart';
import '../../features/simulator/presentation/pages/simulator_page.dart';
import '../di/app_dependencies.dart';
import '../shell/app_shell.dart';
import 'app_routes.dart';

/// Central navigation layer. EVERY screen redirect goes through [go] (or the
/// generated routes), so future deeplinks only need to translate a URI into
/// one of the [AppRoutes] paths and call [go].
class AppRouter {
  AppRouter(this._dependencies);

  final AppDependencies _dependencies;

  final GlobalKey<AppShellState> shellKey = GlobalKey<AppShellState>();

  /// Nested navigator of the Investir tab — its section screens (Dividendos,
  /// Evolução, Metas, Simulador) keep the bottom navigation visible, matching
  /// the Figma mocks where the Investir tab stays active on them.
  final GlobalKey<NavigatorState> investNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Root routes (screens without the bottom navigation).
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => LoginPage(
            viewModel: _dependencies.buildLoginViewModel(),
            onLoggedIn: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.home),
          ),
        );
      case AppRoutes.home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => AppShell(
            key: shellKey,
            router: this,
            dependencies: _dependencies,
          ),
        );
      case AppRoutes.newOperation:
        return MaterialPageRoute<void>(
          settings: settings,
          fullscreenDialog: true,
          builder: (_) => NewOperationPage(
            viewModel: _dependencies.buildNewOperationViewModel(),
          ),
        );
      case AppRoutes.aiAssistant:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => AssistantPage(
            viewModel: _dependencies.buildAssistantViewModel(),
          ),
        );
    }
    return null;
  }

  /// Routes hosted inside the Investir tab's nested navigator.
  Route<dynamic>? onGenerateInvestRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dividends:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) =>
              DividendsPage(viewModel: _dependencies.dividendsViewModel),
        );
      case AppRoutes.evolution:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => EvolutionPage(
            viewModel: _dependencies.buildEvolutionViewModel(),
          ),
        );
      case AppRoutes.goals:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => GoalsPage(viewModel: _dependencies.goalsViewModel),
        );
      case AppRoutes.simulator:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) =>
              SimulatorPage(viewModel: _dependencies.simulatorViewModel),
        );
    }
    return null;
  }

  /// Central dispatch — the single entry point for screen redirects.
  void go(BuildContext context, String path) {
    switch (path) {
      case AppRoutes.home:
      case AppRoutes.dashboard:
        shellKey.currentState?.selectTab(AppTab.home);
      case AppRoutes.portfolio:
        shellKey.currentState?.selectTab(AppTab.portfolio);
      case AppRoutes.discover:
        shellKey.currentState?.selectTab(AppTab.discover);
      case AppRoutes.profile:
        shellKey.currentState?.selectTab(AppTab.profile);
      case AppRoutes.dividends:
      case AppRoutes.evolution:
      case AppRoutes.goals:
      case AppRoutes.simulator:
        shellKey.currentState?.selectTab(AppTab.invest);
        // Wait a frame when the tab (and its navigator) is being built.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          investNavigatorKey.currentState
              ?.popUntil((Route<dynamic> route) => route.isFirst);
          investNavigatorKey.currentState?.pushNamed(path);
        });
      case AppRoutes.newOperation:
      case AppRoutes.aiAssistant:
        Navigator.of(context, rootNavigator: true).pushNamed(path);
    }
  }
}
