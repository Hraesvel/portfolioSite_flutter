import 'package:flutter/material.dart';
import 'package:portfolio_site/pages/about_me_builder_row.dart';
import 'package:mustache_template/mustache_template.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class AboutMeBuilder extends StatelessWidget {
  AboutMeBuilder({
    Key key,
    @required this.aboutMeText,
  }) : super(key: key);

  final String aboutMeText;

  final List<String> skills = [
    "C",
    "Rust",
    "Python",
    "Csharp",
    "Javascript",
    "Html & CSS",
    "Flutter",
    "React",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.only(left: 128, right: 128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            // body
                          // height: 300,
                          constraints: BoxConstraints(maxWidth: 300 , minWidth: 128),
                            width: (MediaQuery.of(context).size.width - 256) / 2,
                            child: Text(aboutMeText)),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            child: Text("Here are the languages I work in:")),
                        AboutMeSkillSet(),
                      ],
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Image(
                        image: AssetImage("assets/img/me.png"),
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class AboutMe extends StatefulWidget {
  const AboutMe({Key key, this.info, this.templatePath}) : super(key: key);

  final Map info;
  final String templatePath;

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  String _aboutme;

  @override
  void initState() {
    getAboutMe().then((result) {
      setState(() {
        _aboutme = Template(result).renderString(widget.info);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_aboutme == null)
      return Container(
        height: 600,
        decoration: BoxDecoration(color: Colors.red),
      );
    else
      return AboutMeBuilder(aboutMeText: _aboutme);
  }

  Future<String> getAboutMe() async {
    return await rootBundle.loadString(widget.templatePath);
  }
}
