import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/creation_players/presentation/state/adding_new_game_bloc/adding_new_game_event.dart';
import 'package:battle_gender/features/creation_players/presentation/state/adding_new_game_bloc/adding_new_game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingNewGameBloc extends Bloc<AddingNewGameEvent, AddingNewGameState> {
  AddingNewGameBloc() : super(const AddingNewGameState(players: [])) {
    on<AddPlayer>((event, emit) {
      final newPlayers = List<TemporaryPlayer>.from(state.players)
        ..add(TemporaryPlayer());
      emit(state.copyWith(players: newPlayers));
    });

    on<DeletePlayer>((event, emit) {
      final newPlayers = List<TemporaryPlayer>.from(state.players)
        ..removeAt(event.index);
      emit(state.copyWith(players: newPlayers));
    });

    on<UpdatePlayerGender>((event, emit) {
      final updatedPlayers = List<TemporaryPlayer>.from(state.players);
      final updatedPlayer =
          updatedPlayers[event.index].copyWith(gender: event.gender);
      updatedPlayers[event.index] = updatedPlayer;
      emit(state.copyWith(players: updatedPlayers));
    });

    on<UpdatePlayerName>((event, emit) {
      final updated = List<TemporaryPlayer>.from(state.players);
      updated[event.index].name.text = event.name;
      emit(state.copyWith(players: updated));
    });
  }
}
