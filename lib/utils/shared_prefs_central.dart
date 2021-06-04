import 'dart:convert';

import 'package:lofi/data/models/lofi.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  if (lofis.length > 0) {
    if (lofis[0].id != lofi.id) lofis.insert(0, lofi);

    if (lofis.length > 4) {
      lofis.removeLast();
    }
  } else {
    lofis.insert(0, lofi);
  }
  recLofi = Lofi.encode(lofis);
  print(recLofi);
  save("Recently Played", recLofi);
}

void updateFavouriteLofi(Lofi lofi) async {
  List<Lofi> lofis = [];
  var favLofi;
  try {
    favLofi = await read('Favourite');
  } on Exception {
    print("FAV Error Occured");
  }

  if (favLofi != null) {
    lofis = Lofi.decode(favLofi);
  }
  lofis.insert(0, lofi);
  print("Fav Lofis" + lofis.toString());
  save("Favourite", lofis);
}
