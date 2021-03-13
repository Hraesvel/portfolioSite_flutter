import 'package:flutter/material.dart';
import 'package:portfolio_site/utilities/customListItem.dart';

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

    for (int i = 0; i < rows && tally <= skill.length; i++) {
      List<Widget> s = [];

      for (int j = tally; j < depth + tally; j++) {
        try {
          s.add(CustomListItem(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: c1);
  }
}

