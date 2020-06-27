import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen ID';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //Colors for gradient from Theme and height
    double deviceHeight = MediaQuery.of(context).size.height;
    final light = Theme.of(context).primaryColorLight;
    final dark = Theme.of(context).primaryColorDark;
    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          decoration:
              BoxDecoration(gradient: RadialGradient(colors: [light, dark])),
          child: Column(
            children: [
              //TODO: Add mail id

              //TODO: Add Password

              //TODO: Add Login Button

              //TODO: Add LOG IN WITH GOOGLE
            ],
          ),
        ),
      ),
    );
  }
}
