import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// for alamat class only
import 'address_provider.dart';

class MerchantProvider extends ChangeNotifier {
  // list alamat from excel
  List<Alamat> _listMerchant = [];
  List<Alamat> get listMerchant => _listMerchant;

  Alamat? _selectedMerchant;
  Alamat? get selectedMerchant => _selectedMerchant;
  set selectedMerchant(Alamat? merchant) {
    _selectedMerchant = merchant;
    notifyListeners();
  }

  // load data from excel
  void readMerchant() async {
    final tmp = FirebaseFirestore.instance
        .collection('merchant')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Alamat.fromJson(doc.data())).toList())
        .listen((event) {
      _listMerchant = event;
    });
    // ByteData data = await rootBundle.load('assets/data/merchant.xlsx');
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);

    // var table = excel.tables[excel.tables.keys.first];
    // _listMerchant = List.generate(
    //   table!.maxRows,
    //   (index) {
    //     var row = table.row(index);
    //     return Alamat(
    //       alamatID: row[0]!.value.toString(),
    //       alamatTitle: row[1]!.value.toString(),
    //       alamatLengkap: row[2]!.value.toString(),
    //       alamatDesk: row[3]!.value.toString(),
    //       alamatLang: double.parse(row[4]!.value.toString()),
    //       alamatLong: double.parse(row[5]!.value.toString()),
    //       alamatMapsDesc: row[6]!.value.toString(),
    //     );
    //   },
    // );
    // changeSelected(_listMerchant[0]);
    // notifyListeners();
  }

  void changeSelected(Alamat alamat) {
    _selectedMerchant = alamat;
    notifyListeners();
  }

  // void resetParam() {
  //   // _listMerchant = [];
  //   _selectedMerchant = null;
  // }
}
