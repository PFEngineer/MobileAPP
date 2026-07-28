import 'package:flutter/material.dart';

/// Icon set — Figma `05. Ícones` (24×24, stroke 2px).
///
/// Mapped to the closest Material outlined glyphs so the package ships no SVG
/// assets. Reference icons by these semantic names, not by raw `Icons.*`, so a
/// future swap to bundled custom SVGs is a one-file change.
abstract final class DsIcons {
  const DsIcons._();

  static const IconData home = Icons.home_outlined;
  static const IconData chart = Icons.show_chart;
  static const IconData wallet = Icons.account_balance_wallet_outlined;
  static const IconData bell = Icons.notifications_outlined;
  static const IconData search = Icons.search;
  static const IconData plus = Icons.add;
  static const IconData plusCircle = Icons.add_circle_outline;
  static const IconData minus = Icons.remove;
  static const IconData arrowRight = Icons.arrow_forward;
  static const IconData edit = Icons.edit_outlined;
  static const IconData trash = Icons.delete_outline;
  static const IconData eye = Icons.visibility_outlined;
  static const IconData heart = Icons.favorite_border;
  static const IconData star = Icons.star_border;
  static const IconData moreVertical = Icons.more_vert;
  static const IconData check = Icons.check;
  static const IconData close = Icons.close;
}
