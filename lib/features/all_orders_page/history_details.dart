import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:provider/provider.dart';

class HistoryDetailPage extends StatelessWidget {
  HistoryDetailPage({super.key, required this.orderCartHistory});
  OrdersCart orderCartHistory;

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    var selectedAccount = provAccount.selectedAccount;

    return Container();
  }
}
