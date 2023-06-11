import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum TypeOrder { delivery, takeaway, dinein, fail }

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
  // format helper
  NumberFormat formatter = NumberFormat("#,###", "en_US");

  // list of orders that must be filled
  // TypeOrder? paramTypeOrder;
  // String? paramTakeawayCode;
  // String? paramDineInCode;
  Account? paramAccountInformation;
  List<FoodMenu>? paramListOrder;
  Promo? paramVoucherCode;
  // end
  // helper parameters

  // main parameters
  Map<String, int> _listOrders = {};
  Map<String, int> get listOrders => _listOrders;
  bool _pointsUse = false;
  bool get pointsUse => _pointsUse;
  set pointsUse(value) {
    _pointsUse = value;
    notifyListeners();
  }

  int paramTotalsInt = 0;
  String paramTotals = '0';

  TypeOrder? _typeOrders;
  TypeOrder? get typeOrders => _typeOrders;
  set typeOrders(TypeOrder? value) {
    _typeOrders = value;
    notifyListeners();
  }

  void addOrders(key, context) {
    _listOrders[key] = (_listOrders[key] ?? 0) + 1;
    calculateTotals(context);
    notifyListeners();
  }

  void deleteOrders(key, context) {
    _listOrders[key] = (_listOrders[key] ?? 0) - 1;
    if (_listOrders[key]! < 0) {
      _listOrders[key] = 0;
    }
    calculateTotals(context);
    notifyListeners();
  }

  void calculateTotals(context) {
    MenuProvider provMenu = Provider.of<MenuProvider>(context, listen: false);
    int totals = 0;
    var arrKey = listOrders.keys.toList();
    for (var el in arrKey) {
      FoodMenu? found = provMenu.listFoodMenu.firstWhere(
          (menu) => menu.menuID == el,
          orElse: () => FoodMenu(
              menuID: 'XXX',
              menuCategory: 'xxx',
              menuName: 'xxx',
              menuShortDesc: 'xxx',
              menuLongDesc: 'xxx',
              menuImage: 'xxx',
              menuPrice: 0,
              menuPriceString: '0'));
      totals = totals + found.menuPrice * int.parse(listOrders[el].toString());
    }
    paramTotals = formatter.format(totals).toString().replaceAll(',', '.');
    paramTotalsInt = totals;
    notifyListeners();
  }

  void resetParam() {
    _listOrders = {};
    paramAccountInformation = null;
    paramListOrder = null;
    paramVoucherCode = null;
    paramTotals = '0';
    paramTotalsInt = 0;
    pointsUse = false;
  }
}
