import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String leading;
  final double minLeadingWidth;
  final double width;
  final double height;

  final TextStyle textStyle;

  const CustomListItem(
      {Key key,
      this.leading: "->",
      this.title: "unknown",
      this.textStyle,
      this.minLeadingWidth: 12,
      this.width: 150,
      this.height: 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListTile(
        minLeadingWidth: minLeadingWidth,
        contentPadding: EdgeInsets.all(0),
        leading: Text(
          "$leading",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        title: SelectableText(
          title,
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
