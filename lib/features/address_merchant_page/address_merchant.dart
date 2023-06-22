import 'package:flutter/material.dart';
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
    // set address here
    // provAddress.getAddress(provAccount.selectedAccount!.email);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text("Merchant Point"),
      ),
      body: Column(
        children: [
          ...List.generate(
              provMerchant.listMerchant.length,
              (index) => GestureDetector(
                    onTap: () {
                      provMerchant.selectedMerchant =
                          provMerchant.listMerchant[index];
                      provOrder.paramTakeawayAlamat =
                          provMerchant.listMerchant[index];
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Merchant Address selected!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: AddressListTile(
                      alamat: provMerchant.listMerchant[index],
                      selection:
                          (provMerchant.listMerchant[index].alamatLengkap ==
                                  provMerchant.selectedMerchant?.alamatLengkap)
                              ? true
                              : false,
                      slider: false,
                      icon: true,
                    ),
                  )),
          (provMerchant.listMerchant.isEmpty == true)
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
                            'There is No Merchant Location saved yet... ',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        ]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
