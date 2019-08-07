import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/bus.dart';

// Mock
class BusService {

  Future<List<BusSchedule>> getBusSchedules() {
    final schedules = [
      BusSchedule(
        id: 'bs1',
        bus: Bus(
          seatCapacity: 61,
          busCompany: BusCompany(
            id: 'bc1',
            name: 'HM Transport'
          ),
        ),
        amenities: [
          Amenity(name: 'Wi-Fi'),
          Amenity(name: 'Restroom'),
          Amenity(name: 'Comfortable Seats'),
        ],
        baseFare: 120,
        availableSeats: 24,
        departureTime: '5:30 AM',
        arrivalTime: '7:30 AM'
      ),
      BusSchedule(
        id: 'bs2',
        bus: Bus(
          seatCapacity: 66,
          busCompany: BusCompany(
            id: 'bc2',
            name: 'RRCG Transport'
          ),
        ),
        amenities: [
          Amenity(name: 'Wi-Fi'),
          Amenity(name: 'Comfortable Seats'),
        ],
        baseFare: 100,
        availableSeats: 50,
        departureTime: '6:00 AM',
        arrivalTime: '8:00 AM'
      ),
      BusSchedule(
        id: 'bs3',
        bus: Bus(
          seatCapacity: 56,
          busCompany: BusCompany(
            id: 'bc3',
            name: 'RRCG Transport'
          ),
        ),
        baseFare: 90,
        availableSeats: 23,
        departureTime: '7:00 AM',
        arrivalTime: '9:00 AM'
      )
    ];

    return Future.delayed(Duration(seconds: 1), () => schedules);
  }

}