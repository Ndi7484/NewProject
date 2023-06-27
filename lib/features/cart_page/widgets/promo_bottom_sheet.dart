import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';

class PromoBottomSheet {
  getBottomSheet(BuildContext context, List<Promo> listPromo,
      OrdersProvider provOrders, PromoProvider provPromo) {
    SlideDialog.showSlideDialog(
        context: context,
        backgroundColor: Colors.white,
        pillColor: Theme.of(context).colorScheme.primary,
        transitionDuration: const Duration(milliseconds: 500),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView(children: [
            ...List.generate(
                listPromo.length,
                (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // set the result of promo t/f
                            var result = provPromo.validatePromo(
                                listPromo[index],
                                provOrders.paramSubTotalsInt,
                                provOrders.typeOrders);
                            // change the voch validate
                            provOrders.changeVoucherValid(
                                result, listPromo[index], context);
                            // if the vocher valid close
                            if (result) {
                              // recalculate delivery if there any free delivery occour
                              // provOrders.calculateDeliveryNext();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: (provOrders.paramVoucherCode?.promoID ==
                                        listPromo[index].promoID)
                                    ? Colors.lightGreenAccent
                                    : null,
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: ListTile(
                              leading: Image.asset('assets/etc/Voucher.png'),
                              title: Text(listPromo[index].promoName),
                              subtitle: Text(
                                listPromo[index].promoShortDesc,
                                style: const TextStyle(fontSize: 10),
                              ),
                              trailing: (provOrders.paramVoucherCode?.promoID ==
                                      listPromo[index].promoID)
                                  ? const Icon(Icons.check_circle_outlined)
                                  : const Icon(Icons.circle_outlined),
                            ),
                          ),
                        ),
                        const Divider(
                          indent: 65,
                        )
                      ],
                    )),
          ]),
        ));
  }
}
