import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/lofi_bloc.dart';
import 'package:lofi/data/icon/my_flutter_app_icons.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/pages/widgets/drawer.dart';

import 'package:lofi/pages/widgets/rec_widget.dart';
import 'package:lofi/pages/widgets/pop_widget.dart';
import 'package:lofi/pages/widgets/bottom_navbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollViewController = new ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();

    final lofibloc = BlocProvider.of<LofiBloc>(context);
    print('Lofi Bloc ' + lofibloc.toString());
    lofibloc.add(PopulateLofi());

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
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfffcfcff),
      drawer: DrawerWidget(),
      body: BlocBuilder<LofiBloc, LofiState>(builder: (context, state) {
        if (state is LofiLoaded) {
          return Column(
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
                            List<Lofi> _lofiList = state.lofiList;
                            return SizedBox(
                              height: 270,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.lofiList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return (index == 0)
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              PopWidget(
                                                image: 'assets/images/01.jpg',
                                                artist: 'Enrique Iglesias',
                                                title: 'Why Not Me',
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
                                                  image: 'assets/images/01.jpg',
                                                  artist: 'Enrique Iglesias',
                                                  title: 'Why Not Me',
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
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                      RecentLofi(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
      bottomNavigationBar: BottomNav(),
    );
  }
}
