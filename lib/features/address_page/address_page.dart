import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/features/add_address_page/add_address_page.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    final provAddress = Provider.of<AddressProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    // set address here
    provAddress.getAddress(provAccount.selectedAccount!.email);

    // function build widget list
    Widget buildAddressTile(Alamat address, bool selection) {
      return (provAccount.selectedAccount!.email == address.alamatID)
          ? AddressListTile(
              alamat: address, selection: selection, slider: true, icon: true)
          : Container();
    }

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Address"),
        ),
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<List<Alamat>>(
                stream: FirebaseFirestore.instance
                    .collection('address')
                    .snapshots()
                    .map((snapshot) => snapshot.docs
                        .map((doc) => Alamat.fromJson(doc.data()))
                        .toList()),
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    List<Widget> addressWidgets = snapshot.data!.map((alamat) {
                      provAddress.selectedAlamat ??= alamat;
                      print(provAddress.selectedAlamat?.alamatLengkap);
                      print(alamat.alamatLengkap);
                      return GestureDetector(
                          onTap: () {
                            provAddress.changeSelected(alamat);
                            Navigator.pop(context);
                          },
                          child: buildAddressTile(
                              alamat,
                              ((provAddress.selectedAlamat?.alamatLengkap) ==
                                      alamat.alamatLengkap)
                                  ? true
                                  : false));
                    }).toList();

                    return Column(
                      children: addressWidgets,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_off,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'There is No Location Saved yet... ',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              )
                            ]),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddAddressPage()));
          },
          tooltip: 'Add Address',
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ));
  }
}
