import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BankTransferConfirmPaymentPage extends StatelessWidget {
  BankTransferConfirmPaymentPage({
    super.key,
    required this.bankData,
  });
  Payment bankData;

  NumberFormat formmater = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);
    final provHistory = Provider.of<HistoryProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);
    final provPage = Provider.of<PageProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
          title: Center(
            child: Text(
              "m-Transfer",
              style:
                  TextStyle(color: bankData.color, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Icon(Icons.rectangle_rounded,
                  color: Colors.green[300], size: 15),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Center(
                child: Text(
                  "Send",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Bank",
                          style: TextStyle(
                              color: bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            bankData.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Ke Rekening Tujuan",
                          style: TextStyle(
                              color: bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: bankData.color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Jumlah Uang",
                          style: TextStyle(
                              color: bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            formmater
                                .format(provOrders.tmpOrdersCartHistory!.totals)
                                .toString()
                                .replaceAll(',', '.'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: bankData.color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Layanan Transfer",
                          style: TextStyle(
                              color: bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: bankData.color),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Dari Rekening",
                        style: TextStyle(
                            color: bankData.color, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "112233445566",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: bankData.color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () {
                    // Handle button press
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
                  child: const Padding(
                    padding: EdgeInsets.only(
                        right: 100.0, left: 100.0, top: 7, bottom: 7),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }
}
