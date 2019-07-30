import 'package:flutter/material.dart';

const double kMaxWidth = 520;
const Color kPrimaryColor = Colors.deepOrange;
const Color kAccentColor = Colors.orange;
// const Color kPrimaryColor = Colors.orange;
// const Color kAccentColor = Colors.deepOrange;

final Color kGreyColor = Colors.grey[400];

final kCoreFontFamily = 'GoogleSans';

ThemeData kMaterialTheme = ThemeData(
  primarySwatch: kPrimaryColor,
  accentColor: kAccentColor,
  canvasColor: Colors.white,
  fontFamily: kCoreFontFamily,
  hintColor: kGreyColor,
  cursorColor: kAccentColor,
  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.black87
    ),
    button: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3,
      color: Colors.white
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.black87,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black87
      ),
    )
  ),
  buttonTheme: ButtonThemeData(
    height: 44,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
    ),
  )
);