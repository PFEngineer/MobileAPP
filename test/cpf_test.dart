import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/core/format/cpf.dart';

void main() {
  group('Cpf.format (mask)', () {
    test('masks progressively as digits arrive', () {
      expect(Cpf.format('529'), '529');
      expect(Cpf.format('529982'), '529.982');
      expect(Cpf.format('529982247'), '529.982.247');
      expect(Cpf.format('52998224725'), '529.982.247-25');
    });

    test('ignores non-digits and caps at 11 digits', () {
      expect(Cpf.format('abc529.982'), '529.982');
      expect(Cpf.format('5299822472599999'), '529.982.247-25');
    });
  });

  group('Cpf.isValid', () {
    test('accepts valid CPFs (masked or raw)', () {
      expect(Cpf.isValid('529.982.247-25'), isTrue);
      expect(Cpf.isValid('52998224725'), isTrue);
      expect(Cpf.isValid('168.995.350-09'), isTrue);
    });

    test('rejects wrong check digits', () {
      expect(Cpf.isValid('529.982.247-24'), isFalse);
      expect(Cpf.isValid('11122233300'), isFalse);
    });

    test('rejects repeated-digit sequences', () {
      for (int i = 0; i <= 9; i++) {
        expect(Cpf.isValid('$i' * 11), isFalse, reason: 'all $i');
      }
    });

    test('rejects wrong length', () {
      expect(Cpf.isValid('529982247'), isFalse);
      expect(Cpf.isValid('529982247259'), isFalse);
      expect(Cpf.isValid(''), isFalse);
    });
  });

  group('Cpf.validationError', () {
    test('returns targeted messages', () {
      expect(Cpf.validationError(''), 'Informe seu CPF');
      expect(Cpf.validationError('529.982'), 'O CPF deve ter 11 dígitos');
      expect(Cpf.validationError('529.982.247-24'), 'CPF inválido');
      expect(Cpf.validationError('529.982.247-25'), isNull);
    });
  });
}
