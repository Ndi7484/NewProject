import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

// class SnKPaymentPage extends StatelessWidget {
//   SnKPaymentPage({super.key, required this.img, required this.snkList});
//   List<String> snkList;
//   String img;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(Icons.arrow_back_ios_new_outlined),
//           ),
//           title: const Text(
//             "OVO",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.red),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 10),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             border: Border.all(
//               color: Colors.white,
//               width: 1.0,
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.grey, // Shadow color
//                 spreadRadius: 2.0, // Spread radius
//                 blurRadius: 5.0, // Blur radius
//                 offset: Offset(0, 3), // Offset in the x and y direction
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10.0, bottom: 10),
//             child: IntrinsicHeight(
//               child: ListTile(
//                 leading: Image.asset("assets/etc/OVO.png"),
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("INSTRUCTIONS"),
//                     Text("\t1. Make sure you have an active OVO account"),
//                     Text(
//                         "\t2. Sufficient OVO Cash balance during the transaction"),
//                     Text(
//                         "\t3. Make sure OVO registered mobile number is the same with Randumu."),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SnKPayment {
  getBottomSheet(BuildContext context, List<String> snkList, String img) {
    SlideDialog.showSlideDialog(
        context: context,
        backgroundColor: Colors.white,
        pillColor: Theme.of(context).colorScheme.primary,
        transitionDuration: const Duration(milliseconds: 500),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    img,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ...List.generate(snkList.length, (index) {
                  var tmp = snkList[index].split('.');
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          tmp.length,
                          (index2) => (index2 == 0)
                              ? Text(
                                  '${tmp[index2].trim()}. ',
                                  softWrap: true,
                                )
                              : Expanded(
                                child: Text(
                                  '${tmp[index2].trim()}. ',
                                  softWrap: true,
                                ),
                              )));
                })
              ]),
        ));
  }
}
