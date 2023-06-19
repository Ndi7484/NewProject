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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 80,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey, offset: Offset(2.0, 3.0), blurRadius: 4.0)
        ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                (widget.type == TypeOrder.delivery)
                    ? 'assets/etc/Delivery.png'
                    : (widget.type == TypeOrder.takeaway)
                        ? 'assets/etc/Takeaway.png'
                        : 'assets/etc/DineIn.png',
                width: 60,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'D${widget.indexing}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: widget.data.deliveryAddress?.alamatLengkap,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
