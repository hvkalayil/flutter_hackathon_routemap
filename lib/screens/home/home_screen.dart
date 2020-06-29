import 'package:RouteMap/Constants.dart';
import 'package:RouteMap/screens/new_trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _tripName = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getDatafromCloud();
  }

  final _database = Firestore.instance;

  String _tripNames;
  DateTime _tripDates;
  List<GeoPoint> _tripCords = [];
  List<String> _tripInteractions = [];

  Future<void> _getDatafromCloud() async {
    Map _data;
    final FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    try {
      await _database
          .collection('tripDetails')
          .document(_user.uid)
          .get()
          .then((value) => _data = value.data);
      _tripNames = _data['tripName'];
      _tripDates = _data['date'];
      _tripCords = _data['cordinates'];
      _tripInteractions = _data['interactions'];
    } catch (e) {
      print('Error while retrieving data');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Colors and height

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
              children: [makeTodayCard()],
            ),
          ],
        ),
      ),
    );
  }

  Container makeTodayCard() {
    final accent = Theme.of(context).accentColor;
    return Container(
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
                  DateTime.now().day.toString() +
                      ' ' +
                      months[DateTime.now().month],
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          ),

          //Trips
          _tripDates != null
              ? Wrap(
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
                        _tripName[0],
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ],
                )
              : Text(
                  'You have\'nt made any trips today.',
                  textAlign: TextAlign.center,
                ),

          //Button to start new trip
          makeStartTripButton()
        ],
      ),
    );
  }

  RaisedButton makeStartTripButton() {
    final accent = Theme.of(context).accentColor;
    return RaisedButton(
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
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  scrollable: true,
                  title: Text(
                    'Enter Trip Name',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Divider(color: backgroundColor),
                        TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'TripName Should not be empty';
                            }
                          },
                          onSaved: (input) => _tripName = input,
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.italic),
                            labelText: 'Trip Name',
                          ),
                        ),
                      ],
                    ),
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
                        final _formState = _formKey.currentState;
                        if (_formState.validate()) {
                          _formState.save();
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewTrip(
                                  name: _tripName,
                                  today: DateTime.now(),
                                ),
                              ));
                        }
                      },
                      child: Text('Done'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Start New Trip',
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        ],
      ),
    );
  }
}
