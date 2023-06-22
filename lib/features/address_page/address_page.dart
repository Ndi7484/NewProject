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
            ...List.generate(
                provAddress.listSelectedAlamat.length,
                (index) => GestureDetector(
                      onTap: () {
                        provAddress.changeSelected(
                            provAddress.listSelectedAlamat[index]);
                        // set the value delayed
                        provOrders.paramDeliveryAlamat =
                            provAddress.listSelectedAlamat[index];
                        provOrders.calculateSubTotals(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Address changed!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: AddressListTile(
                        alamat: provAddress.listSelectedAlamat[index],
                        selection: (provAddress
                                    .listSelectedAlamat[index].alamatLengkap ==
                                provAddress.selectedAlamat?.alamatLengkap)
                            ? true
                            : false,
                        slider: true, icon: true,
                      ),
                    )),
            (provAddress.listSelectedAlamat.isEmpty == true)
                ? Expanded(
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ]),
                    ),
                  )
                : Container(),
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
