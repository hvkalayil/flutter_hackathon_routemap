import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //MENU BUTTON
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
            onPressed: () {},
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
            onPressed: () {},
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
}
