import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool setObscure = true;

  @override
  Widget build(BuildContext context) {
    //Colors for gradient from Theme and height
    double deviceHeight = MediaQuery.of(context).size.height;

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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: largePadding,
                  right: largePadding,
                  bottom: 80,
                  top: bigPadding),
              child: Text(
                "Sign Up.",
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(140)),
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
                    obscureText: setObscure,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: 'Password',
                      suffixIcon: FlatButton(
                        onPressed: () {
                          setState(() {
                            setObscure = !setObscure;
                          });
                        },
                        child: Icon(setObscure
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye),
                      ),
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
                  onPressed: () {
                    //TODO: Register Code
                  },
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
        ],
      ),
    );
  }
}
