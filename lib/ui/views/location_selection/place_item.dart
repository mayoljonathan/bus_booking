import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    Key key,
    @required this.title,
    this.onTap,
    this.onLongPress,
    this.trailing,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Widget trailing;
  
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 12.0, 18.0),
              child: Text(title, style: textTheme.subhead.copyWith(
                fontWeight: FontWeight.normal,
              )),
            ),
          ),
          if (trailing != null) trailing
        ],
      ),
    );
  }
}