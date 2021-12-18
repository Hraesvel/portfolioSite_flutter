import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:portfolio_site/app_level/links/links.dart';
import 'package:portfolio_site/app_level/text/text.dart';
import 'package:portfolio_site/utilities/common.dart';
import 'package:url_launcher/url_launcher.dart';

class Introduction extends StatelessWidget {
  final Map? info;

  final Size? size;

  Introduction({Key? key, required this.info, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      // padding: EdgeInsets.only(top: 120),
      height: 800,
      // decoration: BoxDecoration(color: Colors.purple.withOpacity(.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 1,
          ),
          // SizedBox(height: 120),
          SelectableText(
            TextSnips.introBlurb,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  TextSnips.intro(info: this.info),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 32,
                ),
                CommonUtility.simpleTextButton(
                    text: TextSnips.viewSource, uri: Links.pageSource)
              ],
            ),
          ),

          SizedBox(
            height: 32,
          ),
          TextButton(
              onPressed: () => launch(Links.emailUri.toString()),
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
                        color:
                            Theme.of(context).accentColor.withOpacity(0.40))),
              )),
          Spacer(
            flex: 1,
          ),
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
