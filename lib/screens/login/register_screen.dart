import 'package:RouteMap/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  double _smallPadding = 8.0,
      _defaultPadding = 16.0,
      _bigPadding = 26.0,
      _largePadding = 50,
      _signUpButtonSize = 90,
      _containerCornerRadius = 140;
  bool setObscure = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Colors for gradient from Theme and height
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_smallPadding),
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
                    left: _largePadding,
                    right: _largePadding,
                    bottom: 80,
                    top: _bigPadding),
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
                    topRight: Radius.circular(_containerCornerRadius)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  // Email
                  Padding(
                    padding: EdgeInsets.only(
                        top: 100,
                        left: _bigPadding,
                        right: _bigPadding,
                        bottom: _bigPadding),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return "Email cannot be empty";
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                  ),

                  // Password
                  Padding(
                    padding:
                        EdgeInsets.only(left: _bigPadding, right: _bigPadding),
                    child: TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return "Password must be atleast 6 characters long";
                        }
                      },
                      onSaved: (input) => _password = input,
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
                        left: _signUpButtonSize,
                        right: _signUpButtonSize,
                        top: _defaultPadding,
                        bottom: _defaultPadding),
                    color: Color(0xff55ce9e),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    onPressed: signUp,
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
      ),
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
      } catch(e) {
        print(e.message);
      }
    }
  }
}
