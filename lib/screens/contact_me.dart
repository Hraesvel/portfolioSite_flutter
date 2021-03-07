import 'dart:html';

import 'package:flutter/material.dart';
import 'package:portfolio_site/app_level/assets/assets.dart';
import 'package:portfolio_site/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMe extends StatelessWidget {
  const ContactMe({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          Text(
            "Contact me",
            style: Theme.of(context).textTheme.headline2,
          ),
          Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 450,
            child: Text(
              "Thanks for visiting my site. I’d love to hear from you. Feel free to drop me a line or to connect with me on social media. Cheers!",
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
                TextButton(
                    onPressed: () => launch(
                        Uri.parse(WebAssets.resume)
                            .toString()),
                    child: Container(
                      height: 60,
                      width: 128,
                      alignment: Alignment.center,
                      child:
                          Text("Resume", style: Theme.of(context).textTheme.button),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color:
                                  Theme.of(context).accentColor.withOpacity(0.40))),
                    )),
              ],
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Footer(),
        ],
      ),
    );
  }
}
