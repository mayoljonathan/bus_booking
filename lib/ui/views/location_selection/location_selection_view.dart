import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/viewmodels/location_selection_view_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'city_places_sticky_header.dart';
import 'place_list.dart';

class LocationSelectionView extends StatefulWidget {
  const LocationSelectionView({
    Key key,
    @required this.title,
    @required this.locationType
  }) : super(key: key);

  final String title;
  final LocationType locationType;

  @override
  _LocationSelectionViewState createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {

  final LocationSelectionViewModel _locationSelectionViewModel = LocationSelectionViewModel();

  get _favorites => _locationSelectionViewModel.getFavorites(widget.locationType);
  get _cityPlaces => _locationSelectionViewModel.getCityWithPlaces(widget.locationType);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => _locationSelectionViewModel,
      child: Scaffold(
        body: CustomSliverBody(
          title: Text(widget.title, style: Theme.of(context).textTheme.title),
          slivers: <Widget>[
            if (_favorites.length > 0) 
            CityPlacesStickyHeader(
              label: 'Your Favorites',
              hasDivider: false,
              labelStyle: TextStyle(
                color: kAccentColor,
              ),
              child: PlaceList(
                items: _locationSelectionViewModel.getFavorites(widget.locationType),
                onTap: (Place place) {
                  // TODO
                  print(place.name);
                }
              )
            ),
            if (_favorites.length > 0) 
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 6.0,
                  color: Colors.grey.withOpacity(0.35)
                ),
              ),
            ),

            for (CityPlaces cityPlace in _cityPlaces) 
            CityPlacesStickyHeader(
              label: cityPlace.city.name,
              child: SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                sliver: PlaceList(
                  items: cityPlace.places,
                  onTap: (Place place) {
                    // TODO
                    print(place.name);
                  }
                ),
              )
            ),
          ],
        ),
      ),
    );

  }

}
