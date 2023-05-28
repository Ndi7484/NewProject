import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/dragable_fab.dart';
import 'package:flutter_application_1/core/widgets/menu_card.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(
          children: List.generate(
        15,
        (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuCard(
              isMenu: true,
            )),
      )),
      DraggableFAB(),
    ]);
  }
}
