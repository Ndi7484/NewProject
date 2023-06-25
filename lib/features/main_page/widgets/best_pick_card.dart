import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/features/menu_page/widgets/menu_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BestPickCard extends StatefulWidget {
  const BestPickCard({super.key});

  @override
  State<BestPickCard> createState() => _BestPickCardState();
}

class _BestPickCardState extends State<BestPickCard> {
  dynamic color_picker = [
    Colors.amber,
    Colors.grey,
    Colors.brown.shade500,
    Colors.blue,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<MenuProvider>(context);
    final provOrders = Provider.of<OrdersProvider>(context);
    var bottomSheet = MenuBottomSheet();
    ;

    return CarouselSlider(
        items: List.generate(
            provMenu.randomUniqueList.length,
            (index) => Card(
                  elevation: 7,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Stack(children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  child: Image.asset(
                                    provMenu.randomUniqueList[index].menuImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: color_picker[index],
                                        size: 40,
                                      ),
                                      Positioned(
                                          top: 12,
                                          right: 15,
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  )),
                            ]),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provMenu.randomUniqueList[index].menuName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  RichText(
                                      textAlign: TextAlign.justify,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: provMenu.randomUniqueList[index]
                                            .menuShortDesc,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 10,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Rp. ${provMenu.randomUniqueList[index].menuPriceString}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => provOrders.deleteOrders(
                                            provMenu
                                                .randomUniqueList[index].menuID,
                                            context),
                                        child: Icon(
                                          Icons.remove_circle_outline_rounded,
                                          color: ((provOrders.listOrders[
                                                          provMenu
                                                              .randomUniqueList[
                                                                  index]
                                                              .menuID] ??
                                                      0) <=
                                                  0)
                                              ? Colors.red[100]
                                              : Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          (provOrders.listOrders[provMenu
                                                      .randomUniqueList[index]
                                                      .menuID] ??
                                                  0)
                                              .toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => provOrders.addOrders(
                                            provMenu
                                                .randomUniqueList[index].menuID,
                                            context),
                                        child: const Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          bottomSheet.getBottomSheet(context,
                                              provMenu.randomUniqueList[index]);
                                        },
                                        child: Row(
                                          children: const [
                                            Text(
                                              'details',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 9,
                                              ),
                                            ),
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                )),
        options: CarouselOptions(
          height: 300,
          aspectRatio: 0.1,
          viewportFraction: 0.5,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          scrollDirection: Axis.horizontal,
        ));
  }
}
