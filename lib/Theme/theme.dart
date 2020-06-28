import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff00c389),
  secondaryHeaderColor: Colors.white,
  accentColor: Color(0xff092531),
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline1: TextStyle(
        letterSpacing: 1.5,
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.w900),
    headline2: TextStyle(
        fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
    headline3: TextStyle(
      fontSize: 20,
      color: Color(0xff00c389),
    ),
    headline4: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
  ),
);
