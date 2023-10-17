import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/state/ads_state.dart';
import 'package:flutter_application_1/core/state/http_helper.dart';

class AdsProvider extends ChangeNotifier {
  late HttpHelper helper = HttpHelper();

  late AdsState? _jsonResultAds = null;
  AdsState? get jsonResultAds => _jsonResultAds;
  set jsonResultAds(value) {
    _jsonResultAds = value;
    notifyListeners();
  }

  Future<AdsState> loadApiAds() async {
    final data = await helper.getAds();
    jsonResultAds = adsStateFromJson(data);
    return adsStateFromJson(data);
  }
}
