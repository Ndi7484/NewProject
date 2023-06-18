import 'package:flutter/material.dart';

class Payment {
  Payment({
    required this.img,
    required this.title,
    this.snk,
    required this.children,
    this.typePay,
  });
  String img;
  String title;
  List<String>? snk;
  dynamic children;
  TypePayment? typePay;
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
    ),
    'Pay at Randumu': Payment(
      img: 'assets/etc/Logo.png',
      title: 'Pay at Randumu',
      snk: [],
      children: [],
      typePay: TypePayment.PayRandumu,
    ),
  };
  Map<String, dynamic> get listPayment => _listPayment;
}
