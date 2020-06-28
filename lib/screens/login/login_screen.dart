import 'package:RouteMap/screens/home/home_screen.dart';
import 'package:RouteMap/screens/login/register_screen.dart';
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

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen ID';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _smallPadding = 8.0,
      _defaultPadding = 16.0,
      _bigPadding = 26.0,
      _largePadding = 50,
      _containerCornerRadius = 100,
      _signUpButtonSize = 90;
  bool setObscure = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void checkLogin() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLogin();

    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      left: _largePadding,
                      right: _largePadding,
                      bottom: _largePadding + 20,
                      top: _largePadding + 30),
                  child: Text(
                    "Log In",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  )),

              // The white Container for Email, Password fields & Create button
              Container(
                height: deviceHeight - 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_containerCornerRadius)),
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
                      padding: EdgeInsets.only(
                          left: _bigPadding, right: _bigPadding),
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
                    const SizedBox(height: 80),
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
                      onPressed: signIn,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),

                    // "Don't have an account? SignUp" Text
                    new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'Don\'t have an Account? Sign Up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> signIn() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
