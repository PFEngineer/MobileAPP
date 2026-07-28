import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/asset.dart';

/// Asset row from Figma `List Item` (48:20): bordered white card with a
/// square initials logo, ticker/name, unit price / total and a chevron.
class AssetListItem extends StatelessWidget {
  const AssetListItem({required this.asset, this.onTap, super.key});

  final Asset asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      decoration: BoxDecoration(
        color: ds.surface,
        borderRadius: DsRadius.mdAll,
        border: Border.all(color: ds.border),
      ),
      child: DsListItem(
        title: asset.ticker,
        subtitle: asset.name,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: DsColors.neutral100,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            asset.initials,
            style: DsTypography.bodyMedium.copyWith(
              fontSize: 13,
              fontWeight: DsTypography.semiBold,
              color: ds.textPrimary,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  Brl.format(asset.unitPrice),
                  style: DsTypography.bodyMedium.copyWith(
                    fontWeight: DsTypography.semiBold,
                    color: ds.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  Brl.format(asset.totalValue),
                  style: DsTypography.labelMedium.copyWith(
                    color: ds.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: DsSpacing.sm),
            Icon(Icons.chevron_right, color: ds.textTertiary),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
