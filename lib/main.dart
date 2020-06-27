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
      home: SplashScreen(),
      initialRoute: LoginRegisterScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginRegisterScreen.id: (context) => LoginRegisterScreen(),
      },
    );
  }
}
