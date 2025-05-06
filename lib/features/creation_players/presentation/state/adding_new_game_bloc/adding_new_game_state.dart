import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:equatable/equatable.dart';

class AddingNewGameState extends Equatable {
  final List<TemporaryPlayer> players;
  const AddingNewGameState({required this.players});

  AddingNewGameState copyWith({List<TemporaryPlayer>? players}) {
    return AddingNewGameState(players: players ?? this.players);
  }

  @override
  List<Object?> get props => [players];
}
