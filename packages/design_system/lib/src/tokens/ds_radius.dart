import 'package:flutter/widgets.dart';

/// Corner radius scale — Figma `03. Espaçamento & Radius` (radius/md = 12,
/// radius/full = pill). The intermediate steps follow the base-4 rhythm.
abstract final class DsRadius {
  const DsRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xl2 = 24;

  /// Pill / circular — clamp with a large value.
  static const double full = 9999;

  static const Radius xsRadius = Radius.circular(xs);
  static const Radius smRadius = Radius.circular(sm);
  static const Radius mdRadius = Radius.circular(md);
  static const Radius lgRadius = Radius.circular(lg);
  static const Radius xlRadius = Radius.circular(xl);
  static const Radius xl2Radius = Radius.circular(xl2);
  static const Radius fullRadius = Radius.circular(full);

  static const BorderRadius xsAll = BorderRadius.all(xsRadius);
  static const BorderRadius smAll = BorderRadius.all(smRadius);
  static const BorderRadius mdAll = BorderRadius.all(mdRadius);
  static const BorderRadius lgAll = BorderRadius.all(lgRadius);
  static const BorderRadius xlAll = BorderRadius.all(xlRadius);
  static const BorderRadius xl2All = BorderRadius.all(xl2Radius);
  static const BorderRadius fullAll = BorderRadius.all(fullRadius);
}
