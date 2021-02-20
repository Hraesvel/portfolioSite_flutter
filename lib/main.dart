import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/side_bar.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// exports for screens directory
import 'screens.dart';

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
    final List<Widget> actionButtons = [
      TextButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 1, duration: dur);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("About Me",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffeb3575),
                  fontWeight: FontWeight.w100)),
        ),
      ),
      TextButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 2, duration: dur);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Experiences",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffeb3575),
                  fontWeight: FontWeight.w100)),
        ),
      ),
      TextButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 3, duration: dur);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Projects",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffeb3575),
                  fontWeight: FontWeight.w100)),
        ),
      ),
      TextButton(
        onPressed: () {
          itemScrollController.scrollTo(index: 4, duration: dur);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Contact Me",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffeb3575),
                  fontWeight: FontWeight.w100)),
        ),
      ),
      TextButton(
        onPressed: () => launch(
            Uri.parse("assets/assets/static/Martin_Backend_Engineer.pdf")
                .toString()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Resume",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffeb3575),
                  fontWeight: FontWeight.w100)),
        ),
      ),
    ];


    final List<Widget> pages = [
      Introduction(
        info: info,
        size: MediaQuery.of(context).size,
      ),
      AboutMe(
        info: info,
        templatePath: "assets/text_template/about_me.mustache",
        size: MediaQuery.of(context).size,
      ),
      Experiences(
        size: MediaQuery.of(context).size,
      ),
      Projects(
        size: MediaQuery.of(context).size,
      ),
      ContactMe(),
    ];

    var listOfPages = ScrollablePositionedList.builder(
      itemCount: pages.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) => pages[index],
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );

    List<Widget> drawer = [
      DrawerHeader(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text("Navigation", textAlign: TextAlign.center,),
        ),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
      )
    ];
    drawer.addAll(actionButtons);

    return Scaffold(
      appBar: CustomAppBar(actions: actionButtons),
      drawer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
            child: ListView.builder(
          itemCount: drawer.length,
          itemBuilder: (_, idx) {
            return drawer[idx];
          },
        )),
      ),
      body: Container(
        color: Color(0xff0a192f),
        child: Stack(
          children: [
            Container(
              height: 1000,
            ),
            Padding(
              padding: CommonWidgets.defaultEdgeInset(context),
              child: listOfPages,
            ),
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
          TextButton(
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
        padding: CommonWidgets.defaultEdgeInset(context)
            .copyWith(top: 25, bottom: 25),
        child: MediaQuery.of(context).size.width <= 980
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        debugPrint("opening Drawer");
                        Scaffold.of(context).openDrawer();
                      }),
                ],
              )
            : Wrap(
                // crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: actions,
              ),
      ),
    ));
  }
}
