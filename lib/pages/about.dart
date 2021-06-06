import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xFF00022E),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              MdiIcons.informationOutline,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'App Version',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              '1.0',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              MdiIcons.bug,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Report Bugs',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              'Report any found bugs or you want a new feature',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              MdiIcons.googlePlay,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'More Apps',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              'Check out our other applications in PlayStore',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              MdiIcons.star,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Rate',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              'Rate our applications at PlayStore',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              MdiIcons.share,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Share',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              'Share the link of app with your friends and family',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              MdiIcons.codeTags,
              size: 28,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Developer',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            subtitle: Text(
              'Nabin Thapa \nKathmandu,Nepal',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
