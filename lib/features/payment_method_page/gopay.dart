import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GoPayPage extends StatefulWidget {
  const GoPayPage({super.key});

  @override
  State<GoPayPage> createState() => _GoPayPageState();
}

class _GoPayPageState extends State<GoPayPage> {
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
            "GoPay",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 10),
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
          child: Padding(
            padding: const EdgeInsets.only(top:10.0, bottom: 10),
            child: IntrinsicHeight(
              child: ListTile(
                leading: Image.asset("assets/etc/GoPay.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("INSTRUCTIONS"),
                    Text("1. Make sure you have an active GoPay account"),
                    Text("2. Sufficient GoPay Cash balance during the transaction"),
                    Text(
                        "3. Make sure GoPay registered mobile number is the same with Randumu."),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
