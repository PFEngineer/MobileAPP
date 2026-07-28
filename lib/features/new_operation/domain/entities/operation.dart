import 'package:flutter/foundation.dart';

/// Buy/sell side of an operation — Figma segmented control (71:183).
enum OperationSide {
  buy('Compra'),
  sell('Venda');

  const OperationSide(this.label);

  final String label;
}

/// A trade the user records manually (Figma 03. Nova Operação).
@immutable
class Operation {
  const Operation({
    required this.side,
    required this.assetLabel,
    required this.quantity,
    required this.unitPrice,
    required this.date,
    required this.broker,
    required this.fees,
  });

  final OperationSide side;
  final String assetLabel;
  final int quantity;
  final double unitPrice;
  final DateTime date;
  final String broker;
  final double fees;

  double get total => quantity * unitPrice + fees;
}
