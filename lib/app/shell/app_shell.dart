import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:analytics/analytics.dart';
import 'package:design_system/design_system.dart';

import '../../features/discover/presentation/pages/discover_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/invest/presentation/pages/invest_hub_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../di/app_dependencies.dart';
import '../router/app_router.dart';
import '../router/app_routes.dart';

/// Bottom-navigation tabs — Figma `Bottom Navigation` (64:45).
enum AppTab { home, portfolio, invest, discover, profile }

/// Shell hosting the five tabs behind a [DsBottomNavigation]. The Investir
/// tab wraps a nested [Navigator] so its section screens keep the bar
/// visible (as in the Figma mocks).
class AppShell extends StatefulWidget {
  const AppShell({
    required this.router,
    required this.dependencies,
    super.key,
  });

  final AppRouter router;
  final AppDependencies dependencies;

  @override
  State<AppShell> createState() => AppShellState();
}

class AppShellState extends State<AppShell> {
  AppTab _current = AppTab.home;

  void selectTab(AppTab tab) {
    if (tab == _current) return;
    setState(() => _current = tab);
  }

  @override
  Widget build(BuildContext context) {
    final AppRouter router = widget.router;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Home and Perfil open with a purple hero behind the status bar.
      value: _current == AppTab.home || _current == AppTab.profile
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: IndexedStack(
          index: _current.index,
          children: <Widget>[
            HomePage(
              viewModel: widget.dependencies.homeViewModel,
              onNavigate: (String path) => router.go(context, path),
            ),
            PortfolioPage(
              viewModel: widget.dependencies.portfolioViewModel,
              onAddOperation: () =>
                  router.go(context, AppRoutes.newOperation),
            ),
            Navigator(
              key: router.investNavigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                if (settings.name == Navigator.defaultRouteName) {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (context) => InvestHubPage(
                      onOpen: (String path) => router.go(context, path),
                    ),
                  );
                }
                return router.onGenerateInvestRoute(settings);
              },
            ),
            DiscoverPage(viewModel: widget.dependencies.discoverViewModel),
            ProfilePage(viewModel: widget.dependencies.profileViewModel),
          ],
        ),
        bottomNavigationBar: DsBottomNavigation(
          currentIndex: _current.index,
          onChanged: (int index) {
            final AppTab tab = AppTab.values[index];
            AnalyticsService.trackClick('Tab ${_tabLabel(tab)}');
            if (tab == AppTab.invest && _current == AppTab.invest) {
              // Re-tapping resets the section to the hub.
              widget.router.investNavigatorKey.currentState
                  ?.popUntil((Route<dynamic> route) => route.isFirst);
            }
            selectTab(tab);
          },
          items: const <DsBottomNavItem>[
            DsBottomNavItem(icon: DsIcons.home, label: 'Início'),
            DsBottomNavItem(icon: DsIcons.wallet, label: 'Carteira'),
            DsBottomNavItem(icon: Icons.bar_chart, label: 'Investir'),
            DsBottomNavItem(icon: Icons.explore_outlined, label: 'Descobrir'),
            DsBottomNavItem(icon: Icons.person_outline, label: 'Perfil'),
          ],
        ),
      ),
    );
  }

  String _tabLabel(AppTab tab) => switch (tab) {
        AppTab.home => 'Início',
        AppTab.portfolio => 'Carteira',
        AppTab.invest => 'Investir',
        AppTab.discover => 'Descobrir',
        AppTab.profile => 'Perfil',
      };
}
