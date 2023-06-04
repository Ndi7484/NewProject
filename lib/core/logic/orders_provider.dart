import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';

enum TypeOrder { delivery, takeaway, dinein }

class OrdersCart {
  OrdersCart({
    required this.typeOrder,
    this.takeawayCode,
    this.dineInCode,
    required this.accountInformation,
    required this.listOrder,
    required this.voucherCode,
    required this.pointsUse,
  });
  TypeOrder typeOrder;
  String? takeawayCode;
  String? dineInCode;
  Account accountInformation;
  List<FoodMenu> listOrder;
  Promo voucherCode;
  bool pointsUse;
}

class OrdersProvider extends ChangeNotifier {
  // list of orders that must be filled
  TypeOrder? paramTypeOrder;
  String? paramTakeawayCode;
  String? paramDineInCode;
  Account? paramAccountInformation;
  List<FoodMenu>? paramListOrder;
  Promo? paramVoucherCode;
  bool pointsUse = false;
  // end
  // helper parameters

  // main parameters
  Map<String, int> _listOrders = {};
  Map<String, int> get listOrders => _listOrders;

  void addOrders(key) {
    _listOrders[key] = (_listOrders[key] ?? 0) + 1;
    notifyListeners();
  }

  void deleteOrders(key) {
    _listOrders[key] = (_listOrders[key] ?? 0) - 1;
    if (_listOrders[key]! < 0) {
      _listOrders[key] = 0;
    }
    notifyListeners();
  }

  void resetParam() {
    paramTypeOrder = null;
    paramTakeawayCode = null;
    paramDineInCode = null;
    paramAccountInformation = null;
    paramListOrder = null;
    paramVoucherCode = null;
    pointsUse = false;
  }
}
