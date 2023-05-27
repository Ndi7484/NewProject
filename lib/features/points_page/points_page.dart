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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
      ),
      body: Center(
          child: Column(
        children: [
          Text('Your Points Balance is :'),
          Text('17.000'),
          Text('You can redeem it at our store'),
        ],
      )),
    );
  }
}
