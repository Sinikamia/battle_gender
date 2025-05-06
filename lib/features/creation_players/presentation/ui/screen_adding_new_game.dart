import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/creation_players/presentation/state/adding_new_game_bloc/adding_new_game_bloc.dart';
import 'package:battle_gender/features/creation_players/presentation/ui/screen_adding_new_game_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenAddingNewGame extends StatelessWidget {
  const ScreenAddingNewGame({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AddingNewGameBloc(),
        child: const ScreenAddingNewGameContent());
  }
}
