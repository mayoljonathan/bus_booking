import 'package:bus_booking/core/enums/location_type.dart';
import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/booking_dto.dart';
import 'package:bus_booking/core/models/place.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class BusSelectionViewModel extends BaseModel {

  BusSelectionViewModel() {

  }

  List<Amenity> _filteredAmenities = [];

  bool isSelectedAmenity(Amenity amenity) {
    return _filteredAmenities.indexWhere((Amenity _amenity) => _amenity.id == amenity.id) != -1;
  }

  void toggleAmenity(Amenity amenity) {
    if (!isSelectedAmenity(amenity)) {
      _filteredAmenities.add(amenity);
    } else {
      _filteredAmenities.removeWhere((Amenity _amenity) => _amenity.id == amenity.id);
    }
    notifyListeners();
  }

}