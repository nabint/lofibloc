import 'package:equatable/equatable.dart';

class Lofi extends Equatable {
  final String lofiUrl;
  final String artist;
  final String title;
  final String imageUrl;

  Lofi({
    this.lofiUrl,
    this.artist,
    this.title,
    this.imageUrl
  });

  @override
  List<Object> get props => throw UnimplementedError();
}
