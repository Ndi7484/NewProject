import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
// import 'package:flutter_application_1/features/syarat_page/syarat_page.dart';
import 'package:provider/provider.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  _showBottomSheet(Promo isiDialog) {
    SlideDialog.showSlideDialog(
        context: context,
        backgroundColor: Colors.white,
        pillColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              children: [
                const Text(
                  'Terms & Condition',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    isiDialog.promoLongDesc.split('\n').length,
                    (index) => (isiDialog.promoLongDesc
                            .split('\n')[index]
                            .contains('•'))
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('•'),
                              Text(isiDialog.promoLongDesc.split('\n')[index])
                            ],
                          )
                        : Container()),
                // Text(
                //   isiDialog.promoLongDesc,
                //   style: TextStyle(color: Colors.grey[700]),
                // ),
              ],
            ),
          ),
        ));
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Syarat dan Ketentuan'),
    //       content: Container(
    //         padding: EdgeInsets.all(16.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             RichText(
    //               text: TextSpan(
    //                 text: '- Promo makanan hingga xxx%',
    //                 style: TextStyle(color: Colors.black, fontSize: 16.0),
    //               ),
    //             ),
    //             RichText(
    //               text: TextSpan(
    //                 text:
    //                     '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In',
    //                 style: TextStyle(color: Colors.black, fontSize: 16.0),
    //               ),
    //             ),
    //             RichText(
    //               text: TextSpan(
    //                 text:
    //                     '- Voucher hanya bisa digunakan untuk memesan menu Dessert',
    //                 style: TextStyle(color: Colors.black, fontSize: 16.0),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('Tutup'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final provPromo = Provider.of<PromoProvider>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: provPromo.listPromo.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2.0, 3.0),
                          blurRadius: 4.0)
                    ]),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.19,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment(
                          -1.0 +
                              (220 /
                                  (MediaQuery.of(context).size.height * 0.2)),
                          -1.0 +
                              (160 /
                                  (MediaQuery.of(context).size.height * 0.2))),
                      child: Transform.scale(
                        scale: 2.5,
                        child: Image.asset(
                          'assets/etc/Voucher.png',
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provPromo.listPromo[index].promoName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        provPromo.listPromo[index].promoShortDesc,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: MediaQuery.of(context).size.width * 0.41,
                child: GestureDetector(
                  onTap: () {
                    _showBottomSheet(provPromo.listPromo[index]);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SyaratKetentuan()));
                  },
                  child: const Text(
                    'S & K',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
