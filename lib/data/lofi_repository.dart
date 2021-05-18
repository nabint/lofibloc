import 'models/lofi.dart';

class LofiRepo {

  List<Lofi> _allLofi;
  
  void populateLofi(){
    _allLofi.add(Lofi(title: "Chill Lofi",lofiUrl: "I_Got_This.mp3",artist: "Enrique",imageUrl:"assets/images/01.jpg"));
    
  } 

  List<Lofi> get allLofi{
    return _allLofi;
  }
  
  Lofi singleLofi(String title){
    return _allLofi.where((element) => element.title == title) as Lofi;
  }




}