import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
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
class _ListOrderState extends State<ListOrder>
    with AutomaticKeepAliveClientMixin<ListOrder> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the super.build is called
    bool anyOrders = false;

    final provHistory = Provider.of<HistoryProvider>(context);
    // don't delete this line : to avoid range menu error / or not found
    final provMenu = Provider.of<MenuProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        ...List.generate(provHistory.listOrderHistory.length, (index) {
          if (provHistory.listOrderHistory[index].accountInformation.email ==
              provAccount.selectedAccount!.email) {
            if (widget.type == 'Delivery' &&
                provHistory.listOrderHistory[index].typeOrder ==
                    TypeOrder.delivery) {
              setState(() {
                anyOrders = true;
              });
            }
            if (widget.type == 'Takeaway' &&
                provHistory.listOrderHistory[index].typeOrder ==
                    TypeOrder.takeaway) {
              setState(() {
                anyOrders = true;
              });
            }
            if (widget.type == 'Dine-In' &&
                provHistory.listOrderHistory[index].typeOrder ==
                    TypeOrder.dinein) {
              setState(() {
                anyOrders = true;
              });
            }
            return OrderCard(
                type: (widget.type == 'Delivery')
                    ? TypeOrder.delivery
                    : (widget.type == 'Takeaway')
                        ? TypeOrder.takeaway
                        : TypeOrder.dinein,
                data: provHistory.listOrderHistory[index],
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
            : Container(),
      ]),
    );
  }
}
