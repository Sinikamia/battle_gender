import 'package:battle_gender/features/rules/presentation/state/rules_bloc/rules_event.dart';
import 'package:battle_gender/features/rules/presentation/state/rules_bloc/rules_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RulesBloc extends Bloc<RulesEvent, RulesState> {
  RulesBloc() : super(const RulesState()) {
    on<RulesEvent>((event, emit) {});
  }
}
