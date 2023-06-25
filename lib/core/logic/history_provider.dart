import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';

class HistoryProvider extends ChangeNotifier {
  final List<OrdersCart> _listOrderHistory = [
    OrdersCart(
        dateTime: '2022-09-29 10:11:30',
        typeOrder: TypeOrder.delivery,
        accountInformation: Account(
            firstName: 'Admin',
            lastName: 'Admin',
            email: 'admin@admin.com',
            password: 'admin',
            phone: '081375722604',
            points: 17000,
            pointsString: '17000'),
        deliveryAddress: Alamat(
            alamatID: 'admin@admin.com',
            alamatTitle: 'Home',
            alamatLengkap: 'Jl. Kertajaksaan Muraka No. 45',
            alamatDesk: 'sebelah bakpao',
            alamatLang: 5.3434,
            alamatLong: 67.989,
            alamatMapsDesc:
                'Medan Timur, Petisah, Medan, Sumatera Utara, 20222, Indonesia'),
        listOrder: {"A01": 1, "A02": 2},
        // delivery fee
        deliveryVal: 34000,
        voucherCode: null,
        voucherDisc: 0,
        pointsUse: false,
        pointsMuch: 0,
        pointsGet: 1000,
        subTotals: 100000,
        totals: 100000,
        doneStatus: false),
    OrdersCart(
        dateTime: '2022-09-28 13:45:27',
        typeOrder: TypeOrder.delivery,
        accountInformation: Account(
            firstName: 'Admin',
            lastName: 'Admin',
            email: 'admin@admin.com',
            password: 'admin',
            phone: '081375722604',
            points: 17000,
            pointsString: '17000'),
        deliveryAddress: Alamat(
            alamatID: 'admin@admin.com',
            alamatTitle: 'Home',
            alamatLengkap: 'Jl. Kemangi Suaka No. 545A',
            alamatDesk: 'sebelah kopi kenangan',
            alamatLang: 5.3434,
            alamatLong: 67.989,
            alamatMapsDesc:
                'Medan Timur, Petisah, Medan, Sumatera Utara, 20222, Indonesia'),
        listOrder: {
          "A01": 1,
          "A02": 2,
          "M01": 1,
        },
        // delivery fee
        deliveryVal: 34000,
        voucherCode: null,
        voucherDisc: 0,
        pointsUse: false,
        pointsMuch: 0,
        pointsGet: 1000,
        subTotals: 100000,
        totals: 100000,
        doneStatus: true),
    OrdersCart(
        dateTime: '2022-09-25 17:03:23',
        typeOrder: TypeOrder.takeaway,
        accountInformation: Account(
            firstName: 'Admin',
            lastName: 'Admin',
            email: 'admin@admin.com',
            password: 'admin',
            phone: '081375722604',
            points: 17000,
            pointsString: '17000'),
        takeawayAddress: Alamat(
            alamatID: 'KMT',
            alamatTitle: 'Kios Medan Telaga',
            alamatLengkap: 'Jl. Kertajaksaan Setiadi, SPBU Setiadi',
            alamatDesk: 'SPBU sebelah kios kopi go',
            alamatLang: 5.3574,
            alamatLong: 67.879,
            alamatMapsDesc:
                'Medan Timur, Petisah, Medan, Sumatera Utara, 20222, Indonesia'),
        listOrder: {
          "A05": 1,
          "M03": 1,
        },
        voucherCode: Promo(
            promoID: 'RANDUMUNCH',
            promoName: 'RANDUMUNCH20%',
            promoShortDesc: 'promo bla bla',
            promoLongDesc: 'promo bla bla',
            maxDisc: 10000,
            minTrans: 10000,
            typeOrder: 'Takeaway',
            menuExc: [''],
            typeExc: [''],
            freeDelivery: false,
            maxDelivery: 0,
            typeTrans: 'Takeaway',
            dateExp: 12,
            monthExp: 9,
            yearExp: 2024,
            percentage: 0.2),
        voucherDisc: 1000,
        pointsUse: true,
        pointsMuch: 1000,
        pointsGet: 900,
        subTotals: 99000,
        totals: 99000,
        doneStatus: true),
    // OrdersCart(
    //     dateTime: '2022-09-25 17:03:23',
    //     typeOrder: TypeOrder.dinein,
    //     accountInformation: Account(
    //         firstName: 'Admin',
    //         lastName: 'Admin',
    //         email: 'admin@admin.com',
    //         password: 'admin',
    //         phone: '081375722604',
    //         points: 17000,
    //         pointsString: '17000'),
    //     listOrder: {
    //       "A05": 1,
    //       "M03": 1,
    //     },
    //     dineInCode:
    //         '{"place" : "Kios Mall Kioto", "address" : "Jl. Kertajaksa Kioto", "table" : "KJ02"}',
    //     voucherCode: null,
    //     voucherDisc: 0,
    //     pointsUse: true,
    //     pointsMuch: 1000,
    //     pointsGet: 900,
    //     subTotals: 99000,
    //     totals: 99000,
    //     doneStatus: true),
  ];
  List<OrdersCart> get listOrderHistory => _listOrderHistory;
  void addListOrderHistory(OrdersCart value) {
    _listOrderHistory.add(value);
    notifyListeners();
  }

  void changeDoneStatus(OrdersCart toFind, BuildContext context) {
    for (var i = 0; i < listOrderHistory.length; i++) {
      print('${listOrderHistory[i].dateTime} - ${toFind.dateTime}');
      if (listOrderHistory[i].dateTime == toFind.dateTime) {
        listOrderHistory[i].setDoneStatus(true);
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => BottomNavigationPage(selectNext: 4)));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('order status is complete'),
        ));
        break;
      }
    }
    notifyListeners();
  }
}
