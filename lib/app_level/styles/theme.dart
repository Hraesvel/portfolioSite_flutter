import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final baseTheme = _baseTheme();

  static ThemeData _baseTheme() {
    final lightBlue = Color(0xffCDD6F6);
    final string = 'Roboto';

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xff0a192f),
      cardColor: Color(0xff102646),
      accentColor: Color(0xffeb3575),
      primaryColorLight: lightBlue,
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 68.0,
              color: lightBlue,
              fontWeight: FontWeight.w600,
              fontFamily: string),
          headline2: TextStyle(
              fontSize: 38.0,
              color: lightBlue,
              fontWeight: FontWeight.bold,
              fontFamily: string),
          headline3: TextStyle(
              fontSize: 24.0,
              color: lightBlue,
              fontWeight: FontWeight.bold,
              fontFamily: string),
          headline4: TextStyle(
              color: Color(0xffB7BEDB).withOpacity(.55),
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontFamily: string),
          bodyText1: TextStyle(
            fontSize: 20.0,
            height: 1.3,
            fontFamily: string,
            fontWeight: FontWeight.w400,
            color: lightBlue,
          ),
          bodyText2: TextStyle(
            fontSize: 18.0,
            fontFamily: string,
            height: 1.4,
            fontWeight: FontWeight.w400,
            color: lightBlue,
          ),
          button: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 16.0,
              color: Color(0xffeb3575),
              height: 1,
              fontWeight: FontWeight.w400)),
    );
  }
}
