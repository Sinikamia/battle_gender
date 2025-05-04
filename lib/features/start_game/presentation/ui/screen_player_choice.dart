import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_bloc.dart';
import 'package:battle_gender/features/start_game/presentation/ui/screen_player_choice_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenPlayerChoice extends StatelessWidget {
  final List<TemporaryPlayer> players;

  const ScreenPlayerChoice({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayerChoiceBloc(),
      child: ScreenPlayerChoiceContent(players: players),
    );
  }
}
