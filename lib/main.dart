
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/sharedprefs_bloc.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/pages/home.dart';
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

  @override
  void initState() {
    cache = AudioCache(fixedPlayer: _player);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.red),
      debugShowCheckedModeBanner: false,

      home: BlocProvider(
        create: (context) => SharedprefsBloc(),
        child: BlocProvider<LofiBloc>(
          create: (context) => LofiBloc(
            LofiRepo(),
            cache,
            _player,
            sbloc: BlocProvider.of<SharedprefsBloc>(context),
          ),
          child: Home(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
