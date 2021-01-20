import 'package:flutter/material.dart';

class AboutMeSkillSet extends StatelessWidget {
  final List<String> skill;
  final rows;
  final depth;
  final start;
  final numPadding;

  const AboutMeSkillSet(
      {Key key,
      this.skill,
      this.rows: 2,
      this.depth: 4,
      this.start: 1,
      this.numPadding: 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            ListItemSkill(),
          ],
        ),
        Column(children: [ListItemSkill()]),
      ],
    );
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
      this.minLeadingWidth: 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ListTile(
        minLeadingWidth: minLeadingWidth,
        leading: Text(leading),
        title: Text(title),
      ),
    );
  }
}
