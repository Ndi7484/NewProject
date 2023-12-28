import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/order_card.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _ListOrderState createState() => _ListOrderState();
}

// ensure the scroll position of the widgets
class _ListOrderState extends State<ListOrder> {
  @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context); // Ensure the super.build is called
    bool anyOrders = false;

    // final provHistory = Provider.of<HistoryProvider>(context);
    // don't delete this line : to avoid range menu error / or not found
    // final provMenu = Provider.of<MenuProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("history")
            .orderBy("date_time", descending: false)
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((doc) => OrdersCart.fromJson(doc.data()))
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                ...List.generate(snapshot.data!.length, (index) {
                  if (snapshot.data![index].accountInformation.email ==
                      provAccount.selectedAccount!.email) {
                    if (widget.type == 'Delivery' &&
                        snapshot.data![index].typeOrder == TypeOrder.delivery) {
                      anyOrders = true;
                    }
                    if (widget.type == 'Takeaway' &&
                        snapshot.data![index].typeOrder == TypeOrder.takeaway) {
                      anyOrders = true;
                    }
                    if (widget.type == 'Dine-In' &&
                        snapshot.data![index].typeOrder == TypeOrder.dinein) {
                      anyOrders = true;
                    }
                    return OrderCard(
                        type: (widget.type == 'Delivery')
                            ? TypeOrder.delivery
                            : (widget.type == 'Takeaway')
                                ? TypeOrder.takeaway
                                : TypeOrder.dinein,
                        data: snapshot.data![index],
                        indexing: index);
                  } else {
                    return Container();
                  }
                }).reversed,
                (!anyOrders)
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        child: Center(
                            child: Column(
                          children: [
                            Image.asset('assets/etc/Empty_Orders.png'),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'There is no orders here..',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                      )
                    : Container()
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return (!anyOrders)
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Center(
                      child: Column(
                    children: [
                      Image.asset('assets/etc/Empty_Orders.png'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'There is no orders here..',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
                )
              : Container();
        });
  }
}
