import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff89C9B8),
  primaryColorLight: Color(0xffB1E0C4),
  primaryColorDark: Color(0xff6BD8C1),
    accentColor: Color(0xff9b73ec),
    fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline1: TextStyle(
        letterSpacing: 1.5,
        fontSize: 28,
        color: Color(0xff092531),
        fontWeight: FontWeight.w900),
    headline2: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600),
    headline3: TextStyle(
      fontSize: 20,
      color: Color(0xff092531),
    ),
    headline4: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);
