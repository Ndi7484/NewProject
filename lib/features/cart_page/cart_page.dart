import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Text("Address"),
      ),
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
              child: const ListTile(
                leading: Icon(
                  Icons.car_crash,
                  color: Colors.red,
                ),
                title: Text(
                  "Delivery",
                  style: TextStyle(color: Colors.red),
                ),
                trailing: Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Address : ",
                style: TextStyle(color: Colors.grey,
                fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 3),
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
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text("Address"),
                    ),
                  ],
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Detail address"),
                ),
                trailing: const Icon(Icons.arrow_right_outlined),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order details : ",
                style: TextStyle(color: Colors.red,
                fontSize: 18),
                
              ),
            ),
          ),
          Column(
            children: [
              Row(
                
              )
            ],
          )
        ],
      ),
    );
  }
}
