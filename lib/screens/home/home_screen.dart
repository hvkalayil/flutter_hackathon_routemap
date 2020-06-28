import 'package:RouteMap/screens/new_trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'drawer_menu.dart';
import 'topbar.dart';

final backgroundColor = Color(0xff00c389);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backgroundColor,
    statusBarColor: backgroundColor,
  ));
}

class HomeScreen extends StatefulWidget {
  static String id = 'HomeSCreen ID';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Colors and height
    final accent = Theme.of(context).accentColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: BuildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            //Top Bar
            TopBar(
              userName: 'hoseakalayil@gmail.com',
            ),

            ListView(
              shrinkWrap: true,
              children: [
                //Todays Card
                //TODO: Automate with current date
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      //Heading Date
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '27th June',
                              style: Theme.of(context).textTheme.headline2,
                            )
                          ],
                        ),
                      ),

                      //Trips
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ]),
                            child: Text(
                              'Trip #1',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ],
                      ),

                      //Button to start new trip
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        color: accent,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.plus,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    scrollable: true,
                                    title: Text(
                                      'Enter Trip Name',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    content: Column(
                                      children: [
                                        Divider(color: backgroundColor),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            icon: Icon(FontAwesomeIcons.italic),
                                            labelText: 'Trip Name',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, NewTrip.id);
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  ),
                                );
//                                Navigator.pushNamed(context, NewTrip.id);
                              },
                              child: Text(
                                'Start New Trip',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //Previous Days Card
                //TODO: Automate History with cloud data
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      //Heading date
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '26th June',
                              style: Theme.of(context).textTheme.headline2,
                            )
                          ],
                        ),
                      ),

                      //Trips
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ]),
                            child: Text(
                              'Trip #1',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
