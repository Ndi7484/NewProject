import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/core/widgets/menu_card.dart';
import 'package:flutter_application_1/features/address_page/address_page.dart';
import 'package:flutter_application_1/features/cart_page/widgets/bottom_orders.dart';
import 'package:provider/provider.dart';

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
    final provAccount = Provider.of<AccountProvider>(context);
    // get address
    provAddress.getAddress(provAccount.selectedAccount!.email);
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

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(list[index]),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                    ],
                                  ),
                                )))),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Address : ",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 3, bottom: 10),
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
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 4),
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

                    return Column(
                      children: widgets,
                    );
                  },
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
                          offset:
                              Offset(0, 3), // Offset in the x and y direction
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
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 15),
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
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 15),
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
                ),
              ],
            ),
          ),
          // bottom bar
          const Expanded(flex: 2, child: BottomOrders()),
        ],
      ),
    );
  }
}
