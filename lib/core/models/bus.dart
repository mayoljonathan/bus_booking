import 'amenity.dart';

class Bus {
  BusCompany busCompany;
  int seatCapacity; //including driver's seat

  Bus({
    this.busCompany,
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

class BusSchedule {
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
}