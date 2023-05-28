import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_application_1/features/syarat_page/syarat_page.dart';
import 'package:provider/provider.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Syarat dan Ketentuan'),
          content: Container(
              padding: EdgeInsets.all(16.0),
              child: RichText(
                  text: TextSpan(
                      text:
                          '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In',
                      children: [
                    TextSpan(
                        text:
                            '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In'),
                    TextSpan(
                        text:
                            '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In'),
                    TextSpan(
                        text:
                            '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In'),
                    TextSpan(
                        text:
                            '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In'),
                  ]))

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     RichText(
              //       text: TextSpan(
              //         text: '- Promo makanan hingga xxx%',
              //         style: TextStyle(color: Colors.black, fontSize: 16.0),
              //       ),
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         text:
              //             '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In',
              //         style: TextStyle(color: Colors.black, fontSize: 16.0),
              //       ),
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         text:
              //             '- Voucher hanya bisa digunakan untuk memesan menu Dessert',
              //         style: TextStyle(color: Colors.black, fontSize: 16.0),
              //       ),
              //     ),
              //   ],
              // ),
              ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
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
                child: Row(
                  children: [
                    Padding(
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
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.19,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment(
                              -1.0 +
                                  (220 /
                                      (MediaQuery.of(context).size.height *
                                          0.2)),
                              -1.0 +
                                  (160 /
                                      (MediaQuery.of(context).size.height *
                                          0.2))),
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
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: MediaQuery.of(context).size.width * 0.41,
                child: GestureDetector(
                  onTap: () {
                    _showDialog();
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
