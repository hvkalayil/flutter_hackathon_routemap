import 'package:RouteMap/screens/CLoginScreen/login_screen.dart';
import 'package:RouteMap/screens/DRegisterScreen/register_screen.dart';
import 'package:RouteMap/screens/EHomeScreen/home_screen.dart';
import 'package:RouteMap/screens/FSettingsScreen/settings_screen.dart';
import 'package:RouteMap/screens/GNewTrip/new_trip.dart';
import 'package:flutter/material.dart';

import 'Theme/theme.dart';
import 'screens/ASplashScreen/splash_screen.dart';
import 'screens/BLoginRegisterScreen/login_register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Route Map',
      theme: lightTheme,
      home: HomeScreen(),
      initialRoute: HomeScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginRegisterScreen.id: (context) => LoginRegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        NewTrip.id: (context) => NewTrip(),
      },
    );
  }
}
