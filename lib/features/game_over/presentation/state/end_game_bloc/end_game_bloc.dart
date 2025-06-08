import 'package:battle_gender/features/game_over/presentation/state/end_game_bloc/end_game_event.dart';
import 'package:battle_gender/features/game_over/presentation/state/end_game_bloc/end_game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EndGameBloc extends Bloc<EndGameEvent, EndGameState> {
  EndGameBloc() : super(const EndGameState()) {
    on<EndGameEvent>((event, emit) {});
  }
}
