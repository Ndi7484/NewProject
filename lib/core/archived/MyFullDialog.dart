// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pertemuan%2010/CardData.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// class MyFullScreenDialog extends StatefulWidget {
//   const MyFullScreenDialog({super.key, required this.Warna});
//   final Color Warna;

//   @override
//   State<MyFullScreenDialog> createState() => _MyFullScreenDialogState();
// }

// class _MyFullScreenDialogState extends State<MyFullScreenDialog> {
//   @override
//   Widget build(BuildContext context) {
//     var NumberController = TextEditingController();
//     var prov = Provider.of<CardData>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('New entry'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   prov.addData(NumberController.text, widget.Warna);
//                   Navigator.of(context).pop();
//                   Fluttertoast.showToast(
//                       msg: 'Data Tersimpan',
//                       gravity: ToastGravity.BOTTOM,
//                       webPosition: "center",
//                       toastLength: Toast.LENGTH_SHORT);
//                 },
//                 child: new Text('SAVE', style: TextStyle(color: Colors.white))),
//           ],
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: NumberController,
//                   decoration: InputDecoration(labelText: "Player Number"),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
