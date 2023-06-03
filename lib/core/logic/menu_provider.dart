import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
}

class MenuProvider extends ChangeNotifier {
  List<FoodMenu> _listFoodMenu = [];
  List<FoodMenu> get listFoodMenu => _listFoodMenu;
  // load data from excel
  void readMenu() async {
    ByteData data = await rootBundle.load('assets/data/menu.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];

    NumberFormat formatter = NumberFormat("#,###", "en_US");

    _listFoodMenu = [
      ...List.generate(
        table!.maxRows,
        (index) {
          var row = table.row(index);
          return FoodMenu(
            menuID: row[0]!.value.toString(),
            menuCategory: row[1]!.value.toString(),
            menuName: row[2]!.value.toString(),
            menuShortDesc: row[3]!.value.toString(),
            menuLongDesc: row[4]!.value.toString(),
            menuImage: row[5]!.value.toString(),
            menuPrice: int.parse(row[6]!.value.toString()),
            menuPriceString: formatter
                .format(int.parse(row[6]!.value.toString()))
                .toString()
                .replaceAll(',', '.'),
          );
        },
      )
    ];
    notifyListeners();
  }
}
