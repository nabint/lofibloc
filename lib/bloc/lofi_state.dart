part of 'lofi_bloc.dart';

@immutable
abstract class LofiState extends Equatable {}

class LofiInitial extends LofiState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class LofiLoaded extends LofiState{
  
  final List<Lofi> lofiList;

  LofiLoaded(this.lofiList);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class LofiPaused extends LofiState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
class LofiPlaying extends LofiState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
