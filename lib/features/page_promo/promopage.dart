import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
import 'package:flutter_application_1/features/S&K/SK.dart';
import 'package:provider/provider.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

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
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment(
                              -1.0 +
                                  (150 /
                                      (MediaQuery.of(context).size.height *
                                          0.2)),
                              -1.0 +
                                  (160 /
                                      (MediaQuery.of(context).size.height *
                                          0.2))),
                          child: Transform.scale(
                            scale: 2.25,
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
                bottom: 5,
                left: MediaQuery.of(context).size.width * 0.43,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(context, 
                    // MaterialPageRoute(builder: (context) => SyaratKetentuan(),));
                  },
                  child: const Text(
                    'S & K',
                    style: TextStyle(color: Colors.red),
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
