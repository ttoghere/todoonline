import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:todoonline/blocs/blocs.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(switchValue: false)) {
    on<SwitchOn>(_switchOn);
    on<SwitchOff>(_switchOff);
  }

  void _switchOn(SwitchOn event, Emitter<SwitchState> emit) {
    emit(const SwitchState(switchValue: true));
  }

  void _switchOff(SwitchOff event, Emitter<SwitchState> emit) {
    emit(const SwitchState(switchValue: false));
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
