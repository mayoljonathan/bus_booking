import 'package:flutter/material.dart';

class LocationField extends StatelessWidget {
  const LocationField({
    Key key,
    @required this.placeName,
    @required this.placeholder,
    @required this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0)
  });

  final String placeName;
  final String placeholder;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: padding,
              // child: Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Text(placeName ?? placeholder, style: textTheme.headline.copyWith(
              //         color: (placeName != null) ? Colors.white : Colors.white54,
              //         fontWeight: (placeName != null) ? FontWeight.bold : FontWeight.w100,
              //       )),
              //     ),
              //     SizedBox(width: 6.0),
              //     Icon(EvaIcons.chevronRight, color: Colors.white70, size: 30)
              //   ],
              // ),
              child: Text(placeName ?? placeholder, style: textTheme.headline.copyWith(
                color: (placeName != null) ? Colors.white : Colors.white54,
                fontWeight: (placeName != null) ? FontWeight.bold : FontWeight.w100,
              )),
            ),
            Divider(color: Colors.white, height: 1.0),
            SizedBox(height: 3.0)
          ],
        ),
      ),
    );
  }
}