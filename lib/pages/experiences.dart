import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/common.dart';
import 'package:flutter/foundation.dart';

import 'package:portfolio_site/types/types.dart';

class Experiences extends StatefulWidget {
  final Size size;

  const Experiences({Key key, this.size}) : super(key: key);

  @override
  _ExperiencesState createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ExpData expData;
  ExperienceWidget currentExp = ExperienceWidget(
    headline: "PlaceHolder",
    start: 0,
    theme: ThemeData(),
  );

  int _displayedIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      // decoration: BoxDecoration(color: Colors.purple),
      child: FutureBuilder(
        future: _constructExperience(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            debugPrint(snapshot.error.toString());
          if (!snapshot.hasData)
            return Container(
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 60,
                  width: 60,
                ),
              ),
            );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experiences",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 550,
                height: 54,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    expData.count,
                    (index) => ExpTextButton(
                      idx: index,
                      experience: this.expData.data[index],
                      parent: this,
                    ),
                  ),
                ),
              ),
              currentExp,
              TextButton(
                  onPressed: () => launch(Uri.parse(
                          "assets/assets/static/Martin_Backend_Engineer.pdf")
                      .toString()),
                  child: Container(
                    height: 60,
                    width: 128,
                    alignment: Alignment.center,
                    child: Text("Resume",
                        style: Theme.of(context).textTheme.button),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context)
                                .accentColor
                                .withOpacity(0.40))),
                  )),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> _constructExperience() async {
    return this._memoizer.runOnce(() async {
      this.expData = await parseExp('assets/experiences.json');
      currentExp = ExperienceWidget.fromData(expData.data[0], context);
      return this.expData;
    });
  }

  Future<ExpData> parseExp(String path) async {
    Map<String, dynamic> out;
    String json = "";
    http.Response res =
        // await CommonUtility.fetchFromWeb("$S3ACCESS/experiences.json");
        await CommonUtility.fetchFromS3(file: "experiences.json");
    json = res.statusCode == 200
        ? res.body
        : await CommonUtility.loadStringAsset(path);
    out = JsonDecoder().convert(json);
    ExpData exp = ExpData.fromJson(out);
    return exp;
  }
}

class ExpTextButton extends StatelessWidget {
  final int idx;
  final Experience experience;
  final _ExperiencesState _parent;

  ExpTextButton({
    Key key,
    @required this.idx,
    @required this.experience,
    parent,
  }) : this._parent = parent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: TextButton(
          onPressed: () {
            // ignore: invalid_use_of_protected_member
            _parent.setState(() {
              if (this.idx == _parent._displayedIdx) return;
              _parent.currentExp =
                  ExperienceWidget.fromData(experience, context);
              _parent._displayedIdx = this.idx;
            });
          },
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                experience.name,
                style: this.idx == _parent._displayedIdx
                    ? Theme.of(context).textTheme.button.copyWith(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                        )
                    : Theme.of(context).textTheme.button,
              ))),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget(
      {Key key,
      @required this.headline,
      @required this.start,
      @required this.theme,
      this.description: "",
      this.end: 0,
      this.isCurrent: true,
      List<String> achievements: const <String>[]})
      : super(key: key);

  final ThemeData theme;
  final String headline;
  final String description;
  final int start;
  final int end;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    RichText hl = RichText(text: TextSpan(text: "Blank"));
    String tl = "Month-year to Month-year";
    try {
      hl = parseDetail(headline);
      tl =
          "${convertTime(start)} - ${isCurrent ? "Present" : convertTime(end)}";
    } catch (e) {
      debugPrint(e.toString());
    }

    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hl,
            Text(
              tl,
              style: theme.textTheme.headline4,
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                leading: Text("❤"),
                title: Text("Woof"),
                contentPadding: EdgeInsets.all(0),
                minLeadingWidth: 15,
              ),
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                leading: Text("❤"),
                title: Text("Woof"),
                contentPadding: EdgeInsets.all(0),
                minLeadingWidth: 15,
              ),
            ),
            ListTile(
              leading: Text("❤"),
              title: Text("Woof"),
              contentPadding: EdgeInsets.all(0),
              minLeadingWidth: 15,
            ),
          ],
        ),
      ),
    );
  }

  static Widget fromData(Experience data, BuildContext context) {
    return ExperienceWidget(
        headline: data.headline,
        start: data.start,
        description: data.description,
        achievements: data.achievements,
        isCurrent: data.isCurrent,
        end: data.end,
        theme: Theme.of(context));
  }

  String convertTime(int milliseconds, {format: "MMMM yyyy"}) {
    var dt = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
    DateFormat formatter = DateFormat(format);
    return formatter.format(dt);
  }

  RichText parseDetail(String data) {
    RegExp exp2 = RegExp(
        r"((?<leading>.+)(?<coInfo>\[(?<name>.+)\]\((?<url>.+)\))(?<tail>.+)?)");
    RegExpMatch matches = exp2.firstMatch(data);
    if (matches == null ||
        matches.groupCount == 0 ||
        matches.namedGroup("coInfo") == null)
      return RichText(
          text: TextSpan(text: data, style: this.theme.textTheme.headline3));

    Map<String, String> map = {};

    for (String n in matches.groupNames) map[n] = matches.namedGroup(n);

    var tap = TapGestureRecognizer();
    tap.onTap = () => launch(map['url']);

    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(text: map["leading"], style: theme.textTheme.headline3),
      TextSpan(
          text: map['name'],
          style: theme.textTheme.headline3.copyWith(
              color: theme.accentColor, decoration: TextDecoration.underline),
          recognizer: tap),
      map.containsKey('tail')
          ? TextSpan(text: map["tail"], style: theme.textTheme.headline3)
          : null,
    ]));
  }
}
