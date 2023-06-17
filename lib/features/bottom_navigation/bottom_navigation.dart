import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/widgets/typemenu_dialog.dart';
import 'package:flutter_application_1/features/Page_Promo/promopage.dart';
import 'package:flutter_application_1/features/cart_page/cart_page.dart';
import 'package:flutter_application_1/features/main_page/main_page.dart';
import 'package:flutter_application_1/features/menu_page/menu_page.dart';
import 'package:flutter_application_1/features/points_page/points_page.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;

  final List<String> _appBarTitle = [
    'Main Home',
    'Menu',
    'Points',
    'Promo',
    'Orders'
  ];
  final List<dynamic> _bodyFill = [
    const MainPage(),
    const MenuPage(),
    const PointsPage(),
    const PromoPage(),
    const MainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var typeMenuDialog = TypeOrderDialog();
    var provPage = Provider.of<PageProvider>(context);
    var provOrders = Provider.of<OrdersProvider>(context);
    _selectedIndex = provPage.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle[_selectedIndex]),
        actions: [
          (_selectedIndex == 0)
              ? GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Stack(children: [
                      const Icon(
                        Icons.notifications,
                        size: 25,
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '10',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 8),
                              ),
                            ),
                          ))
                    ]),
                  ))
              : Container(),
          const SizedBox(
            width: 5,
          ),
          Image.asset(
            'assets/etc/Logo.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        // if (_selectedIndex == 1 && provOrders.typeOrders == null) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     showDialog(
        //       context: context,
        //       builder: (_) => typeMenuDialog.getDialog(context),
        //     );
        //   });
        // }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _bodyFill[_selectedIndex],
        );
      }),
      floatingActionButton: (_selectedIndex == 0 || _selectedIndex == 1)
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                if (provOrders.typeOrders == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (_) => typeMenuDialog.getDialog(context),
                    );
                  });
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartPage()));
              },
              label: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: child,
                  ),
                ),
                child: (provOrders.listOrders.values
                            .fold(0, (prevEl, el) => prevEl + el) ==
                        0)
                    ? const Icon(Icons.shopping_basket)
                    : Row(
                        children: [
                          // const Padding(
                          //   padding: EdgeInsets.only(right: 8.0),
                          //   child: Icon(Icons.shopping_basket),
                          // ),
                          Text(
                            "${provOrders.listOrders.values.fold(0, (prevEl, el) => prevEl + el)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              ' in cart',
                              style: TextStyle(color: Colors.white60),
                            ),
                          ),
                          Text('Rp. ${provOrders.paramSubTotals},-'),
                        ],
                      ),
              ))
          // FloatingActionButton(
          //     onPressed: () {
          // if (provOrders.typeOrders == null) {
          //   WidgetsBinding.instance.addPostFrameCallback((_) {
          //     showDialog(
          //       context: context,
          //       builder: (_) => typeMenuDialog.getDialog(context),
          //     );
          //   });
          // }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => const CartPage()));
          //     },
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     child: const Icon(
          //       Icons.shopping_basket,
          //       color: Colors.white,
          //     ))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining_rounded), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star_rate_rounded,
                size: 27,
              ),
              label: 'Points'),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_rounded), label: 'Promo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: 'Orders'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          provPage.selectedIndex = index;
        },
      ),
    );
  }
}
