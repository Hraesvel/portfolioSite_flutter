import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/access.dart';
import 'package:portfolio_site/types/project.dart';
import 'package:portfolio_site/types/projectData.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:transparent_image/transparent_image.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  List<Project> frontend = [];
  List<Project> backend = [];

  Column fp;
  Column bp;

  @override
  void initState() {
    super.initState();
    setState(() {
      CommonUtility.fetchFromS3(bucket: "projects", file: "projects.json")
          .then((res) {
        if (res.statusCode == 200) {
          Map<String, dynamic> out = JsonDecoder().convert(res.body);
          ProjectData projects = ProjectData.fromJson(out);
          this.frontend = projects.frontend;
          this.backend = projects.backend;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // constructFrontend();
    return Container(
      height: 1400,
      child: Padding(
        padding: const EdgeInsets.only(left: 128, right: 128),
        child: Column(
          children: [
            FutureBuilder(
              future: _getProjectData(),
              builder:
                  (BuildContext context, AsyncSnapshot<ProjectData> snapshot) {
                if (snapshot.hasData) {
                  constructFrontend();
                } else {
                  this.fp = Column(children: [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ]);
                }
                return this.fp;
              },
            )
          ],
        ),
      ),
    );
  }

  Future<ProjectData> _getProjectData() async {
    ProjectData projects;

    var res = await CommonUtility.fetchFromS3(
        bucket: "projects", file: "projects.json");
    if (res.statusCode == 200) {
      Map<String, dynamic> out = JsonDecoder().convert(res.body);
      projects = ProjectData.fromJson(out);
    }
    return projects;
  }

  void constructFrontend() async {
    List<Widget> content = [
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Text(
          "Frontend Projects",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ];

    for (Project p in this.frontend) {
      content.add(FrontendWidget(project: p));
      content.add(SizedBox(width: 50, height: 50,));
    }

    this.fp = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  List<Widget> constructBackend() {
    if (this.backend.isEmpty)
      return [];
    else
      // do stuff
      return [];
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
    var frontendProjects = [
      Container(
        constraints: BoxConstraints(
            minWidth: 128,
            minHeight: 64,
            maxHeight: 321 * 0.7,
            maxWidth: 516 * 0.7),
        decoration: BoxDecoration(
            color: Color(0xff081F41),
            border:
                Border.all(width: 2.0, color: Colors.blueGrey.withOpacity(0.3) )),
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
      Container(
        constraints: BoxConstraints(
          minWidth: 200,
          maxHeight: 321 * 0.7,
          maxWidth: 516 * 0.65,
        ),
        height: 312 * 0.7,
        decoration: BoxDecoration(color: Colors.white10),
        child: Text(this.project.description),
      ),

    ];
    return Container(
      child: MediaQuery.of(context).size.width <= 980
          ? Column(children: frontendProjects)
          : Row(children: frontendProjects)
      // crossAxisAlignment: WrapCrossAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ,
    );
  }
}
