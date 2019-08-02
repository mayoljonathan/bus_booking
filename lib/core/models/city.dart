import 'package:bus_booking/core/models/place.dart';

class City {
  String id;
  String name;

  City({
    this.id,
    this.name,
  });
}

class CityPlaces {
  City city;
  List<Place> places;

  CityPlaces({
    this.city,
    this.places
  });
}