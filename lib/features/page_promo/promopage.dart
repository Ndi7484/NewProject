import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/promo_provider.dart';
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
                    isiDialog.promoLongDesc!.split('\n').length,
                    (index) => (isiDialog.promoLongDesc!
                            .split('\n')[index]
                            .contains('•'))
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('•'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      Text(
                                        isiDialog.promoLongDesc!
                                            .split('\n')[index]
                                            .substring(2),
                                        style: const TextStyle(fontSize: 12),
                                        textAlign: TextAlign.justify,
                                        softWrap: true,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                            child: Text(
                              isiDialog.promoLongDesc!.split('\n')[index],
                              style: TextStyle(color: Colors.red.shade900),
                              textAlign: TextAlign.justify,
                            ),
                          )),
              ],
            ),
          ),
        ));
  }

  int _lengthPromo = 0;
  int _lengthNoPromo = 0;

  @override
  Widget build(BuildContext context) {
    final provPromo = Provider.of<PromoProvider>(context);
    _lengthPromo = provPromo.listPromo.length;
    return
        // promo check
        (_lengthPromo > _lengthNoPromo)
            ? Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: provPromo.listPromo.length,
                  itemBuilder: (context, index) {
                    return (DateTime(
                                provPromo.listPromo[index].yearExp!,
                                provPromo.listPromo[index].monthExp!,
                                provPromo.listPromo[index].dateExp!)
                            .isAfter(DateTime.now()))
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                  width:
                                      MediaQuery.of(context).size.height * 0.19,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ClipRect(
                                    child: Align(
                                      alignment: Alignment(
                                          -1.0 +
                                              (220 /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2)),
                                          -1.0 +
                                              (160 /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height *
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
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 8, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provPromo.listPromo[index].promoName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        provPromo
                                            .listPromo[index].promoShortDesc!,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10),
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
                                    _showBottomSheet(
                                        provPromo.listPromo[index]);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => const SyaratKetentuan()));
                                  },
                                  child: const Text(
                                    'S & K',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ]),
                          )
                        : Builder(
                            builder: (context) {
                              _lengthNoPromo = _lengthNoPromo + 1;
                              return Container();
                            },
                          );
                  },
                ),
              )
            : const Center(
                child: Text(
                  'There is No Promo for Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              );
  }
}
