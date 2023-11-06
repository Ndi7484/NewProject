// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Payment {
  Payment({
    required this.img,
    required this.title,
    this.snk,
    required this.children,
    this.typePay,
    this.color,
  });
  String img;
  String title;
  List<String>? snk;
  dynamic children;
  TypePayment? typePay;
  dynamic color;
}

enum TypePayment {
  bankTfBCA,
  bankTfBNI,
  OVO,
  Gopay,
  Dana,
  PayRandumu,
}

class PaymentProvider extends ChangeNotifier {
  final List<String> _structurePayment = [
    'Bank Transfer',
    'OVO',
    'Gopay',
    'DANA',
    'Pay at Randumu',
  ];
  List<String> get structurePayment => _structurePayment;

  final Map<String, dynamic> _listPayment = {
    'Bank Transfer': Payment(
        img: 'assets/etc/Bank_transfer.png',
        title: 'Bank Transfer',
        snk: [
          'bank terms and conition'
        ],
        children: [
          Payment(
            img: 'assets/etc/BCA.png',
            title: 'BCA',
            snk: [
              "1. Make sure you have an active BCA banks account",
              "2. Check Sufficient your bank balance during the transaction",
              "3. The pop up will appear and it will confirm the transactions",
              "4. Please verify that the transfer account is to Randumu.id",
              "5. Please check the nominals of the  transactions",
              "6. Enter the pin",
              "7. Transactions is done, and confirm it to our cashier"
            ],
            children: [],
            typePay: TypePayment.bankTfBCA,
            color: Colors.blue[900],
          ),
          Payment(
            img: 'assets/etc/BNI.png',
            title: 'BNI',
            snk: [
              "1. Make sure you have an active BNI banks account",
              "2. Check Sufficient your bank balance during the transaction",
              "3. The pop up will appear and it will confirm the transactions",
              "4. Please verify that the transfer account is to Randumu.id",
              "5. Please check the nominals of the  transactions",
              "6. Enter the pin",
              "7. Transactions is done, and confirm it to our cashier"
            ],
            children: [],
            typePay: TypePayment.bankTfBNI,
            color: Colors.orange[800],
          ),
        ]),
    'OVO': Payment(
      img: 'assets/etc/OVO.png',
      title: 'OVO',
      snk: [
        'INSTRUCTIONS',
        "1. Make sure you have an active OVO account",
        "2. Sufficient OVO Cash balance during the transaction",
        "3. Make sure OVO registered mobile number is the same with Randumu"
      ],
      children: [],
      typePay: TypePayment.OVO,
      color: Colors.purple[800],
    ),
    'Gopay': Payment(
      img: 'assets/etc/Gopay.png',
      title: 'Gopay',
      snk: [
        'INSTRUCTIONS',
        "1. Make sure you have an active Gopay account",
        "2. Sufficient Gopay Cash balance during the transaction",
        "3. Make sure Gopay registered mobile number is the same with Randumu"
      ],
      children: [],
      typePay: TypePayment.Gopay,
      color: Colors.blue,
    ),
    'DANA': Payment(
      img: 'assets/etc/Dana.png',
      title: 'DANA',
      snk: [
        'INSTRUCTIONS',
        "1. Make sure you have an active DANA account",
        "2. Sufficient DANA Cash balance during the transaction",
        "3. Make sure DANA registered mobile number is the same with Randumu"
      ],
      children: [],
      typePay: TypePayment.Dana,
      color: Colors.blue[800],
    ),
    'Pay at Randumu': Payment(
      img: 'assets/etc/Logo.png',
      title: 'Pay at Randumu',
      snk: [],
      children: [],
      typePay: TypePayment.PayRandumu,
      color: Colors.orange,
    ),
  };
  Map<String, dynamic> get listPayment => _listPayment;

  String? findImg(TypePayment typePayment){
    var keysList = listPayment.keys.toList();
    for (var el in keysList) {
      if(listPayment[el].children.isNotEmpty){
        for (var el2 in listPayment[el].children) {
          if(el2.typePay == typePayment){
            return el2.img;
          }
        }
      } else{
        if(listPayment[el].typePay == typePayment){
          return listPayment[el].img;
        }
      }
    }
    return null;
  }
}
