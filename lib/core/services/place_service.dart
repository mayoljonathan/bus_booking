// Mock
import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/city.dart';
import 'package:bus_booking/core/models/place.dart';

class PlaceService {

  final Map<LocationType, List<CityPlaces>> places = {
    LocationType.ORIGIN: [
      CityPlaces(
        city: City(
          id: 'c1',
          name: 'Muntinlupa'
        ),
        places: <Place>[
          Place(
            id: 'atc',
            name: 'Alabang Town Center'
          ),
          Place(
            id: 'mmdao',
            name: 'MMDA Organized Bus Terminal'
          ),
          Place(
            id: 'sstt',
            name: 'South Station Transport Terminal'
          ),
          Place(
            id: 'o1',
            name: 'Origin 1'
          ),
          Place(
            id: 'o2',
            name: 'Origin 2'
          ),
          Place(
            id: 'o3',
            name: 'Origin 3'
          ),
          Place(
            id: 'o4',
            name: 'Origin 4'
          ),
          Place(
            id: 'o5',
            name: 'Origin 5'
          ),
          Place(
            id: 'o6',
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
            id: 'atm',
            name: 'Antipolo Triangle Mall'
          ),
          Place(
            id: 'mmdaobt',
            name: 'MMDA Organized Bus Terminal'
          ),
          Place(
            id: 'sstt',
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
            id: 'li',
            name: 'Lorem Ipsum'
          ),
          Place(
            id: 'li1',
            name: 'Lorem Ipsum 1'
          ),
          Place(
            id: 'li2',
            name: 'Lorem Ipsum 2'
          ),
          Place(
            id: 'li3',
            name: 'Lorem Ipsum 3'
          ),
          Place(
            id: 'li4',
            name: 'Lorem Ipsum 4'
          ),
          Place(
            id: 'li5',
            name: 'Lorem Ipsum 5'
          ),
        ]
      )
    ],
    LocationType.DESTINATION: [
      CityPlaces(
        city: City(
          id: 'p1',
          name: 'Pasig'
        ),
        places: <Place>[
          Place(
            id: 'amt3',
            name: 'Ayala Malls the 30th'
          ),
          Place(
            id: 'd1',
            name: 'Destination 1'
          ),
          Place(
            id: 'd2',
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
            id: 'g1',
            name: 'Greenbelt 1'
          ),
          Place(
            id: 'g5',
            name: 'Greenbelt 5'
          ),
          Place(
            id: 'mcbd',
            name: 'Makati CBD'
          ),
        ]
      )
    ]
  };

}