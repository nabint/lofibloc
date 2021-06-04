import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/pages/home.dart';
import 'package:lofi/utils/shared_prefs_central.dart';

part 'sharedprefs_event.dart';
part 'sharedprefs_state.dart';

class SharedprefsBloc extends Bloc<SharedprefsEvent, SharedprefsState> {
  SharedprefsBloc() : super(SharedprefsInitial());

  @override
  Stream<SharedprefsState> mapEventToState(
    SharedprefsEvent event,
  ) async* {
    if (event is AddRecent) {
      
      updateRecentLofi(event.lofi);
      yield RecentAdded();
    }
  }
}
