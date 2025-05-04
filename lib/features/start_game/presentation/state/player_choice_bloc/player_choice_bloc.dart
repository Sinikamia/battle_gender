import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_event.dart';
import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerChoiceBloc extends Bloc<PlayerChoiceEvent, PlayerChoiceState> {
  PlayerChoiceBloc() : super(const PlayerChoiceState(selectedIndex: 0)) {
    on<PlayerSelected>((event, emit) {
      emit(PlayerChoiceState(selectedIndex: event.index));
    });
  }
}
