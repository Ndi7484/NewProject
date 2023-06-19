import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';

class OrderCard extends StatefulWidget {
  OrderCard(
      {super.key,
      required this.type,
      required this.data,
      required this.indexing});
  TypeOrder type;
  OrdersCart data;
  int indexing;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        leading: Image.asset('assets/etc/Delivery.png'),
        title: Text('Hello'),
        subtitle: Text('hello'),
      ),
    );
  }
}
