import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/booking_dto.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // Number of max seats a user can choose
  int maxSeats = 10;

  void setTripDate(DateTime dateTime) {
    bookingDto.date = dateTime;
    notifyListeners();
  }

  void setLocation(LocationType type, Place place) {
    switch (type) {
      case LocationType.ORIGIN:
        bookingDto.origin = place;
        break;
      case LocationType.DESTINATION:
        bookingDto.destination = place;
        break;
    }

    notifyListeners();
  }

  // Not used
  void setNumberOfSeat(int number) {
    bookingDto.numberOfSeats = number;
    notifyListeners();
  }

  void onFieldItemTap(context, bool isOrigin) {
    Navigator.pushNamed(context, '/location-selection',
      arguments: {
        "title": isOrigin ? 'Select Origin' : 'Select Destination',
        "locationType": isOrigin ? LocationType.ORIGIN : LocationType.DESTINATION
      },
    );
  }

  void onFindBusTap(context) async {
    if (bookingDto.origin == null || bookingDto.destination == null) {
      String errorMessage;
      if (bookingDto.origin == null) {
        errorMessage = 'Please select an origin';
      } else if (bookingDto.destination == null) {
        errorMessage = 'Please select your destination';
      }

      final snackBar = SnackBar(
        content: Text(errorMessage, style: Theme.of(context).textTheme.body1.copyWith(
          color: Colors.white,
        )),
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ),
        behavior: SnackBarBehavior.floating,
      );

      scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    }

    // TODO
    print('navigate');

  }

}