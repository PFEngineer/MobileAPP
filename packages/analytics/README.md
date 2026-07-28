# analytics

Client usability analytics — a standalone Flutter package that wraps
[Amplitude](https://amplitude.com) with a small, Google-style event API
(`screen_view`, `click`, and a generic escape hatch).

## Why a separate package

The module lives in `mobile_app/packages/analytics` but is a fully isolated
package with its own `pubspec.yaml`. It **must not** depend on `mobile_app`
(or any app code) — the dependency arrow is always:

```
mobile_app  ──▶  analytics        (never the reverse)
```

This guarantees no cyclic dependency and lets us extract the package to its
own GitHub repository later with zero code changes. To extract:

1. Move `packages/analytics` to a new repo.
2. In `mobile_app/pubspec.yaml`, swap the path dependency for a git one:
   ```yaml
   analytics:
     git:
       url: git@github.com:your-org/analytics.git
       ref: v0.1.0
   ```

## Usage

```dart
import 'package:analytics/analytics.dart';

// Once, in main() — before runApp().
await AnalyticsService.init(apiKey);

// On screen mount (load-time event).
AnalyticsService.trackScreenView('Home');

// On an interaction's existing success handler.
AnalyticsService.trackClick('Começar');

// Anything outside the screen_view / click taxonomy.
AnalyticsService.trackEvent('signed_up', properties: {'plan': 'free'});
```

## Conventions

- Event names are `snake_case`, following Google/GA4's convention for
  standard interaction events (`screen_view`, `click`).
- `trackScreenView` / `trackClick` always carry `screen_name` /
  `element_name` respectively; extra context goes in `properties`.
- `AnalyticsService.init` is idempotent and must run exactly once, before any
  track call.

## Dev

```sh
flutter test        # unit tests
flutter analyze     # lint + type-check (strict analysis_options)
```
