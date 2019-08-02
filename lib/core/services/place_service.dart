// Mock
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';

class PlaceService {
  final List<CityPlaces> origins =[
    CityPlaces(
      city: City(
        id: 'c1',
        name: 'Muntinlupa'
      ),
      places: <Place>[
        Place(
          name: 'Alabang Town Center'
        ),
        Place(
          name: 'MMDA Organized Bus Terminal'
        ),
        Place(
          name: 'South Station Transport Terminal'
        ),
        Place(
          name: 'Origin 1'
        ),
        Place(
          name: 'Origin 2'
        ),
        Place(
          name: 'Origin 3'
        ),
        Place(
          name: 'Origin 4'
        ),
        Place(
          name: 'Origin 5'
        ),
        Place(
          name: 'Origin 6'
        ),
      ]
    ),
    CityPlaces(
      city: City(
        id: 'c2',
        name: 'Antipolo'
      ),
      places: <Place>[
        Place(
          name: 'Antipolo Triangle Mall'
        ),
        Place(
          name: 'MMDA Organized Bus Terminal'
        ),
        Place(
          name: 'South Station Transport Terminal'
        ),
      ]
    ),
    CityPlaces(
      city: City(
        id: 'c3',
        name: 'Dummy Data'
      ),
      places: <Place>[
        Place(
          name: 'Lorem Ipsum'
        ),
        Place(
          name: 'Lorem Ipsum 1'
        ),
        Place(
          name: 'Lorem Ipsum 2'
        ),
        Place(
          name: 'Lorem Ipsum 3'
        ),
        Place(
          name: 'Lorem Ipsum 4'
        ),
        Place(
          name: 'Lorem Ipsum 5'
        ),
      ]
    )
  ];

  final List<CityPlaces> destinations =[
    CityPlaces(
      city: City(
        id: 'p1',
        name: 'Pasig'
      ),
      places: <Place>[
        Place(
          name: 'Ayala Malls the 30th'
        ),
        Place(
          name: 'Destination 1'
        ),
        Place(
          name: 'Destination 2'
        ),
      ]
    ),
    CityPlaces(
      city: City(
        id: 'dw2',
        name: 'Makati'
      ),
      places: <Place>[
        Place(
          name: 'Greenbelt 1'
        ),
        Place(
          name: 'Greenbelt 5'
        ),
        Place(
          name: 'Makati CBD'
        ),
      ]
    )
  ];

}