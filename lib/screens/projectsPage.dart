import 'dart:convert';
import 'dart:html';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portfolio_site/app_level/access/access.dart';
import 'package:portfolio_site/types/types.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:portfolio_site/utilities/customListItem.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'about_me_builder_row.dart';
import 'package:portfolio_site/main.dart';

class BackendWidget extends StatelessWidget {
  final Project project;
  final int priority;
  final String name;

  final Size size;
  final _cardColor;

  final int maxLength = 135;

  BackendWidget(this.project,
      {Key key,
      this.size = const Size(25, 25),
      cardColor: const Color(0xff102646)})
      : this._cardColor = cardColor,
        this.priority = project.priority,
        this.name = project.name;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    String tech = this.project.tech.toString();

    var readMoreWidget = ReadMoreBullets(
      mq: mediaQuery,
      name: name,
      project: project,
    );

    Widget techStack = SelectableText(tech.substring(1, tech.length - 1));

    TapGestureRecognizer tap = TapGestureRecognizer();
    tap.onTap = () {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          backgroundColor: _cardColor,
          children: [readMoreWidget],
        ),
      );
    };
    //
    // if (this.project.tech.length > 4) {
    //   var showTech = this.project.tech.sublist(0, 3).toString();
    //   techStack = RichText(
    //     text: TextSpan(children: [
    //       TextSpan(
    //           text: "Tech: ${showTech.substring(1, showTech.length - 1)}",
    //           style: Theme.of(context).textTheme.bodyText2),
    //       TextSpan(
    //           text: "...read more",
    //           recognizer: tap,
    //           style: Theme.of(context).textTheme.button)
    //     ]),
    //   );
    // }

    // var spans = [TextSpan(text: project.description)];

    // bool isOverflow = true;
    bool isOverflow = project.description.length > maxLength;

    var spans = [
      TextSpan(
          text: isOverflow
              ? project.description.substring(0, maxLength)
              : project.description),
    ];

    if (isOverflow)
      spans.add(TextSpan(
          text: "...read more",
          recognizer: tap,
          style: Theme.of(context).textTheme.button));

    // Achievements
    List<Widget> achiv = [];

    var max = project.achievements.length;
    // bool isOverSized;

    // if ((isOverSized = MediaQuery.of(context).size.width < 500)) max = 1;

    for (int i = 0; i < max; i++) {
      achiv.add(CustomListItem(
        title: project.achievements[i],
        textStyle: Theme.of(context).textTheme.bodyText2,
        width: null,
        height: null,
      ));
    }

    if (isOverflow)
      achiv.add(TextButton(
        child: Text(
          "...view all",
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            backgroundColor: _cardColor,
            children: [readMoreWidget],
          ),
        ),
      ));

    var description = RichText(
        text: TextSpan(
            children: spans, style: Theme.of(context).textTheme.bodyText2));

    List<Widget> children = [
      SelectableText(
        this.name,
        style: Theme.of(context).textTheme.headline3,
      ),
      Spacer(
        flex: 2,
      ),
      description,
      Spacer(
        flex: 1,
      ),
      SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: achiv,
        ),
      ),
      Spacer(
        flex: 1,
      ),
      // techstack,
      SelectableText(tech),
      Spacer(
        flex: 5,
      ),
      CommonUtility.simpleTextButton(
          uri: this.project.link, text: "View on Github ->")
    ];

    Widget out =  Container(
      // height: 8,
      // width: 16,
      decoration: BoxDecoration(color: _cardColor),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );


    return out;
  }
}

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key key,
    @required this.mq,
    @required this.name,
    @required this.project,
    @required this.techStack,
  }) : super(key: key);

  final MediaQueryData mq;
  final String name;
  final Project project;
  final String techStack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.size.height > 500 ? 450 : mq.size.height,
      width: mq.size.width > 800 ? 400 : mq.size.width * .8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              this.name,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 250,
              child: Scrollbar(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  SelectableText(
                    this.project.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 25,
            ),
            SelectableText(
              "Tech Stack:",
              textAlign: TextAlign.left,
            ),
            SelectableText(techStack,
                style: Theme.of(context).textTheme.bodyText2),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class ReadMoreBullets extends StatelessWidget {
  const ReadMoreBullets({
    Key key,
    @required this.mq,
    @required this.name,
    @required this.project,
  }) : super(key: key);

  final MediaQueryData mq;
  final String name;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.size.height > 500 ? 450 : mq.size.height,
      width: mq.size.width > 800 ? 400 : mq.size.width * .8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              this.name,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              children: project.achievements
                  .map((e) => CustomListItem(
                        title: e,
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        width: null,
                        height: null,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class FrontendWidget extends StatelessWidget {
  final Project project;
  final int priority;
  final String name;
  final String image;

  FrontendWidget({
    Key key,
    @required this.project,
  })  : priority = project.priority,
        name = project.name,
        image = "${Access.s3}/${project.bucket}/${project.image}",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> textBody = [
      SelectableText(
        this.name,
        style: Theme.of(context).textTheme.headline3,
      ),
      SizedBox(
        height: 15,
      ),
      SelectableText(this.project.description)
    ];

    for (var tech in this.project.tech) {
      textBody.add(CustomListItem(
        title: tech,
        textStyle: Theme.of(context).textTheme.bodyText1,
      ));
    }

    textBody
      ..add(Spacer(
        flex: 1,
      ))
      ..add(CommonUtility.simpleTextButton(
          uri: this.project.link, text: "View on Github ->"))
      ..add(Spacer(
        flex: 1,
      ));

    var fadeInImage = FadeInImage.memoryNetwork(
      imageScale: 0.95,
      placeholder: kTransparentImage,
      image: this.image,
      fit: BoxFit.cover,
    );

    var children = [
      // Image enlarge
      MaterialButton(
        child: Container(
          constraints: BoxConstraints(maxHeight: 321, maxWidth: 516),
          decoration: BoxDecoration(
              color: Color(0xff081F41),
              border: Border.all(
                  width: 2.0, color: Colors.blueGrey.withOpacity(0.3))),
          child: AspectRatio(aspectRatio: 1.6, child: fadeInImage),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: [AspectRatio(aspectRatio: 16 / 9, child: fadeInImage)],
            );
          },
        ),
      ),

      SizedBox(width: 35, height: 35),
      // Spacer(flex: 1,),
      Container(
        constraints: BoxConstraints(
          minWidth: 200,
          maxHeight: 321,
          maxWidth: 500,
        ),
        height: 312,
        // decoration: BoxDecoration(color: Colors.white10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: textBody),
      ),
    ];
    return Container(
      child: MediaQuery.of(context).size.width <= 980
          ? Column(children: children)
          : Row(children: children)
      // crossAxisAlignment: WrapCrossAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ,
    );
  }
}

class Projects extends StatefulWidget {
  final Size size;

  const Projects({Key key, this.size}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>
    with AutomaticKeepAliveClientMixin<Projects> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ProjectData projects;
  Widget fp;
  Widget bp;

  bool keepAlive = true;

  @override
  bool get wantKeepAlive => keepAlive;

  @override
  void updateKeepAlive() => setState(() => keepAlive = !keepAlive);

  void _rebuildGrid() {
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      // height: 1800,
      child: Column(
        children: [
          // Frontend Projects
          FutureBuilder(
            future: _getProjectData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _constructFrontend();
              } else {
                return Container(
                  // height: 500,
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ]),
                );
              }
              return this.fp;
            },
          ),
          // Backend Projects
          FutureBuilder(
              future: _getProjectData(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.hasData) {
                  _constructBackend();
                } else {
                  return Container(
                    height: 500,
                    child: Column(children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ]),
                  );
                }
                return this.bp;
              })
        ],
      ),
    );
  }

  void _constructBackend() {
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SelectableText(
          "Backend Projects",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ];

    var width = MediaQuery.of(context).size.width;

    // var size = width < 500 ? Size(40, 80) : Size(40, 50);
    var size = Size(40, 50);

    if (this.projects.backend.isNotEmpty)
      children.add(GridView(
        addRepaintBoundaries: false,
        // addAutomaticKeepAlives: true,
        primary: true,
        shrinkWrap: true,
        reverse: true,
        children: this
            .projects
            .backend
            .map((prj) => BackendWidget(
                  prj,
                  size: size,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width >= 1024 ? 2 : 1,
            crossAxisSpacing: 25.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: (size.width / size.height)),
      ));

    this.bp = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  void _constructFrontend() {
    List<Widget> content = [
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SelectableText(
          "Frontend Projects",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ];

    for (Project p in this.projects.frontend) {
      content.add(FrontendWidget(project: p));
      content.add(SizedBox(
        width: 50,
        height: 50,
      ));
    }

    this.fp = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(ResizeObserver(updateKeepAlive));
    // keepAlive = true;
  }

  /// Send a request to an Amazon S3 bucket relation to projects
  /// This method construct a `ProjectData` from the response and propagate
  /// the 'projects' field
  Future<dynamic> _getProjectData() async {
    return _memoizer.runOnce(() async {
      if (projects != null) return projects;

      var res = await CommonUtility.fetchFromS3(file: "projects.json");
      if (res.statusCode == 200) {
        try {
          Map<String, dynamic> out = JsonDecoder().convert(res.body);

          // Convert Json to Object
          projects = ProjectData.fromJson(out);
          projects.sortProjects(reverseBackend: false);
        } catch (e) {
          print(e.toString());
        }
      }
      return projects;
    });
  }
}
