import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
