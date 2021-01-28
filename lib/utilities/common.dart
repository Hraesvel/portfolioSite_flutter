import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CommonUtility {

  static Future<String> loadStringAsset(String path ) async {
    return rootBundle.loadString(path);
  }

  static Future<http.Response> fetchFromWeb(String url) async {
    final res = await http.get(url);
    return res;
  }
}