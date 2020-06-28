import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final backgroundColor = Color(0xff00c389);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backgroundColor,
    statusBarColor: backgroundColor,
  ));
}

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen ID';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//TODO: Redirect users to LoginRegister or HomeScreen
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
