import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Promo {
  Promo({
    required this.promoID,
    required this.promoName,
    required this.promoShortDesc,
    required this.promoLongDesc,
    required this.maxDisc,
    required this.minTrans,
    required this.typeOrder,
    required this.menuExc,
    required this.typeExc,
    required this.freeDelivery,
    required this.typeTrans,
    required this.dateExp,
    required this.monthExp,
    required this.yearExp,
  });
  String promoID;
  String promoName;
  String promoShortDesc;
  String promoLongDesc;
  int maxDisc;
  int minTrans;
  String typeOrder;
  List<String> menuExc;
  List<String> typeExc;
  bool freeDelivery;
  String typeTrans;
  int dateExp;
  int monthExp;
  int yearExp;
}

class PromoProvider extends ChangeNotifier {
  List<Promo> _listPromo = [];
  // load data from excel
  void readPromo() async {
    ByteData data = await rootBundle.load('assets/data/account.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];
    _listPromo = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return Promo(
          promoID: row[0]!.value.toString(),
          promoName: row[1]!.value.toString(),
          promoShortDesc: row[2]!.value.toString(),
          promoLongDesc: row[3]!.value.toString(),
          maxDisc: int.parse(row[4]!.value),
          minTrans: int.parse(row[5]!.value),
          typeOrder: row[6]!.value.toString(),
          menuExc: row[7]!.value.split(','),
          typeExc: row[8]!.value.split(','),
          freeDelivery: (row[9]!.value.toString() == 'TRUE') ? true : false,
          typeTrans: row[10]!.value.toString(),
          dateExp: int.parse(row[11]!.value),
          monthExp: int.parse(row[12]!.value),
          yearExp: int.parse(row[13]!.value),
        );
      },
    );
    notifyListeners();
  }
}
