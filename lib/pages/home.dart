import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/lofi_bloc.dart';
import 'package:lofi/bloc/sharedprefs_bloc.dart';
import 'package:lofi/data/icon/my_flutter_app_icons.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/pages/widgets/drawer.dart';

import 'package:lofi/pages/widgets/rec_widget.dart';
import 'package:lofi/pages/widgets/pop_widget.dart';
import 'package:lofi/utils/shared_prefs_central.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollViewController = new ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;
  List<Lofi> _lofiList, lofiList;
  var reqLofi, nextLofi, prevLofi;
  String recLofiString;
  List<Lofi> recLofis = [];

  List<Widget> recWidgets = [];

  @override
  void initState() {
    super.initState();
    final lofibloc = BlocProvider.of<LofiBloc>(context);
    lofibloc.add(PopulateLofi());
    readSharedPref();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollViewController.offset > 300) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection ==
              ScrollDirection.forward &&
          _scrollViewController.offset > 300) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });

    AwesomeNotifications().initialize('resource://drawable/res_ic_play', [
      NotificationChannel(
          icon: 'resource://drawable/res_media_icon',
          channelKey: 'media_player',
          channelName: 'Media player controller',
          channelDescription: 'Media player controller',
          defaultPrivacy: NotificationPrivacy.Public,
          enableVibration: false,
          enableLights: false,
          playSound: false,
          locked: true),
    ]);

    AwesomeNotifications().actionStream.listen(
      (receivedNotification) {
        lofiList = lofibloc.lofiRepo.allLofi;

        reqLofi = lofiList.firstWhere(
          (element) {
            return (element.id == receivedNotification.id);
          },
        );

        if (receivedNotification.buttonKeyPressed == 'MEDIA_PAUSE') {
          print("Pauuedd");
          print("Received" + receivedNotification.id.toString());
          print('Req  ' + reqLofi.id.toString());
          lofibloc.add(PauseLofi(reqLofi));
        } else if (receivedNotification.buttonKeyPressed == 'MEDIA_PLAY') {
          lofibloc.add(
            PlayLofi(reqLofi.id, reqLofi),
          );
        } else if (receivedNotification.buttonKeyPressed == 'MEDIA_NEXT') {
          nextLofi = lofiList.firstWhere(
            (element) => (element.id == (receivedNotification.id + 1)),
          );
          if (nextLofi != null) {
            lofibloc.add(StopLofi());
            // print("Playing Next Lofi" + nextLofi.id.toString());
            lofibloc.add(
              PlayLofi(nextLofi.id, nextLofi),
            );
          } else {
            lofibloc.add(PlayLofi(0, lofiList[0]));
          }
        } else if (receivedNotification.buttonKeyPressed == 'MEDIA_PREV') {
          prevLofi = lofiList.firstWhere(
              (element) => (element.id == (receivedNotification.id - 1)));
          print("Prev Lofi is " + prevLofi.id.toString());
          if (prevLofi != null) {
            lofibloc.add(StopLofi());
            lofibloc.add(PlayLofi(prevLofi.id, prevLofi));
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var time = const Duration(seconds: 10);
    Timer.periodic(time, (timer) => readSharedPref());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfffcfcff),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          AnimatedContainer(
            height: _showAppbar ? 56.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    MyFlutterApp.eq,
                    color: Color(0xFF00022E),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Text(
                      'Popular Lofi',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 26,
                        color: Color(0xFF00022E),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<LofiBloc, LofiState>(
                    builder: (context, state) {
                      if (state is LofiLoaded) {
                        _lofiList = state.lofiList;
                        return SizedBox(
                          height: 270,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _lofiList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return (index == 0)
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          PopWidget(
                                            lofi: _lofiList[index],
                                          ),
                                          SizedBox(width: 17)
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Row(
                                          children: [
                                            PopWidget(
                                              lofi: _lofiList[index],
                                            ),
                                            SizedBox(width: 17)
                                          ],
                                        ),
                                      ],
                                    );
                            },
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 270,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _lofiList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return (index == 0)
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          PopWidget(
                                            lofi: _lofiList[index],
                                          ),
                                          SizedBox(width: 17)
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Row(
                                          children: [
                                            PopWidget(
                                              lofi: _lofiList[index],
                                            ),
                                            SizedBox(width: 17)
                                          ],
                                        ),
                                      ],
                                    );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recently Played',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 26,
                            color: Color(0xFF00022E),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFb3b3c9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (recLofis != null)
                    BlocBuilder<SharedprefsBloc, SharedprefsState>(
                      builder: (context, state) {
                        if (state is RecentAdded ||
                            state is SharedprefsInitial) {
                          // readSharedPref(BlocProvider.of<LofiBloc>(context));
                          return BlocProvider.value(
                            value: BlocProvider.of<LofiBloc>(context),
                            child: Column(children: _buildRecentWidgets()),
                          );
                        }
                      },
                    )
                  else
                    Container()
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }

  List<Widget> _buildRecentWidgets() {
    recWidgets = [];
    for (Lofi lofi in recLofis) {
      recWidgets.add(RecentLofi(lofi: lofi));
    }

    return recWidgets;
  }

  void readSharedPref() async {
    recLofiString = await read("Recently Played");
    if (recLofiString != null) {
      var decodedLofi = Lofi.decode(recLofiString);
      setState(() {
        recLofis = decodedLofi;
      });
    }

    return;
  }
}
