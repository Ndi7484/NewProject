import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/features/menu_page/widgets/menu_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatefulWidget {
  MenuCard(
      {super.key,
      required this.isMenu,
      this.type,
      required this.food,
      this.qtyFood,
      this.indexing});
  bool isMenu = false;
  String? type;
  FoodMenu food;
  int? qtyFood;
  int? indexing;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    var bottomSheet = MenuBottomSheet();
    final provOrders = Provider.of<OrdersProvider>(context);

    return
        // is it in Menu Page?
        (widget.isMenu)
            ?
            // in Menu sort by type of the dish
            (widget.food.menuCategory == widget.type)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
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
                          Stack(children: [
                            Image.network(
                              widget.food.menuImage,
                              height: 120,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                return child;
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Positioned(
                              top: 0,
                              left: 120,
                              child: Transform.rotate(
                                angle: 0.2,
                                child: Container(
                                  height: 150,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.food.menuName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  RichText(
                                      textAlign: TextAlign.justify,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: widget.food.menuShortDesc,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 10,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Rp. ${widget.food.menuPriceString}',
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
                                            widget.food.menuID, context),
                                        child: Icon(
                                          Icons.remove_circle_outline_rounded,
                                          color: ((provOrders.listOrders[
                                                          widget.food.menuID] ??
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
                                          (provOrders.listOrders[
                                                      widget.food.menuID] ??
                                                  0)
                                              .toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => provOrders.addOrders(
                                            widget.food.menuID, context),
                                        child: const Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          bottomSheet.getBottomSheet(
                                              context, widget.food);
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
                          )
                        ],
                      ),
                    ),
                  )

                // hide if not in its type of dish
                : Container(
                    height: 0,
                  )
            // if not in Menu Page
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 120,
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
                      Stack(children: [
                        Image.network(
                          widget.food.menuImage,
                          height: 120,
                          frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                return child;
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                        ),
                        Positioned(
                          top: 0,
                          left: 120,
                          child: Transform.rotate(
                            angle: 0.2,
                            child: Container(
                              height: 150,
                              width: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.food.menuName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              RichText(
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: widget.food.menuShortDesc,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  )),
                              const SizedBox(
                                height: 3,
                              ),
                              const Spacer(),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rp. ${widget.food.menuPriceString}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'x',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.qtyFood.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}
