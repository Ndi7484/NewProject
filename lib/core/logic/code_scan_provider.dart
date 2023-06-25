import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeScan {
  CodeScan({
    required this.codeId,
    required this.jsonData,
  });
  String codeId;
  String jsonData;
}

class CodeScanProvider extends ChangeNotifier {
  List<CodeScan> _listCodeScan = [];
  List<CodeScan> get listCodeScan => _listCodeScan;
  String _codeChecker = '';
  String get codeChecker => _codeChecker;
  set codeChecker(String value){
    _codeChecker = value;
    notifyListeners();
  }

  void readCode() async {
    ByteData data = await rootBundle.load('assets/data/code.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];

    _listCodeScan = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return CodeScan(
            codeId: row[0]!.value.toString(),
            jsonData: row[1]!.value.toString());
      },
    );
    notifyListeners();
  }

  String checkCode(){
    for (var el in listCodeScan) {
      if(el.codeId == codeChecker){
        return el.jsonData;
      }
    }
    return '';
  }

  void resetparam(){
    _listCodeScan = [];
  }
}
