import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lofi/bloc/sharedprefs_bloc.dart';
import 'package:lofi/data/lofi_repository.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/utils/media_player_central.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lofi_event.dart';
part 'lofi_state.dart';

class LofiBloc extends Bloc<LofiEvent, LofiState> with ChangeNotifier {
  final LofiRepo lofiRepo;

  final AudioCache cache;
  final AudioPlayer _player;
  static bool isRepeat = false;
  static bool isPlaying = false;
  SharedprefsBloc sbloc;

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print('Shared Preferences' + prefs.toString());
    final prefString = prefs.getString(key);
    if (prefString != null) {
      return json.decode(prefString);
    } else {
      print("Prefs Key Null");
      return null;
    }
  }

  LofiBloc(this.lofiRepo, this.cache, this._player, {this.sbloc})
      : super(LofiInitial()) {
    if (isRepeat == false) {
      listenPlayerState();
    }
  }

  listenPlayerState() {
    _player.onPlayerStateChanged.listen(
      (event) async {
        if (event == AudioPlayerState.COMPLETED) {
          print("Completed");
          // cancelNotification();
          this.add(StopLofi());
          isPlaying = false;
        }
      },
    );
  }

  loop_lofi(lofiUrl) {
    cache.loop(lofiUrl);
  }

  play_lofi(lofiUrl) {
    cache.play(lofiUrl);
  }

  resume_lofi() {
    _player.resume();
  }

  @override
  Stream<LofiState> mapEventToState(
    LofiEvent event,
  ) async* {
    if (event is PopulateLofi) {
      lofiRepo.populateLofi();
      yield LofiLoaded(lofiRepo.allLofi);
    } else if (event is PlayLofi) {
      updateNotificationMediaPlayer(true, event.lofi);
      // updateRecentLofi(event.lofi);
      sbloc.add(AddRecent(event.lofi));

      if (isPlaying) {
        resume_lofi();
        if (isRepeat) {
          loop_lofi(event.lofi.lofiUrl);
        } else {
          play_lofi(event.lofi.lofiUrl);
        }
      } else {
        if (isRepeat) {
          loop_lofi(event.lofi.lofiUrl);
        } else {
          play_lofi(event.lofi.lofiUrl);
          isPlaying = true;
        }
      }
      yield LofiPlaying(event.lofi);
    } else if (event is StopLofi) {
      _player.stop();
      cancelNotification();
      yield LofiPaused();
    } else if (event is PauseLofi) {
      print('PauseLofi called');
      updateNotificationMediaPlayer(false, event.lofi);
      _player.pause();
      yield LofiPaused();
    } else if (event is StopLofii) {
      yield LofiPaused();
    }
  }

  void updateRecentLofi(Lofi lofi) async {
    List<Lofi> lofis = [];
    var recLofi;
    try {
      recLofi = await read('Recently Played');
      print("Error Not Occured");
    } on Exception {
      print("Error Occured");
    }

    print(recLofi);
    if (recLofi != null) {
      lofis = Lofi.decode(recLofi);
    }
    lofis.insert(0, lofi);
    if (lofis.length >= 6) {
      lofis.removeLast();
    }
    recLofi = Lofi.encode(lofis);
    print(recLofi);
    save("Recently Played", recLofi); 
  }
}
