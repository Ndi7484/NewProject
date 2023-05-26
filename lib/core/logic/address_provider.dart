import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Alamat {
  Alamat({
    required this.alamatID,
    required this.alamatTitle,
    required this.alamatLengkap,
    required this.alamatDesk,
  });
  String alamatID;
  String alamatTitle;
  String alamatLengkap;
  String alamatDesk;
}

class AddressProvider extends ChangeNotifier {
  // list alamat from excel
  List<Alamat> _listAlamat = [];
  Alamat? _selectedAlamat = null;
  // load data from excel
  void readAddress() async {
    ByteData data = await rootBundle.load('assets/data/address.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];
    _listAlamat = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return Alamat(
            alamatID: row[0]!.value.toString(),
            alamatTitle: row[1]!.value.toString(),
            alamatLengkap: row[2]!.value.toString(),
            alamatDesk: row[3]!.value.toString());
      },
    );
    notifyListeners();
  }

  List<Alamat>? getAddress(String paramEmail) {
    List<Alamat>? accountAlamat = [];
    for (var el in _listAlamat) {
      if (el.alamatID == paramEmail) {
        accountAlamat.add(Alamat(
            alamatID: el.alamatID,
            alamatTitle: el.alamatTitle,
            alamatLengkap: el.alamatLengkap,
            alamatDesk: el.alamatDesk));
      }
    }
    return accountAlamat;
  }

  void resetParam() {
    _listAlamat = [];
    _selectedAlamat = null;
  }
}
