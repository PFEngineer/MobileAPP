import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Text input — Figma `Input` composed with `Campo` (label + helper/error).
///
/// Wraps a labelled column around a Material [TextField] styled with DS tokens.
/// Passing [errorText] flips the field to the error state.
class DsTextField extends StatelessWidget {
  const DsTextField({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final FocusNode? focusNode;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: DsRadius.mdAll,
          borderSide: BorderSide(color: color, width: width),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: DsTypography.labelMedium.copyWith(
              color: enabled ? ds.textSecondary : ds.textDisabled,
              fontWeight: DsTypography.medium,
            ),
          ),
          const SizedBox(height: DsSpacing.xs),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          maxLines: obscureText ? 1 : maxLines,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: DsTypography.bodyMedium.copyWith(color: ds.textPrimary),
          cursorColor: ds.primary,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: enabled ? ds.surface : ds.disabledBackground,
            hintText: hint,
            hintStyle: DsTypography.bodyMedium.copyWith(color: ds.textTertiary),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DsSpacing.md,
              vertical: DsSpacing.md,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: 20, color: ds.textTertiary),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    icon: Icon(suffixIcon, size: 20, color: ds.textTertiary),
                    onPressed: onSuffixTap,
                    splashRadius: 20,
                  ),
            enabledBorder: border(_hasError ? ds.danger : ds.border),
            focusedBorder:
                border(_hasError ? ds.danger : ds.borderFocus, width: 1.5),
            disabledBorder: border(ds.border),
            errorBorder: border(ds.danger),
            focusedErrorBorder: border(ds.danger, width: 1.5),
          ),
        ),
        if (_hasError || (helperText != null && helperText!.isNotEmpty)) ...[
          const SizedBox(height: DsSpacing.xs),
          Text(
            _hasError ? errorText! : helperText!,
            style: DsTypography.caption.copyWith(
              color: _hasError ? ds.danger : ds.textTertiary,
            ),
          ),
        ],
      ],
    );
  }
}
