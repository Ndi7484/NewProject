import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum TypeOrder { delivery, takeaway, dinein, fail }

class OrdersCart {
  OrdersCart({
    required this.typeOrder,
    this.deliveryAddress,
    this.takeawayAddress,
    this.dineInCode,
    required this.accountInformation,
    required this.listOrder,
    required this.voucherCode,
    required this.pointsUse,
    this.muchPoints,
  });
  TypeOrder typeOrder;
  Alamat? deliveryAddress;
  Alamat? takeawayAddress;
  String? dineInCode;
  Account accountInformation;
  List<FoodMenu> listOrder;
  Promo voucherCode;
  bool pointsUse;
  int? muchPoints;
}

class OrdersProvider extends ChangeNotifier {
  // format helper
  NumberFormat formatter = NumberFormat("#,###", "en_US");

  // main parameters
  Map<String, int> _listOrders = {};
  Map<String, int> get listOrders => _listOrders;

  // list of orders that must be filled : list takeaway or dine-in
  Alamat? paramTakeawayAlamat;
  String? paramDineInCode;

  // account info
  Account? paramAccountInformation;
  List<FoodMenu>? paramListOrder;

  // helper function
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
  // end..helper function

  // points calculation
  bool _pointsUse = false;
  bool get pointsUse => _pointsUse;
  int paramMuchPoints = 0;
  String paramMuchPointsStr = '';
  setPointsUse(value, Account account) {
    _pointsUse = value;
    if (_pointsUse) {
      int tmp = ((paramSubTotalsInt - paramVoucherDisc) * 0.5).floor();
      if (tmp > 150000) {
        tmp = 150000;
      }
      if (account.points < tmp) {
        tmp = account.points;
      }
      paramMuchPoints = tmp;
      paramMuchPointsStr =
          formatter.format(tmp).toString().replaceAll(',', '.');
    }
    countTotals();
    // notifyListeners();
  }

  // voucher based code checker
  Promo? paramVoucherCode;
  bool paramVoucherValid = false;
  int paramVoucherDisc = 0;
  String paramVoucherDiscStr = '';
  void changeVoucherValid(bool value, Promo vochCode, context) {
    paramVoucherValid = value;
    if (value) {
      paramVoucherCode = vochCode;
      _voucherCalculate();
    } else {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Text(
          'Voucher ${vochCode.promoID} is not valid',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ).show(context);
    }
    notifyListeners();
  }

  // voucher disc calculation (private)
  void _voucherCalculate() {
    int tmp = (paramSubTotalsInt * (paramVoucherCode!.percentage)).floor();
    if (tmp > paramVoucherCode!.maxDisc) {
      tmp = paramVoucherCode!.maxDisc;
    }
    paramVoucherDisc = tmp;
    paramVoucherDiscStr =
        formatter.format(paramVoucherDisc).toString().replaceAll(',', '.');
    setPointsUse(_pointsUse, paramAccountInformation!);
    countTotals();
  }

  // calculation parameter
  // sub totals parameter
  int paramSubTotalsInt = 0;
  String paramSubTotals = '0';
  double paramDeliveryVal = 0;
  String paramDeliveryStr = '0';
  // totals
  int paramTotalPayInt = 0;
  String paramTotalPay = '0';
  int paramPointsGetInt = 0;
  String paramPointsGet = '0';


  // calculate sub total of menu
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
    countTotals();
    // notifyListeners();
  }

  void countTotals() {
    paramTotalPayInt = paramSubTotalsInt.toInt() -
        paramVoucherDisc.toInt() -
        paramMuchPoints.toInt();
    paramTotalPay =
        formatter.format(paramTotalPayInt).toString().replaceAll(',', '.');
    paramPointsGetInt = (paramTotalPayInt * 0.03).floor();
    paramPointsGet = formatter.format(paramPointsGetInt).toString().replaceAll(',', '.');
    notifyListeners();
  }

  void resetParam() {
    _listOrders = {};
    paramAccountInformation = null;
    paramListOrder = null;
    paramVoucherCode = null;
    paramSubTotals = '0';
    paramSubTotalsInt = 0;
    paramDeliveryVal = 0;
    paramDeliveryStr = '';
    paramVoucherDisc = 0;
    paramVoucherDiscStr = '';
    paramTotalPay = '';
    paramTotalPayInt = 0;
    _pointsUse = false;
  }

  void softReset() {
    paramDeliveryVal = 0;
    paramDeliveryStr = '';
    paramVoucherCode = null;
    paramVoucherDisc = 0;
    paramVoucherDiscStr = '';
    paramVoucherValid = false;
    _pointsUse = false;
    paramMuchPoints = 0;
    paramMuchPointsStr = '';
    // paramTotalPay = '';
    // paramTotalPayInt = 0;
  }
}
