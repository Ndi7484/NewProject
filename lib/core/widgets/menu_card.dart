import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';

class MenuCard extends StatefulWidget {
  MenuCard(
      {super.key,
      required this.isMenu,
      required this.type,
      required this.food});
  bool isMenu = false;
  String type;
  FoodMenu food;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return (widget.food.menuCategory == widget.type)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                    )
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
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: widget.food.menuShortDesc,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                ),
                              )),
                          Text(
                            'Rp. ${widget.food.menuPriceString}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
        : Container(
            height: 0,
          );
  }
}
