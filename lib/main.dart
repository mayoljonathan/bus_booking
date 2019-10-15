import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:bus_booking/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bus_booking/locator.dart';
import 'package:bus_booking/core/config/constants.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  return runApp(BusBookingApp());
}

class BusBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (ctx) {
        var userModel = UserModel();
        userModel.currentUser.displayName = DISPLAY_NAME;
        userModel.currentUser.emailAddress = EMAIL_ADDRESS;
        userModel.currentUser.mobileNumber = MOBILE_NUMBER;

        return userModel;
      },
      child: MaterialApp(
        theme: kMaterialTheme,
        title: APP_NAME,
        // initialRoute: '/',
        initialRoute: '/main',
        onGenerateRoute: Router.generateRoute,
        showPerformanceOverlay: false,
      ),
    );
  }
}