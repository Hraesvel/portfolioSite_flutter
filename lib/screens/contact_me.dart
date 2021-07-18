import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portfolio_site/app_level/assets/assets.dart';
import 'package:portfolio_site/app_level/text/text.dart';
import 'package:portfolio_site/main.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_site/screens/contactForum.dart';

class ContactMe extends StatelessWidget {
  const ContactMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uri emailMe = Uri(
        scheme: "mailto",
        path: "mcodesmith@gmail.com",
        queryParameters: {'subject': 'Greetings'});

    return Container(
      height: 800,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          SelectableText(
            TextSnips.contactMe,
            style: Theme.of(context).textTheme.headline2,
          ),
          Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 450,
            child: SelectableText(
              TextSnips.outro,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 500,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    child: Container(
                      height: 60,
                      width: 128,
                      alignment: Alignment.center,
                      child: Text(TextSnips.contactMe,
                          style: Theme.of(context).textTheme.button),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.40))),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              children: [ContactForum()],
                            ))),
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
            ),
          ),
          Spacer(
            flex: 1,
          ),
          SizedBox(
              width: 450,
              child: SelectableText(
                TextSnips.contactInfo,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              )),
          Spacer(
            flex: 5,
          ),
          Footer(),
        ],
      ),
    );
  }
}

// Link(uri: emailMe, builder: (context, followLink) =>
// TextButton(
// onPressed: () => followLink(),
// child: Container(
// height: 60,
// width: 128,
// alignment: Alignment.center,
// child: Text(TextSnips.contactMe,
// style: Theme.of(context).textTheme.button),
// decoration: BoxDecoration(
// color: Colors.transparent,
// border: Border.all(
// width: 1,
// color: Theme.of(context)
// .accentColor
//     .withOpacity(0.40))),
// ))),
