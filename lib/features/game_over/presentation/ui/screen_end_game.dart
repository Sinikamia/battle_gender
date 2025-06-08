import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game_over/presentation/state/end_game_bloc/end_game_bloc.dart';
import 'package:battle_gender/features/game_over/presentation/ui/screen_end_game_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenEndGame extends StatelessWidget {
  final List<TemporaryPlayer> players;
  const ScreenEndGame({
    super.key,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => EndGameBloc(),
        child: ScreenEndGameContent(players: players));
  }
}
