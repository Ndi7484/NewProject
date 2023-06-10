import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  bool _isBankTransferExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text(
            "Bank Transfer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    spreadRadius: 2.0, // Spread radius
                    blurRadius: 5.0, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isBankTransferExpanded = expanded;
                  });
                },
                children: [
                  ListView(
                    padding: const EdgeInsets.only(left: 20.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Text("INSTRUCTIONS:"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "1. Make sure you have an active BCA banks account"),
                            Text(
                                "2. Check Sufficient your bank balance during the transaction"),
                            Text(
                                "3. The pop up will appear and it will confirm the transactions"),
                            Text(
                                "4. Please verify that the transfer account is to Randumu.id"),
                            Text(
                                "5. Please check the nominals of the  transactions"),
                            Text("6. Enter the pin"),
                            Text(
                                "7. Transactions is done, and confirm it to our cashier"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/etc/BCA.png"),
                    const SizedBox(width: 10),
                    const Text(
                      "BCA",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
                    Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    spreadRadius: 2.0, // Spread radius
                    blurRadius: 5.0, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isBankTransferExpanded = expanded;
                  });
                },
                children: [
                  ListView(
                    padding: const EdgeInsets.only(left: 20.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Text("INSTRUCTIONS:"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "1. Make sure you have an active BCA banks account"),
                            Text(
                                "2. Check Sufficient your bank balance during the transaction"),
                            Text(
                                "3. The pop up will appear and it will confirm the transactions"),
                            Text(
                                "4. Please verify that the transfer account is to Randumu.id"),
                            Text(
                                "5. Please check the nominals of the  transactions"),
                            Text("6. Enter the pin"),
                            Text(
                                "7. Transactions is done, and confirm it to our cashier"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/etc/BNI.png"),
                    const SizedBox(width: 10),
                    const Text(
                      "BNI",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
