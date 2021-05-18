import 'package:flutter/material.dart';
import 'package:lofi/data/icon/my_flutter_app_icons.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        height: 50,
        decoration: new BoxDecoration(
          color: const Color(0xFFEBCECB).withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              MyFlutterApp.home_2,
              color: Colors.black,
              size: 32,
            ),
            Icon(
              MyFlutterApp.compass,
              color: Colors.black,
              size: 34,
            ),
            Icon(
              MyFlutterApp.heart,
              color: Colors.black,
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}
