import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    final provAddress = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
          title: const Text(
            "New Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextField(
              onChanged: (value) {
                provAddress.paramCategory = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Home, Office, etc..',
                  contentPadding: EdgeInsets.all(6),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextField(
              onChanged: (value) {
                provAddress.paramAddress = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Jl. ABC No. 45D',
                  contentPadding: EdgeInsets.all(6),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Text(
              "Note",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextField(
              onChanged: (value) {
                provAddress.paramNote = value;
              },
              decoration: const InputDecoration(
                  hintText: 'sebelah toko bunga',
                  contentPadding: EdgeInsets.all(6),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Text(
              "Map:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 212, 212, 212),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Shadow color
                      spreadRadius: 2.0, // Spread radius
                      blurRadius: 5.0, // Blur radius
                      offset: Offset(0, 3), // Offset in the x and y direction
                    ),
                  ],
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
