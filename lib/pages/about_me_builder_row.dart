import 'package:flutter/material.dart';

class AboutMeSkillSet extends StatelessWidget {
  final List<String> skill;
  final rows;
  final depth;
  final start;
  final numPadding;

  const AboutMeSkillSet(
      {Key key,
      @required this.skill,
      this.rows: 2,
      this.depth: 4,
      this.start: 1,
      this.numPadding: 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> c1 = [];
    int tally = 1;

    for (int i = 0; i < rows; i++) {
      List<Widget> s = [];

      for (int j = tally; j < depth + tally; j++) {
        try {
          s.add(ListItemSkill(
            leading: j.toString().padLeft(2, "0"),
            title: skill[j - 1],
          ));
        } catch (e) {
          break;
        }
      }
      tally += depth;
      c1.add(Column(
        children: s,
      ));
    }

    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: c1);
  }
}

class ListItemSkill extends StatelessWidget {
  final String title;
  final String leading;
  final double minLeadingWidth;

  const ListItemSkill(
      {Key key,
      this.leading: "🤦‍",
      this.title: "unknown",
      this.minLeadingWidth: 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 30,
      child: ListTile(
        minLeadingWidth: minLeadingWidth,
        contentPadding: EdgeInsets.all(0),
        leading: Text(
          "$leading.",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        title: Text(title),
      ),
    );
  }
}
