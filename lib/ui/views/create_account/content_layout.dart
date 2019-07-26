import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';

class ContentLayout extends StatefulWidget {
  const ContentLayout({
    Key key,
    this.onInit,
    @required this.title,
    this.subtitle,
    @required this.child
  }) : super(key: key);

  final VoidCallback onInit;

  /// Can be a string or a widget
  final dynamic title;
  final String subtitle;
  final Widget child;

  @override
  _ContentLayoutState createState() => _ContentLayoutState();
}

class _ContentLayoutState extends State<ContentLayout> {

  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          if (widget.subtitle != null) Text(widget.subtitle, style: themeData.textTheme.body1.copyWith(
            color: themeData.textTheme.caption.color
          )),
          SizedBox(height: 12.0),
          widget.child
        ],
      )
    );
  }

  Widget _buildTitle() {
    ThemeData themeData = Theme.of(context);

    if (widget.title is String) {
      return Text(widget.title, style: themeData.textTheme.display1.copyWith(
        fontWeight: FontWeight.bold,
        color: kPrimaryColor
      ));
    } 
    return widget.title;
  }
}
