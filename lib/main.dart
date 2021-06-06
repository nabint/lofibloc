import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/sharedprefs_bloc.dart';
import 'package:lofi/pages/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'bloc/lofi_bloc.dart';
import 'data/lofi_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer _player = AudioPlayer();
  AudioCache cache;
  LofiBloc lofiBloc;

  @override
  void initState() {
    cache = AudioCache(fixedPlayer: _player);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lofiBloc = LofiBloc(
      LofiRepo(),
      cache,
      _player,
      sbloc: SharedprefsBloc(),
    );
    lofiBloc.add(PopulateLofi());
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new BlocProvider(
          create: (context) => SharedprefsBloc(),
          child: BlocProvider<LofiBloc>.value(
            value: lofiBloc,
            child: Home(),
          ),
        ),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.network(
            'https://flutter.io/images/catalog-widget-placeholder.png'),
        backgroundColor: Colors.white,
        loaderColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
