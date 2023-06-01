import 'package:flutter/material.dart';

class NotifBanner {
  bool _showBanner = true;
  bool get showBanner => _showBanner;
  // set showBanner(value) {
  //   _showBanner = value;
  // }

  changeView(BuildContext context) {
    _showBanner = false;
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  getBanner(BuildContext context, String code) {
    if (_showBanner == true) {
      return MaterialBanner(
          content: Text('Your Verification code : $code'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
              child: const Text('HIDE'),
            ),
          ]);
    } else {
      ScaffoldMessenger.of(context).clearMaterialBanners();
    }
  }
}
