/// Formats a value as Brazilian currency (e.g. `R$ 12.345,67`).
String formatBrl(double value) {
  final bool negative = value < 0;
  final List<String> parts = value.abs().toStringAsFixed(2).split('.');
  final String intPart = parts[0];

  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    final int posFromEnd = intPart.length - i;
    buffer.write(intPart[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write('.');
  }

  return '${negative ? '-' : ''}R\$ $buffer,${parts[1]}';
}

/// Formats a signed percentage (e.g. `+1.80%`, `-0.90%`).
String formatPercent(double value) {
  final String sign = value >= 0 ? '+' : '';
  return '$sign${value.toStringAsFixed(2)}%';
}
