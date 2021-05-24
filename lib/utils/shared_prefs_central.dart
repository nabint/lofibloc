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
    print("Updated recLofi" + recLofi.toString());
    print("Error Not Occured");
  } on Exception {
    print("Error Occured");
  }

  print(recLofi);
  if (recLofi != null) {
    lofis = Lofi.decode(recLofi);
  }
  lofis.insert(0, lofi);
  if (lofis.length > 4) {
    lofis.removeLast();
  }
  recLofi = Lofi.encode(lofis);
  print(recLofi);
  save("Recently Played", recLofi);
}

void updateFavouriteLofi(Lofi lofi) async {
  
}


