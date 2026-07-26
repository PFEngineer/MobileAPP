/// Turbi mobile design system.
///
/// Atomic-design component library plus design tokens generated from the Figma
/// foundations. This package has **no dependency on the host app** — the
/// dependency arrow is always `app -> design_system` — so it can be lifted into
/// its own repository unchanged.
///
/// Layers:
/// - `tokens/`  — primitives, semantic colors, spacing, radius, typography,
///   elevation, icons (the source of truth; never hard-code values in widgets).
/// - `theme/`   — [DsTheme] builds Material `ThemeData`; [DsThemeExtension]
///   exposes semantic colors via `context.dsColors`.
/// - `atoms/`, `molecules/`, `organisms/` — components.
library;

// Tokens
export 'src/tokens/ds_colors.dart';
export 'src/tokens/ds_color_scheme.dart';
export 'src/tokens/ds_spacing.dart';
export 'src/tokens/ds_radius.dart';
export 'src/tokens/ds_typography.dart';
export 'src/tokens/ds_elevation.dart';
export 'src/tokens/ds_icons.dart';

// Theme
export 'src/theme/ds_theme.dart';
export 'src/theme/ds_theme_extension.dart';

// Atoms
export 'src/atoms/ds_tone.dart';
export 'src/atoms/ds_button.dart';
export 'src/atoms/ds_text_field.dart';
export 'src/atoms/ds_checkbox.dart';
export 'src/atoms/ds_radio.dart';
export 'src/atoms/ds_switch.dart';
export 'src/atoms/ds_avatar.dart';
export 'src/atoms/ds_badge.dart';
export 'src/atoms/ds_chip.dart';
export 'src/atoms/ds_tag.dart';
export 'src/atoms/ds_status.dart';
export 'src/atoms/ds_progress.dart';
export 'src/atoms/ds_indicator.dart';

// Molecules
export 'src/molecules/ds_card.dart';
export 'src/molecules/ds_list_item.dart';

// Organisms
export 'src/organisms/ds_app_bar.dart';
export 'src/organisms/ds_tabs.dart';
export 'src/organisms/ds_bottom_navigation.dart';
