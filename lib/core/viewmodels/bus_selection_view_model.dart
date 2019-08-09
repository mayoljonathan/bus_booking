import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/services/bus_service.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class BusSelectionViewModel extends BaseModel {

  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>(debugLabel: 'BusSelectionViewModel');
  final ScrollController scrollController = ScrollController();

  /// List of amenities that has been filtered/selected
  List<Amenity> _filteredAmenities = [];

  List<Amenity> getAvailableFilterAmenities() {
    List<Amenity> _amenityFilters = [];
    _$busSchedules.forEach((BusSchedule schedule) {
      schedule.amenities.forEach((Amenity amenity) {
        if (_amenityFilters.indexWhere((Amenity fAmenity) => fAmenity.id == amenity.id) == -1) {
          _amenityFilters.add(amenity);
        }
      });
    });
    return _amenityFilters;
  }

  bool isSelectedAmenity(Amenity amenity) {
    return _filteredAmenities.indexWhere((Amenity _amenity) => _amenity.id == amenity.id) != -1;
  }

  void toggleAmenity(Amenity amenity) {
    if (!isSelectedAmenity(amenity)) {
      _filteredAmenities.add(amenity);
    } else {
      _filteredAmenities.removeWhere((Amenity _amenity) => _amenity.id == amenity.id);
    }
    onFilterBusSchedules();
    notifyListeners();
  }

  // All bus schedules, should be immutable!
  List<BusSchedule> _$busSchedules = [];

  // Current list of bus schedules whether has filter or not
  List<BusSchedule> _busSchedules = [];
  List<BusSchedule> get busSchedules => _busSchedules;
  set busSchedules(List<BusSchedule> busSchedules) {
    _busSchedules = busSchedules;
    notifyListeners();
  }

  // Bus schedules but filtered by amenities, etc.
  List<BusSchedule> _filteredBusSchedules = [];
  List<BusSchedule> get filteredBusSchedules => _filteredBusSchedules;
  set filteredBusSchedules(List<BusSchedule> filteredBusSchedules) {
    _filteredBusSchedules = filteredBusSchedules;
    notifyListeners();
  }

  void onFilterBusSchedules() {
    _busSchedules = _$busSchedules;

    if (_filteredAmenities.length > 0) {
      List<BusSchedule> filteredSchedules = _busSchedules.where((BusSchedule schedule) {
        return _filteredAmenities.every((Amenity fAmenity) {
          return schedule.amenities.any((Amenity bAmenity) {
            return bAmenity.id == fAmenity.id;
          });
        });
      }).toList();
      _busSchedules = filteredSchedules;
      return;
    }
  }

  void getBusSchedules() async {
    print('[getBusSchedules]');
    setViewState(ViewState.BUSY);
    try {
      _$busSchedules = await BusService().getBusSchedules();
      _busSchedules = List.from(_$busSchedules);
      setViewState(ViewState.IDLE);
    } catch (e) {
      setViewState(ViewState.IDLE);
      print(e);
      print('[getBusSchedules]: Error in model: $e');
    }
  }

  void onBusScheduleTap(BuildContext context, BusSchedule busSchedule) {
    Navigator.pushNamed(context, '/seat-selection', arguments: busSchedule);
  }

}