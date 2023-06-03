// import 'package:flutter/material.dart';

// class MyBanner {
//   bool _showBanner = true;
//   bool get showBanner => _showBanner;

//   getBanner(BuildContext context) {
//     return MaterialBanner(
//         content: Text('Click FAB to add Player to get the card'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).clearMaterialBanners();
//             },
//             child: Text('Hide Banner'),
//           ),
//           TextButton(
//             onPressed: () {
//               _showBanner = false;
//               ScaffoldMessenger.of(context).clearMaterialBanners();
//             },
//             child: Text('Don\'t Show Again'),
//           ),
//         ]);
//   }
// }
