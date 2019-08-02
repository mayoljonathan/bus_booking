// Mock
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/models/route.dart';

class FavoriteService {
  final List<Place> favoriteOrigins = [
    Place(
      name: 'Alabang Town Center',
    ),
    Place(
      name: 'Araneta Center',
    ),
  ];

  final List<Place> favoriteDestinations = [
    Place(
      name: 'Ayala Malls The 30th',
    ),
  ];


  // final List<Route> favorites = [
  //   Route(
  //     origin: Place(
  //       name: 'Alabang Town Center',
  //     ),
  //     destination: Place(
  //       name: 'Ayala Malls The 30th'
  //     )
  //   ),
  //   Route(
  //     origin: Place(
  //       name: 'Araneta Center',
  //     ),
  //   ),
  // ];

}