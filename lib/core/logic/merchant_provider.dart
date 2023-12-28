import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  // load data from db, dont remove
  void readMerchant() async {
    final tmp = FirebaseFirestore.instance
        .collection('merchant')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Alamat.fromJson(doc.data())).toList())
        .listen((event) {
      _listMerchant = event;
    });
  }

  void changeSelected(Alamat alamat) {
    _selectedMerchant = alamat;
    notifyListeners();
  }
}
