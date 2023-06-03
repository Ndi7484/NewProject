// import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pertemuan%2010/MyBanner.dart';
// import 'package:flutter_application_1/Pertemuan%2010/MyBottomSheet.dart';
// import 'package:flutter_application_1/Pertemuan%2010/MyDialog.dart';
// // import 'package:flutter_application_1/Pertemuan%2010/MyBanner.dart';
// // import 'package:flutter_application_1/Pertemuan%2010/MyBottomSheet.dart';
// // import 'package:flutter_application_1/Pertemuan%2010/MyDialog.dart';
// import 'package:provider/provider.dart';
// import 'CardData.dart';
// import 'MyFullDialog.dart';

// class MyHome extends StatefulWidget {
//   const MyHome({super.key});

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   @override
//   Widget build(BuildContext context) {
//     var prov = Provider.of<CardData>(context);
//     var _banner = MyBanner();
//     var _bottomSheet = MyBottomSheet();
//     var _dialog = MyDialog();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//         elevation: 10,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 (_banner.showBanner)
//                     ? ScaffoldMessenger.of(context)
//                         .showMaterialBanner(_banner.getBanner(context))
//                     : Container();
//               },
//               icon: const Icon(Icons.help))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//           children: prov.data.isNotEmpty
//               ? List.generate(
//                   prov.data.length,
//                   (index) => SizedBox(
//                     height: 80,
//                     width: 60,
//                     child: GestureDetector(
//                       onDoubleTap: () {
//                         showDialog(
//                             context: context,
//                             builder: (_) =>
//                               _dialog.getDialog(context, index)
//                             );
//                       },
//                       child: Card(
//                         elevation: 10,
//                         color: prov.data[index].warna,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(prov.data[index].No),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : [
//                   const Center(
//                     child: Text("No Data"),
//                   )
//                 ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _bottomSheet.getCustomBottomSheet(context);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
