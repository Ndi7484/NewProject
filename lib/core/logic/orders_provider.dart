import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
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
  bool paramVoucherValid = false;
  void changeVoucherValid(bool value, Promo vochCode, context) {
    paramVoucherValid = value;
    if (value) {
      paramVoucherCode = vochCode;
    } else {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Text(
          'Voucher ${vochCode.promoID} is not valid',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ).show(context);
    }
    notifyListeners();
  }
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

  // calculation parameter
  // sub totals parameter
  int paramSubTotalsInt = 0;
  String paramSubTotals = '0';
  double paramDeliveryInt = 0;
  String paramDelivery = '0';
  double paramVoucherValInt = 0;
  String paramVoucherVal = '0';
  double paramPointsValInt = 0;
  String paramPointsVal = '0';
  // totals
  double paramTotalPayInt = 0;
  String paramTotalPay = '0';


  TypeOrder? _typeOrders;
  TypeOrder? get typeOrders => _typeOrders;
  set typeOrders(TypeOrder? value) {
    _typeOrders = value;
    notifyListeners();
  }

  void addOrders(key, context) {
    _listOrders[key] = (_listOrders[key] ?? 0) + 1;
    calculateSubTotals(context);
    notifyListeners();
  }

  void deleteOrders(key, context) {
    _listOrders[key] = (_listOrders[key] ?? 0) - 1;
    if (_listOrders[key]! < 0) {
      _listOrders[key] = 0;
    }
    calculateSubTotals(context);
    notifyListeners();
  }

  void calculateSubTotals(context) {
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
    paramSubTotals = formatter.format(totals).toString().replaceAll(',', '.');
    paramSubTotalsInt = totals;
    notifyListeners();
  }

  void resetParam() {
    _listOrders = {};
    paramAccountInformation = null;
    paramListOrder = null;
    paramVoucherCode = null;
    paramSubTotals = '0';
    paramSubTotalsInt = 0;
    pointsUse = false;
  }
}
