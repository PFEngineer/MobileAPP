import 'dart:ui';

import 'ds_colors.dart';

/// Semantic color roles — the layer widgets should consume.
///
/// Mirrors the Figma `Cores Semânticas` collection (mode "Claro"). A dark
/// variant can be added later as a second factory without touching widgets,
/// because components read roles (e.g. [primary], [textSecondary]) rather than
/// raw [DsColors].
class DsColorScheme {
  const DsColorScheme({
    required this.brightness,
    required this.primary,
    required this.primaryHover,
    required this.primaryPressed,
    required this.primarySubtle,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.success,
    required this.successSubtle,
    required this.onSuccess,
    required this.danger,
    required this.dangerHover,
    required this.dangerSubtle,
    required this.onDanger,
    required this.warning,
    required this.warningSubtle,
    required this.onWarning,
    required this.info,
    required this.infoSubtle,
    required this.onInfo,
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.border,
    required this.borderStrong,
    required this.borderFocus,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.overlay,
  });

  /// Light theme ("Claro") — the only mode defined in Figma today.
  factory DsColorScheme.light() => const DsColorScheme(
        brightness: Brightness.light,
        primary: DsColors.purple500,
        primaryHover: DsColors.purple600,
        primaryPressed: DsColors.purple700,
        primarySubtle: DsColors.purple50,
        onPrimary: DsColors.neutral0,
        secondary: DsColors.purple100,
        onSecondary: DsColors.purple700,
        success: DsColors.green500,
        successSubtle: Color(0xFFDCFCE7),
        onSuccess: DsColors.neutral0,
        danger: DsColors.red500,
        dangerHover: Color(0xFFDC2626),
        dangerSubtle: Color(0xFFFEE2E2),
        onDanger: DsColors.neutral0,
        warning: DsColors.orange500,
        warningSubtle: Color(0xFFFFEDD5),
        onWarning: DsColors.neutral0,
        info: DsColors.blue500,
        infoSubtle: Color(0xFFDBEAFE),
        onInfo: DsColors.neutral0,
        background: DsColors.neutral50,
        surface: DsColors.neutral0,
        surfaceAlt: DsColors.neutral100,
        textPrimary: DsColors.neutral900,
        textSecondary: DsColors.neutral600,
        textTertiary: DsColors.neutral400,
        textDisabled: DsColors.neutral400,
        textInverse: DsColors.neutral0,
        border: DsColors.neutral200,
        borderStrong: DsColors.neutral300,
        borderFocus: DsColors.purple500,
        disabledBackground: DsColors.neutral100,
        disabledForeground: DsColors.neutral400,
        overlay: Color(0x99111827),
      );

  final Brightness brightness;

  final Color primary;
  final Color primaryHover;
  final Color primaryPressed;
  final Color primarySubtle;
  final Color onPrimary;

  final Color secondary;
  final Color onSecondary;

  final Color success;
  final Color successSubtle;
  final Color onSuccess;

  final Color danger;
  final Color dangerHover;
  final Color dangerSubtle;
  final Color onDanger;

  final Color warning;
  final Color warningSubtle;
  final Color onWarning;

  final Color info;
  final Color infoSubtle;
  final Color onInfo;

  final Color background;
  final Color surface;
  final Color surfaceAlt;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;

  final Color border;
  final Color borderStrong;
  final Color borderFocus;

  final Color disabledBackground;
  final Color disabledForeground;

  final Color overlay;

  DsColorScheme copyWith({
    Brightness? brightness,
    Color? primary,
    Color? primaryHover,
    Color? primaryPressed,
    Color? primarySubtle,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? success,
    Color? successSubtle,
    Color? onSuccess,
    Color? danger,
    Color? dangerHover,
    Color? dangerSubtle,
    Color? onDanger,
    Color? warning,
    Color? warningSubtle,
    Color? onWarning,
    Color? info,
    Color? infoSubtle,
    Color? onInfo,
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textInverse,
    Color? border,
    Color? borderStrong,
    Color? borderFocus,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? overlay,
  }) {
    return DsColorScheme(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primarySubtle: primarySubtle ?? this.primarySubtle,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      success: success ?? this.success,
      successSubtle: successSubtle ?? this.successSubtle,
      onSuccess: onSuccess ?? this.onSuccess,
      danger: danger ?? this.danger,
      dangerHover: dangerHover ?? this.dangerHover,
      dangerSubtle: dangerSubtle ?? this.dangerSubtle,
      onDanger: onDanger ?? this.onDanger,
      warning: warning ?? this.warning,
      warningSubtle: warningSubtle ?? this.warningSubtle,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      infoSubtle: infoSubtle ?? this.infoSubtle,
      onInfo: onInfo ?? this.onInfo,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInverse: textInverse ?? this.textInverse,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      borderFocus: borderFocus ?? this.borderFocus,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      overlay: overlay ?? this.overlay,
    );
  }

  /// Linear interpolation between two schemes (used by the ThemeExtension so
  /// theme transitions animate).
  static DsColorScheme lerp(DsColorScheme a, DsColorScheme b, double t) {
    Color c(Color x, Color y) => Color.lerp(x, y, t) ?? y;
    return DsColorScheme(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      primary: c(a.primary, b.primary),
      primaryHover: c(a.primaryHover, b.primaryHover),
      primaryPressed: c(a.primaryPressed, b.primaryPressed),
      primarySubtle: c(a.primarySubtle, b.primarySubtle),
      onPrimary: c(a.onPrimary, b.onPrimary),
      secondary: c(a.secondary, b.secondary),
      onSecondary: c(a.onSecondary, b.onSecondary),
      success: c(a.success, b.success),
      successSubtle: c(a.successSubtle, b.successSubtle),
      onSuccess: c(a.onSuccess, b.onSuccess),
      danger: c(a.danger, b.danger),
      dangerHover: c(a.dangerHover, b.dangerHover),
      dangerSubtle: c(a.dangerSubtle, b.dangerSubtle),
      onDanger: c(a.onDanger, b.onDanger),
      warning: c(a.warning, b.warning),
      warningSubtle: c(a.warningSubtle, b.warningSubtle),
      onWarning: c(a.onWarning, b.onWarning),
      info: c(a.info, b.info),
      infoSubtle: c(a.infoSubtle, b.infoSubtle),
      onInfo: c(a.onInfo, b.onInfo),
      background: c(a.background, b.background),
      surface: c(a.surface, b.surface),
      surfaceAlt: c(a.surfaceAlt, b.surfaceAlt),
      textPrimary: c(a.textPrimary, b.textPrimary),
      textSecondary: c(a.textSecondary, b.textSecondary),
      textTertiary: c(a.textTertiary, b.textTertiary),
      textDisabled: c(a.textDisabled, b.textDisabled),
      textInverse: c(a.textInverse, b.textInverse),
      border: c(a.border, b.border),
      borderStrong: c(a.borderStrong, b.borderStrong),
      borderFocus: c(a.borderFocus, b.borderFocus),
      disabledBackground: c(a.disabledBackground, b.disabledBackground),
      disabledForeground: c(a.disabledForeground, b.disabledForeground),
      overlay: c(a.overlay, b.overlay),
    );
  }
}
