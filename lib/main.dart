import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/merchant_provider.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/carousel_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_application_1/features/payment_method_page/bank_transfer_page.dart';
import 'package:flutter_application_1/features/payment_method_page/confirm_payment/bank_transfer_confirm.dart';
import 'package:flutter_application_1/features/payment_method_page/confirm_payment/ewallet.dart';
import 'package:flutter_application_1/features/payment_method_page/payment_method_page.dart';
// import 'package:flutter_application_1/features/payment_method_page/bank_transfer_page.dart';
// import 'package:flutter_application_1/features/payment_method_page/ovo.dart';
// import 'package:flutter_application_1/features/payment_method_page/payment_method_page.dart';
import 'package:provider/provider.dart';

import 'core/logic/promo_provider.dart';
import 'core/logic/warning_provider.dart';

// multi provider is here
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AccountProvider()
              ..resetParam()
              ..readAccount()),
        ChangeNotifierProvider(
            create: (_) => AddressProvider()
              ..resetParam()
              ..readAddress()),
        ChangeNotifierProvider(create: (_) => PromoProvider()..readPromo()),
        ChangeNotifierProvider(
            create: (_) => CarouselProvider()..readCarousel()),
        ChangeNotifierProvider(create: (_) => WarningProvider()..readWarn()),
        ChangeNotifierProvider(create: (_) => MenuProvider()..readMenu()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => MerchantProvider()..resetParam()..readMerchant()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// root of app is here
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randumu App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.grey[850])),
      home: const LoginPage(),
    );
  }
}
