import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Lofi extends Equatable {
  final int id;
  final String lofiUrl;
  final String artist;
  final String title;
  final String imageUrl;
  bool favourite;

  Lofi({
    this.id,
    this.lofiUrl,
    this.artist,
    this.title,
    this.imageUrl,
    this.favourite = false,
  });

  static Map<String, dynamic> toMap(Lofi lofi) => {
        'id': lofi.id,
        'lofiUrl': lofi.lofiUrl,
        'artist': lofi.artist,
        'title': lofi.title,
        'imageUrl': lofi.imageUrl,
        'favourite': lofi.favourite,
      };

  factory Lofi.fromJson(Map<String, dynamic> jsonData) {
    return Lofi(
      id: jsonData['id'],
      lofiUrl: jsonData['lofiUrl'],
      artist: jsonData['artist'],
      title: jsonData['title'],
      imageUrl: jsonData['imageUrl'],
      favourite: jsonData['favourite'],
    );
  }

  static String encode(List<Lofi> lofis) {
    return json.encode(
        lofis.map<Map<String, dynamic>>((lofi) => Lofi.toMap(lofi)).toList());
  }

  static List<Lofi> decode(String lofis) =>
      (json.decode(lofis) as List<dynamic>)
          .map<Lofi>((item) => Lofi.fromJson(item))
          .toList();

  String get getLofiUrl {
    return lofiUrl;
  }

  String get getArtist {
    return artist;
  }

  String get getTitle {
    return title;
  }

  String get getImageUrl {
    return imageUrl;
  }

  void setFavourite(bool isfav) {
    this.favourite = isfav;
  }

  @override
  List<Object> get props => [lofiUrl, artist, title, imageUrl, favourite];
}
