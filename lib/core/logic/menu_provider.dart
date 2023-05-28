import 'package:flutter/material.dart';

class FoodMenu {
  FoodMenu({
    required this.menuID,
    required this.menuCategory,
    required this.menuName,
    required this.menuShortDesc,
    required this.menuLongDesc,
    required this.menuImage,
    required this.menuPrice,
  });
  String menuID;
  String menuCategory;
  String menuName;
  String menuShortDesc;
  String menuLongDesc;
  String menuImage;
  String menuPrice;
}

class MenuProvider extends ChangeNotifier {
  late List<FoodMenu> _listFoodMenu;
  List<FoodMenu> get listFoodMenu => _listFoodMenu;
}
