import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Visual style of a [DsButton] — Figma `Botão` set, axis `Estilo`.
enum DsButtonVariant { primary, secondary, outline, text, destructive }

/// Size of a [DsButton].
enum DsButtonSize { small, medium, large }

/// The design-system button.
///
/// State (`Default/Hover/Pressed/Loading/Disabled`) is handled internally:
/// hover/pressed via Material's state layers, `Disabled` when [onPressed] is
/// null, and `Loading` via [isLoading] (which also blocks taps and swaps the
/// content for a spinner).
class DsButton extends StatelessWidget {
  const DsButton({
    required this.label,
    required this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.size = DsButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final DsButtonSize size;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;

  /// Stretches the button to the full available width.
  final bool expanded;

  bool get _enabled => onPressed != null && !isLoading;

  double get _height => switch (size) {
        DsButtonSize.small => 36,
        DsButtonSize.medium => 44,
        DsButtonSize.large => 52,
      };

  double get _horizontalPadding => switch (size) {
        DsButtonSize.small => DsSpacing.md,
        DsButtonSize.medium => DsSpacing.lg,
        DsButtonSize.large => DsSpacing.xl,
      };

  double get _iconSize => size == DsButtonSize.small ? 16 : 20;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    // Resolve foreground/background/border per variant. `_On` is the color used
    // for label + icons + spinner.
    final Color background;
    final Color foreground;
    final Color? borderColor;
    final Color overlayHover;
    final Color overlayPressed;

    switch (variant) {
      case DsButtonVariant.primary:
        background = ds.primary;
        foreground = ds.onPrimary;
        borderColor = null;
        overlayHover = ds.primaryHover;
        overlayPressed = ds.primaryPressed;
      case DsButtonVariant.secondary:
        background = ds.secondary;
        foreground = ds.onSecondary;
        borderColor = null;
        overlayHover = ds.onSecondary.withValues(alpha: 0.06);
        overlayPressed = ds.onSecondary.withValues(alpha: 0.12);
      case DsButtonVariant.outline:
        background = Colors.transparent;
        foreground = ds.textPrimary;
        borderColor = ds.borderStrong;
        overlayHover = ds.surfaceAlt;
        overlayPressed = ds.border;
      case DsButtonVariant.text:
        background = Colors.transparent;
        foreground = ds.primary;
        borderColor = null;
        overlayHover = ds.primary.withValues(alpha: 0.06);
        overlayPressed = ds.primary.withValues(alpha: 0.12);
      case DsButtonVariant.destructive:
        background = ds.danger;
        foreground = ds.onDanger;
        borderColor = null;
        overlayHover = ds.dangerHover;
        overlayPressed = ds.dangerHover;
    }

    final bool solid = variant == DsButtonVariant.primary ||
        variant == DsButtonVariant.secondary ||
        variant == DsButtonVariant.destructive;

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, _height)),
      fixedSize: WidgetStatePropertyAll(Size.fromHeight(_height)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: _horizontalPadding),
      ),
      textStyle: WidgetStatePropertyAll(
        (size == DsButtonSize.small
                ? DsTypography.labelMedium
                : DsTypography.bodyMedium)
            .copyWith(fontWeight: DsTypography.semiBold),
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: DsRadius.mdAll),
      ),
      side: borderColor == null
          ? null
          : WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: ds.border);
              }
              return BorderSide(color: borderColor!);
            }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return solid ? ds.disabledBackground : Colors.transparent;
        }
        // For solid variants, deepen the fill on hover/press so state reads on
        // top of an already-opaque background (state-layer overlays alone are
        // subtle on saturated fills).
        if (solid) {
          if (states.contains(WidgetState.pressed)) return overlayPressed;
          if (states.contains(WidgetState.hovered)) return overlayHover;
        }
        return background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return ds.disabledForeground;
        return foreground;
      }),
      overlayColor: solid
          ? const WidgetStatePropertyAll(Colors.transparent)
          : WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) return overlayPressed;
              if (states.contains(WidgetState.hovered)) return overlayHover;
              return Colors.transparent;
            }),
      elevation: const WidgetStatePropertyAll(0),
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    );

    final Widget child = _DsButtonContent(
      label: label,
      icon: icon,
      trailingIcon: trailingIcon,
      isLoading: isLoading,
      iconSize: _iconSize,
      spinnerColor: _enabled ? foreground : ds.disabledForeground,
    );

    final Widget button = TextButton(
      onPressed: _enabled ? onPressed : null,
      style: style,
      child: child,
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class _DsButtonContent extends StatelessWidget {
  const _DsButtonContent({
    required this.label,
    required this.icon,
    required this.trailingIcon,
    required this.isLoading,
    required this.iconSize,
    required this.spinnerColor,
  });

  final String label;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final double iconSize;
  final Color spinnerColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: iconSize,
        width: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: iconSize),
          const SizedBox(width: DsSpacing.sm),
        ],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
        if (trailingIcon != null) ...<Widget>[
          const SizedBox(width: DsSpacing.sm),
          Icon(trailingIcon, size: iconSize),
        ],
      ],
    );
  }
}
