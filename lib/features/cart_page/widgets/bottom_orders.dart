import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/merchant_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/features/payment_method_page/payment_method_page.dart';
import 'package:provider/provider.dart';

class BottomOrders extends StatefulWidget {
  const BottomOrders({super.key});

  @override
  State<BottomOrders> createState() => _BottomOrdersState();
}

class _BottomOrdersState extends State<BottomOrders> {
  bool switchPoints = false;

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    final provAddress = Provider.of<AddressProvider>(context);
    final provMerchant = Provider.of<MerchantProvider>(context);
    // print(provAccount.selectedAccount!.points);

    // trigger the calculation function, so the button is clickable
    if (!switchPoints) {
      switchPoints = !switchPoints;
      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(() {
            provOrders.setPointsUse(false, provAccount.selectedAccount!);
          });
        },
      );
    }

    bool checkAddress() {
      if (provOrders.typeOrders == TypeOrder.delivery) {
        if (provOrders.paramDeliveryAlamat != null) {
          return true;
        }
        try {
          provOrders.paramDeliveryAlamat = provAddress.listSelectedAlamat[0];
          return true;
        } catch (e) {
          provOrders.paramDeliveryAlamat = null;
        }
      } else if (provOrders.typeOrders == TypeOrder.takeaway) {
        if (provOrders.paramTakeawayAlamat != null) {
          return true;
        }
        try {
          provOrders.paramTakeawayAlamat = provMerchant.listMerchant[0];
          return true;
        } catch (e) {
          provOrders.paramTakeawayAlamat = null;
        }
      } else if (provOrders.typeOrders == TypeOrder.dinein) {
        if (provOrders.paramDineInCode != null) {
          return true;
        }
      }
      return false;
    }

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black, width: 1))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Use Points : ",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  provAccount.selectedAccount!.pointsString,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                (provAccount.selectedAccount!.points > 0)
                    ? Switch(
                        // points is not 0 or less
                        value: provOrders.pointsUse,
                        onChanged: (bool value) {
                          setState(() {
                            provOrders.setPointsUse(
                                value, provAccount.selectedAccount!);
                          });
                        },
                      )
                    : Switch(
                        value: false,
                        onChanged: (value) {},
                        inactiveThumbColor: Colors.grey[300],
                      )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    provOrders.softReset();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Orders',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    if (provOrders.typeOrders != null &&
                        provOrders.paramSubTotalsInt > 1 &&
                        checkAddress()) {
                      provOrders.setInitOrders();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PaymentMethodPage()));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: (provOrders.typeOrders != null &&
                                provOrders.paramSubTotalsInt > 1 &&
                                checkAddress())
                            ? Theme.of(context).colorScheme.primary
                            : Colors.red.shade100,
                        border: Border.all(
                            color: (provOrders.typeOrders != null &&
                                    provOrders.paramSubTotalsInt > 1 &&
                                    checkAddress())
                                ? Theme.of(context).colorScheme.primary
                                : Colors.red.shade100,
                            width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
