import 'models/lofi.dart';

class LofiRepo {
  List<Lofi> _allLofi = [];

  void populateLofi() {
    _allLofi.add(
      Lofi(
          id: 1,
          title: "The End",
          lofiUrl: "The End by Eva.mp3",
          artist: "Eva",
          imageUrl: "assets/images/theend.jpg"),
    );

    _allLofi.add(
      Lofi(
          id: 2,
          title: "Thoughts",
          lofiUrl: "Thoughts by Envy.mp3",
          artist: "Envy",
          imageUrl: "assets/images/Thoughts.jpg"),
    );
    _allLofi.add(
      Lofi(
          id: 3,
          title: "Alone",
          lofiUrl: "Alone by Envy.mp3",
          artist: "Envy",
          imageUrl: "assets/images/Alone.jpg"),
    );
    _allLofi.add(
      Lofi(
          id: 4,
          title: "Sad Afternoon",
          lofiUrl: "Sweet Sad Afternoon by BubbleBeats.mp3",
          artist: "BubbleBeats",
          imageUrl: "assets/images/Afternoon.jpg"),
    );
    _allLofi.add(
      Lofi(
          id: 5,
          title: "Loving You",
          lofiUrl: "Loving You by l33.mp3",
          artist: "I33",
          imageUrl: "assets/images/LovingYou.PNG"),
    );
    _allLofi.add(
      Lofi(
          id: 6,
          title: "Summer Nights",
          lofiUrl: "Summer Night by l33.mp3",
          artist: "I33",
          imageUrl: "assets/images/Summer Nights.jpg"),
    );
    print("Lofi Populated");
  }

  List<Lofi> get allLofi {
    return _allLofi;
  }

  Lofi singleLofi(String title) {
    return _allLofi.where((element) => element.title == title) as Lofi;
  }

  void playLofi() {}
}
