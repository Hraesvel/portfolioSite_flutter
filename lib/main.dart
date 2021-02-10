import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/side_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/pages.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  final lightBlue = Color(0xffCDD6F6);
  final string = 'Roboto';
  runApp(
    MaterialApp(
      title: "Martin's Portfolio",
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff0a192f),
        accentColor: Color(0xffeb3575),
        primaryColorLight: lightBlue,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 60.0,
                color: lightBlue,
                fontWeight: FontWeight.w500,
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
                fontWeight: FontWeight.w300,
                fontFamily: string),
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontFamily: string,
              fontWeight: FontWeight.w400,
              color: lightBlue,
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              fontFamily: string,
              fontWeight: FontWeight.w400,
              color: lightBlue,
            ),
            button: TextStyle(
                fontFamily: string,
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
      Footer(),
    ];

    var list = ScrollablePositionedList.builder(
      itemCount: pages.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          Center(child: SizedBox(width: 1024, child: pages[index])),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );

    List<Widget> drawer = [
      DrawerHeader(
        child: null,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      )
    ];
    drawer.addAll(actionButtons);

    return Scaffold(
      appBar: CustomAppBar(actions: actionButtons),
      drawer: Drawer(
          child: ListView.builder(
        itemCount: drawer.length,
        itemBuilder: (_, idx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: drawer[idx],
          );
        },
      )),
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

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 64),
      height: 80,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Text(
            "© Martin Smith 2021",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Theme.of(context).accentColor.withOpacity(.6)),
          ),
          FlatButton(
            onPressed: () => showAboutDialog(
              context: context,
              applicationVersion: '0.0.1',
              applicationLegalese: '',
            ),
            child: Text("About"),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  CustomAppBar({Key key, this.actions})
      : preferredSize = Size.fromHeight(128),
        super(key: key);

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
        child: MediaQuery.of(context).size.width <= 980
            ? IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  debugPrint("opening Drawer");
                  Scaffold.of(context).openDrawer();
                })
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actions,
              ),
      ),
    ));
  }
}
