/// Client usability analytics.
///
/// Thin wrapper around Amplitude exposing Google-style event names
/// (`screen_view`, `click`) so screens and components can instrument
/// usability without depending on the Amplitude SDK directly. This package
/// has **no dependency on the host app** — the dependency arrow is always
/// `app -> analytics` — so it can be lifted into its own repository
/// unchanged.
library;

export 'src/analytics_service.dart';
