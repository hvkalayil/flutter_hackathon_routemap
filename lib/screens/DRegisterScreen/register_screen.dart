import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String id = '_RegisterScreen ID';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              //TODO: Add Profile Image

              //TODO: Add mail id (required)

              //TODO: Add Password(required)

              //TODO: Add Sign up Button

              //TODO: TRY Add SIGN UP WITH GOOGLE
            ],
          ),
        ),
      ),
    );
  }
}
