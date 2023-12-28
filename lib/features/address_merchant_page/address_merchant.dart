import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/merchant_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:provider/provider.dart';

class AddressMerchantPage extends StatefulWidget {
  const AddressMerchantPage({super.key});

  @override
  State<AddressMerchantPage> createState() => _AddressMerchantPageState();
}

class _AddressMerchantPageState extends State<AddressMerchantPage> {
  @override
  Widget build(BuildContext context) {
    final provMerchant = Provider.of<MerchantProvider>(context);
    final provOrder = Provider.of<OrdersProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Merchant Point"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('merchant')
                .snapshots()
                .map((snapshot) => snapshot.docs
                    .map((doc) => Alamat.fromJson(doc.data()))
                    .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ...List.generate(
                        snapshot.data!.length,
                        (index) => GestureDetector(
                              onTap: () async {
                                provMerchant.selectedMerchant =
                                    snapshot.data![index];
                                provOrder.paramTakeawayAlamat =
                                    snapshot.data![index];
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Merchant Address selected!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: AddressListTile(
                                alamat: snapshot.data![index],
                                selection:
                                    (snapshot.data![index].alamatLengkap ==
                                            provMerchant.selectedMerchant
                                                ?.alamatLengkap)
                                        ? true
                                        : false,
                                slider: false,
                                icon: true,
                              ),
                            )),
                    (snapshot.data!.isEmpty == true)
                        ? Expanded(
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_off,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'There is No Merchant Location saved yet... ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    )
                                  ]),
                            ),
                          )
                        : Container(),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
