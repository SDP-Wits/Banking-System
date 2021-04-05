import 'dart:convert';

import "package:http/http.dart" as http;

import '../../constants/php_url.dart';

Future<List<Map<String, dynamic>>> getURLData(String url) async {
  final Uri uri = Uri.parse(url);

  final httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    final jsonOutput = json.decode(httpResponse.body);

    List<Map<String, dynamic>> map = [];
    for (dynamic e in jsonOutput) {
      map.add(Map<String, dynamic>.from(e));
    }

    return map;
  } else {
    print("Oi, the url that just failed was : $url");
    return [
      {"error": "Failed to get data from database"}
    ];
  }
}

Future<String> getTestPHPData() async {
  final String url = urlPath + testPHPPath;

  return ((await getURLData(url)).toString());
}
