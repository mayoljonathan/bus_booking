import 'amenity.dart';
import 'money.dart';

class Bus {
  BusCompany company;
  int seatCapacity;

  Bus({
    this.company,
    this.seatCapacity
  });
}

class BusCompany {
  String id;
  String name;

  BusCompany({
    this.id,
    this.name
  });
}

class BusSchedule extends Money {
  String id;
  Bus bus;
  List<Amenity> amenities;
  double baseFare;
  int availableSeats;
  String departureTime;
  String arrivalTime;

  BusSchedule({
    this.id,
    this.bus,
    this.amenities,
    this.baseFare,
    this.availableSeats,
    this.departureTime,
    this.arrivalTime
  });

  @override
  double get amount => baseFare;

  String seatsAvailableToString() {
    String noun = 'seat';
    if (availableSeats > 1) noun += 's';
    return '$availableSeats $noun available';
  }
}