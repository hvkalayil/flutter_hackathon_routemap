import 'dart:async';
import 'dart:collection';

import 'package:RouteMap/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NewTrip extends StatefulWidget {
  static String id = 'NewTrip Id';
  const NewTrip({
    Key key,
    this.name,
    this.today,
  }) : super(key: key);
  final String name;
  final DateTime today;
  @override
  _NewTripState createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  //Text Variables
  String _interaction = '';
  List<String> _allInteractions = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Map Variables
  GoogleMapController mapController;
  LatLng _center = LatLng(45.521563, -122.677433);
  geo.Position _currentPosition;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _getCurrentLocation() {
    final geo.Geolocator geolocator = geo.Geolocator()
      ..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best)
        .then((geo.Position position) {
      setState(() {
        _currentPosition = position;
        _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
        _markers.add(
          Marker(
              markerId: MarkerId('0'),
              position: _center,
              infoWindow: InfoWindow(title: 'You'),
              icon: _markerUser),
        );
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: 11,
        ),
      ));
    }).catchError((e) {
      print(e);
    });
    print(_center.toString());
  }

  //Marker Code
  Set<Marker> _markers = HashSet<Marker>();
  BitmapDescriptor _markerUser;
  Future<void> _setMarkerIcon() async {
    _markerUser = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/user.png');
  }

  //getLocation
  StreamSubscription _getPositionSubscription;
  _getLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _getPositionSubscription = location.onLocationChanged.listen((event) {
      _setPolyline(LatLng(event.latitude, event.longitude));
    });
  }

  @override
  void dispose() {
    _getPositionSubscription?.cancel();
    super.dispose();
  }

  //PolyLine Code
  final Set<Polyline> _polyLine = HashSet<Polyline>();
  List<LatLng> _routeCords = [];
  void _setPolyline(LatLng cords) {
    _routeCords.add(cords);
    _polyLine.add(Polyline(
      polylineId: PolylineId('1'),
      points: _routeCords,
    ));
  }

  //Firebase code
  final _database = Firestore.instance;
  @override
  void initState() {
    super.initState();
    _getLocationPermission();
    _setMarkerIcon();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          //ACTUAL MAP
          Container(
            alignment: Alignment.topCenter,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: _polyLine,
            ),
          ),

          //GPS BUTTON
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            alignment: Alignment.topRight,
            child: RaisedButton(
              onPressed: () => _getCurrentLocation(),
              padding: EdgeInsets.all(20),
              color: primaryColor,
              shape: CircleBorder(),
              child: Icon(
                Icons.gps_fixed,
                color: secondaryColor,
              ),
            ),
          ),

          //BOTTOM UI
          Positioned(
            bottom: 0,
            child: Container(
              height: deviceHeight * 0.45,
              width: deviceWidth,
              color: primaryColor,
              child: Column(
                children: [
                  //Date And Trip Details
                  topBarDetails(),
                  SizedBox(height: 20),

                  //Interactions
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Your Interactions',
                      style: TextStyle(
                          fontSize: 20,
                          color: secondaryColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  //CARDS
                  _allInteractions.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.all(5),
                          height: deviceHeight * 0.15,
                          width: deviceWidth,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: _allInteractions
                                .asMap()
                                .entries
                                .map(
                                    (e) => makeInteractionCards(e.key, e.value))
                                .toList(),
                          ),
                        )
                      : SizedBox(
                          height: 40,
                        ),
                  SizedBox(height: 10),

                  //Add Button
                  addInteractionButton(
                      _allInteractions.isEmpty ? 0 : _allInteractions.length),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> _data = {};
          //for converting latlng to geopoint to store in firebase
          List<GeoPoint> _finalCords = [];
          for (LatLng item in _routeCords)
            _finalCords.add(GeoPoint(item.latitude, item.longitude));

          _data.addAll({
            'tripName': widget.name,
            'date': widget.today,
            'cordinates': _finalCords,
            'interactions': _allInteractions
          });
          final FirebaseUser _user = await FirebaseAuth.instance.currentUser();
          try {
            await _database
                .collection('tripDetails')
                .document(_user.uid)
                .updateData(_data);
          } catch (e) {
            await _database
                .collection('tripDetails')
                .document(_user.uid)
                .setData(_data);
          }
          Navigator.pop(context);
        },
        backgroundColor: secondaryColor,
        child: Icon(
          FontAwesomeIcons.check,
          color: primaryColor,
        ),
      ),
    );
  }

  Container topBarDetails() {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
        color: secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.today.day.toString() + ' ' + months[widget.today.month],
                style: TextStyle(
                    fontSize: 24,
                    color: primaryColor,
                    fontWeight: FontWeight.w900),
              ),
              Text(widget.name,
                  style: TextStyle(
                      fontSize: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          Text('10km'),
        ],
      ),
    );
  }

  Container makeInteractionCards(int index, String value) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;

    return Container(
      height: deviceHeight * 0.15,
      width: deviceWidth * 0.4,
      child: CupertinoContextMenu(
        child: Card(
          color: secondaryColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: deviceWidth * 0.3,
              child: ListView(
                children: [
                  Text('Interacted with ' + value),
                ],
              ),
            ),
          ),
        ),
        actions: [
          CupertinoContextMenuAction(
            child: const Text('Edit'),
            onPressed: () {
              Navigator.pop(context);
              showAddDialog(index, true);
            },
          ),
          CupertinoContextMenuAction(
            child: const Text('Delete'),
            onPressed: () {
              setState(() {
                _allInteractions.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Container addInteractionButton(int index) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
          onPressed: () {
            showAddDialog(index, false);
          },
          padding: EdgeInsets.all(20),
          color: secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Text(
            'Add Interaction',
            style: TextStyle(color: primaryColor),
          )),
    );
  }

  void showAddDialog(int index, bool isEdit) {
    final primaryColor = Theme.of(context).primaryColor;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        scrollable: true,
        title: Text(
          'Enter Interaction Details',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Divider(color: primaryColor),
              TextFormField(
                initialValue: isEdit ? _allInteractions[index] : null,
                // ignore: missing_return
                validator: (input) {
                  if (input.isEmpty) {
                    return "Interaction cannot be empty";
                  }
                },
                onSaved: (input) => _interaction = input,
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.italic),
                  labelText: 'Interacted with',
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
                setState(() {
                  if (isEdit)
                    _allInteractions[index] = _interaction;
                  else
                    _allInteractions.insert(index, _interaction);
                });
                Navigator.pop(context);
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
