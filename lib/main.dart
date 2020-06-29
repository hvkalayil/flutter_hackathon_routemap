import 'package:RouteMap/screens/home/home_screen.dart';
import 'package:RouteMap/screens/login//register_screen.dart';
import 'package:RouteMap/screens/login/login_screen.dart';
import 'package:RouteMap/screens/new_trip.dart';
import 'package:RouteMap/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import 'Theme/theme.dart';
import 'screens/login/login_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Route Map',
      theme: lightTheme,
      home: LoginScreen(),
      initialRoute: LoginScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        NewTrip.id: (context) => NewTrip(),
      },
    );
  }
}
