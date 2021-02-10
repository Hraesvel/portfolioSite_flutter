import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_site/access.dart';
import 'package:http/http.dart' as http;

class CommonUtility {
  static Future<String> loadStringAsset(String path) async {
    return rootBundle.loadString(path);
  }

  static Future<http.Response> fetchFromWeb(String url) async {
    final res = await http.get(url);
    return res;
  }

  static Future<http.Response> fetchFromS3({bucket: "", file: ""}) async {
    String ep = "";
    ep += bucket == "" || bucket == null ? "" : "/$bucket";
    ep += file == "" || file == null ? "" : "/$file";
    final res = await http.get("$S3ACCESS$ep");
    return res;
  }

}
