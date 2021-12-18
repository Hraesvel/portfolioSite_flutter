import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/link.dart';
import 'package:portfolio_site/app_level/links/links.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
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
              createLinkedIcon(
                  uri: Links.github,
                  icon: FontAwesome5.github_alt),

              createLinkedIcon(
                  uri: Links.linkedIn,
                  icon: FontAwesome5.linkedin_in),
              createLinkedIcon(
                  uri: Links.twitter,
                  icon: FontAwesome5.twitter),
              createLinkedIcon(
                  uri: Links.medium,
                  icon: FontAwesome5.medium_m),
            ],
          ),
        ));
  }

  Widget createLinkedIcon(
      {required String uri,
      LinkTarget target: LinkTarget.blank,
      IconData? icon,
      Color? color}) {
    Link iconButton = Link(
        uri: Uri.parse(uri),
        target: target,
        builder: (_, followLink) => IconButton(
            icon: Icon(
              icon,
              color: color ?? Colors.white.withOpacity(0.9),
            ),
            onPressed: () => followLink!()));

    return iconButton;
  }
}
