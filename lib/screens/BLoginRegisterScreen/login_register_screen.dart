import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  static String id = 'LoginRegisterScreen ID';
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
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
              //TODO: Add Banner
              // Find Illustrations https://undraw.co/illustrations

              //TODO: Add Login Button

              //TODO: Add Register Button
            ],
          ),
        ),
      ),
    );
  }
}
