import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OVOPage extends StatefulWidget {
  const OVOPage({super.key});

  @override
  State<OVOPage> createState() => _OVOPageState();
}

class _OVOPageState extends State<OVOPage> {
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
            "OVO",
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
                leading: Image.asset("assets/etc/OVO.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("INSTRUCTIONS"),
                    Text("1. Make sure you have an active OVO account"),
                    Text("2. Sufficient OVO Cash balance during the transaction"),
                    Text(
                        "3. Make sure OVO registered mobile number is the same with Randumu."),
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
