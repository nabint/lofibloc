import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lofi/data/lofi_repository.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:meta/meta.dart';

part 'lofi_event.dart';
part 'lofi_state.dart';

class LofiBloc extends Bloc<LofiEvent, LofiState> {
  final LofiRepo lofiRepo;


  LofiBloc(this.lofiRepo) : super(LofiInitial());

  @override
  Stream<LofiState> mapEventToState(
    LofiEvent event,
  ) async* {

    if(event is PopulateLofi){
      lofiRepo.populateLofi();
      yield LofiLoaded(lofiRepo.allLofi);
    }

    // TODO: implement mapEventToState
    else if (event is PlayLofi){

    }
    else if(event is StopLofi){

    }
    else if(event is PauseLofi){

    }
  }
}
