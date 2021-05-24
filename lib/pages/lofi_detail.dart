import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/lofi_bloc.dart';
import 'package:lofi/data/models/lofi.dart';

class LofiDetail extends StatefulWidget {
  final bool isPlaying;
  final Lofi lofi;
  const LofiDetail({Key key, this.isPlaying, this.lofi}) : super(key: key);
  static bool repeat = true;

  @override
  _LofiDetailState createState() => _LofiDetailState();
}

class _LofiDetailState extends State<LofiDetail> {
  // StreamController<bool> _streamController = StreamController<bool>();
  LofiBloc lofibloc;
  @override
  void initState() {
    lofibloc = BlocProvider.of<LofiBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Builder(
      builder: (BuildContext context) {
        double maxSize =
            max(mediaQueryData.size.width, mediaQueryData.size.height);
        double imageHeight = (maxSize - mediaQueryData.padding.top) * 0.45;
        double imageWidth = mediaQueryData.size.width * 0.8;
        return Scaffold(
          body: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      minHeight: mediaQueryData.size.height,
                      minWidth: mediaQueryData.size.width,
                    ),
                    child: Stack(
                      children: <Widget>[
                        _buildBackgroundMedia(mediaQueryData),
                        _buildMediaPlayerContent(
                          mediaQueryData,
                          Theme.of(context),
                          imageHeight,
                          imageWidth,
                          maxSize,
                          lofibloc,
                          context,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: mediaQueryData.padding.top + 10,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildMediaPlayerContent(
      MediaQueryData mediaQueryData,
      ThemeData themeData,
      double imageHeight,
      double imageWidth,
      double maxSize,
      LofiBloc lofibloc,
      BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQueryData.padding.top + 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Opacity(
                opacity: 1,
                child:
                    mediaArt(imageHeight, imageWidth, mediaQueryData, maxSize),
              ),
            ],
          ),
          SizedBox(height: maxSize * 0.02),
          mediaInfo(maxSize, mediaQueryData, context),
          SizedBox(height: maxSize * 0.15),
          mediaPlayerControllers(maxSize, widget.isPlaying, context, lofibloc),
        ],
      ),
    );
  }

  Widget mediaInfo(
      double maxSize, MediaQueryData mediaQueryData, BuildContext context) {
    return Container(
      height: maxSize * 0.2 - mediaQueryData.padding.top,
      width: mediaQueryData.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.lofi.artist ?? 'No track',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: maxSize * 0.01),
          Text(
            widget.lofi.title ?? '',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget mediaArt(double imageHeight, double imageWidth,
      MediaQueryData mediaQueryData, double maxSize) {
    return Center(
      child: Container(
        height: imageHeight,
        width: imageWidth,
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black, Colors.transparent],
                    stops: [0.0, 0.75, 0.98])
                .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image(
            image: AssetImage(widget.lofi.imageUrl),
            width: mediaQueryData.size.width,
            height: (maxSize - mediaQueryData.padding.top) * 0.45,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundMedia(MediaQueryData mediaQueryData) {
    return Container(
      height: mediaQueryData.size.height,
      width: mediaQueryData.size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(widget.lofi.imageUrl), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white?.withOpacity(0.63),
        ),
      ),
    );
  }

  Widget mediaPlayerControllers(
      double maxSize, bool isPlaying, BuildContext context, LofiBloc lofibloc) {
    return Center(
      child: Container(
        height: maxSize * 0.15,
        width: maxSize * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.18),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: maxSize * 0.05,
                  onPressed: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  child: BlocBuilder<LofiBloc, LofiState>(
                    builder: (context, state) {
                      if (state is LofiPlaying) {
                        return IconButton(
                          icon: Icon(Icons.pause_circle_filled),
                          padding: EdgeInsets.zero,
                          iconSize: maxSize * 0.08,
                          onPressed: () {
                            print('On tappped');
                            lofibloc.add(PauseLofi(widget.lofi));
                          },
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.play_circle_filled),
                          padding: EdgeInsets.zero,
                          iconSize: maxSize * 0.08,
                          onPressed: () {
                            print('On tappped');
                            lofibloc.add(PlayLofi(widget.lofi.id, widget.lofi));
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: maxSize * 0.05,
                    onPressed: () {}),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: LofiBloc.isRepeat
                  ? Icon(CupertinoIcons.repeat)
                  : Icon(CupertinoIcons.repeat, color: Colors.grey),
              iconSize: maxSize * 0.05,
              onPressed: () {
                setState(
                  () {
                    LofiBloc.isRepeat = !LofiBloc.isRepeat;
                    if (LofiBloc.isPlaying == true) {
                      lofibloc.add(
                        PlayLofi(widget.lofi.id, widget.lofi),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
