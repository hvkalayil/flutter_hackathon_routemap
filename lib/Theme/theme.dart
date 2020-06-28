import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff89C9B8),
  primaryColorLight: Color(0xffB1E0C4),
  primaryColorDark: Color(0xff6BD8C1),
  accentColor: Color(0xff9b73ec),
  textTheme: TextTheme(
    headline1: TextStyle(
        fontFamily: 'QuickSand',
        letterSpacing: 1.5,
        fontSize: 28,
        color: Color(0xff092531),
        fontWeight: FontWeight.w900),
    headline2: TextStyle(
        fontFamily: 'QuickSand',
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600),
    headline3: TextStyle(
      fontFamily: 'QuickSand',
      fontSize: 20,
      color: Color(0xff092531),
    ),
    headline4: TextStyle(
      fontFamily: 'QuickSand',
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);
