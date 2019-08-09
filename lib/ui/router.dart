import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/viewmodels/create_account_model.dart';
import 'package:bus_booking/ui/views/bus_selection/bus_selection_view.dart';
import 'package:bus_booking/ui/views/seat_selection/seat_selection_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bus_booking/ui/views/entry/entry_view.dart';
import 'package:bus_booking/ui/views/create_account/create_account_view.dart';
import 'package:bus_booking/ui/views/create_account/create_account_success_view.dart';
import 'package:bus_booking/ui/views/location_selection/location_selection_view.dart';
import 'package:bus_booking/ui/views/main/main_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => EntryView());
      case '/create-account':
        return CupertinoPageRoute(builder: (_) => CreateAccountView());
      case '/create-account-success':
        final CreateAccountModel model = settings.arguments as CreateAccountModel;
        return CupertinoPageRoute(builder: (_) => CreateAccountSuccessView(
          model: model,
        ));
      case '/main':
        return CupertinoPageRoute(
          builder: (_) => MainView(), 
          settings: settings
        );
      case '/location-selection':
        final arguments = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(builder: (_) => LocationSelectionView(
          homeViewModel: arguments['homeViewModel'],
          title: arguments['title'],
          locationType: arguments['locationType']
        ));

      case '/bus-selection':
        final arguments = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(builder: (_) => BusSelectionView(
          homeViewModel: arguments['homeViewModel'],
        ));

      case '/seat-selection':
        final busSchedule = settings.arguments as BusSchedule;
        return CupertinoPageRoute(builder: (_) => SeatSelectionView(
          busSchedule: busSchedule
        ));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
        });
    }
  }
}