import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/payment_method_page/bank_transfer_page.dart';
import 'package:flutter_application_1/features/payment_method_page/dana.dart';
import 'package:flutter_application_1/features/payment_method_page/gopay.dart';
import 'package:flutter_application_1/features/payment_method_page/ovo.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
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
            "Payment Method",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Padding(
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
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
                        // List of bank options
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                leading: Image.asset("assets/etc/BCA.png"),
                                title: const Text("Bank BCA"),
                                onTap: () {
                                  // Handle Bank BCA selection
                                },
                              ),
                              ListTile(
                                leading: Image.asset("assets/etc/BNI.png"),
                                title: const Text("Bank BNI"),
                                onTap: () {
                                  // Handle Bank BNI selection
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/etc/Bank Transfer.png"),
                          const SizedBox(width: 10),
                          const Text(
                            "Bank Transfer",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BankTransferPage()));
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            foregroundColor: Colors.red,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.question_mark,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Padding(
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/etc/OVO.png"),
                      title: const Text(
                        "OVO",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OVOPage()));
                    },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              )
          )],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Padding(
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/etc/Gopay.png"),
                      title: const Text(
                        "Gopay",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const GoPayPage()));
                    },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              )
          )],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Padding(
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/etc/Dana.png"),
                      title: const Text(
                        "Dana",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DanaPage()));
                    },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              )
          )],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Padding(
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/etc/Logo.png"),
                      title: const Text(
                        "Pay at Ramudu",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              )
            ],
          ),
        ],
      ),
    );
  }
}
