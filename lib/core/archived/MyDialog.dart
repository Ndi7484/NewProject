// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pertemuan%2010/CardData.dart';
// import 'package:flutter_application_1/Pertemuan%2010/MySnackBar.dart';
// import 'package:provider/provider.dart';

// class MyDialog {
//   getDialog(BuildContext context, int index) {
//     var prov = Provider.of<CardData>(context);
//     var _snackbar = MySnackBar();
//     return AlertDialog(
//       title: Text('Delete ${prov.data[index].No}?'),
//       content: Text(
//           'Are you sure to delete ${prov.data[index].No} Card?\n these actions can\'t be undone'),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('CANCEL')),
//         TextButton(
//             onPressed: () {
//               prov.removeData(index);
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(_snackbar.getSnackBar(context));
//             },
//             child: const Text('DELETE', style: TextStyle(color: Colors.red),)),
//       ],
//     );
//   }
// }
