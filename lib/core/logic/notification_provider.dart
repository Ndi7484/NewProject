import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notif {
  Notif({
    required this.subject,
    required this.title,
    required this.text,
  });
  String subject;
  String title;
  String text;
}

class NotificationProvider extends ChangeNotifier {
  List<Notif> _listNotification = [];
  List<Notif> get listNotification => _listNotification;

  void readNotif() async {
    ByteData data = await rootBundle.load('assets/data/notification.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];

    _listNotification = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return Notif(
            subject: row[0]!.value.toString(),
            title: row[1]!.value.toString(),
            text: row[2]!.value.toString());
      },
    );
    notifyListeners();
  }
}
