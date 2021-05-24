part of 'sharedprefs_bloc.dart';

abstract class SharedprefsEvent extends Equatable {
  const SharedprefsEvent();

  @override
  List<Object> get props => [];
}

class AddFavourite extends SharedprefsEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class RemoveFavourite extends SharedprefsEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class AddRecent extends SharedprefsEvent {
  final Lofi lofi;

  AddRecent(this.lofi);
  List<Object> get props => [lofi];
}
