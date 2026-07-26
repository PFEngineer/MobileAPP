import 'package:flutter/widgets.dart';

/// Elevation / shadow scale — Figma `04. Elevation & Sombras` (xs … 2xl).
///
/// Each level is a ready-to-use `List<BoxShadow>` for `BoxDecoration.boxShadow`.
abstract final class DsElevation {
  const DsElevation._();

  static const Color _shadow = Color(0x1A111827); // neutral/900 @ 10%
  static const Color _shadowSoft = Color(0x0D111827); // neutral/900 @ 5%

  static const List<BoxShadow> none = <BoxShadow>[];

  static const List<BoxShadow> xs = <BoxShadow>[
    BoxShadow(color: _shadowSoft, blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> sm = <BoxShadow>[
    BoxShadow(color: _shadow, blurRadius: 4, offset: Offset(0, 2)),
    BoxShadow(color: _shadowSoft, blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> md = <BoxShadow>[
    BoxShadow(color: _shadow, blurRadius: 8, offset: Offset(0, 4)),
    BoxShadow(color: _shadowSoft, blurRadius: 4, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> lg = <BoxShadow>[
    BoxShadow(color: _shadow, blurRadius: 16, offset: Offset(0, 8)),
    BoxShadow(color: _shadowSoft, blurRadius: 6, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> xl = <BoxShadow>[
    BoxShadow(color: _shadow, blurRadius: 24, offset: Offset(0, 12)),
    BoxShadow(color: _shadowSoft, blurRadius: 8, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> xl2 = <BoxShadow>[
    BoxShadow(color: _shadow, blurRadius: 40, offset: Offset(0, 20)),
    BoxShadow(color: _shadowSoft, blurRadius: 12, offset: Offset(0, 8)),
  ];
}
