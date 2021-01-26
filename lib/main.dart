import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/side_bar.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'pages/pages.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Martin's Portfolio",
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff0a192f),
        accentColor: Color(0xffeb3575),
        primaryColorLight: Color(0xffB7BEDB),
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto'),
            headline2: TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'),
            headline3: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'),
            headline4: TextStyle(
                color: Color(0xffB7BEDB).withOpacity(.55),
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto'),
            bodyText1: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color(0xffB7BEDB)),
            bodyText2: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color(0xffB7BEDB)),
            button: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  final Map<String, String> info = {"resident": "San Francisco, CA"};

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    var dur = Duration(milliseconds: 200);
    List<Widget> actionButtons = [
      FlatButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 1, duration: dur);
        },
        child: Text("About Me",
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
      FlatButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 2, duration: dur);
        },
        child: Text("Experiences",
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
      FlatButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 3, duration: dur);
        },
        child: Text("Projects",
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
      FlatButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 4, duration: dur);
        },
        child: Text("Contact Me",
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
      FlatButton(
        onPressed: () => launch(
            Uri.parse("assets/assets/static/Martin_Backend_Engineer.pdf")
                .toString()),
        child: Text("Resume",
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
    ];

    List<Widget> pages = [
      Introduction(
        info: info,
      ),
      AboutMe(
        info: info,
        templatePath: "assets/text_template/about_me.mustache",
      ),
      Experiences(),
      Projects(),
      Container(
        height: 600,
        decoration: BoxDecoration(color: Colors.purple),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 64),
        height: 80,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Center(
          child: Text(
            "© Martin Smith 2021",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Theme.of(context).accentColor.withOpacity(.6)),
          ),
        ),
      ),
    ];

    var list = ScrollablePositionedList.builder(
      itemCount: pages.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          Center(child: SizedBox(width: 1024, child: pages[index])),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );

    return Scaffold(
      appBar: CustomAppBar(actions: actionButtons),
      body: Container(
        color: Color(0xff0a192f),
        child: Stack(
          children: [
            list,
            SideBar(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: EdgeInsets.only(
            left: 128,
            right: MediaQuery.of(context).size.width * 0.35,
            top: 25,
            bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions,
        ),
      ),
    ));
  }

  CustomAppBar({@required this.actions}) : preferredSize = Size.fromHeight(128);
}

class Temp {
  var name;
  var age;

  Temp({Key key, this.name: "woof", this.age: 30});
}
