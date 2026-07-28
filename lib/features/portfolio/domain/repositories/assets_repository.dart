import '../entities/asset.dart';

/// Domain contract for the user's asset positions.
abstract interface class AssetsRepository {
  Future<List<Asset>> getAssets();
}
