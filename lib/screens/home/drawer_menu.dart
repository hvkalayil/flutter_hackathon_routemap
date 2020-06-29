import 'package:RouteMap/screens/login/login_screen.dart';
import 'package:RouteMap/screens/settings_screen.dart';
import 'package:RouteMap/utility/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> drawerItems = ['About', 'LogOut'];
    List<IconData> drawerIcons = [
      FontAwesomeIcons.info,
      FontAwesomeIcons.signOutAlt
    ];
    double deviceHeight = MediaQuery.of(context).size.height;

    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    return Drawer(
      child: Container(
          height: deviceHeight,
          color: primaryColor,
          child: Column(
            children: [
              Container(
                height: deviceHeight / 3,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png')),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60))),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      onPressed: () async {
                        //About
                        if (drawerItems[index] == 'About') {
                          showAboutDialog(
                              context: context,
                              applicationName: 'Route Map',
                              applicationVersion: 'Version 1.0',
                              children: [
                                Text('This is a location tracking'
                                    'application. It can be used to track'
                                    'your locations and interactions.'
                                    'This data can be used to isolate '
                                    'your contacts for COVID tests.')
                              ]);
                        }

                        //Settings
                        else if (drawerItems[index] == 'Settings') {
                          Navigator.pushNamed(context, SettingsScreen.id);
                        }

                        //Logout
                        else if (drawerItems[index] == 'LogOut') {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text('Confirm Log Out'),
                                    content: Text(
                                        'Are you sure you want to Log Out'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          await SharedPrefs.clearAll();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              LoginScreen.id,
                                              (Route<dynamic> route) => false);
                                        },
                                      ),
                                    ],
                                  ));
                        }
                      },
                      splashColor: Colors.white70,
                      child: ListTile(
                        leading: Icon(drawerIcons[index]),
                        title: Text(
                          drawerItems[index],
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 5,
                      thickness: 5,
                      color: secondaryColor,
                    );
                  },
                  itemCount: drawerItems.length),
            ],
          )),
    );
  }
}
