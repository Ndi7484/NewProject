import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/features/cart_page/widgets/dine_in_card.dart';
import 'package:flutter_application_1/features/cart_page/widgets/transaction_label.dart';
import 'package:flutter_application_1/features/menu_page/widgets/menu_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryDetailsPage extends StatelessWidget {
  HistoryDetailsPage({super.key, required this.ordersCartHistory});
  OrdersCart ordersCartHistory;

  // format helper
  NumberFormat formatter = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<MenuProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        title: const Text("History Details"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                (ordersCartHistory.doneStatus ? 0.9 : 0.79),
            child: ListView(
              children: [
                // order date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Order date :'),
                      const Spacer(),
                      Text(ordersCartHistory.dateTime)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  // dropdown re-type orders type
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Theme.of(context).colorScheme.primary))),
                    child: Row(
                      children: [
                        Image.asset(
                          (ordersCartHistory.typeOrder == TypeOrder.delivery)
                              ? 'assets/etc/Delivery.png'
                              : (ordersCartHistory.typeOrder ==
                                      TypeOrder.takeaway)
                                  ? 'assets/etc/Takeaway.png'
                                  : 'assets/etc/DineIn.png',
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.08,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text((ordersCartHistory.typeOrder == TypeOrder.delivery)
                            ? 'Delivery'
                            : (ordersCartHistory.typeOrder ==
                                    TypeOrder.takeaway)
                                ? 'Takeaway'
                                : 'DineIn'),
                        const Spacer(),
                        Container(
                            padding: const EdgeInsets.fromLTRB(7, 2.5, 7, 2.5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(
                              (ordersCartHistory.doneStatus)
                                  ? 'Complete'
                                  : 'In-queue',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary),
                            )),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),

                // address state
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    (ordersCartHistory.typeOrder == TypeOrder.delivery)
                        ? "Deliver to :"
                        : (ordersCartHistory.typeOrder == TypeOrder.takeaway)
                            ? "TakeAway from :"
                            : "Dine In Table :",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),

                // delivery address state
                (ordersCartHistory.typeOrder == TypeOrder.delivery)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, bottom: 24),
                        child: AddressListTile(
                          alamat: ordersCartHistory.deliveryAddress,
                          selection: false,
                          slider: false,
                        ),
                      )
                    : Container(),

                // takeaway address state
                (ordersCartHistory.typeOrder == TypeOrder.takeaway)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, bottom: 24),
                        child: AddressListTile(
                          alamat: ordersCartHistory.takeawayAddress,
                          selection: false,
                          slider: false,
                        ),
                      )
                    : Container(),

                // dine-in address state
                (ordersCartHistory.typeOrder == TypeOrder.dinein)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        child: DineInCard(
                            jsonString: (ordersCartHistory.dineInCode ??
                                    '{"place":"Unknown","address":"Location address missing","table":"NOT"}')
                                .toString()),
                      )
                    : Container(),

                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Order details : ",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Builder(
                  builder: (context) {
                    var keysList = ordersCartHistory.listOrder.keys.toList();
                    // print(keysList);
                    List<Widget> widgets = [];

                    for (var i = 0; i < keysList.length; i++) {
                      print(keysList[i].runtimeType);
                      print(provMenu.returnMenu(keysList[i]));
                      print(provMenu.listFoodMenu.length);
                      print(provMenu.listFoodMenu[0].menuID == keysList[i]);
                      print('stop');

                      if (ordersCartHistory.listOrder[keysList[i]] == 0) {
                        continue; // Skip this iteration and move to the next one
                      }

                      widgets.add(
                        MenuCard(
                          isMenu: false,
                          qtyFood: ordersCartHistory.listOrder[keysList[i]],
                          food: provMenu.returnMenu(keysList[i])!,
                        ),
                      );
                    }
                    if (widgets.isNotEmpty) {
                      return Column(
                        children: widgets,
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Center(
                          child: Column(children: [
                            Image.asset('assets/etc/Empty_Orders.png'),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('There is no orders yet..'),
                          ]),
                        ),
                      );
                    }
                  },
                ),
                const Divider(),

                // NO VOUCHER BAR

                // decoration payment lines
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8, top: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Payment Details : ",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),

                // SUB TOTAL
                TransactionLabel(
                  label: 'Sub-total',
                  price: formatter
                      .format(ordersCartHistory.subTotals)
                      .toString()
                      .replaceAll(',', '.'),
                ),

                // DELIVERY FEE
                (ordersCartHistory.typeOrder == TypeOrder.delivery)
                    ? TransactionLabel(
                        label: 'Delivery Fee',
                        price: formatter
                            .format(ordersCartHistory.deliveryVal)
                            .toString()
                            .replaceAll(',', '.'),
                      )
                    : Container(),

                // VOUCHER
                (ordersCartHistory.voucherCode != null)
                    ? TransactionLabel(
                        label:
                            'Voucher ${ordersCartHistory.voucherCode!.promoID}',
                        price:
                            '-${formatter.format(ordersCartHistory.voucherDisc).toString().replaceAll(',', '.')}',
                      )
                    : Container(),

                // POINTS
                (ordersCartHistory.pointsUse)
                    ? TransactionLabel(
                        label: 'Points used',
                        price:
                            '-${formatter.format(ordersCartHistory.pointsMuch).toString().replaceAll(',', '.')}',
                      )
                    : Container(),

                // line red
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: Theme.of(context).colorScheme.primary))),
                  ),
                ),

                // TOTAL
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 7,
                        child: Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const Text(
                              "Rp",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              formatter
                                  .format(ordersCartHistory.totals)
                                  .toString()
                                  .replaceAll(',', '.'),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // get points info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.green.shade900,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Points',
                          style: TextStyle(
                              fontSize: 13, color: Colors.green.shade700),
                        ),
                        const Spacer(),
                        Text(
                          formatter
                              .format(ordersCartHistory.pointsGet)
                              .toString()
                              .replaceAll(',', '.'),
                          style: TextStyle(
                              fontSize: 13, color: Colors.green.shade700),
                        ),
                      ],
                    ),
                  ),
                ),

                // add little pad in bottom
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          (ordersCartHistory.doneStatus)
              ? Container()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height *
                      (ordersCartHistory.doneStatus ? 0 : 0.088),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Complete Orders',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
