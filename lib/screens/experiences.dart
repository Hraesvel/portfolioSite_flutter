import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfolio_site/app_level/assets/assets.dart';
import 'package:portfolio_site/app_level/links/links.dart';
import 'package:portfolio_site/app_level/text/text.dart';
import 'package:portfolio_site/types/types.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/common.dart';

class Experiences extends StatefulWidget {
  final Size? size;

  const Experiences({Key? key, this.size}) : super(key: key);

  @override
  _ExperiencesState createState() => _ExperiencesState();
}

class ExperienceWidget extends StatelessWidget {
  final _icon = const Icon(Icons.label_important_outline);

  final ThemeData theme;

  final String? headline;
  final String? description;
  final int? start;
  final int? end;
  final bool? isCurrent;
  final List<String>? _achievements;
  final List<Widget?>? _children;

  const ExperienceWidget(
      {Key? key,
      required this.headline,
      required this.start,
      required this.theme,
      this.description,
      this.end: 0,
      this.isCurrent: true,
      List<Widget?>? children: const <Widget>[],
      List<String>? achievements: const <String>[]})
      : this._achievements = achievements,
        this._children = children,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This Constructs the Cards for an experience/job
    // Widget hl = RichText(text: TextSpan(text: "Blank"));
    String timeline = "Month-year to Month-year";

    List<Widget?> children = [];

    try {
      // build timestamp
      timeline =
          "${convertTime(start!)} - ${isCurrent! ? "Present" : convertTime(end!)}";

      children = [
        parseDetail(headline!),
        SelectableText(
          timeline,
          style: theme.textTheme.headline4,
        ),
        SizedBox(
          height: 15,
        ),
        SelectableText(description!, style: theme.textTheme.bodyText2),
        SizedBox(
          height: 20,
        ),
      ];

      if (this._children != null && this._children!.isNotEmpty) {
        this._children!.removeWhere((element) => element == null);
        if (this.description!.isEmpty) {
          // children[3] = this.child;
          children = [
            ...children.sublist(0, 3),
            ...this._children!,
            ...children.sublist(3)
          ];
        } else
          // children.insert(5, this.child);
          children = [...children, ...this._children!];
      }

      _achievements!.forEach((achievement) {
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

    List<Widget> c = children.map((e) => e as Widget).toList();

    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: c,
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
    RegExp exp2 = CommonWidgets.regex;
    RegExpMatch? matches = exp2.firstMatch(data);
    if (matches == null ||
        matches.groupCount == 0 ||
        matches.namedGroup("coInfo") == null)
      return RichText(
          text: TextSpan(text: data, style: this.theme.textTheme.headline3));

    Map<String, String?> map = {};

    for (String n in matches.groupNames) map[n] = matches.namedGroup(n);

    var tap = TapGestureRecognizer();
    tap.onTap = () => launch(map['url']!);

    return SelectableText.rich(TextSpan(children: <TextSpan>[
      TextSpan(text: map["leading"], style: theme.textTheme.headline3),
      TextSpan(
          text: map['name'],
          style: theme.textTheme.headline3!.copyWith(
              color: theme.colorScheme.secondary,
              decoration: TextDecoration.underline),
          recognizer: tap),
      if (map.containsKey('tail'))
        TextSpan(text: map["tail"], style: theme.textTheme.headline3)
      else
        TextSpan(text: "", style: theme.textTheme.headline3),
    ]));
  }

  static Widget fromData(Experience data, BuildContext context,
      {List<Widget?>? children}) {
    return ExperienceWidget(
        headline: data.headline,
        start: data.start,
        description: data.description,
        achievements: data.achievements,
        isCurrent: data.isCurrent,
        end: data.end,
        children: children,
        theme: Theme.of(context));
  }
}

class ExpTextButton extends StatelessWidget {
  final int idx;
  final Experience experience;
  final _ExperiencesState? _parent;

  ExpTextButton({
    Key? key,
    required this.idx,
    required this.experience,
    parent,
  }) : this._parent = parent;

  @override
  Widget build(BuildContext context) {
    Widget? resume, artPortfolio;
    if (this.experience.name == "CG Generalist") {
      String resLink = WebAssets.cgResume;
      if (!kIsWeb)
        resLink =
            "https://msmith.online/assets/static/Martin_CG_Generalist.pdf";

      resume = TextButton(
          onPressed: () => launch(Uri.parse(resLink).toString()),
          child: Text(TextSnips.viewResumeCG,
              style: Theme.of(context).textTheme.button));

      artPortfolio = TextButton(
          onPressed: () => launch(Uri.parse(Links.cgPortfolio).toString()),
          child: Text(TextSnips.viewCGPort,
              style: Theme.of(context).textTheme.button));
    }

    return Container(
      width: 175,
      child: TextButton(
          onPressed: () {
            // ignore: invalid_use_of_protected_member
            _parent!.setState(() {
              if (this.idx == _parent!._displayedIdx) return;
              _parent!.currentExp = ExperienceWidget.fromData(
                      experience, context, children: [resume, artPortfolio])
                  as ExperienceWidget;
              _parent!._displayedIdx = this.idx;
            });
          },
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                experience.name!,
                style: this.idx == _parent!._displayedIdx
                    ? Theme.of(context).textTheme.button!.copyWith(
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
  ExpData? expData;
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
      height: 800,
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
                    expData!.count!,
                    (index) => ExpTextButton(
                      idx: index,
                      experience: this.expData!.data![index],
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
                    child: Text(TextSnips.viewResume,
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

  Future<ExpData> parseExp(String filename, {String setLast = ""}) async {
    Map<String, dynamic>? out;
    String json = "";

    if (kReleaseMode) {
      http.Response res = await CommonUtility.fetchFromS3(file: filename);
      json = res.statusCode == 200
          ? res.body
          : await CommonUtility.loadStringAsset("assets/$filename");
    } else
      json = await CommonUtility.loadStringAsset("assets/$filename");

    out = JsonDecoder().convert(json);
    ExpData exp = ExpData.fromJson(out!);
    if (setLast.isNotEmpty) {
      int? i =
          exp.data?.indexWhere((element) => element.name!.contains(setLast));
      exp.data?.add(exp.data![i!]);
      exp.data?.removeAt(i!);
    }
    return exp;
  }

  @override
  void updateKeepAlive() {}

  Future<dynamic> _constructExperience() async {
    return this._memoizer.runOnce(() async {
      this.expData =
          await parseExp('experiences.json', setLast: "CG Generalist");
      // create an Experience Widget from the first member of the array.
      currentExp = ExperienceWidget.fromData(expData!.data![0], context)
          as ExperienceWidget;
      return this.expData;
    });
  }
}
