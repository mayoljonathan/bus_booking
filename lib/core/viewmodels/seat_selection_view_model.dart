import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/services/bus_service.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:bus_booking/ui/views/seat_selection/bus_information.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:flutter/material.dart';

class SeatSelectionViewModel extends BaseModel {

  void onBusInfoTap(BuildContext context, BusSchedule busSchedule) {
    Navigator.of(context).push(ScaleSizeRoute(
      curve: Curves.easeOut,
      builder: (context) => BusInformation(
        busSchedule: busSchedule,
      ),
    ));
  }

  void getSeatsData() {
    print('hey seats data');
  }
}