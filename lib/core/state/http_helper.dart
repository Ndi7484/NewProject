import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlBase =
      'https://sublimeads.com/api/random?token=HdizxtNtwjGnQdE3SY0Sxeez0bqWZx3Mo3kG7NYzs-w&id=UtNW280YrPL0bg';

  Future<String> getAds() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
