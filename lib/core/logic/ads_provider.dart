import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/state/ads_state.dart';
import 'package:flutter_application_1/core/state/http_helper.dart';
import 'package:flutter_application_1/core/state/map_search_state.dart';

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

  Future<Map<String,dynamic>?> loadLatLong(double lat, double long) async{
    final data = await helper.getLatLong(lat, long);
    return data;
  }

  Future<List<MapSearchState>?> loadSearchMap(String query) async{
    final data = await helper.getMapSearch(query);
    return data;
  }
}
