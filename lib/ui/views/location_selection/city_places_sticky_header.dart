import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class CityPlacesStickyHeader extends StatelessWidget {
  const CityPlacesStickyHeader({
    Key key,
    this.label, 
    this.labelStyle,
    this.child, 
    this.hasDivider = true
  });

  final String label;
  final TextStyle labelStyle;
  final Widget child;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Column(
        children: <Widget>[
          Container(
            height: 48.0,
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            alignment: Alignment.centerLeft,
            child: Text(label, 
              style: Theme.of(context).textTheme.subhead.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: kPrimaryColor
              ).merge(labelStyle)
            ),
          ),
          if (hasDivider) Divider(height: 1.0)
        ],
      ),
      sliver: child
    );
  }
}