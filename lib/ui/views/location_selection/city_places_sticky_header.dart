import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class CityPlacesStickyHeader extends StatelessWidget {
  const CityPlacesStickyHeader({
    Key key,
    this.label, 
    this.labelStyle,
    this.trailing,
    this.child, 
    this.headerPadding,
    this.headerBackground,
  });

  final String label;
  final TextStyle labelStyle;
  final Widget trailing;
  final Widget child;
  final EdgeInsetsGeometry headerPadding;
  final Color headerBackground;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 48.0,
        color: headerBackground == null ? Theme.of(context).canvasColor : headerBackground,
        padding: headerPadding == null ? const EdgeInsets.symmetric(horizontal: 24.0) : headerPadding,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label, 
              style: Theme.of(context).textTheme.subhead.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: kPrimaryColor
              ).merge(labelStyle)
            ),
            if (trailing != null) trailing
          ],
        ),
      ),
      sliver: child
    );
  }
}