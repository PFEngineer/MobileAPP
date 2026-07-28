import '../../features/ai_assistant/data/datasources/assistant_local_data_source.dart';
import '../../features/ai_assistant/data/repositories/assistant_repository_impl.dart';
import '../../features/ai_assistant/domain/usecases/assistant_usecases.dart';
import '../../features/ai_assistant/presentation/viewmodels/assistant_view_model.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/presentation/viewmodels/login_view_model.dart';
import '../../features/discover/data/datasources/discover_local_data_source.dart';
import '../../features/discover/data/repositories/discover_repository_impl.dart';
import '../../features/discover/domain/usecases/get_discover_feed.dart';
import '../../features/discover/presentation/viewmodels/discover_view_model.dart';
import '../../features/dividends/data/datasources/dividends_local_data_source.dart';
import '../../features/dividends/data/repositories/dividends_repository_impl.dart';
import '../../features/dividends/domain/usecases/get_dividends.dart';
import '../../features/dividends/presentation/viewmodels/dividends_view_model.dart';
import '../../features/evolution/data/datasources/evolution_local_data_source.dart';
import '../../features/evolution/data/repositories/evolution_repository_impl.dart';
import '../../features/evolution/domain/usecases/get_evolution.dart';
import '../../features/evolution/presentation/viewmodels/evolution_view_model.dart';
import '../../features/goals/data/datasources/goals_local_data_source.dart';
import '../../features/goals/data/repositories/goals_repository_impl.dart';
import '../../features/goals/domain/usecases/get_goals.dart';
import '../../features/goals/presentation/viewmodels/goals_view_model.dart';
import '../../features/home/data/datasources/portfolio_local_data_source.dart';
import '../../features/home/data/repositories/portfolio_repository_impl.dart';
import '../../features/home/domain/usecases/get_dashboard_stats.dart';
import '../../features/home/domain/usecases/get_portfolio_summary.dart';
import '../../features/home/presentation/viewmodels/home_view_model.dart';
import '../../features/new_operation/data/repositories/operations_repository_impl.dart';
import '../../features/new_operation/domain/usecases/save_operation.dart';
import '../../features/new_operation/presentation/viewmodels/new_operation_view_model.dart';
import '../../features/portfolio/data/datasources/assets_local_data_source.dart';
import '../../features/portfolio/data/repositories/assets_repository_impl.dart';
import '../../features/portfolio/domain/usecases/get_assets.dart';
import '../../features/portfolio/presentation/viewmodels/portfolio_view_model.dart';
import '../../features/profile/data/datasources/profile_local_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/presentation/viewmodels/profile_view_model.dart';
import '../../features/simulator/domain/usecases/calculate_future_value.dart';
import '../../features/simulator/presentation/viewmodels/simulator_view_model.dart';

/// Composition root: wires data source -> repository -> use case -> view
/// model for every feature. Swap a piece here (e.g. a real API data source)
/// without touching the layers themselves.
class AppDependencies {
  AppDependencies() {
    final portfolioRepository =
        const PortfolioRepositoryImpl(PortfolioLocalDataSource());
    homeViewModel = HomeViewModel(
      getPortfolioSummary: GetPortfolioSummary(portfolioRepository),
      getDashboardStats: GetDashboardStats(portfolioRepository),
      getPortfolioAllocation: GetPortfolioAllocation(portfolioRepository),
    );

    portfolioViewModel = PortfolioViewModel(
      getAssets: GetAssets(
        const AssetsRepositoryImpl(AssetsLocalDataSource()),
      ),
    );

    final dividendsRepository =
        const DividendsRepositoryImpl(DividendsLocalDataSource());
    dividendsViewModel = DividendsViewModel(
      getUpcomingPayments: GetUpcomingPayments(dividendsRepository),
      getMonthlyReceived: GetMonthlyReceived(dividendsRepository),
    );

    goalsViewModel = GoalsViewModel(
      getGoals: GetGoals(const GoalsRepositoryImpl(GoalsLocalDataSource())),
    );

    simulatorViewModel = SimulatorViewModel(
      calculateFutureValue: const CalculateFutureValue(),
    );

    final discoverRepository =
        const DiscoverRepositoryImpl(DiscoverLocalDataSource());
    discoverViewModel = DiscoverViewModel(
      getInsights: GetInsights(discoverRepository),
      getRecommendedContent: GetRecommendedContent(discoverRepository),
    );

    profileViewModel = ProfileViewModel(
      getProfile: GetProfile(
        const ProfileRepositoryImpl(ProfileLocalDataSource()),
      ),
    );
  }

  late final HomeViewModel homeViewModel;
  late final PortfolioViewModel portfolioViewModel;
  late final DividendsViewModel dividendsViewModel;
  late final GoalsViewModel goalsViewModel;
  late final SimulatorViewModel simulatorViewModel;
  late final DiscoverViewModel discoverViewModel;
  late final ProfileViewModel profileViewModel;

  /// Pushed screens get a fresh view model per navigation.
  LoginViewModel buildLoginViewModel() => LoginViewModel(
        login: Login(const AuthRepositoryImpl(AuthLocalDataSource())),
      );

  EvolutionViewModel buildEvolutionViewModel() => EvolutionViewModel(
        getEvolution: GetEvolution(
          const EvolutionRepositoryImpl(EvolutionLocalDataSource()),
        ),
      );

  NewOperationViewModel buildNewOperationViewModel() => NewOperationViewModel(
        saveOperation: SaveOperation(const OperationsRepositoryImpl()),
      );

  AssistantViewModel buildAssistantViewModel() {
    final repository =
        const AssistantRepositoryImpl(AssistantLocalDataSource());
    return AssistantViewModel(
      getConversation: GetConversation(repository),
      sendAssistantMessage: SendAssistantMessage(repository),
    );
  }
}
