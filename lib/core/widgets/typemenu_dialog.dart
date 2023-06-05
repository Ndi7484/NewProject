import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:provider/provider.dart';

class TypeOrderDialog {
  getDialog(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);

    return AlertDialog(
      title: const Text('Select Order'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.asset(
              'assets/etc/Delivery.png',
              width: 50,
            ),
            title: const Text('Delivery',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              provOrders.typeOrders = TypeOrder.delivery;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              child: Center(
                child: Image.asset(
                  'assets/etc/Takeaway.png',
                  width: 40,
                ),
              ),
            ),
            title: const Text(
              'Takeway',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              provOrders.typeOrders = TypeOrder.takeaway;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/etc/DineIn.png',
              width: 50,
            ),
            title: const Text('Dine-In',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              provOrders.typeOrders = TypeOrder.dinein;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
