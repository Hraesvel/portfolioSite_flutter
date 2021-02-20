import 'package:flutter/material.dart';
import 'package:portfolio_site/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';

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
          TextButton(
              onPressed: () => launch(
                  Uri.parse("assets/assets/static/Martin_Backend_Engineer.pdf")
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
          Spacer(
            flex: 5,
          ),
          Footer(),
        ],
      ),
    );
  }
}
