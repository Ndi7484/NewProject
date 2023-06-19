import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
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

    final provHistory = Provider.of<HistoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        ...List.generate(provHistory.listOrderHistory.length, (index) {
          return OrderCard(
              type: (widget.type == 'Delivery')
                  ? TypeOrder.delivery
                  : (widget.type == 'Takeaway')
                      ? TypeOrder.takeaway
                      : TypeOrder.dinein,
              data: provHistory.listOrderHistory[index],
              indexing: index);
        }),
      ]),
    );
  }
}
