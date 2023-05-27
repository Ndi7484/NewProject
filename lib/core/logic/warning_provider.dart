import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Warning {
  Warning({
    required this.desc,
    required this.startDate,
    required this.startMonth,
    required this.startYear,
    required this.startHour,
    required this.startMinute,
    required this.finishDate,
    required this.finishMonth,
    required this.finishYear,
    required this.finishHour,
    required this.finishMinute,
  });
  String desc;
  int startDate;
  int startMonth;
  int startYear;
  int startHour;
  int startMinute;
  int finishDate;
  int finishMonth;
  int finishYear;
  int finishHour;
  int finishMinute;
}

class WarningProvider extends ChangeNotifier {
  Warning? _getWarning;
  void readAccount() async {
    ByteData data = await rootBundle.load('assets/data/warning.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];
    var row = table!.row(0);
    try {
      _getWarning = Warning(
          desc: row[0]!.value.toString(),
          startDate: int.parse(row[1]!.value.toString()),
          startMonth: int.parse(row[2]!.value.toString()),
          startYear: int.parse(row[3]!.value.toString()),
          startHour: int.parse(row[4]!.value.toString()),
          startMinute: int.parse(row[5]!.value.toString()),
          finishDate: int.parse(row[6]!.value.toString()),
          finishMonth: int.parse(row[7]!.value.toString()),
          finishYear: int.parse(row[8]!.value.toString()),
          finishHour: int.parse(row[9]!.value.toString()),
          finishMinute: int.parse(row[10]!.value.toString()));
    } catch (e) {
      _getWarning = null;
    }
    notifyListeners();
  }
}
