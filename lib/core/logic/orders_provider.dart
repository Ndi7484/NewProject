import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum TypeOrder { delivery, takeaway, dinein, fail }

class OrdersCart {
  OrdersCart({
    required this.dateTime,
    required this.typeOrder,
    this.deliveryAddress,
    this.takeawayAddress,
    this.dineInCode,
    required this.accountInformation,
    required this.listOrder,
    required this.subTotals,
    required this.totals,
    this.deliveryVal,
    required this.voucherCode,
    required this.pointsUse,
    required this.voucherDisc,
    required this.pointsMuch,
    required this.pointsGet,
    this.typePayment,
    required this.doneStatus,
  });
  String dateTime;
  TypeOrder typeOrder;
  Alamat? deliveryAddress;
  Alamat? takeawayAddress;
  String? dineInCode;
  Account accountInformation;
  Map<String, int> listOrder;
  int subTotals;
  int totals;
  int? deliveryVal;
  Promo? voucherCode;
  bool pointsUse;
  int voucherDisc;
  int pointsMuch;
  int pointsGet;
  // typePayment let null first then filled
  TypePayment? typePayment;
  bool doneStatus;

  setDoneStatus(value) {
    doneStatus = value;
  }
}

class OrdersProvider extends ChangeNotifier {
  // format helper
  NumberFormat formatter = NumberFormat("#,###", "en_US");

  // main parameters
  Map<String, int> _listOrders = {};
  Map<String, int> get listOrders => _listOrders;

  // list of orders that must be filled : delivery, takeaway or dine-in
  Alamat? paramDeliveryAlamat;
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
  set pointsUse(value) {
    _pointsUse = value;
    notifyListeners();
  }

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
    } else {
      paramMuchPoints = 0;
      paramMuchPointsStr = '';
    }
    countTotals();
    notifyListeners();
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
    calculateDeliveryNext();
    countTotals();
  }

  // delivery check calculate by lang and long of map
  int paramDeliveryVal = 0;
  String paramDeliveryStr = '0';
  bool validAlamat = false;
  double smallestDistance = 0;
  // other param
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // in kilometers
    // Convert degrees to radians
    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);
    // Calculate the difference between the latitudes and longitudes
    double latDiff = lat2Rad - lat1Rad;
    double lonDiff = lon2Rad - lon1Rad;
    // Apply the Haversine formula
    double a = pow(sin(latDiff / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(lonDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;
    return distance;
  } // in kilometers

  // calculate
  void calculateDelivery(Alamat? custAlamat, List<Alamat> mercAlamat) {
    if (custAlamat == null) {
      validAlamat = false;
    } else {
      validAlamat = true;
      var listAlamatValue = [];
      for (var i = 0; i < mercAlamat.length; i++) {
        listAlamatValue.add(calculateDistance(
            custAlamat.alamatLang,
            custAlamat.alamatLong,
            mercAlamat[i].alamatLang,
            mercAlamat[i].alamatLong));
      }
      smallestDistance = listAlamatValue.reduce((currentMin, nextNumber) =>
          currentMin < nextNumber ? currentMin : nextNumber);
      calculateDeliveryNext();
    }
  }

  int freeDeliverValue = 0;
  String freeDeliverValueStr = '';
  void calculateDeliveryNext() {
    // constanta of distance vs price; just random calculation
    var tmp = (3.5 * smallestDistance * 1000).toInt() +
        ((0.2 * smallestDistance < 3.5) ? 1.5 * smallestDistance * 1000 : 0)
            .toInt();
    paramDeliveryVal = ((tmp / 1000).floor()) * 1000;
    // if there is promo for free delivery
    // free delivery is 15% from the sub totals of the menu
    if (paramVoucherCode != null) {
      // print(paramVoucherCode!.freeDelivery);
      if (paramVoucherCode!.freeDelivery) {
        freeDeliverValue =
            ((paramSubTotalsInt - paramMuchPoints - paramVoucherDisc) * 0.1)
                .toInt();
        if (freeDeliverValue > paramVoucherCode!.maxDelivery) {
          freeDeliverValue = paramVoucherCode!.maxDelivery;
        }
        freeDeliverValueStr = formatter.format(freeDeliverValue).toString().replaceAll(',', '.');
      }
    }
    paramDeliveryStr =
        formatter.format(paramDeliveryVal).toString().replaceAll(',', '.');
    // notifyListeners();
  }

  // calculation parameter
  // sub totals parameter
  int paramSubTotalsInt = 0;
  String paramSubTotals = '0';
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
    paramTotalPayInt = paramSubTotalsInt.toInt() +
        paramDeliveryVal.toInt() -
        freeDeliverValue.toInt() -
        paramVoucherDisc.toInt() -
        paramMuchPoints.toInt();
    paramTotalPay =
        formatter.format(paramTotalPayInt).toString().replaceAll(',', '.');
    paramPointsGetInt =
        ((paramSubTotalsInt - freeDeliverValue - paramVoucherDisc - paramMuchPoints) * 0.03)
            .floor();
    paramPointsGet =
        formatter.format(paramPointsGetInt).toString().replaceAll(',', '.');
    // notifyListeners();
  }

  // we init the orders tidy first
  OrdersCart? tmpOrdersCartHistory;
  void setInitOrders() {
    print(_typeOrders);
    switch (_typeOrders) {
      case TypeOrder.delivery:
        tmpOrdersCartHistory = OrdersCart(
            dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            typeOrder: typeOrders!,
            accountInformation: paramAccountInformation!,
            // alamat delivery address
            deliveryAddress: paramDeliveryAlamat,
            listOrder: listOrders,
            // delivery fee
            deliveryVal: paramDeliveryVal,
            voucherCode: paramVoucherCode,
            voucherDisc: paramVoucherDisc,
            pointsUse: _pointsUse,
            pointsMuch: paramMuchPoints,
            pointsGet: paramPointsGetInt,
            subTotals: paramSubTotalsInt,
            totals: paramTotalPayInt,
            doneStatus: false);
        break;
      case TypeOrder.takeaway:
        tmpOrdersCartHistory = OrdersCart(
            dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            typeOrder: typeOrders!,
            accountInformation: paramAccountInformation!,
            // alamat takeaway merchant address
            takeawayAddress: paramTakeawayAlamat,
            listOrder: listOrders,
            voucherCode: paramVoucherCode,
            voucherDisc: paramVoucherDisc,
            pointsUse: _pointsUse,
            pointsMuch: paramMuchPoints,
            pointsGet: paramPointsGetInt,
            subTotals: paramSubTotalsInt,
            totals: paramTotalPayInt,
            doneStatus: false);
        break;
      case TypeOrder.dinein:
        tmpOrdersCartHistory = OrdersCart(
            dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            typeOrder: typeOrders!,
            accountInformation: paramAccountInformation!,
            // dine in code in jsonString
            dineInCode: paramDineInCode,
            listOrder: listOrders,
            voucherCode: paramVoucherCode,
            voucherDisc: paramVoucherDisc,
            pointsUse: _pointsUse,
            pointsMuch: paramMuchPoints,
            pointsGet: paramPointsGetInt,
            subTotals: paramSubTotalsInt,
            totals: paramTotalPayInt,
            doneStatus: false);
        break;
      default:
        tmpOrdersCartHistory = null;
        break;
    }
    print(tmpOrdersCartHistory);
  }

  void resetParam() {
    _listOrders = {};
    paramAccountInformation = null;
    paramListOrder = null;
    paramSubTotals = '0';
    paramSubTotalsInt = 0;
    paramDeliveryAlamat = null;
    paramTakeawayAlamat = null;
    paramDineInCode = null;
    paramDeliveryVal = 0;
    paramDeliveryStr = '';
    paramVoucherCode = null;
    paramVoucherDisc = 0;
    paramVoucherDiscStr = '';
    paramTotalPay = '';
    paramTotalPayInt = 0;
    _pointsUse = false;
    paramMuchPoints = 0;
    paramMuchPointsStr = '';
    notifyListeners();
  }

  void softReset() {
    paramDeliveryVal = 0;
    paramDeliveryStr = '';
    freeDeliverValue = 0;
    freeDeliverValueStr = '';
    paramVoucherCode = null;
    paramVoucherDisc = 0;
    paramVoucherDiscStr = '';
    paramVoucherValid = false;
    // _pointsUse = false;
    // paramMuchPoints = 0;
    // paramMuchPointsStr = '';
    // paramTotalPay = '';
    // paramTotalPayInt = 0;
    notifyListeners();
  }
}
