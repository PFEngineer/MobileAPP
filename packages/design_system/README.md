# design_system

Turbi mobile design system — a standalone Flutter package with design **tokens**
and an **atomic-design** component library, generated from the Figma
`📐 Foundations` (INVESTAI design system, file `ICHnXdD2RpuUNQlrbPyi2o`).

## Why a separate package

The module lives in `mobile_app/packages/design_system` but is a fully isolated
package with its own `pubspec.yaml`. It **must not** depend on `mobile_app` (or
any app code) — the dependency arrow is always:

```
mobile_app  ──▶  design_system        (never the reverse)
```

This guarantees no cyclic dependency and lets us extract the package to its own
GitHub repository later with zero code changes. To extract:

1. Move `packages/design_system` to a new repo.
2. In `mobile_app/pubspec.yaml`, swap the path dependency for a git one:
   ```yaml
   design_system:
     git:
       url: git@github.com:turbi/design_system.git
       ref: v0.1.0
   ```

## Structure (atomic design)

```
lib/
├─ design_system.dart        # public API (barrel — import only this)
└─ src/
   ├─ tokens/                # source of truth — never hard-code values in widgets
   │  ├─ ds_colors.dart          primitive palette (purple/neutral/semantic)
   │  ├─ ds_color_scheme.dart    semantic roles (DsColorScheme.light())
   │  ├─ ds_spacing.dart         4px base scale
   │  ├─ ds_radius.dart          corner radii (md = 12, full = pill)
   │  ├─ ds_typography.dart      Inter type scale (8 styles)
   │  ├─ ds_elevation.dart       shadow scale (xs … 2xl)
   │  └─ ds_icons.dart           24×24 icon set
   ├─ theme/
   │  ├─ ds_theme.dart           DsTheme.light() → Material ThemeData
   │  └─ ds_theme_extension.dart context.dsColors accessor
   ├─ atoms/                 Button, TextField, Checkbox, Radio, Switch,
   │                         Avatar, Badge, Chip, Tag, Status, Progress, Indicator
   ├─ molecules/             Card, ListItem
   └─ organisms/             AppBar, Tabs, BottomNavigation
```

## Usage

```dart
import 'package:design_system/design_system.dart';

MaterialApp(
  theme: DsTheme.light(),
  home: Scaffold(
    body: DsButton(label: 'Reservar', icon: DsIcons.check, onPressed: () {}),
  ),
);
```

Read semantic colors from any widget via `context.dsColors` (e.g.
`context.dsColors.primary`). Always go through **semantic** roles, not raw
`DsColors`, so a future dark theme is a one-file change.

## Fonts

The type scale targets **Inter**. The font files are intentionally not bundled
to keep the package asset-free; without them Flutter falls back to the platform
font. To render Inter exactly, add the Inter `.ttf` files as assets to this
package under family `Inter`, or provide them from the host app.

## Conventions

- Public names are prefixed `Ds*`.
- Tokens are the only place literals live; components reference tokens.
- Components are stateless where possible; interactive state is lifted to the
  caller (controlled widgets).

## Dev

```sh
flutter test        # unit + widget tests
flutter analyze     # lint + type-check (strict analysis_options)
```
