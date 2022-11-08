import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 255, 160, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(Icons.home),
              tooltip: 'Home',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => mainScreen()));
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.bookmark),
              tooltip: 'Follow',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.access_time),
              tooltip: 'Recent Booking',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'More',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
