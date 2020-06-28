import 'package:flutter/gestures.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' UserName',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),

                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text("Forgot Password?"),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: FlatButton(
                        color: Colors.white,
                        textColor: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(6.0)),
                        splashColor: Colors.blueAccent,
                        onPressed: () {},
                        child: Text(
                          "LOGIN",
                        ),
                      ),
                    ),
                  ),
                  Text("Login With"),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          height: 60,
                          child: FlatButton(
                            color: Colors.blue[900],
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(6.0)),
                            splashColor: Colors.blueAccent,
                            onPressed: () {},
                            child: Text(
                              "FACEBOOK",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          height: 60,
                          child: FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(6.0)),
                            splashColor: Colors.blueAccent,
                            onPressed: () {},
                            child: Text(
                              "GOOGLE",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign up',
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {},
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )

                  //TODO: Add mail id

                  //TODO: Add Password

                  //TODO: Add Login Button

                  //TODO: TRY Add LOG IN WITH GOOGLE
                ],
              ),
            )),
      ),
    );
  }
}
