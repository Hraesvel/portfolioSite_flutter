import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_site/app_level/access/access.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';

class CommonUtility {
  static Future<String> loadStringAsset(String path) async {
    return rootBundle.loadString(path);
  }

  static Future<http.Response> fetchFromWeb(String url) async {
    final res = await http.get(Uri.parse(url));
    return res;
  }

  static Future<http.Response> fetchFromS3({bucket: "", file: ""}) async {
    String ep = "";
    ep += bucket == "" || bucket == null ? "" : "/$bucket";
    ep += file == "" || file == null ? "" : "/$file";
    // final res = await http.get(Uri(path: "${Access.s3}$ep"));
    final res = await http.get(Uri.parse("${Access.s3}$ep"));
    return res;
  }

  static Future<http.Response> sendContact(Map<String, String?> data) async {
    var body = jsonEncode(data);
    final res =
        await http.post(Uri.parse(Access.contact_me), body: body, headers: {
      "Content-Type": "application/json",
    });
    return res;
  }

  static Widget simpleTextButton(
      {required String uri, String? text, TextStyle? textTheme, Widget? child}) {
    return Link(
        uri: Uri.parse(uri),
        target: LinkTarget.self,
        builder: (context, followLink) => TextButton(
            onPressed: () => followLink!(),
            child: child ??
                Text(
                  text!,
                  style: textTheme ?? Theme.of(context).textTheme.button,
                )));
  }
}

class CommonWidgets {
  static EdgeInsets defaultEdgeInset(BuildContext context,
      {Key? key, double pageWidth = 980, double? left, double? right}) {
    EdgeInsets edgeInset;
    double mult = 0.12;
    var edge = MediaQuery.of(context).size.width * mult;

    var curWidth = MediaQuery.of(context).size.width;

    if (curWidth >= 1024) {
      var s = (curWidth - pageWidth);
      edge = s / 2;
    }
    edgeInset = EdgeInsets.only(
      left: left ?? edge,
      right: right ?? edge,
    );

    return edgeInset;
  }

  static RegExp regex = RegExp(
      r"((?<leading>.+)(?<coInfo>\[(?<name>.+)\]\((?<url>.+)\))(?<tail>.+)?)");
}
