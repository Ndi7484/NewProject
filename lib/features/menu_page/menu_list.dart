import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';

import 'widgets/menu_card.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _ListMenuState createState() => _ListMenuState();
}

// ensure the scroll position of the widgets
class _ListMenuState extends State<ListMenu>
    with AutomaticKeepAliveClientMixin<ListMenu> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the super.build is called

    return StreamBuilder<List<FoodMenu>>(
      stream: FirebaseFirestore.instance.collection('menu').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => FoodMenu.fromJson(doc.data()))
              .toList()),
      builder: (context, snapshot) {
        // print(snapshot.data![21].menuID);
        // print(snapshot.data![21].menuCategory);
        // print(snapshot.data![21].menuName);
        // print(snapshot.data![21].menuImage);
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle loading state
          return Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.35,
                MediaQuery.of(context).size.height * 0.31,
                MediaQuery.of(context).size.width * 0.35,
                MediaQuery.of(context).size.height * 0.31),
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Handle case where data is empty or not available
          return const Text('No data available.');
        } else {
          // Handle data state
          List<FoodMenu> foodMenuList = snapshot.data!;

          // Filter the menu items based on the type
          List<FoodMenu> filteredMenuList = foodMenuList
              .where((menu) => menu.menuCategory == widget.type)
              .toList();

          return ListView(
            children: [
              ...List.generate(filteredMenuList.length, (index) {
                return MenuCard(
                  type: widget.type,
                  isMenu: true,
                  food: filteredMenuList[index],
                  indexing: index,
                );
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ClipRect(
                  child: Align(
                    alignment: Alignment(
                      -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1)),
                      -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1)),
                    ),
                    child: Transform.scale(
                      scale: 3,
                      child: Image.asset(
                        'assets/etc/Food_doodle.png',
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );

    // ListView(children: [
    //   ...List.generate(provMenu.listFoodMenu.length, (index) {
    //     return MenuCard(
    //         type: widget.type,
    //         isMenu: true,
    //         food: provMenu.listFoodMenu[index],
    //         indexing: index);
    //   }),
    //   SizedBox(
    //     height: MediaQuery.of(context).size.height * 0.1,
    //     child: ClipRect(
    //       child: Align(
    //         alignment: Alignment(
    //             -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1)),
    //             -1.0 + (100 / (MediaQuery.of(context).size.height * 0.1))),
    //         child: Transform.scale(
    //           scale: 3,
    //           child: Image.asset(
    //             'assets/etc/Food_doodle.png',
    //             height: MediaQuery.of(context).size.height * 0.1,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ]);
  }
}
