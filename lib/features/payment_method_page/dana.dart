import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DanaPage extends StatefulWidget {
  const DanaPage({super.key});

  @override
  State<DanaPage> createState() => _DanaPageState();
}

class _DanaPageState extends State<DanaPage> {
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
            "Dana",
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
                leading: Image.asset("assets/etc/Dana.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("INSTRUCTIONS"),
                    Text("1. Make sure you have an active Dana account"),
                    Text("2. Sufficient Dana Cash balance during the transaction"),
                    Text(
                        "3. Make sure Dana registered mobile number is the same with Randumu."),
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
