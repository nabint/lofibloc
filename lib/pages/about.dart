import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
              Icons.info_outline,
              size: 28,
            ),
            title: Text(
              'App Version',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              '1.0',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.bug_report_sharp,
              size: 28,
            ),
            title: Text(
              'Report Bugs',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              'Report any found bugs or you want a new feature',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.code_outlined,
              size: 28,
            ),
            title: Text(
              'Developer',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              'Nabin Thapa \nKathmandu,Nepal' ,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          
        ],
      ),
    );
  }
}
