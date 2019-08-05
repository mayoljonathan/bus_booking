import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/helpers/ui_helper.dart';
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/services/favorite_service.dart';
import 'package:bus_booking/core/services/place_service.dart';
import 'package:bus_booking/locator.dart';
import 'package:flutter/material.dart';

class LocationSelectionViewModel extends ChangeNotifier {
  FavoriteService _favoriteService = locator<FavoriteService>();
  PlaceService _placeService = locator<PlaceService>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Place> getFavorites(LocationType type) {
    return _favoriteService.favorites[type];
  }

  List<CityPlaces> getCityWithPlaces(LocationType type) {
    return _placeService.places[type];
  }

  void toggleFavorites({BuildContext context, LocationType locationType, Place place}) {
    String message = 'Added to favorites';
    if (!isFavorited(locationType: locationType, place: place)) {
      _favoriteService.favorites[locationType].add(place);
    } else {
      message = 'Removed from favorites';
      _favoriteService.favorites[locationType].removeWhere((Place _place) => _place.id == place.id);
    }
    notifyListeners();

    final snackBar = SnackBar(
      content: Text(message, style: Theme.of(context).textTheme.body1.copyWith(
        color: Colors.white,
      )),
      duration: Duration(seconds: 2),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(12.0)
      // ),
      // behavior: SnackBarBehavior.floating,
    );

    scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  bool isFavorited({LocationType locationType, Place place}) {
    return _favoriteService.favorites[locationType].indexWhere((Place _place) => _place.id == place.id) != -1;
  }

  void onFavoriteLongPress({BuildContext context, LocationType locationType, Place place}) {
    showConfirmDialog(
      context: context,
      title: 'Remove from Favorites?',
      message: 'Do you want to remove ${place.name} from your favorites?',
      cancelText: 'Cancel',
      confirmText: 'Remove',
      isConfirmButtonEmphasized: true,
      onConfirm: () => toggleFavorites(
        context: context, 
        locationType: locationType, 
        place: place
      )
    );
  }
}