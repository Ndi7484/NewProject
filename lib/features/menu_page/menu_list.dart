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

// ensure the scroll position of the widgets
class _ListMenuState extends State<ListMenu>
    with AutomaticKeepAliveClientMixin<ListMenu> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the super.build is called

    final provMenu = Provider.of<MenuProvider>(context);

    return ListView(children: [
      ...List.generate(
        provMenu.listFoodMenu.length,
        (index) => MenuCard(
            type: widget.type,
            isMenu: true,
            food: provMenu.listFoodMenu[index]),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: ClipRect(
          child: Align(
            alignment: Alignment(
                -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1)),
                -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1))),
            child: Transform.scale(
              scale: 3,
              child: Image.asset(
                'assets/etc/Food_doodle.png',
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
