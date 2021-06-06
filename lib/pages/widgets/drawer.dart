import 'package:flutter/material.dart';
import 'package:lofi/pages/about.dart';
import 'package:share_plus/share_plus.dart';
import 'package:volume/volume.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  double _sliderValue;
  int maxVol, currentVol;
  double height;
  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager
        .STREAM_MUSIC); // you can change which volume you want to change
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;

    await Share.share("sasdasdas",
        subject: "qweqwe",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    _sliderValue = currentVol.toDouble();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    updateVolumes();
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: height * 0.3,
              child: DrawerHeader(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Low fly',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/drawer.jpg"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ListTile(
                leading: Icon(
                  Icons.share,
                  size: 28,
                  color: Color(0xff152238),
                ),
                title: Text(
                  'Share It',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onTap: () => _onShare(context)),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.volume_down,
                size: 34,
                color: Color(0xff152238),
              ),
              title: Text(
                'Volume Control',
                style: TextStyle(color: Colors.black, fontSize: 16),
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
                activeColor: Color(0xff152238),
                max: maxVol.toDouble(),
                value: _sliderValue,
                onChanged: (value) async {
                  setState(() {
                    _sliderValue = value;
                  });
                  await setVol(value.toInt());
                  await updateVolumes();
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.star,
                size: 28,
                color: Color(0xff152238),
              ),
              title: Text(
                'Rate Us',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.people,
                size: 28,
                color: Color(0xff152238),
              ),
              title: Text(
                'About',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return AboutUs();
                }));
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
