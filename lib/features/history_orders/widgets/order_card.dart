import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/features/history_orders/history_details_page.dart';

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
    return (widget.data.typeOrder == widget.type)
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HistoryDetailsPage(
                              ordersCartHistory: widget.data,
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2.0, 3.0),
                          blurRadius: 4.0)
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: Row(
                              children: [
                                Text(
                                  (widget.type == TypeOrder.delivery)
                                      ? 'Delivery'
                                      : (widget.type == TypeOrder.takeaway)
                                          ? 'Takeaway'
                                          : 'Dine-In',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.red),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Text(
                                    (widget.data.doneStatus)
                                        ? 'Complete'
                                        : 'In-queue',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                )
                              ],
                            ),
                          ),
                          (widget.data.deliveryAddress != null)
                              ? RichText(
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        '${widget.data.deliveryAddress?.alamatTitle},\n${widget.data.deliveryAddress?.alamatLengkap}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ))
                              : Container(),
                          (widget.data.takeawayAddress != null)
                              ? RichText(
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        '${widget.data.takeawayAddress?.alamatTitle},\n${widget.data.takeawayAddress?.alamatLengkap}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ))
                              : Container(),
                          (widget.data.dineInCode != null)
                              ? RichText(
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        'table : ${jsonDecode(widget.data.dineInCode!)['table']},\nplace : ${jsonDecode(widget.data.dineInCode!)['place']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ))
                              : Container(),
                          const Spacer(),
                          Text(
                            'date : ${widget.data.dateTime}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
