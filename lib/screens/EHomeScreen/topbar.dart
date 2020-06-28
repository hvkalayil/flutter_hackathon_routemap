import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key key,
    @required this.userName,
  }) : super(key: key);
  final String userName;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//          //MENU BUTTON
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              FontAwesomeIcons.bars,
              size: 15,
              color: primaryColor,
            ),
          ),

          //HEADING
          Text(
            'ROUTE MAP',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),

          //Profile Button
          RaisedButton(
            color: Colors.white,
            shape: CircleBorder(),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => buildDialog(primaryColor, secondaryColor));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                FontAwesomeIcons.user,
                size: 15,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildDialog(Color primaryColor, Color secondaryColor) {
    return Dialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Container(
        margin: EdgeInsets.all(20),
        height: 250,
        child: ListView(
          children: [
            //PROFILE ICON
            CircleAvatar(
              radius: 40,
              backgroundColor: secondaryColor,
              child: getProfile(),
            ),

            //UPLOAD PROFILE IMAGE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () {
                    //TODO: Add FilePicker code
                  },
                  color: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.image,
                        color: primaryColor,
                      ),
                      Text(
                        'Gallery',
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    //TODO: Add FilePicker code
                  },
                  color: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.camera,
                        color: primaryColor,
                      ),
                      Text('Camera',
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                )
              ],
            ),

            //DIVIDER
            SizedBox(height: 10),
            Divider(
              height: 2,
              thickness: 2,
              color: secondaryColor,
            ),
            SizedBox(height: 10),

            //USERNAME
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }

  getProfile() {
    //TODO: Check for profile imge
    return Icon(
      FontAwesomeIcons.user,
      color: Color(0xff00c389),
    );
  }
}
