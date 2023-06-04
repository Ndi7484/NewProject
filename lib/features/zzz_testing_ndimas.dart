import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class ZZZTesting extends StatelessWidget {
  const ZZZTesting({super.key});

  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<MenuProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('tetsting'),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Builder(builder: (context) {
            var keysList = provOrders.listOrders.keys.toList();
            // return ListView(
            //     children: List.generate(
            //   keysList.length,
            //   (index) => Text(
            //       '${keysList[index]} - ${provOrders.listOrders[keysList.toList()[index]].toString()}'),
            // ));
            return ListView(
              children: List.generate(
                  keysList.length,
                  (index) => (provOrders.listOrders[keysList.toList()[index]] ==
                          0)
                      ? Container()
                      : MenuCard(
                          isMenu: false,
                          qtyFood:
                              provOrders.listOrders[keysList.toList()[index]],
                          food: provMenu.returnMenu(keysList[index])!)),
            );
          }),
        ));
  }
}
