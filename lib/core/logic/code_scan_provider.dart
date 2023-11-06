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

  Future<String> checkCode() async {
    DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('code')
        .doc(codeChecker.toString())
        .get();
    if (result.exists) {
      return CodeScan.fromJson(result.data()!).jsonData.toString();
    } else {
      return '';
    }
  }

  void resetparam() {
    // _listCodeScan = [];
  }
}
