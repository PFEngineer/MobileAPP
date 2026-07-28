import 'package:flutter/foundation.dart';

/// Asset categories — Figma Carteira tabs (node 50:19).
enum AssetCategory {
  stocks('Ações'),
  reits('FIIs'),
  etfs('ETFs'),
  bdrs('BDRs'),
  treasury('Tesouro'),
  crypto('Cripto');

  const AssetCategory(this.label);

  final String label;
}

/// One position in the user's portfolio.
@immutable
class Asset {
  const Asset({
    required this.ticker,
    required this.name,
    required this.initials,
    required this.unitPrice,
    required this.totalValue,
    required this.category,
  });

  final String ticker;
  final String name;
  final String initials;
  final double unitPrice;
  final double totalValue;
  final AssetCategory category;
}
