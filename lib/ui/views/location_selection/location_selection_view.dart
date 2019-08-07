import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/location_selection_view_model.dart';
import 'package:bus_booking/locator.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'city_places_sticky_header.dart';
import 'place_list.dart';

class LocationSelectionView extends StatefulWidget {
  const LocationSelectionView({
    Key key,
    @required this.homeViewModel,
    @required this.title,
    @required this.locationType
  }) : super(key: key);

  final HomeViewModel homeViewModel;
  final String title;
  final LocationType locationType;

  @override
  _LocationSelectionViewState createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> with TickerProviderStateMixin {

  final LocationSelectionViewModel _locationSelectionViewModel = locator<LocationSelectionViewModel>();
  get _cityPlaces => _locationSelectionViewModel.getCityWithPlaces(widget.locationType);

  bool _isFavoritesHeaderExpanded = false;

  int _initialFavoritesVisible = 3;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => _locationSelectionViewModel,
      child: Scaffold(
        key: _locationSelectionViewModel.scaffoldKey,
        body: CustomSliverBody(
          title: Text(widget.title, style: Theme.of(context).textTheme.title),
          slivers: <Widget>[
            Consumer<LocationSelectionViewModel>(
              builder: (_, model, ___) {
                final favorites = model.getFavorites(widget.locationType);
                if (favorites.length == 0) return SliverToBoxAdapter();

                return CityPlacesStickyHeader(
                  label: 'Your Favorites',
                  labelStyle: TextStyle(
                    color: kAccentColor,
                  ),
                  headerPadding: const EdgeInsets.only(left: 24.0, right: 6.0),
                  trailing: AnimatedOpacity(
                    opacity: favorites.length > _initialFavoritesVisible ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: _buildFavoritesHeaderTrailing() 
                  ),
                  child: SliverPadding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    sliver: PlaceList(
                      locationType: widget.locationType,
                      items: _isFavoritesHeaderExpanded ? favorites : favorites.take(3).toList(),
                      onTap: (Place place) => widget.homeViewModel.setLocation(
                        context: context, 
                        locationType: widget.locationType, 
                        place: place
                      ),
                      onLongPress: (Place place) => model.onFavoriteLongPress(
                        context: context, 
                        locationType: widget.locationType, 
                        place: place
                      ),
                    ),
                  ),
                );
              }
            ),
           
            // if (_locationSelectionViewModel.getFavorites(widget.locationType).length > 0) 
            // SliverPadding(
            //   padding: const EdgeInsets.only(top: 6.0, bottom: 12.0),
            //   sliver: SliverToBoxAdapter(
            //     child: Container(
            //       height: 6.0,
            //       color: Colors.grey.withOpacity(0.35)
            //     ),
            //   ),
            // ),

            for (CityPlaces cityPlace in _cityPlaces) 
            CityPlacesStickyHeader(
              label: cityPlace.city.name,
              labelStyle: TextStyle(
                color: Colors.white
              ),
              headerBackground: kPrimaryColor,
              child: SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                sliver: PlaceList(
                  locationType: widget.locationType,
                  items: cityPlace.places,
                  onTap: (Place place) => widget.homeViewModel.setLocation(
                    context: context, 
                    locationType: widget.locationType, 
                    place: place
                  ),
                  hasTrailing: true,
                  onTrailingTap: (Place place) => _locationSelectionViewModel.toggleFavorites(
                    context: context,
                    locationType: widget.locationType,
                    place: place
                  )
                ),
              )
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildFavoritesHeaderTrailing() {
    return Material(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(
          child: child,
          scale: animation,
        ),
        child: _FavoritesToggleIcon(
          key: ValueKey<int>(_isFavoritesHeaderExpanded ? 1 : 0),
          isExpanded: _isFavoritesHeaderExpanded,
          onPressed: _onToggleFavoritesHeader
        ),
      )
    );
  }

  void _onToggleFavoritesHeader() {
    setState(() => _isFavoritesHeaderExpanded = !_isFavoritesHeaderExpanded);
  }

}


class _FavoritesToggleIcon extends StatelessWidget {
  const _FavoritesToggleIcon({
    Key key,
    @required this.isExpanded,
    @required this.onPressed
  }) : super(key: key);

  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String label = 'See more';
    if (isExpanded) label = 'See less';

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.subtitle),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: isExpanded
                ? Icon(EvaIcons.arrowIosUpward)
                : Icon(EvaIcons.arrowIosDownward),
            ),
          ],
        ),
      )
    );
  }
}