import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class Notif {
  Notif({
    required this.subject,
    required this.title,
    required this.text,
    required this.date,
  });
  String subject;
  String title;
  String text;
  DateTime date;

  Map<String, dynamic> toJson() => {
        'date': Timestamp.fromDate(date),
        'desc': text,
        'email': subject,
        'head': title,
      };

  static Notif fromJson(Map<String, dynamic> json) => Notif(
        subject: json['email'],
        title: json['head'],
        text: json['desc'],
        date: (json['date'] as Timestamp).toDate(),
      );
}

class NotificationProvider extends ChangeNotifier {
  final Stream<List<Notif>> listNotification = FirebaseFirestore.instance
      .collection('notification')
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Notif.fromJson(doc.data())).toList());
  // List<Notif> get listNotification => _listNotification;

  void readNotif() async {
    // ByteData data = await rootBundle.load('assets/data/notification.xlsx');
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);

    // var table = excel.tables[excel.tables.keys.first];

    // _listNotification = List.generate(
    //   table!.maxRows,
    //   (index) {
    //     var row = table.row(index);
    //     return Notif(
    //         subject: row[0]!.value.toString(),
    //         title: row[1]!.value.toString(),
    //         text: row[2]!.value.toString());
    //   },
    // );
    // notifyListeners();
  }
}
