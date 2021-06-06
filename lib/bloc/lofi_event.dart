part of 'lofi_bloc.dart';

@immutable
abstract class LofiEvent extends Equatable {}

class LofiLoading extends LofiEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RepeatEvent extends LofiEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PopulateLofi extends LofiEvent {
  PopulateLofi() {
    print("PopulateLofi event");
  }
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PlayLofi extends LofiEvent {
  final int id;
  Lofi lofi;
  bool repeat;
  PlayLofi(this.id, this.lofi, {this.repeat = false});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopLofi extends LofiEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopLofii extends LofiEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PauseLofi extends LofiEvent {
  Lofi lofi;
  PauseLofi(this.lofi);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
