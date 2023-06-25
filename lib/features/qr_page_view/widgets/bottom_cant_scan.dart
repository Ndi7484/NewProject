import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

import '../../cart_page/cart_page.dart';

class CantScanBottomSheet {
  getBottomSheet(BuildContext context, mounted, tocart, provOrders, provCode) {
    // var provCode = Provider.of<CodeScanProvider>(context);
    // var provOrders = Provider.of<OrdersProvider>(context);
    SlideDialog.showSlideDialog(
        context: context,
        backgroundColor: Colors.white,
        pillColor: Colors.blue,
        transitionDuration: const Duration(milliseconds: 500),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Can't Scan QR?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'just input QRCode below ..',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(child: TextField(
                onChanged: (value) {
                  provCode.codeChecker = value;
                },
              )),
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          var result = provCode.checkCode();
                          if (result == '') {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              messageText: const Text(
                                'Code is invalid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ).show(context);
                          } else {
                            provOrders.paramDineInCode = result;

                            // because is OK go pop the bottom sheet and camera

                            // Delay the pop operation by 500 milliseconds (optional)
                            Future.delayed(const Duration(milliseconds: 800),
                                () {
                              Navigator.pop(context);
                              if (mounted) {
                                if (tocart) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CircularProgressPage()));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const CartPage()));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CircularProgressPage()));
                                  Navigator.pop(context);
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    messageText: Text(
                                      'Voucher ${provCode.codeChecker} is valid, select menu..',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ).show(context);
                                }
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Check me in',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
