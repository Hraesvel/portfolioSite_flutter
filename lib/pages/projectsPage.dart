import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/access.dart';
import 'package:portfolio_site/pages/about_me_builder_row.dart';
import 'package:portfolio_site/types/types.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  final Size size;

  const Projects({Key key, this.size}) : super(key: key);
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ProjectData projects;

  Widget fp;
  Widget bp;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this.projects = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // constructFrontend();
    return Container(
      // height: 1800,
      child: Column(
        children: [
          // Frontend Projects
          FutureBuilder(
            future: _getProjectData(),
            builder:
                (BuildContext context, AsyncSnapshot<ProjectData> snapshot) {
              if (snapshot.hasData) {
                constructFrontend(snapshot.data);
              } else {
                this.fp = Container(
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
              return this.fp;
            },
          ),
          // Backend Projects
          FutureBuilder(
              future: _getProjectData(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.hasData) {
                  constructBackend(snapShot.data);
                } else {
                  this.bp = Container(
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

  /// Send a request to an Amazon S3 bucket relation to projects
  /// This method construct a `ProjectData` from the response and propagate
  /// the 'projects' field
  Future<ProjectData> _getProjectData() async {
    if (this.projects != null) return this.projects;

    var res = await CommonUtility.fetchFromS3(
        bucket: "projects", file: "projects.json");
    if (res.statusCode == 200) {
      try {
        // var bytes = res.body.codeUnits;
        // Map<String, dynamic> out = JsonDecoder().convert(utf8.decode(bytes));
        Map<String, dynamic> out = JsonDecoder().convert(res.body);
        this.projects = ProjectData.fromJson(out);
        // debugPrint(this.projects.frontend.toString());
        this.projects.frontend.sort((a, b) => a.priority.compareTo(b.priority));
        // debugPrint(this.projects.frontend.toString());

        this.projects.backend.sort((a, b) => a.priority.compareTo(b.priority));
      } catch (e) {
        print("whoops");
        // debugPrint(e.toString());
      }
    }
    return this.projects;
  }

  void constructFrontend(ProjectData projects) {
    List<Widget> content = [
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Text(
          "Frontend Projects",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ];

    for (Project p in projects.frontend) {
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

  void constructBackend(ProjectData projects) {
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Text(
          "Backend Projects",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ];

    List<BackendWidget> prjList = [];

    var size = Size(40, 25);

    for (Project prj in projects.backend) {
      prjList.add(BackendWidget(
        prj,
        size: size,
      ));
    }

    if (prjList.isNotEmpty)
      children.add(GridView(
        shrinkWrap: true,
        children: prjList,
        addRepaintBoundaries: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 25.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: (size.width / size.height)),
      ));

    this.bp = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
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
        image = "$S3ACCESS/${project.bucket}/${project.image}",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> textBody = [
      Text(
        this.name,
        style: Theme.of(context).textTheme.headline3,
      ),
      SizedBox(
        height: 15,
      ),
      Text(this.project.description)
    ];

    for (var tech in this.project.tech) {
      textBody.add(ListItemSkill(
        title: tech,
      ));
    }

    textBody.add(Spacer(
      flex: 1,
    ));
    textBody.add(Text(
      "Link",
      style: Theme.of(context).textTheme.button,
    ));

    var children = [
      Container(
        constraints: BoxConstraints(
            // minWidth: 128,
            // minHeight: 128,
            maxHeight: 321 * 0.7,
            maxWidth: 516 * 0.7),
        decoration: BoxDecoration(
            color: Color(0xff081F41),
            border: Border.all(
                width: 2.0, color: Colors.blueGrey.withOpacity(0.3))),
        child: AspectRatio(
            aspectRatio: 1.6,
            child: FadeInImage.memoryNetwork(
              imageScale: 0.95,
              placeholder: kTransparentImage,
              image: this.image,
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(width: 35, height: 35),
      // Spacer(flex: 1,),
      Container(
        constraints: BoxConstraints(
          minWidth: 200,
          maxHeight: 321 * 0.7,
          maxWidth: 516 * 0.65,
        ),
        height: 312 * 0.7,
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

class BackendWidget extends StatelessWidget {
  final Project project;
  final int priority;
  final String name;

  final Size size;

  // final String? image;

  BackendWidget(this.project, {Key key, this.size = const Size(25, 25)})
      : this.priority = project.priority,
        this.name = project.name;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        this.name,
        style: Theme.of(context).textTheme.headline3,
      ),
      Spacer(
        flex: 2,
      ),
      Text(
        this.project.description,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      Spacer(
        flex: 1,
      ),
      Text(
        this.project.tech.toString(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      Spacer(
        flex: 5,
      ),
      TextButton(
          onPressed: () => launch(this.project.link),
          child: Text(
            "View on Github ->",
            style: Theme.of(context).textTheme.button,
          ))
    ];

    return Container(
      height: 8,
      width: 16,
      decoration: BoxDecoration(color: Color(0xff102646)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
