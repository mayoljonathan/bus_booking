import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/bus.dart';

// Mock
class BusService {

  Future<List<BusSchedule>> getBusSchedules() {
    final schedules = [
      BusSchedule(
        id: 'bs1',
        bus: Bus(
          seatCapacity: 60,
          company: BusCompany(
            id: 'bc1',
            name: 'HM Transport'
          ),
        ),
        amenities: [
          Amenity(id: 'wifi', name: 'Wi-Fi'),
          Amenity(id: 'rr', name: 'Restroom'),
        ],
        baseFare: 120,
        availableSeats: 24,
        departureTime: '5:30 AM',
        arrivalTime: '7:30 AM'
      ),
      BusSchedule(
        id: 'bs2',
        bus: Bus(
          seatCapacity: 65,
          company: BusCompany(
            id: 'bc2',
            name: 'RRCG Transport'
          ),
        ),
        amenities: [
          Amenity(id: 'ac', name: 'A/C'),
          Amenity(id: 'wifi', name: 'Wi-Fi'),
          Amenity(id: 'cs', name: 'Comfortable Seats'),
        ],
        baseFare: 100,
        availableSeats: 50,
        departureTime: '6:00 AM',
        arrivalTime: '8:00 AM'
      ),
      BusSchedule(
        id: 'bs3',
        bus: Bus(
          seatCapacity: 55,
          company: BusCompany(
            id: 'bc3',
            name: 'RRCG Transport'
          ),
        ),
        baseFare: 90,
        availableSeats: 23,
        departureTime: '7:00 AM',
        arrivalTime: '9:00 AM',
        amenities: []
      ),
      BusSchedule(
        id: 'bs4',
        bus: Bus(
          seatCapacity: 55,
          company: BusCompany(
            id: 'bc3',
            name: 'RRCG Transport'
          ),
        ),
        baseFare: 90,
        availableSeats: 23,
        departureTime: '7:00 AM',
        arrivalTime: '9:00 AM',
        amenities: [
          Amenity(id: 'ac', name: 'A/C'),
        ]
      )
    ];

    return Future.delayed(Duration(seconds: 1), () => schedules);
  }

}