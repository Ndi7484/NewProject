import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Your Points Balance is :',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '17.000',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          '(1 points = Rp. 1)',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 15,
        ),
        Text('Redeem your points at cashier'),
        SizedBox(
          height: 15,
        ),
        // qr code here
        
        SizedBox(
          height: 15,
        ),
        Text('or by confirm payments checkouts'),
        SizedBox(
          height: 15,
        ),
      ],
    ));
  }
}
