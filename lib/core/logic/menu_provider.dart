import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

class FoodMenu {
  FoodMenu({
    required this.menuID,
    required this.menuCategory,
    required this.menuName,
    required this.menuShortDesc,
    required this.menuLongDesc,
    required this.menuImage,
    required this.menuPrice,
    required this.menuPriceString,
  });
  String menuID;
  String menuCategory;
  String menuName;
  String menuShortDesc;
  String menuLongDesc;
  String menuImage;
  int menuPrice;
  String menuPriceString;

  Map<String, dynamic> toJson() => {
        'menu_id': menuID,
        'type': menuCategory,
        'name': menuName,
        'short_desc': menuShortDesc,
        'long_desc': menuLongDesc,
        'image': menuImage,
        'price': menuPrice,
      };

  static FoodMenu fromJson(Map<String, dynamic> json) => FoodMenu(
      menuID: json['menu_id'],
      menuCategory: json['type'],
      menuName: json['name'],
      menuShortDesc: json['short_desc'],
      menuLongDesc: json['long_desc'],
      // menuImage: json['image'] ?? 'https://media.licdn.com/dms/image/C4D12AQEvahwBzDgypw/article-cover_image-shrink_600_2000/0/1626875581857?e=2147483647&v=beta&t=vPJ-f97pEohpJ3hV6bVzbT2J4MglLU55eDYFPrAEHv4',
      menuImage: json['image'],
      menuPrice: json['price'],
      menuPriceString: json['price'].toString());
}

class MenuProvider extends ChangeNotifier {
  final Stream<List<FoodMenu>> listFoodMenu = FirebaseFirestore.instance
      .collection('menu')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => FoodMenu.fromJson(doc.data())).toList());
  
  // Stream<List<FoodMenu>> get listFoodMenu => _listFoodMenu;
  
  // load data from excel
  void readMenu() async {
    // ByteData data = await rootBundle.load('assets/data/menu.xlsx');
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);

    // var table = excel.tables[excel.tables.keys.first];

    // NumberFormat formatter = NumberFormat("#,###", "en_US");

    // _listFoodMenu = [
    //   ...List.generate(
    //     table!.maxRows,
    //     (index) {
    //       var row = table.row(index);
    //       return FoodMenu(
    //         menuID: row[0]!.value.toString(),
    //         menuCategory: row[1]!.value.toString(),
    //         menuName: row[2]!.value.toString(),
    //         menuShortDesc: row[3]!.value.toString(),
    //         menuLongDesc: row[4]!.value.toString(),
    //         menuImage: row[5]!.value.toString(),
    //         menuPrice: int.parse(row[6]!.value.toString()),
    //         menuPriceString: formatter
    //             .format(int.parse(row[6]!.value.toString()))
    //             .toString()
    //             .replaceAll(',', '.'),
    //       );
    //     },
    //   )
    // ];
    // bestPickMenu();
    // notifyListeners();
  }

  List<FoodMenu> _randomUniqueList = [];
  List<FoodMenu> get randomUniqueList => _randomUniqueList;
  set randomUniqueList(value) {
    _randomUniqueList = value;
  }

  void bestPickMenu() {
    listFoodMenu.listen((food) {
      List<FoodMenu> tmp = food; // Create a copy of the original list

      // Shuffle the randomUniqueList
      final random = Random();
      tmp.shuffle(random);

      int newListLength = 5;
      randomUniqueList = tmp.sublist(0, newListLength);
    });
  }

  FoodMenu? returnMenu(String menuID) {
    FoodMenu? result;
    listFoodMenu.listen((food) {
      for (var el in food) {
        if (el.menuID == menuID) {
          result = el;
          break;
        }
      }
    });
    return result;
  }

  // int processCalculation(Map<String, int> map) {
  //   int totals = 0;
  //   var arrKey = map.keys.toList();
  //   for (var el in arrKey) {
  //     FoodMenu? found = _listFoodMenu.firstWhere((menu) => menu.menuID == el,
  //         // ignore: cast_from_null_always_fails
  //         orElse: () => null as FoodMenu);
  //         try {
  //           totals = totals + found.menuPrice;
  //         } catch (e) {
  //           totals = totals + 0;
  //         }
  //   }
  //   return totals;
  // }
}
