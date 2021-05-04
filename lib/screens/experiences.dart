import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio_site/app_level/assets/assets.dart';
import 'package:portfolio_site/types/types.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/common.dart';

class Experiences extends StatefulWidget {
  final Size size;

  const Experiences({Key key, this.size}) : super(key: key);

  @override
  _ExperiencesState createState() => _ExperiencesState();
}

class ExperienceWidget extends StatelessWidget {
  final _icon = const Icon(Icons.label_important_outline);

  final ThemeData theme;

  final String headline;
  final String description;
  final int start;
  final int end;
  final bool isCurrent;
  final List<String> _achievements;

  const ExperienceWidget(
      {Key key,
      @required this.headline,
      @required this.start,
      @required this.theme,
      this.description: "",
      this.end: 0,
      this.isCurrent: true,
      List<String> achievements: const <String>[]})
      : this._achievements = achievements,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget hl = RichText(text: TextSpan(text: "Blank"));
    String timeline = "Month-year to Month-year";

    List<Widget> children = [];

    try {
      // hl = parseDetail(headline);
      timeline =
          "${convertTime(start)} - ${isCurrent ? "Present" : convertTime(end)}";

      children = [
        parseDetail(headline),
        SelectableText(
          timeline,
          style: theme.textTheme.headline4,
        ),
        SizedBox(
          height: 15,
        ),
        SelectableText(description, style: theme.textTheme.bodyText2),
        SizedBox(
          height: 20,
        ),
      ];

      _achievements.forEach((achievement) {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            leading: _icon,
            title: SelectableText(
              achievement,
              style: theme.textTheme.bodyText2,
            ),
            contentPadding: EdgeInsets.all(0),
            minLeadingWidth: 15,
          ),
        ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  String convertTime(int milliseconds, {format: "MMMM yyyy"}) {
    var dt = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
    DateFormat formatter = DateFormat(format);
    return formatter.format(dt);
  }

  Widget parseDetail(String data) {
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

    return SelectableText.rich(TextSpan(children: <TextSpan>[
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
    return Container(
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
                          decorationThickness: 2,
                          fontWeight: FontWeight.w600,
                        )
                    : Theme.of(context).textTheme.button,
              ))),
    );
  }
}

class _ExperiencesState extends State<Experiences>
    with AutomaticKeepAliveClientMixin {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ExpData expData;
  ExperienceWidget currentExp = ExperienceWidget(
    headline: "PlaceHolder",
    start: 0,
    theme: ThemeData(),
  );

  int _displayedIdx = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      // decoration: BoxDecoration(color: Colors.purple),
      child: FutureBuilder(
        future: _constructExperience(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) debugPrint(snapshot.error.toString());
          if (!snapshot.hasData)
            return Container(
              height: 700,
              child: Center(
                child: SizedBox(
                  child: SelectableText("Fetching Data..."),
                  height: 60,
                  width: 60,
                ),
              ),
            );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                "Experience",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                // Experience Nav bar
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
                  onPressed: () =>
                      launch(Uri.parse(WebAssets.resume).toString()),
                  child: Container(
                    height: 60,
                    width: 128,
                    alignment: Alignment.center,
                    child: Text("View Resume",
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

  @override
  void initState() {
    super.initState();
  }

  Future<ExpData> parseExp(String filename) async {
    Map<String, dynamic> out;
    String json = "";

    if (kReleaseMode) {
      http.Response res = await CommonUtility.fetchFromS3(file: filename);
      json = res.statusCode == 200
          ? res.body
          : await CommonUtility.loadStringAsset("assets/$filename");
    } else
      json = await CommonUtility.loadStringAsset("assets/$filename");

    out = JsonDecoder().convert(json);
    ExpData exp = ExpData.fromJson(out);
    return exp;
  }

  @override
  void updateKeepAlive() {}

  Future<dynamic> _constructExperience() async {
    return this._memoizer.runOnce(() async {
      this.expData = await parseExp('experiences.json');
      // create an Experience Widget from the first member of the array.
      currentExp = ExperienceWidget.fromData(expData.data[0], context);
      return this.expData;
    });
  }
}
