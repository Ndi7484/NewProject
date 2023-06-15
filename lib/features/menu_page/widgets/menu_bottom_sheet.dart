import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';

class MenuBottomSheet {
  getBottomSheet(BuildContext context, FoodMenu food) {
    SlideDialog.showSlideDialog(
        context: context,
        backgroundColor: Colors.white,
        pillColor: Theme.of(context).colorScheme.primary,
        transitionDuration: const Duration(milliseconds: 500),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView(children: [
            Image.asset(
              food.menuImage,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const Text('**there might be slight variations',
                style: TextStyle(color: Colors.red, fontSize: 10)),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    food.menuName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    food.menuPriceString,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                food.menuLongDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '**Please note that there might be slight variations between the image of the food and the actual dish served. While we strive to present accurate representations, factors such as lighting, presentation, and ingredients may result in minor differences in appearance. Rest assured, the quality and taste of the dish remain our top priority.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ),
          ]),
        ));
  }
}
