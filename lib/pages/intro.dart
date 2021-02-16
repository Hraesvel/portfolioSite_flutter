import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_site/utilities/common.dart';

class Introduction extends StatelessWidget {
  final Map info;

  final Size size;

  Introduction({Key key, @required this.info, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      // decoration: BoxDecoration(color: Colors.purple.withOpacity(.2)),
      child: Padding(
        padding: CommonWidgets.defaultEdgeInset(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 120),
            Text(
              "Hello, I'm Martin Smith",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: 400,
              child: Text(
                "I'm a full-stack software engineer based in ${this.info['resident']} with experience in frontend with Flutter and React, and backend development using Python, Rust.",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            TextButton(
                onPressed: () {
                  Uri emailMe = Uri(
                      scheme: "mailto",
                      path: "mcodesmith@gmail.com",
                      queryParameters: {'subject': 'Greetings'});

                  launch(emailMe.toString());
                },
                child: Container(
                  height: 60,
                  width: 128,
                  alignment: Alignment.center,
                  child: Text("Contact Me",
                      style: Theme.of(context).textTheme.button),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.40))),
                )),
            Center(
                child: SizedBox(
                    width: 180,
                    child: Divider(
                      color: Theme.of(context).accentColor.withOpacity(.50),
                      thickness: 2,
                      height: 180,
                    )))
          ],
        ),
      ),
    );
  }

  Widget fromJson(String json) {
    var map = JsonDecoder().convert(json);
    return Introduction(info: map['info']);
  }

  String intoJson() {
    var map = {'type': 'Introduction', 'info': this.info};

    return JsonEncoder().convert(map);
  }
}
