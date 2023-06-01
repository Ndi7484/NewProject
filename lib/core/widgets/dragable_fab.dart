import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DraggableFAB extends StatefulWidget {
  const DraggableFAB({super.key});

  @override
  _DraggableFABState createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB> {
  bool isFABDragged = false;
  Offset fabPosition = Offset(
      (ui.window.physicalSize.width / ui.window.devicePixelRatio) * 0.82,
      (ui.window.physicalSize.height / ui.window.devicePixelRatio) * 0.68);

  @override
  Widget build(BuildContext context) {
    // fabPosition = Offset(MediaQuery.of(context).size.width * 0.82,
    //     MediaQuery.of(context).size.height * 0.68);
    return Stack(
      children: [
        Positioned(
          left: fabPosition.dx,
          top: fabPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                fabPosition += details.delta;
              });
            },
            onPanEnd: (details) {
              setState(() {
                isFABDragged = false;
              });
            },
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.shopping_basket),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
