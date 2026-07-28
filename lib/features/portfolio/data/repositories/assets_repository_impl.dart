import '../../domain/entities/asset.dart';
import '../../domain/repositories/assets_repository.dart';
import '../datasources/assets_local_data_source.dart';

/// Data-layer implementation of [AssetsRepository], backed by fixtures.
class AssetsRepositoryImpl implements AssetsRepository {
  const AssetsRepositoryImpl(this._dataSource);

  final AssetsLocalDataSource _dataSource;

  @override
  Future<List<Asset>> getAssets() => _dataSource.fetchAssets();
}
