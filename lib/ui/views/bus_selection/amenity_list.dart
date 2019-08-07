import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/viewmodels/bus_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amenity_item.dart';

class AmenityList extends StatelessWidget {
  const AmenityList({
    Key key,
    @required this.items,
  });

  final List<Amenity> items;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BusSelectionViewModel>(context);

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, int i) => SizedBox(width: 9.0),
      itemBuilder: (_, int i) => AmenityItem(
        label: items[i].name,
        isSelected: model.isSelectedAmenity(items[i]),
        onTap: () => model.toggleAmenity(items[i]),
      ),
    );
  }
}