import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayingPage extends StatefulWidget {
  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  AudioPlayer _player = AudioPlayer();
  AudioCache cache;
  // AudioManager audioManager = AudioManager.instance;

  @override
  void initState() {
    // TODO: implement initState
    cache = AudioCache(fixedPlayer: _player);

  }
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 50,
                ),
                onPressed: () {
                  cache.play("Angel.mp3");
                },
              ),
            ),
          ),
          Center(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.stop,
                  size: 50,
                ),
                onPressed: () {
                  _player.stop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
