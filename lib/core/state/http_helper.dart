import 'dart:io';
import 'package:flutter_application_1/core/state/map_latlong_state.dart';
import 'package:flutter_application_1/core/state/map_search_state.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlBase =
      'https://sublimeads.com/api/random?token=HdizxtNtwjGnQdE3SY0Sxeez0bqWZx3Mo3kG7NYzs-w&id=UtNW280YrPL0bg';
  // https://geocode.maps.co/reverse.php?lat=26.00363&lon=40.64117
  final String _urlMapBase = 'https://geocode.maps.co/reverse?';
  // https://geocode.maps.co/search?q=gahar
  final String _urlSearchMapBase =
      'https://geocode.maps.co/search?';

  Future<String> getAds() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }

  Future<MapLatLongState?> getLatLong(double lat, double long) async {
    var url = Uri.parse(
        '${_urlMapBase}lat=$lat&lon=$long');
    try {
      http.Response result = await http.get(url);
      print(result);
      if (result.statusCode == HttpStatus.ok) {
        String responseBody = result.body;
        return mapLatLongStateFromJson(responseBody);
      }
    } catch (e) {
      print('SocketError..');
    }

    return null;
  }

  Future<List<MapSearchState>?> getMapSearch(String query) async {
    var url = Uri.parse(
        '${_urlSearchMapBase}q=$query');
    try {
      http.Response result = await http.get(url);
      print(result);
      if (result.statusCode == HttpStatus.ok) {
        String responseBody = result.body;
        return mapSearchStateFromJson(responseBody);
      }
    } catch (e) {
      print('SocketError..');
    }

    return null;
  }
}
