import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EWalletPage extends StatelessWidget {
  EWalletPage({
    super.key,
    required this.typePay,
    required this.color,
    required this.image,
  });
  TypePayment typePay;
  dynamic color;
  String image;

  NumberFormat formatter = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);
    final provHistory = Provider.of<HistoryProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);
    final provPage = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Confirm Payment",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 5.0, left: 5.0, bottom: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        color: Colors.grey[600],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "RANDUMU",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Colors.grey[200]!, width: 1))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 5, left: 5, right: 5),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 4,
                            child: Text(
                              "Total Pembayaran",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Lihat Detail",
                              style: TextStyle(
                                  color: color, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 5.0, left: 5.0, bottom: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Rp",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      Text(
                        " ${formatter.format(provOrders.tmpOrdersCartHistory!.totals).toString().replaceAll(',', '.')}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              children: [
                const Spacer(),
                const Text('powered by ', style: TextStyle(color: Colors.grey),),
                Image.asset(image, width: 30, height: 30,),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CircularProgressPage(
                              messageText:
                                  'Please wait, confirming payment..',
                            )));

                // set history
                provHistory
                    .addListOrderHistory(provOrders.tmpOrdersCartHistory!);
                provAccount.pointsChange(
                    provOrders.tmpOrdersCartHistory!.pointsMuch,
                    provOrders.tmpOrdersCartHistory!.pointsGet);
                provPage.historyIndex =
                        (provOrders.tmpOrdersCartHistory!.typeOrder ==
                                TypeOrder.delivery)
                            ? 0
                            : (provOrders.tmpOrdersCartHistory!.typeOrder ==
                                    TypeOrder.takeaway)
                                ? 1
                                : 2;
                provOrders.resetParam();
                provPage.selectedIndex = 4;

                // replace with pop til first after delay
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                      ),
                      color: color,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        "Bayar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
