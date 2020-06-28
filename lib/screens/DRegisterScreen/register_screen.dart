import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final backgroundColor = Color(0xff00c389);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backgroundColor,
    statusBarColor: backgroundColor,
  ));
}

class RegisterScreen extends StatefulWidget {
  static String id = '_RegisterScreen ID';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double smallPadding = 8.0;
  double defaultPadding = 16.0;
  double bigPadding = 26.0;
  double largePadding = 50;
  double containerCornerRadius = 40;
  double signUpButtonSize = 90;

  @override
  Widget build(BuildContext context) {
    //Colors for gradient from Theme and height
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final light = Theme.of(context).primaryColorLight;
    final dark = Theme.of(context).primaryColorDark;
    final accent = Theme.of(context).accentColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(smallPadding),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: largePadding, right: largePadding, bottom: 80, top: bigPadding),
              child: Text(
                "Sign Up",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              )),

          // The white Container for Email, Password fields & Create button
          Container(
            height: deviceHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(140)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                // Email
                Padding(
                  padding: EdgeInsets.only(
                      top: 100,
                      left: bigPadding,
                      right: bigPadding,
                      bottom: bigPadding),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                ),

                // Password
                Padding(
                  padding: EdgeInsets.only(left: bigPadding, right: bigPadding),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: 'Password',
                    ),
                  ),
                ),

                // Sign Up Button
                const SizedBox(height: 120),
                RaisedButton(
                  padding: EdgeInsets.only(
                      left: signUpButtonSize,
                      right: signUpButtonSize,
                      top: defaultPadding,
                      bottom: defaultPadding),
                  color: Color(0xff55ce9e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Create',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          )

          //TODO: TRY Add SIGN UP WITH GOOGLE
        ],
      ),
    );
  }
}
