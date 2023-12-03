import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/widgets/flutter_map_widget.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Column(
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
              (provAddress.paramDisplayName != '')
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.gps_fixed_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            provAddress.paramDisplayName,
                            softWrap: true,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Row(
                          children: [
                            const Text('Select Location'),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close))
                          ],
                        ),
                        content: FlutterMapPage(
                          center: LatLongCenter(
                            latitude: provAddress.paramLang ?? 3.5952,
                            longitude: provAddress.paramLong ?? 98.6722,
                            // latitude: 3.5952,
                            // longitude: 98.6722,
                          ),
                        ),

                        // FlutterGoogleLocationPicker(
                        //   markerColor: Theme.of(context).colorScheme.primary,
                        //   primaryColor: Theme.of(context).colorScheme.primary,
                        //   onPicked: (pickedData) {
                        //     print(
                        //         'object here object here object here object here');
                        //     print(pickedData.address);
                        //     print(pickedData.latLong.latitude);
                        //     print(pickedData.latLong.longitude);
                        //     provAddress.paramLang = pickedData.latLong.latitude;
                        //     provAddress.paramLong =
                        //         pickedData.latLong.longitude;
                        //     provAddress.paramDisplayName = pickedData.displayName;
                        //     provAddress.setMap();
                        //     Navigator.pop(context);
                        //   },
                        //   center: LatLong(
                        //       latitude: provAddress.paramLang ?? 3.6170236,
                        //       longitude: provAddress.paramLong ?? 98.6797823),
                        // ),
                      ),
                    );
                  },
                  child: const Text('Set Location'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      provAddress.saveAddress(
                          context, provAccount.selectedAccount!.email);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
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
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15,
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
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
