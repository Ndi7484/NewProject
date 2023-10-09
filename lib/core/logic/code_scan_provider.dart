import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class CodeScan {
  CodeScan({
    required this.codeId,
    required this.jsonData,
  });
  String codeId;
  String jsonData;

  Map<String, dynamic> toJson() => {
        'table_code': codeId,
        'json': jsonData,
      };

  static CodeScan fromJson(Map<String, dynamic> json) => CodeScan(
        codeId: json['table_code'],
        jsonData: json['json'],
      );
}

class CodeScanProvider extends ChangeNotifier {
  final Stream<List<CodeScan>> _listCodeScan = FirebaseFirestore.instance
      .collection('code')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => CodeScan.fromJson(doc.data())).toList());
  // List<CodeScan> get listCodeScan => _listCodeScan;
  String _codeChecker = '';
  String get codeChecker => _codeChecker;
  set codeChecker(String value) {
    _codeChecker = value;
    notifyListeners();
  }

  void readCode() async {
    // ByteData data = await rootBundle.load('assets/data/code.xlsx');
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);

    // var table = excel.tables[excel.tables.keys.first];

    // _listCodeScan = List.generate(
    //   table!.maxRows,
    //   (index) {
    //     var row = table.row(index);
    //     return CodeScan(
    //         codeId: row[0]!.value.toString(),
    //         jsonData: row[1]!.value.toString());
    //   },
    // );
    // notifyListeners();
  }

  Future<String> checkCode() async {
    DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
        .collection('code')
        .doc(codeChecker.toString()).get();
    if (result.exists) {
      return CodeScan.fromJson(result.data()!).jsonData.toString();
    } else {
      return '';
    }
    // _listCodeScan.listen((code) {
    //   for (var el in code) {
    //     print(el.codeId);
    //     if (el.codeId == codeChecker) {
    //       result = el.jsonData;
    //       break;
    //     }
    //   }
    // });
    // return result;
  }

  void resetparam() {
    // _listCodeScan = [];
  }
}
