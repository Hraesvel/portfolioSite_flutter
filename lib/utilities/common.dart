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

class CommonWidgets {
  static EdgeInsets defaultEdgeInset(BuildContext context,
      {Key key, double pageWidth = 900, double left, double right}) {
    EdgeInsets edgeInset;
    double mult = 0.12;
    var edge = MediaQuery.of(context).size.width * mult;

    var curWidth = MediaQuery.of(context).size.width;

    if (curWidth >= 1024 ) {
      var s = (curWidth - pageWidth)  ;
      edge = s /2 ;
    }
    edgeInset = EdgeInsets.only(
      left: left ?? edge,
      right: right ?? edge,
    );

    return edgeInset;
  }
}
