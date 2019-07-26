import 'package:bus_booking/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bus_booking/locator.dart';
import 'package:bus_booking/core/config/constants.dart';
import 'package:bus_booking/ui/shared/theme.dart';

void main() async {
  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  return runApp(BusBookingApp());
}

class BusBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kMaterialTheme,
      title: APP_NAME,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
      showPerformanceOverlay: false,
    );
  }
}