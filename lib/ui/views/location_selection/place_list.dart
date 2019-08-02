import 'package:bus_booking/core/models/place.dart';
import 'package:flutter/material.dart';

import 'place_item.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    Key key,
    @required this.items,
    this.onTap
  });

  final List<Place> items;
  final Function(Place) onTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          print(i);
          return PlaceItem(
            title: items[i].name,
            onTap: () => onTap(items[i]),
          );
        },
        childCount: items.length,
      ),
    );
  }
}