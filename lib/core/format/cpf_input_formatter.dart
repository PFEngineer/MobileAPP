import 'package:flutter/services.dart';

import 'cpf.dart';

/// Live `000.000.000-00` mask for a CPF text field. Caps input at 11 digits
/// and keeps the caret at the end as punctuation is inserted.
class CpfInputFormatter extends TextInputFormatter {
  const CpfInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String masked = Cpf.format(newValue.text);
    return TextEditingValue(
      text: masked,
      selection: TextSelection.collapsed(offset: masked.length),
    );
  }
}
