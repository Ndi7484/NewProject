import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/main_page/main_page.dart';
import 'package:flutter_application_1/features/menu_page/menu_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  List<dynamic> _bodyFill = [
    MainPage(),
    MenuPage(),
    MainPage(),
    MainPage(),
    MainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Container(
        child: _bodyFill[_selectedIndex],
      ),
      floatingActionButton: (_selectedIndex == 1)
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining_outlined), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rate_rounded), label: 'Points'),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_rounded), label: 'Promo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: 'Orders'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
