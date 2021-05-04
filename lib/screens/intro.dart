import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:url_launcher/url_launcher.dart';

class Introduction extends StatelessWidget {
  final Map info;

  final Size size;

  Introduction({Key key, @required this.info, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 120),
      height: 900,
      // decoration: BoxDecoration(color: Colors.purple.withOpacity(.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 1,
          ),
          // SizedBox(height: 120),
          SelectableText(
            "Hello, I'm Martin Smith",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            width: 500,
            child: SelectableText(
              "I'm a full-stack software engineer based in ${this.info['resident']}. I'm a passionate coder and fast learner with broad interests in frontend development, backend services, system design and networking.",
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
          Spacer(
            flex: 1,
          ),
          // Center(
          //     child: SizedBox(
          //         width: 180,
          //         child: Divider(
          //           color: Theme.of(context).accentColor.withOpacity(.50),
          //           thickness: 2,
          //           // height: 180,
          //         ))),
        ],
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
