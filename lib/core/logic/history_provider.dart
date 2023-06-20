import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';

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
            alamatLengkap: 'Jl. Kemangi Suaka No. 545A',
            alamatDesk: 'sebelah kopi kenangan',
            alamatLang: 5.3434,
            alamatLong: 67.989,
            alamatMapsDesc:
                'Medan Timur, Petisah, Medan, Sumatera Utara, 20222, Indonesia'),
        listOrder: {"A01": 1, "A02": 2, "M01" : 1,},
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
  ];
  List<OrdersCart> get listOrderHistory => _listOrderHistory;
}
