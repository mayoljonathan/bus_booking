// Mock
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/enums/location_type.dart';


class FavoriteService {

  final Map<LocationType, List<Place>> favorites = {
    LocationType.ORIGIN: [
      Place(
        id: 'atc',
        name: 'Alabang Town Center',
      ),
      Place(
        id: 'atm',
        name: 'Antipolo Triangle Mall',
      ),
    ],
    LocationType.DESTINATION: [
      Place(
        id: 'amt3',
        name: 'Ayala Malls The 30th',
      ),
    ]
  };

  // final List<Place> favoriteOrigins = [
  //   Place(
  //     id: 'atc',
  //     name: 'Alabang Town Center',
  //   ),
  //   Place(
  //     id: 'ac',
  //     name: 'Araneta Center',
  //   ),
  // ];

  // final List<Place> favoriteDestinations = [
  //   Place(
  //     id: 'amt3',
  //     name: 'Ayala Malls The 30th',
  //   ),
  // ];


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