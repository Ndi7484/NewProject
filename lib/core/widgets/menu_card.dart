import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  MenuCard({super.key, required this.isMenu});
  bool isMenu = false;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(2.0, 3.0), blurRadius: 4.0)
      ]),
      child: Row(
        children: [
          Stack(children: [
            Image.asset(
              'assets/food/Beefsteak.png',
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
                  const Text(
                    'Beef Stew',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            'a perfect combination of Wagyu A5 beef and glazing sauce',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                      )),
                  const Text('Rp. 80.000'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
