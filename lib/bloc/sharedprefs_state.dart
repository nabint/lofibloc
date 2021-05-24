part of 'sharedprefs_bloc.dart';

abstract class SharedprefsState extends Equatable {
  const SharedprefsState();

  @override
  List<Object> get props => [];
}

class SharedprefsInitial extends SharedprefsState {}

class FavouriteAdded extends SharedprefsState {}

class FavouriteRemoved extends SharedprefsState {}

class RecentAdded extends SharedprefsState {
  RecentAdded() {
    print("Recent Added State is called");
  }
  @override
  List<Object> get props => [];
}
