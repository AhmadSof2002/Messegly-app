import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messegly/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('121212'),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        backgroundColor: HexColor('121212'),
        elevation: 0.0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: HexColor('121212')),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('121212'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amberAccent,
        elevation: 20.0),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600),
        subtitle1: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            height: 1.3)),
    fontFamily: 'Jannah');
ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        iconTheme: IconThemeData(color: Colors.black),
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold)),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HexColor('#2E4C6D'),
        elevation: 20.0,
        backgroundColor: Colors.white),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
        subtitle1: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            height: 1.3)),
    fontFamily: 'Jannah');
