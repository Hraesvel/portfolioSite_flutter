import 'dart:async';
import 'package:flutter/services.dart';

class CommonUtility {

  static Future<String> loadStringAsset(String path ) async {
    return rootBundle.loadString(path);
  }
}