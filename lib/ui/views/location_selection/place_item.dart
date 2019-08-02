import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    Key key,
    @required this.title,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(title, style: textTheme.subhead.copyWith(
                fontWeight: FontWeight.normal,
              )),
            )
          ],
        ),
      ),
    );
  }
}