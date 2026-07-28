import '../../domain/entities/asset.dart';

/// In-memory fixture source — the exact positions from Figma 02. Carteira.
class AssetsLocalDataSource {
  const AssetsLocalDataSource();

  Future<List<Asset>> fetchAssets() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <Asset>[
      Asset(
        ticker: 'PETR4',
        name: 'Petrobras',
        initials: 'PE',
        unitPrice: 34.00,
        totalValue: 3400.00,
        category: AssetCategory.stocks,
      ),
      Asset(
        ticker: 'ITSA4',
        name: 'Itaúsa',
        initials: 'IT',
        unitPrice: 10.80,
        totalValue: 540.00,
        category: AssetCategory.stocks,
      ),
      Asset(
        ticker: 'IVVB11',
        name: 'iShares S&P 500',
        initials: 'IV',
        unitPrice: 410.00,
        totalValue: 20500.00,
        category: AssetCategory.etfs,
      ),
      Asset(
        ticker: 'XPML11',
        name: 'XP Malls',
        initials: 'XP',
        unitPrice: 98.50,
        totalValue: 2955.00,
        category: AssetCategory.reits,
      ),
      Asset(
        ticker: 'TESOURO IPCA+ 2035',
        name: 'Tesouro Direto',
        initials: 'TD',
        unitPrice: 4320.10,
        totalValue: 43201.00,
        category: AssetCategory.treasury,
      ),
      Asset(
        ticker: 'BTC',
        name: 'Bitcoin',
        initials: 'BT',
        unitPrice: 198450.00,
        totalValue: 29787.50,
        category: AssetCategory.crypto,
      ),
    ];
  }
}
