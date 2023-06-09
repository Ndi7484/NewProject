import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/code_scan_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/features/address_merchant_page/address_merchant.dart';
import 'package:flutter_application_1/features/qr_page_view/qr_page_view.dart';
import 'package:provider/provider.dart';

class ButtonCategoriesMain extends StatelessWidget {
  ButtonCategoriesMain({super.key});

  List<String> typeOrderList = ['Delivery', 'TakeAway', 'Dine-In'];
  List<String> typeOrderListDesc = [
    'deliver to you',
    'grab your own',
    'eat at place',
  ];
  List<TypeOrder> listTypeOrder = [
    TypeOrder.delivery,
    TypeOrder.takeaway,
    TypeOrder.dinein
  ];

  @override
  Widget build(BuildContext context) {
    final provPage = Provider.of<PageProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    final provCode = Provider.of<CodeScanProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          typeOrderList.length,
          (index) => GestureDetector(
                onTap: () {
                  provOrders.typeOrders = listTypeOrder[index];
                  // if dellivery
                  if (index == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('selected delivery, choose menu..'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // if takeaway
                  } else if (index == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('selected takeaway, choose merchant..'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // push dialog here address of our merchant
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddressMerchantPage()),
                    );
                    // if dine in
                  } else if (index == 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('selected dine-in, qr first..'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // special case for qr view page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QRViewPage(
                          provOrders: provOrders,
                          tocart: false,
                          provCode: provCode,
                        ),
                      ),
                    );
                  }
                  provPage.selectedIndex = 1;
                },
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: ClipRect(
                    child: Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.12,
                        left: MediaQuery.of(context).size.width * 0.12,
                        child: Transform.rotate(
                          angle: 3.4,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/etc/box${index + 1}.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                          // opacity: const AlwaysStoppedAnimation(0.8),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Text(
                                  typeOrderList[index],
                                  style: TextStyle(
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 0.5
                                        ..color = Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  typeOrderList[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ]),
                              Text(
                                typeOrderListDesc[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ))
                    ]),
                  ),
                ),
              )),
    );
  }
}
