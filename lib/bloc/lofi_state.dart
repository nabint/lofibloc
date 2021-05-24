part of 'lofi_bloc.dart';

@immutable
abstract class LofiState extends Equatable {
  List<Lofi> get lofiList => null;
}

class LofiInitial extends LofiState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LofiLoaded extends LofiState{
  
  final List<Lofi> lofiList;

  LofiLoaded(this.lofiList);

  @override
  // TODO: implement props
  List<Object> get props => [lofiList];

}

class LofiPaused extends LofiState{
  
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}
class LofiPlaying extends LofiState{
  final Lofi lofi;

  LofiPlaying(this.lofi);
  @override
  // TODO: implement props
  List<Object> get props => [];

}
