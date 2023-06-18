import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:provider/provider.dart';

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  bool _isBankTransferExpanded = false;
  @override
  Widget build(BuildContext context) {
    final provPayment = Provider.of<PaymentProvider>(context);
    var tmp = provPayment.listPayment['Bank Transfer'].children;

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text(
            "Bank Transfer T&C",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        children: [
          ...List.generate(
            tmp.length,
            (index) => Padding(
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
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(tmp[index].img),
                      const SizedBox(width: 10),
                      Text(
                        tmp[index].title,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  children: [
                    ListView(
                      padding: const EdgeInsets.only(left: 20.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Text("INSTRUCTIONS:"),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(tmp[index].snk.length,
                                  (index2) => Text(tmp[index].snk[index2]))),
                        )
                      ],
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
