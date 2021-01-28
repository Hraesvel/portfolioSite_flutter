import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    var fp = [
      Container(
        constraints: BoxConstraints(
            minWidth: 128,
            minHeight: 64,
            maxHeight: 321 * 0.7,
            maxWidth: 516 * 0.7),
        decoration: BoxDecoration(color: Color(0xff081F41)),
        // child: Image(image: AssetImage("assets/projects/01/img.png")),
      ),
      SizedBox(width: 25, height: 35),
      Container(
        constraints: BoxConstraints(
          minWidth: 200,
          maxHeight: 321 * 0.7,
          maxWidth: 516 * 0.65,
        ),
        height: 312 * 0.7,
        decoration: BoxDecoration(color: Colors.white10),
        child: Text(""),
      )
    ];
    return Container(
      height: 1400,
      child: Padding(
        padding: const EdgeInsets.only(left: 128, right: 128),
        child: Column(
          children: [
            //Frontend
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Frontend Projects",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Container(
                  child: MediaQuery.of(context).size.width <= 912
                      ? Column(children: fp)
                      : Row(children: fp)
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ,
                ),
              ],
            ),
            //Backend
            Column()
          ],
        ),
      ),
    );
  }
}
