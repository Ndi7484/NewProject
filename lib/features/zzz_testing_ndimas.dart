import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class ZZZTesting extends StatefulWidget {
  const ZZZTesting({super.key});

  @override
  State<ZZZTesting> createState() => _ZZZTestingState();
}

class _ZZZTestingState extends State<ZZZTesting> {
  bool _switchState = false;
  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<MenuProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('tetsting'),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(children: [
            Text('Data of the orders'),
            Builder(
              builder: (context) {
                var keysList = provOrders.listOrders.keys.toList();
                List<Widget> widgets = [];

                for (var i = 0; i < keysList.length; i++) {
                  if (provOrders.listOrders[keysList[i]] == 0) {
                    continue; // Skip this iteration and move to the next one
                  }

                  widgets.add(
                    MenuCard(
                      isMenu: false,
                      qtyFood: provOrders.listOrders[keysList[i]],
                      food: provMenu.returnMenu(keysList[i])!,
                    ),
                  );
                }

                return Column(
                  children: widgets,
                );
              },
            ),
            // Switch(
            //   onChanged: (value) {
            //     provOrders.pointsUse = !provOrders.pointsUse;
            //   },
            //   value: provOrders.pointsUse,
            // ),
            Switch(
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Icon(
                      Icons.check,
                      color: Colors.white,
                    );
                  }
                  return Icon(
                    Icons.close,
                    color: Colors.grey[700],
                  );
                },
              ),
              value: _switchState,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (bool value) {
                setState(() {
                  _switchState = !_switchState;
                });
                provOrders.pointsUse = _switchState;
              },
            ),
            Text('Switch Value: ${provOrders.pointsUse}')
          ]),
        ));
  }
}

// Builder(builder: (context) {
            //   var keysList = provOrders.listOrders.keys.toList();
            //   for (var i = 0; i < (keysList.length); i++) {
            //     if (provOrders.listOrders[keysList.toList()[i]] == 0) {
            //       return Container();
            //     } else {
            //       return MenuCard(
            //           isMenu: false,
            //           qtyFood: provOrders.listOrders[keysList.toList()[i]],
            //           food: provMenu.returnMenu(keysList[i])!);
            //     }
            //   }
            // return ListView(
            //   children: List.generate(
            //       keysList.length,
            //       (index) =>
            //           (provOrders.listOrders[keysList.toList()[index]] == 0)
            //               ? Container()
            //               : MenuCard(
            //                   isMenu: false,
            //                   qtyFood: provOrders
            //                       .listOrders[keysList.toList()[index]],
            //                   food: provMenu.returnMenu(keysList[index])!)),
            // );
            // }),