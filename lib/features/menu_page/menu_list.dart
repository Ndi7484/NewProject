import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<MenuProvider>(context);
    return ListView(
        children: List.generate(
      provMenu.listFoodMenu.length,
      (index) => MenuCard(
        type: widget.type,
        isMenu: true,
        food : provMenu.listFoodMenu[index]
      ),
    ));
    ;
  }
}
