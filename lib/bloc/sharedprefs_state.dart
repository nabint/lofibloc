part of 'sharedprefs_bloc.dart';

abstract class SharedprefsState extends Equatable {
  const SharedprefsState();

  @override
  List<Object> get props => [];
}

class SharedprefsInitial extends SharedprefsState {
  SharedprefsInitial() {
 
  }
}

class FavouriteAdded extends SharedprefsState {}

class FavouriteRemoved extends SharedprefsState {}

class RecentAdded extends SharedprefsState {
  RecentAdded() {
 
    
  }
  @override
  List<Object> get props => [];
}
