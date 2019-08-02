import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/services/favorite_service.dart';
import 'package:bus_booking/core/services/place_service.dart';
import 'package:bus_booking/locator.dart';
import 'package:flutter/material.dart';

class LocationSelectionViewModel extends ChangeNotifier {
  FavoriteService _favoriteService = locator<FavoriteService>();
  PlaceService _placeService = locator<PlaceService>();

  List<Place> getFavorites(LocationType type) {
    switch(type) {
      case LocationType.ORIGIN:
        return _favoriteService.favoriteOrigins;
        break;
      case LocationType.DESTINATION:
        return _favoriteService.favoriteDestinations;
        break;
    }
    return [];
  }

  List<CityPlaces> getCityWithPlaces(LocationType type) {
    switch(type) {
      case LocationType.ORIGIN:
        return _placeService.origins;
        break;
      case LocationType.DESTINATION:
        return _placeService.destinations;
        break;
    }
    return [];
  }
}