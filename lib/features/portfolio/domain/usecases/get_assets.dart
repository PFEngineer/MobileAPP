import '../entities/asset.dart';
import '../repositories/assets_repository.dart';

/// Fetches every position in the portfolio.
class GetAssets {
  const GetAssets(this._repository);

  final AssetsRepository _repository;

  Future<List<Asset>> call() => _repository.getAssets();
}
