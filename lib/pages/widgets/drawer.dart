import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  double _value = 0.0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: DrawerHeader(
              child: Center(
                  child: Text(
                'Low fly',
                style: TextStyle(color: Colors.white, fontSize: 40),
              )),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              size: 28,
            ),
            title: Text(
              'Share It',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.volume_down,
              size: 34,
            ),
            title: Text(
              'Volume Control',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Slider(
              min: 0,
              max: 100,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.thumb_up_sharp,
              size: 28,
            ),
            title: Text(
              'Rate Us',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              size: 28,
            ),
            title: Text(
              'About Us',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
