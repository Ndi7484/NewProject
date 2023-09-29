// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/code_scan_provider.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
import 'package:flutter_application_1/core/logic/merchant_provider.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/carousel_provider.dart';
import 'package:flutter_application_1/core/logic/menu_provider.dart';
import 'package:flutter_application_1/core/logic/notification_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:provider/provider.dart';

import 'core/logic/promo_provider.dart';
import 'core/logic/warning_provider.dart';

// import don't command/remove for firebase
import 'package:firebase_core/firebase_core.dart';

// multi provider is here
Future<void> main() async {
  // add firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()..resetParam()),
        ChangeNotifierProvider(create: (_) => AddressProvider()..resetParam()),
        ChangeNotifierProvider(create: (_) => PromoProvider()..readPromo()),
        ChangeNotifierProvider(
            create: (_) => CarouselProvider()..readCarousel()),
        ChangeNotifierProvider(create: (_) => WarningProvider()..readWarn()),
        ChangeNotifierProvider(create: (_) => MenuProvider()..readMenu()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(
            create: (_) => MerchantProvider()
              ..resetParam()
              ..readMerchant()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(
            create: (_) => CodeScanProvider()
              ..resetparam()
              ..readCode()),
        ChangeNotifierProvider(
            create: (_) => NotificationProvider()..readNotif()),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.grey[850])),
      home: const LoginPage(),
    );
  }
}
