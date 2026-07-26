import 'package:flutter/material.dart';

import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Top app bar — Figma `Top App Bar`. Flat surface with a hairline bottom
/// border, a centered-left [title], optional [leading] and trailing [actions].
class DsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DsAppBar({
    required this.title,
    this.leading,
    this.actions = const <Widget>[],
    this.centerTitle = false,
    super.key,
  });

  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool centerTitle;

  static const double _height = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      height: _height + MediaQuery.paddingOf(context).top,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      decoration: BoxDecoration(
        color: ds.surface,
        border: Border(bottom: BorderSide(color: ds.border)),
      ),
      child: SizedBox(
        height: _height,
        child: Row(
          children: <Widget>[
            const SizedBox(width: DsSpacing.sm),
            if (leading != null)
              leading!
            else
              const SizedBox(width: DsSpacing.sm),
            Expanded(
              child: Text(
                title,
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: DsTypography.heading3.copyWith(color: ds.textPrimary),
              ),
            ),
            ...actions,
            const SizedBox(width: DsSpacing.sm),
          ],
        ),
      ),
    );
  }
}
