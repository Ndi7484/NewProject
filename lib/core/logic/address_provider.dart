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

  List<Alamat> _listSelectedAlamat = [];
  List<Alamat> get listSelectedAlamat => _listSelectedAlamat;
  Alamat? _selectedAlamat;
  Alamat? get selectedAlamat => _selectedAlamat;

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
    // print(_listAlamat);
    notifyListeners();
  }

  void getAddress(String paramEmail) {
    List<Alamat> accountAlamat = [];
    for (var el in _listAlamat) {
      if (el.alamatID == paramEmail) {
        accountAlamat.add(Alamat(
            alamatID: el.alamatID,
            alamatTitle: el.alamatTitle,
            alamatLengkap: el.alamatLengkap,
            alamatDesk: el.alamatDesk));
      }
    }
    _listSelectedAlamat = accountAlamat;
    if (_listSelectedAlamat.isNotEmpty && _selectedAlamat == null) {
      _selectedAlamat = _listSelectedAlamat[0];
    }
  }

  void alamatDelete(String paramEmail, Alamat alamat){
    
  }

  void changeSelected(Alamat alamat) {
    _selectedAlamat = alamat;
    notifyListeners();
  }

  // for add new address purpose
  String paramCategory = '';
  String paramAddress = '';
  String paramNote = '';
  double? paramLang;
  double? paramLong;
  String paramDisplayName = '';

  void setMap() {
    notifyListeners();
  }

  void saveAddress(BuildContext context, String paramEmail) {
    if (paramCategory != '' &&
        paramAddress != '' &&
        paramNote != '' &&
        paramLang != null &&
        paramLong != null &&
        paramDisplayName != '') {
      _listAlamat.add(Alamat(
          alamatID: paramEmail,
          alamatTitle: paramCategory,
          alamatLengkap: paramAddress,
          alamatDesk: paramNote));
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address saved'),
          duration: Duration(seconds: 3),
        ),
      );
      paramCategory = '';
      paramAddress = '';
      paramNote = '';
      paramLang = null;
      paramLong = null;
      paramDisplayName = '';
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please input all the required data'),
          duration: Duration(seconds: 3),
        ),
      );
      // message = 'please fill all the required data';
      notifyListeners();
    }
  }

  void resetParam() {
    _listAlamat = [];
    _listSelectedAlamat = [];
    _selectedAlamat = null;
    paramCategory = '';
    paramAddress = '';
    paramNote = '';
    paramLang = null;
    paramLong = null;
    paramDisplayName = '';
  }
}
