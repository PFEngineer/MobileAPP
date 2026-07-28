/// CPF formatting and validation (Brazilian taxpayer registry).
///
/// Implements every rule for a valid CPF:
/// 1. exactly 11 digits after stripping the mask;
/// 2. not a repeated single digit (`000.000.000-00`, `111…`, … are invalid
///    even though they pass the check-digit math);
/// 3. both check digits (positions 10 and 11) match the modulo-11 algorithm.
abstract final class Cpf {
  const Cpf._();

  /// Keeps only the 11 digits, e.g. `529.982.247-25` → `52998224725`.
  static String strip(String value) => value.replaceAll(RegExp(r'\D'), '');

  /// Applies the `000.000.000-00` mask to whatever digits are present,
  /// truncating anything past 11 digits. Safe for partial input.
  static String format(String value) {
    final String digits = strip(value);
    final String d =
        digits.length > 11 ? digits.substring(0, 11) : digits;
    final StringBuffer out = StringBuffer();
    for (int i = 0; i < d.length; i++) {
      if (i == 3 || i == 6) out.write('.');
      if (i == 9) out.write('-');
      out.write(d[i]);
    }
    return out.toString();
  }

  /// True when [value] (masked or not) is a structurally valid CPF.
  static bool isValid(String value) {
    final String d = strip(value);
    if (d.length != 11) return false;
    // Reject repeated digits (00000000000, 11111111111, …).
    if (RegExp(r'^(\d)\1{10}$').hasMatch(d)) return false;

    int checkDigit(int length) {
      int sum = 0;
      for (int i = 0; i < length; i++) {
        sum += int.parse(d[i]) * (length + 1 - i);
      }
      final int mod = (sum * 10) % 11;
      return mod == 10 ? 0 : mod;
    }

    return checkDigit(9) == int.parse(d[9]) &&
        checkDigit(10) == int.parse(d[10]);
  }

  /// Validation message for a login form, or `null` when [value] is valid.
  static String? validationError(String value) {
    final String d = strip(value);
    if (d.isEmpty) return 'Informe seu CPF';
    if (d.length != 11) return 'O CPF deve ter 11 dígitos';
    if (!isValid(value)) return 'CPF inválido';
    return null;
  }
}
