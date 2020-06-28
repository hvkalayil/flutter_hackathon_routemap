import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewTrip extends StatefulWidget {
  static String id = 'NewTrip Id';

  @override
  _NewTripState createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  GoogleMapController mapController;

  LatLng _center = LatLng(45.521563, -122.677433);
  Marker userLocationMarker = Marker(
      markerId: MarkerId('user'), position: LatLng(45.521563, -122.677433));

  Position _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
        userLocationMarker =
            Marker(markerId: MarkerId('user'), position: _center);
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
                Container(
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
                            '27th June',
                            style: TextStyle(
                                fontSize: 24,
                                color: primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                          Text('Trip Name',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Text('10km'),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                //Interactions
                //Heading
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
                Container(
                  padding: EdgeInsets.all(5),
                  height: deviceHeight * 0.15,
                  width: deviceWidth,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: deviceHeight * 0.15,
                        width: deviceWidth * 0.4,
                        child: Card(
                          color: secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text('Interaction #1')),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.15,
                        width: deviceWidth * 0.4,
                        child: Card(
                          color: secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text('Interaction #2')),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.15,
                        width: deviceWidth * 0.4,
                        child: Card(
                          color: secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text('Interaction #3')),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.15,
                        width: deviceWidth * 0.4,
                        child: Card(
                          color: secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text('Interaction #4')),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                //Add Button
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(20),
                      color: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Text(
                        'Add Interaction',
                        style: TextStyle(color: primaryColor),
                      )),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
