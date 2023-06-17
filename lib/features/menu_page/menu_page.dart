import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
// import 'package:flutter_application_1/core/widgets/menu_card.dart';
import 'package:flutter_application_1/features/menu_page/menu_list.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  static const List<Tab> tabs = [
    Tab(text: 'Appetizer'),
    Tab(text: 'Main Dish'),
    Tab(text: 'Dessert'),
  ];
  @override
  Widget build(BuildContext context) {
    // final provMenu = Provider.of<MenuProvider>(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: tabs,
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ListMenu(type: 'Appetizer'),
                  ListMenu(type: 'Main Dish'),
                  ListMenu(type: 'Dessert'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
