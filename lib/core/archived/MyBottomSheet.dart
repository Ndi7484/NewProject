// import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pertemuan%2010/MyFullDialog.dart';

// class MyBottomSheet {
//   getCustomBottomSheet(BuildContext context) {
//     SlideDialog.showSlideDialog(
//         context: context,
//         backgroundColor: Colors.white,
//         pillColor: Colors.blue,
//         transitionDuration: const Duration(milliseconds: 500),
//         child: Column(
//           children: [
//             const Text('Select Card'),
//             ListTile(
//               title: const Text('Yellow Card'),
//               leading: const Icon(
//                 Icons.crop_portrait,
//                 color: Colors.yellow,
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         fullscreenDialog: true,
//                         builder: (_) =>
//                             const MyFullScreenDialog(Warna: Colors.yellow)));
//               },
//             ),
//             ListTile(
//               title: const Text('Red Card'),
//               leading: const Icon(
//                 Icons.crop_portrait,
//                 color: Colors.red,
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         fullscreenDialog: true,
//                         builder: (_) =>
//                             const MyFullScreenDialog(Warna: Colors.red)));
//               },
//             ),
//             // ListTile(
//             //   title: const Text('Green Card'),
//             //   leading: const Icon(
//             //     Icons.crop_portrait,
//             //     color: Colors.green,
//             //   ),
//             //   onTap: () {
//             //     Navigator.pop(context);
//             //     Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //             fullscreenDialog: true,
//             //             builder: (_) =>
//             //                 const MyFullScreenDialog(Warna: Colors.green)));
//             //   },
//             // ),
//           ],
//         ));
//   }
// }
