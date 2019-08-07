import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/viewmodels/location_selection_view_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'place_item.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    Key key,
    // this.isAnimated = false,
    // this.controller,
    @required this.items,
    @required this.locationType,
    this.onTap,
    this.onLongPress,
    this.trailingIcon,
    this.hasTrailing = false,
    this.onTrailingTap
  });


  /// If [isAnimated] , it uses a AnimatedList
  /// If not, it uses SliverList
  // final bool isAnimated;

  /// Uses if [isAnimated]
  // final ScrollController controller;
  final List<Place> items;
  final Function(Place) onTap;
  final Function(Place) onLongPress;
  final LocationType locationType;
  final bool hasTrailing;
  final Widget trailingIcon;
  final Function(Place) onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      key: key,
      delegate: SliverChildBuilderDelegate((context, i) => _buildPlaceItem(context, i),
        childCount: items.length,
      ),
    );
  }

  Widget _buildPlaceItem(BuildContext context, int i) {
    return PlaceItem(
      key: ValueKey<String>(items[i].id),
      title: items[i].name,
      onTap: () => onTap(items[i]),
      onLongPress: () => onLongPress != null ? onLongPress(items[i]) : null,
      trailing: hasTrailing ? Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: IconButton(
          icon: Provider.of<LocationSelectionViewModel>(context).isFavorited(
            locationType: locationType,
            place: items[i]
          ) ? Icon(EvaIcons.star, color: kAccentColor) : Icon(EvaIcons.starOutline, color: Colors.grey),
          onPressed: () => onTrailingTap(items[i])
        )
      ) : null
    );
  }
}