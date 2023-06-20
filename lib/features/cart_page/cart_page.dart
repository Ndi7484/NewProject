import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/merchant_provider.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/features/address_merchant_page/address_merchant.dart';
import 'package:flutter_application_1/features/address_page/address_page.dart';
import 'package:flutter_application_1/features/cart_page/widgets/bottom_orders.dart';
import 'package:flutter_application_1/features/cart_page/widgets/dine_in_card.dart';
import 'package:flutter_application_1/features/cart_page/widgets/promo_bottom_sheet.dart';
import 'package:flutter_application_1/features/menu_page/widgets/menu_card.dart';
import 'package:flutter_application_1/features/qr_page_view/qr_page_view.dart';
import 'package:provider/provider.dart';

import 'widgets/transaction_label.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> list = ['Delivery', 'Takeaway', 'DineIn'];
  var dropdownValue = 'Delivery';

  @override
  Widget build(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);
    final provMenu = Provider.of<MenuProvider>(context);
    final provAddress = Provider.of<AddressProvider>(context);
    final provMerchant = Provider.of<MerchantProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);
    final provPromo = Provider.of<PromoProvider>(context);

    // bottom sheet
    var bottomSheet = PromoBottomSheet();

    // get account and address
    provAddress.getAddress(provAccount.selectedAccount!.email);
    provOrders.paramAccountInformation = provAccount.selectedAccount!;
    provOrders.paramDeliveryAlamat = provAddress.selectedAlamat;

    switch (provOrders.typeOrders) {
      case TypeOrder.delivery:
        setState(() {
          dropdownValue = 'Delivery';
        });
        break;
      case TypeOrder.takeaway:
        setState(() {
          dropdownValue = 'Takeaway';
        });
        break;
      case TypeOrder.dinein:
        setState(() {
          dropdownValue = 'DineIn';
        });
        break;
      default:
    }

    // this will trigger error on initstate of build
    // because trigger rebuild when in build state
    // if (provOrders.typeOrders == TypeOrder.delivery) {
    //   provOrders.calculateDelivery(
    //     provAddress.selectedAlamat,
    //     provMerchant.listMerchant,
    //   );
    // }

    return WillPopScope(
      onWillPop: () async {
        provOrders.softReset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                provOrders.softReset();
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
          title: const Text("Cart"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // dropdown re-type orders type
                    child: DropdownButton(
                      value: dropdownValue,
                      itemHeight: MediaQuery.of(context).size.height * 0.1,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.red,
                      ),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          switch (dropdownValue) {
                            case 'Delivery':
                              provOrders.typeOrders = TypeOrder.delivery;
                              break;
                            case 'Takeaway':
                              provOrders.typeOrders = TypeOrder.takeaway;
                              break;
                            case 'DineIn':
                              provOrders.typeOrders = TypeOrder.dinein;
                              break;
                            default:
                              provOrders.typeOrders = TypeOrder.fail;
                          }
                          provOrders.softReset();
                          provOrders.calculateSubTotals(context);
                        });
                      },
                      items: List.generate(
                        list.length,
                        (index) => DropdownMenuItem(
                          value: list[index],
                          child: Row(
                            children: [
                              // const Icon(Icons.abc),
                              Image.asset(
                                'assets/etc/${list[index]}.png',
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(list[index]),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // address state
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      (provOrders.typeOrders == TypeOrder.delivery)
                          ? "Deliver to :"
                          : (provOrders.typeOrders == TypeOrder.takeaway)
                              ? "TakeAway from :"
                              : "Dine In Table :",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),

                  // delivery address state
                  (provOrders.typeOrders == TypeOrder.delivery)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 24),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AddressPage()));
                            },
                            child: AddressListTile(
                              alamat: provAddress.selectedAlamat,
                              selection: false,
                              slider: false,
                            ),
                          ),
                        )
                      : Container(),

                  // takeaway address state
                  (provOrders.typeOrders == TypeOrder.takeaway)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 24),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const AddressMerchantPage()));
                            },
                            child: AddressListTile(
                              alamat: provMerchant.selectedMerchant,
                              selection: false,
                              slider: false,
                            ),
                          ),
                        )
                      : Container(),

                  // dine-in address state
                  (provOrders.typeOrders == TypeOrder.dinein)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16,16,16,24),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QRViewPage(
                                    provOrders: provOrders,
                                    tocart : true,
                                  ),
                                ),
                              );
                            },
                            child: DineInCard(
                                jsonString: (provOrders.paramDineInCode ??
                                        '{"place":"Not set","address":"Location address not set","table":"NOT"}')
                                    .toString()),
                          ),
                        )
                      : Container(),

                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Order details : ",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      var keysList = provOrders.listOrders.keys.toList();
                      List<Widget> widgets = [];

                      for (var i = 0; i < keysList.length; i++) {
                        if (provOrders.listOrders[keysList[i]] == 0) {
                          continue; // Skip this iteration and move to the next one
                        }

                        widgets.add(
                          MenuCard(
                            isMenu: false,
                            qtyFood: provOrders.listOrders[keysList[i]],
                            food: provMenu.returnMenu(keysList[i])!,
                          ),
                        );
                      }
                      if (widgets.isNotEmpty) {
                        return Column(
                          children: widgets,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Column(children: [
                              Image.asset('assets/etc/Empty_Orders.png'),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('There is no orders yet..'),
                            ]),
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(),
                  // USE Voucher bar
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: GestureDetector(
                      onTap: () {
                        bottomSheet.getBottomSheet(context, provPromo.validPromo,
                            provOrders, provPromo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: (provOrders.paramVoucherCode == null)
                              ? Colors.grey[200]
                              : Colors.lightGreen,
                          border: Border.all(
                            color: (provOrders.paramVoucherCode == null)
                                ? Colors.grey
                                : Colors.green,
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              spreadRadius: 2.0, // Spread radius
                              blurRadius: 5.0, // Blur radius
                              offset: Offset(
                                  0, 3), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.discount,
                            color: (provOrders.paramVoucherCode == null)
                                ? Colors.red
                                : const Color.fromARGB(255, 47, 110, 49),
                          ),
                          title: Text(
                            (provOrders.paramVoucherCode == null)
                                ? "Use Voucher"
                                : "Voucher ${provOrders.paramVoucherCode!.promoID} Used",
                            style: const TextStyle(color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                      ),
                    ),
                  ),

                  // decoration payment lines
                  Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8, top: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Payment Details : ",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SUB TOTAL
                  TransactionLabel(
                    label: 'Sub-total',
                    price: provOrders.paramSubTotals,
                  ),

                  // DELIVERY FEE
                  (provOrders.typeOrders == TypeOrder.delivery)
                      ? Builder(builder: (context) {
                          provOrders.calculateDelivery(
                            provAddress.selectedAlamat,
                            provMerchant.listMerchant,
                          );
                          return TransactionLabel(
                            label: 'Delivery Fee',
                            price: provOrders.paramDeliveryStr,
                          );
                        })
                      : Container(),

                  // VOUCHER
                  (provOrders.paramVoucherCode != null)
                      ? TransactionLabel(
                          label:
                              'Voucher ${provOrders.paramVoucherCode!.promoID}',
                          price: '-${provOrders.paramVoucherDiscStr}',
                        )
                      : Container(),

                  // POINTS
                  (provOrders.pointsUse)
                      ? TransactionLabel(
                          label: 'Points used',
                          price: '-${provOrders.paramMuchPointsStr}',
                        )
                      : Container(),

                  // line red
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color:
                                      Theme.of(context).colorScheme.primary))),
                    ),
                  ),

                  // TOTAL
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 7,
                          child: Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              const Text(
                                "Rp",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Builder(builder: (context) {
                                provOrders.calculateSubTotals(context);
                                return Text(
                                  provOrders.paramTotalPay,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // add little pad in bottom
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),

            // get points green line info
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  border: Border.all(width: 1, color: Colors.green)),
              child: Row(
                children: [
                  Icon(
                    Icons.wallet_giftcard_rounded,
                    color: Colors.green.shade900,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'You will get ${provOrders.paramPointsGet} points after the transaction..',
                    style:
                        TextStyle(fontSize: 11, color: Colors.green.shade900),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.help_outline_rounded,
                      color: Colors.green.shade900,
                    ),
                  )
                ],
              ),
            ),
            // bottom bar
            const Expanded(flex: 2, child: BottomOrders()),
          ],
        ),
      ),
    );
  }
}
