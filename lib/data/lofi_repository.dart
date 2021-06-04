import 'models/lofi.dart';

class LofiRepo {
  List<Lofi> _allLofi = [];

  void populateLofi() {
    _allLofi.add(
      Lofi(
          id: 1,
          title: "Chill Lofi",
          lofiUrl: "1.mp3",
          artist: "Enrique",
          imageUrl: "assets/images/01.jpg"),
    );
    _allLofi.add(
      Lofi(
          id: 2,
          title: "Fhill Lofi",
          lofiUrl: "2.mp3",
          artist: "Enrique",
          imageUrl: "assets/images/01.jpg"),
    );
    _allLofi.add(
      Lofi(
          id: 3,
          title: "Shill Lofi",
          lofiUrl: "1.mp3",
          artist: "Enrique",
          imageUrl: "assets/images/01.jpg"),
    );
  }

  List<Lofi> get allLofi {
    return _allLofi;
  }

  Lofi singleLofi(String title) {
    return _allLofi.where((element) => element.title == title) as Lofi;
  }

  void playLofi() {}
}
