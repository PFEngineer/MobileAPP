/// Central route table. Every screen redirect in the app goes through these
/// paths — they double as future deeplink paths (e.g. `investai://carteira`),
/// so never navigate with an inline widget; always push a named route.
abstract final class AppRoutes {
  const AppRoutes._();

  /// Entry screen.
  static const String login = '/login';

  /// Shell with the bottom navigation (Início tab).
  static const String home = '/';

  // Tabs inside the shell — deeplinking to one opens the shell on that tab.
  static const String dashboard = '/dashboard';
  static const String portfolio = '/carteira';
  static const String discover = '/descobrir';
  static const String profile = '/perfil';

  // Pushed screens.
  static const String newOperation = '/nova-operacao';
  static const String dividends = '/dividendos';
  static const String evolution = '/evolucao';
  static const String goals = '/metas';
  static const String simulator = '/simulador';
  static const String aiAssistant = '/assistente';
}
