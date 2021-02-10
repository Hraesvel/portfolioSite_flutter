import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _constructSideBar(context);
  }

  Widget _constructSideBar(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width - 90,
        top: MediaQuery.of(context).size.height / 2 - 200,
        child: Container(
          width: 90,
          height: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesome5.github_alt,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  onPressed: () {
                    launch("https://github.com/ostoyae/");
                  }),
              IconButton(
                  icon: Icon(FontAwesome5.linkedin_in),
                  onPressed: () {
                    launch("https://linkedin.com/in/rustyboy");
                  }),
              IconButton(
                  icon: Icon(FontAwesome5.twitter),
                  onPressed: () {
                    launch("https://twitter.com/_ostoyae");
                  }),
              IconButton(
                  icon: Icon(FontAwesome5.medium_m),
                  onPressed: () {
                    launch('https://medium.com/@Ostoyae');
                  }),
            ],
          ),
        ));
  }
}
