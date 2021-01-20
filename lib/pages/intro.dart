import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Introduction extends StatelessWidget {
  final Map info;

  Introduction({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.only(left: 128, right: 128),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
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
            FlatButton(
                onPressed: () {
                  Uri emailMe =   Uri(
                      scheme: "mailto",
                      path: "mcodesmith@gmail.com",
                      queryParameters: {
                        'subject' : 'Greetings'
                      });

                  launch(emailMe.toString());
                },
                padding: EdgeInsets.all(0.0),
                child: Container(
                  height: 60,
                  width: 128,
                  alignment: Alignment.center,
                  child: Text("Contact Me",
                      style: Theme.of(context).textTheme.button),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 1, color: Theme.of(context).accentColor.withOpacity(0.40))),
                ))
          ],
        ),
      ),
    );
  }
}
