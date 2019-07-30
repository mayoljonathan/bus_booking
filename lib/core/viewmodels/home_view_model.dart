import 'package:bus_booking/core/models/booking_dto.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/models/user.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:bus_booking/locator.dart';

class HomeViewModel extends BaseModel {

  DateTime _today = DateTime.now();

  HomeViewModel() {
    bookingDto = BookingDto(
      date: DateTime(_today.year, _today.month, _today.day),
      origin: null,
      destination: null,
      numberOfSeats: 1
    );
  }

  BookingDto bookingDto;

  // Number of max seats a user can choose
  int maxSeats = 10;

  void setTripDate(DateTime dateTime) {
    bookingDto.date = dateTime;
    notifyListeners();
  }

  void setNumberOfSeat(int number) {
    bookingDto.numberOfSeats = number;
    notifyListeners();
  }

  void onFindBusTap() {
    
  }

}