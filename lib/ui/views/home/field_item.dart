import 'package:flutter/material.dart';

class FieldItem extends StatelessWidget {
  const FieldItem({
    Key key,
    @required this.label, 
    @required this.child,
  }) : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: textTheme.subtitle.copyWith(
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 0.5,
        )),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 18.0),
          child: child
        )
      ],
    );
  }
}