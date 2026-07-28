/// Money formatting helpers (pt-BR), shared by every feature. Kept manual to
/// avoid pulling `intl` for a single locale.
abstract final class Brl {
  const Brl._();

  /// `125430.5` → `R$ 125.430,50`
  static String format(double value) {
    final bool negative = value < 0;
    final int cents = (value.abs() * 100).round();
    final String integerPart = (cents ~/ 100).toString();
    final String decimalPart = (cents % 100).toString().padLeft(2, '0');
    final StringBuffer grouped = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      final int remaining = integerPart.length - i;
      grouped.write(integerPart[i]);
      if (remaining > 1 && remaining % 3 == 1) grouped.write('.');
    }
    return '${negative ? '-' : ''}R\$ $grouped,$decimalPart';
  }

  /// `2.66` → `2,66%`
  static String percent(double value, {int decimals = 2}) =>
      '${value.toStringAsFixed(decimals).replaceAll('.', ',')}%';
}
