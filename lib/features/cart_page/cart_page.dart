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
                style: TextStyle(color: Colors.grey, fontSize: 18),
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
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  Column(
                    children: [Text("Food 1"), Text("Food 2")],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.red,
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
                  Icons.discount,
                  color: Colors.red,
                ),
                title: Text(
                  "Use Coupon",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment Details : ",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sub-total",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Rp 95.000",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomOrders(),
    );
  }
}

class BottomOrders extends StatefulWidget {
  @override
  State<BottomOrders> createState() => _BottomOrdersState();
}

class _BottomOrdersState extends State<BottomOrders> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black, width: 1))),
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Use Points : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "17.000",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Switch(
                      value: true, // Replace with your switch value
                      onChanged: (bool value) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.only(
                                  right: 30,
                                  left: 30,
                                  top: 10,
                                  bottom: 10), // Adjust the padding as desired
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.red, width: 1.0),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              Text(
                                "Order",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.only(
                                  right: 30,
                                  left: 30,
                                  top: 10,
                                  bottom: 10), // Adjust the padding as desired
                            ),
                          ),
                          child: Text("Choose Payment")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ); 
  }
}
