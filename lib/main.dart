import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/side_bar.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/link.dart';
import 'package:portfolio_site/app_level/styles/theme.dart';
import 'package:portfolio_site/app_level/assets/assets.dart';
import 'package:url_strategy/url_strategy.dart';

// exports for screens directory
import 'screens.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MaterialApp(
      title: "Martin's Portfolio",
      home: Home(),
      theme: AppTheme.baseTheme,
    ),
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  @override
  final Size preferredSize;

  CustomAppBar({Key key, this.actions})
      : preferredSize = Size.fromHeight(128),
        super(key: key);

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
                      onPressed: () => Scaffold.of(context).openDrawer()),
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
      child: Center(
        child: Column(
          children: [
            Text(
              "© Martin Smith 2021",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(.6)),
            ),
            TextButton(
              onPressed: () => showAboutDialog(
                context: context,
                applicationVersion: '0.0.2',
                applicationLegalese: '',
              ),
              child: Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class ResizeObserver extends WidgetsBindingObserver {
  final VoidCallback onResize;

  ResizeObserver(this.onResize);

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    onResize();
  }
}

class _HomeState extends State<Home> {
  //Todo: convert Map to json file or move this to a global file for easier editing.
  final Map<String, String> info = {"resident": "San Francisco, CA"};

  AutoScrollController controller;
  final Axis scrollDirection = Axis.vertical;
  final Duration scrollDuration = Duration(milliseconds: 1600);

  List<Widget> _actionButtons;
  List<Widget> _pages;

  List<Widget> _listOfPages;

  var _listView;

  @override
  Widget build(BuildContext context) {
    List<Widget> drawer = [
      DrawerHeader(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            "Navigation",
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
      )
    ];
    drawer.addAll(_actionButtons);

    return Scaffold(
      appBar: CustomAppBar(actions: _actionButtons),
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
            // Container(
            //   height: 1000,
            // ),
            // Padding(
            //   padding: CommonWidgets.defaultEdgeInset(context),
            //   child: _listView ??= ListView.builder(
            //     itemCount: _listOfPages.length,
            //     itemBuilder: (_, index) => _listOfPages[index],
            //     // shrinkWrap: true,
            //     addAutomaticKeepAlives: true,
            //     controller: controller,
            //     scrollDirection: scrollDirection,
            //   ),
            // ),
            Padding(
              padding: CommonWidgets.defaultEdgeInset(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _listOfPages,
                ),
                controller: controller,
                scrollDirection: scrollDirection,
              ),
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    controller ??= AutoScrollController(
        axis: scrollDirection,
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom));

    _pages ??= [
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

    if (_listOfPages == null)
      _listOfPages = _pages
          .asMap()
          .entries
          .map((e) => AutoScrollTag(
              key: ValueKey(e.key),
              controller: controller,
              index: e.key,
              child: e.value))
          .toList();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _actionButtons ??= _actionButtons = [
      _textActionButton(() => _scrollToIndex(1), text: "About Me"),
      _textActionButton(() => _scrollToIndex(2), text: "Experiences"),
      _textActionButton(() => _scrollToIndex(3), text: "Projects"),
      _textActionButton(() => _scrollToIndex(4), text: "Contact Me"),
      Link(
          uri: Uri.parse(WebAssets.resume),
          target: LinkTarget.blank,
          builder: (_, followLink) => TextButton(
                //Resume
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Resume",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xffeb3575),
                          fontWeight: FontWeight.w100)),
                ),
                onPressed: () => followLink(),
              )),
    ];

    // WidgetsBinding.instance.addObserver(ResizeObserver(_rebuildScrollPosition));
  }

  Widget _textActionButton(Future<void> Function() fn, {text: "blank"}) {
    return TextButton(
      onPressed: () async => fn(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: TextStyle(
                fontSize: 14.0,
                color: Color(0xffeb3575),
                fontWeight: FontWeight.w100)),
      ),
    );
  }

  void _rebuildScrollPosition() {
    setState(() {
      // _listView = ListView.builder(
      //   itemCount: _listOfPages.length,
      //   itemBuilder: (_, index) => _listOfPages[index],
      //   // shrinkWrap: true,
      //   addAutomaticKeepAlives: true,
      //   controller: controller,
      //   scrollDirection: scrollDirection,
      // );
    });
  }

  Future<void> _scrollToIndex(int index) async {
    await controller.scrollToIndex(index, duration: scrollDuration);
  }
}
