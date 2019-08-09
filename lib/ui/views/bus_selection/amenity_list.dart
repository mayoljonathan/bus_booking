import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/viewmodels/bus_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amenity_item.dart';

class AmenityList extends StatefulWidget {
  const AmenityList({
    Key key,
    @required this.items,
  });

  final List<Amenity> items;

  @override
  _AmenityListState createState() => _AmenityListState();
}

class _AmenityListState extends State<AmenityList> {

  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BusSelectionViewModel>(context);

    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 300),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.items.length,
        separatorBuilder: (_, int i) => SizedBox(width: 9.0),
        itemBuilder: (_, int i) => AmenityItem(
          key: ValueKey<String>(widget.items[i].id),
          label: widget.items[i].name,
          isSelected: model.isSelectedAmenity(widget.items[i]),
          onTap: () => model.toggleAmenity(widget.items[i]),
        ),
      ),
    );
  }
}