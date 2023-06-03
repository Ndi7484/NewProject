import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/widgets/menu_bottom_sheet.dart';

class MenuCard extends StatefulWidget {
  MenuCard(
      {super.key,
      required this.isMenu,
      required this.type,
      required this.food,
      this.qtyFood});
  bool isMenu = false;
  String type;
  FoodMenu food;
  int? qtyFood;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    var _bottomSheet = MenuBottomSheet();
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
                            Image.asset(
                              widget.food.menuImage,
                              height: 120,
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
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    _bottomSheet.getBottomSheet(
                                        context, widget.food);
                                  },
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                ))
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
            : Container();
  }
}
