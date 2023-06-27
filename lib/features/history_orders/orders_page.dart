import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:provider/provider.dart';

import 'list_orders.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  static const List<Tab> tabs = [
    Tab(text: 'Delivery'),
    Tab(text: 'Takeaway'),
    Tab(text: 'Dine-In'),
  ];
  @override
  Widget build(BuildContext context) {
    final provPage = Provider.of<PageProvider>(context);

    return DefaultTabController(
      initialIndex: provPage.historyIndex,
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: tabs,
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ListOrder(type: 'Delivery'),
                  ListOrder(type: 'Takeaway'),
                  ListOrder(type: 'Dine-In'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
