import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../DRegisterScreen/register_screen.dart';

final backgroundColor = Color(0xff00c389);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backgroundColor,
    statusBarColor: backgroundColor,
  ));
}

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen ID';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double smallPadding = 8.0;
  double defaultPadding = 16.0;
  double bigPadding = 26.0;
  double largePadding = 50;
  double containerCornerRadius = 40;
  double signUpButtonSize = 90;
  bool setObscure = true;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: largePadding,
                  right: largePadding,
                  bottom: 80,
                  top: bigPadding + 80),
              child: Text(
                "Log In.",
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(140)),
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
                const SizedBox(height: 100),
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
                    //TODO: Login Code
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text('Don\'t have an Account?')),
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
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child: const Text(
                    'Sign Up',
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
