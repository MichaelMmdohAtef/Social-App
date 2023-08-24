import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTeme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.4,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 1.4,
    ),
    caption: TextStyle(
      color: Colors.black,
      height: 1.4,
    ),
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 30,
  ),
);

ThemeData darkTheme = ThemeData(

  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Color(0xff333739),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Color(0xff333739)),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.4,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 1.4,
    ),
    caption: TextStyle(
      color: Colors.white,
      height: 1.4,
    ),
  ),
  scaffoldBackgroundColor: Color(0xff333739),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: Color(0xff333739),
  ),
);
