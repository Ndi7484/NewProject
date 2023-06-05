import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Text("Payment Method"),
      ),
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
                    child: ListTile(
                      leading: Image.asset("assets/etc/BCA.png"),
                      title: const Text(
                        "Bank Transfer",
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        foregroundColor: Colors.red,
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
