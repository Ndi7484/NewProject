import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/features/S&K/SK.dart';
import 'package:flutter_application_1/core/logic/carousel_provider.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/features/forgetpass_page/forgetpass_page.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_application_1/features/main_page/main_page.dart';
import 'package:flutter_application_1/features/newpass_page/newpass_page.dart';
import 'package:flutter_application_1/features/page_promo/promopage.dart';
import 'package:flutter_application_1/features/profile_page/profile_page.dart';
import 'package:flutter_application_1/features/signup_page/signup_page.dart';
import 'package:flutter_application_1/features/verification_page/verification_page.dart';
import 'package:provider/provider.dart';

import 'core/logic/counter_proivider.dart';
import 'core/logic/promo_provider.dart';
import 'core/logic/warning_provider.dart';

// multi provider is here
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
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
      home: const PromoPage(),
      debugShowCheckedModeBanner: false,
      // home: const BottomNavigationPage(),
    );
  }
}
