import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your Points Balance is :',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('account')
                .snapshots()
                .map((snapshot) => snapshot.docs
                    .map((doc) => Account.fromJson(doc.data()))
                    .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  provAccount.selectedAccount!.pointsString,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                );
              } else if (snapshot.hasError) {
                return Text("Error : ${snapshot.error}");
              } else {
                return const CircularProgressIndicator();
              }
            }),

        const Text(
          '(1 points = Rp. 1)',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Redeem your points at cashier'),
        const SizedBox(
          height: 15,
        ),
        // qr code here
        QrImageView(
          data:
              "{ 'email' : ${provAccount.selectedAccount!.email}, 'phone' : ${provAccount.selectedAccount!.phone}, 'points' : ${provAccount.selectedAccount!.points} }",
          version: QrVersions.auto,
          size: 200.0,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('or by confirm payments checkouts'),
        const SizedBox(
          height: 15,
        ),
        Image.asset(
          'assets/etc/Logo.png',
          width: 60,
          height: 60,
        ),
      ],
    ));
  }
}
