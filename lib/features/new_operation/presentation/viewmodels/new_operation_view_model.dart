import 'package:flutter/foundation.dart';

import '../../domain/entities/operation.dart';
import '../../domain/usecases/save_operation.dart';

/// Presentation state for the Nova Operação modal (MVVM).
class NewOperationViewModel extends ChangeNotifier {
  NewOperationViewModel({required SaveOperation saveOperation})
      : _saveOperation = saveOperation;

  final SaveOperation _saveOperation;

  static const List<String> assetOptions = <String>[
    'PETR4 - Petrobras PN',
    'ITSA4 - Itaúsa PN',
    'IVVB11 - iShares S&P 500',
    'XPML11 - XP Malls',
  ];
  static const List<String> brokerOptions = <String>[
    'XP Investimentos',
    'Rico',
    'NuInvest',
    'Inter',
  ];

  OperationSide _side = OperationSide.buy;
  String _asset = assetOptions.first;
  int _quantity = 100;
  double _unitPrice = 34.00;
  DateTime _date = DateTime(2024, 6, 22);
  String _broker = brokerOptions.first;
  final double _fees = 5.00;
  bool _isSaving = false;

  OperationSide get side => _side;
  String get asset => _asset;
  int get quantity => _quantity;
  double get unitPrice => _unitPrice;
  DateTime get date => _date;
  String get broker => _broker;
  double get fees => _fees;
  bool get isSaving => _isSaving;

  double get total => _quantity * _unitPrice + _fees;

  String get formattedDate =>
      '${_date.day.toString().padLeft(2, '0')}/'
      '${_date.month.toString().padLeft(2, '0')}/${_date.year}';

  void selectSide(OperationSide side) {
    if (side == _side) return;
    _side = side;
    notifyListeners();
  }

  void selectAsset(String asset) {
    _asset = asset;
    notifyListeners();
  }

  void selectBroker(String broker) {
    _broker = broker;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void setQuantity(String raw) {
    _quantity = int.tryParse(raw) ?? 0;
    notifyListeners();
  }

  void setUnitPrice(String raw) {
    final String normalized =
        raw.replaceAll(RegExp(r'[^\d,\.]'), '').replaceAll(',', '.');
    _unitPrice = double.tryParse(normalized) ?? 0;
    notifyListeners();
  }

  Future<void> save() async {
    _isSaving = true;
    notifyListeners();
    try {
      await _saveOperation(
        Operation(
          side: _side,
          assetLabel: _asset,
          quantity: _quantity,
          unitPrice: _unitPrice,
          date: _date,
          broker: _broker,
          fees: _fees,
        ),
      );
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
