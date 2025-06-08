import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen_game_content.dart';

@RoutePage()
class ScreenGame extends StatefulWidget {
  final List<TemporaryPlayer> players;
  final int startingPlayerGender;
  final String startingPlayerId;
  final List<CardQuestions> questions;
  const ScreenGame(
      {super.key,
      required this.players,
      required this.startingPlayerGender,
      required this.startingPlayerId,
      required this.questions});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc(
        players: widget.players,
        questions: widget.questions,
        startingPlayerGender: widget.startingPlayerGender,
        startingPlayerId: widget.startingPlayerId,
        animationController: animationController,
        pageController: PageController(viewportFraction: 0.8),
      ),
      child: ScreenGameContent(
          players: widget.players,
          startingPlayerGender: widget.startingPlayerGender,
          startingPlayerId: widget.startingPlayerId,
          questions: widget.questions),
    );
  }
}
