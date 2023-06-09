import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:flutter_application_1/features/payment_method_page/bank_transfer_page.dart';
import 'package:flutter_application_1/features/payment_method_page/confirm_payment/bank_transfer_confirm.dart';
import 'package:flutter_application_1/features/payment_method_page/confirm_payment/ewallet.dart';
import 'package:flutter_application_1/features/payment_method_page/widgets/snk_payment.dart';
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  bool _isBankTransferExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);
    final provPayment = Provider.of<PaymentProvider>(context);

    var bottomsheet = SnKPayment();

    // init avoid wrong payment that are deliver from the voucher 
    List<TypePayment> tmp = [];
    if (provOrders.tmpOrdersCartHistory!.voucherCode != null) {
      var exc = provOrders.tmpOrdersCartHistory!.voucherCode!.typeTrans
          .split(',')
          .toList();
      for (var el in exc) {
        if (el == 'All-Trans') {
          tmp = [
            TypePayment.bankTfBCA,
            TypePayment.bankTfBNI,
            TypePayment.OVO,
            TypePayment.Gopay,
            TypePayment.Dana,
            TypePayment.PayRandumu
          ];
        }
        if (el == 'BCA') {
          tmp.add(TypePayment.bankTfBCA);
          continue;
        }
        if (el == 'BNI') {
          tmp.add(TypePayment.bankTfBNI);
          continue;
        }
        if (el == 'Gopay') {
          tmp.add(TypePayment.Gopay);
          continue;
        }
        if (el == 'OVO') {
          tmp.add(TypePayment.OVO);
          continue;
        }
        if (el == 'Dana') {
          tmp.add(TypePayment.Dana);
          continue;
        }
        if (el == 'Randumu') {
          tmp.add(TypePayment.PayRandumu);
          continue;
        }
      }
    } else {
      tmp = [
        TypePayment.bankTfBCA,
        TypePayment.bankTfBNI,
        TypePayment.OVO,
        TypePayment.Gopay,
        TypePayment.Dana,
        TypePayment.PayRandumu
      ];
    }

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close),
          ),
          title: const Text(
            "Payment Method",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        children: [
          ...List.generate(provPayment.structurePayment.length, (index) {
            // init tmp variable
            var struct = provPayment.structurePayment[index];

            return (provPayment.listPayment[struct].children.isNotEmpty)
                ? Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey, // Shadow color
                                  spreadRadius: 1.0, // Spread radius
                                  blurRadius: 5.0, // Blur radius
                                  offset: Offset(
                                      0, 3), // Offset in the x and y direction
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              onExpansionChanged: (expanded) {
                                setState(() {
                                  _isBankTransferExpanded = expanded;
                                });
                              },
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      provPayment.listPayment[struct].img),
                                  const SizedBox(width: 10),
                                  Text(
                                    provPayment.listPayment[struct].title,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                              children: [
                                // List of bank options
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      ...List.generate(
                                          provPayment.listPayment[struct]
                                              .children.length,
                                          (index2) => ListTile(
                                                leading: Image.asset(provPayment
                                                    .listPayment[struct]
                                                    .children[index2]
                                                    .img),
                                                title: Text(provPayment
                                                    .listPayment[struct]
                                                    .children[index2]
                                                    .title),
                                                textColor: (tmp.contains(
                                                        provPayment
                                                            .listPayment[struct]
                                                            .children[index2]
                                                            .typePay))
                                                    ? null
                                                    : Colors.grey,
                                                onTap: () {
                                                  if (tmp.contains(provPayment
                                                      .listPayment[struct]
                                                      .children[index2]
                                                      .typePay)) {
                                                    // Handle Bank selection
                                                    provOrders
                                                            .tmpOrdersCartHistory!
                                                            .typePayment =
                                                        provPayment
                                                            .listPayment[struct]
                                                            .children[index2]
                                                            .typePay;
                                                    print(provOrders
                                                        .tmpOrdersCartHistory!
                                                        .typePayment);

                                                    // navigation
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                CircularProgressPage()));
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 1), () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  BankTransferConfirmPaymentPage(
                                                                    bankData: provPayment
                                                                        .listPayment[
                                                                            struct]
                                                                        .children[index2],
                                                                  )));
                                                    });
                                                  }
                                                },
                                              )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      (provPayment.listPayment[struct].snk.isNotEmpty)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const BankTransferPage()));
                              },
                              child: Icon(
                                Icons.help_outline_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ))
                          // if snk is not available
                          : Container()
                    ],
                  )
                // others that dont have childrens / inherit
                : Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1.0,
                                blurRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () async {
                              if (tmp.contains(
                                  provPayment.listPayment[struct].typePay)) {
                                // Handle Bank selection
                                provOrders.tmpOrdersCartHistory!.typePayment =
                                    provPayment.listPayment[struct].typePay;
                                print(provOrders
                                    .tmpOrdersCartHistory!.typePayment);

                                // navigation
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            CircularProgressPage()));
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EWalletPage(
                                                color: provPayment
                                                    .listPayment[struct].color,
                                                typePay: provPayment
                                                    .listPayment[struct]
                                                    .typePay,
                                                image: provPayment
                                                    .listPayment[struct].img,
                                              )));
                                });
                              }
                            },
                            leading: Image.asset(
                                provPayment.listPayment[struct].img),
                            title: Text(
                              provPayment.listPayment[struct].title,
                              style: TextStyle(
                                color: (tmp.contains(provPayment
                                        .listPayment[struct].typePay))
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      (provPayment.listPayment[struct].snk.isNotEmpty)
                          ? GestureDetector(
                              onTap: () {
                                bottomsheet.getBottomSheet(
                                    context,
                                    provPayment.listPayment[struct].snk,
                                    provPayment.listPayment[struct].img);
                              },
                              child: Icon(
                                Icons.help_outline_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ))
                          : Container(),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
