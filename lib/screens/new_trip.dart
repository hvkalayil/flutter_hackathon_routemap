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
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            height: deviceHeight / 4,
            width: deviceWidth,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                RaisedButton(
                  onPressed: () => _getCurrentLocation(),
                  padding: EdgeInsets.all(20),
                  color: primaryColor,
                  shape: CircleBorder(),
                  child: Icon(Icons.gps_fixed),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
