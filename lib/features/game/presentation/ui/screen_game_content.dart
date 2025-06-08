import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_bloc.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_event.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_state.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/button_answer.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_player.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/pageview_card.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_game.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenGameContent extends StatefulWidget {
  final List<TemporaryPlayer> players;
  final int startingPlayerGender;
  final String startingPlayerId;
  final List<CardQuestions> questions;

  const ScreenGameContent(
      {super.key,
      required this.players,
      required this.startingPlayerGender,
      required this.startingPlayerId,
      required this.questions});

  @override
  State<ScreenGameContent> createState() => _ScreenGameContentState();
}

class _ScreenGameContentState extends State<ScreenGameContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      final filteredQuestions = state.questions
          .where((q) =>
              q.type ==
              (state.currentPlayer.gender == 0
                  ? CardQuestionsType.man
                  : CardQuestionsType.woman))
          .toList();
      return Scaffold(
        appBar: AppBarGame(
          onPressed: () {
            context.pushRoute(const RouteRulesGame());
          },
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.01,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background_4.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(children: [
              const SizedBox(height: 20),
              CardPlayer(player: state.currentPlayer),
              const SizedBox(height: 16),
              PageViewCard(
                  pageController: state.pageController,
                  canScroll: state.canScroll,
                  controller: state.animationController,
                  onPageChanged: (index) {
                    context.read<GameBloc>().add(OnPageChanged(index));
                  },
                  selectedIndex: state.selectedIndex,
                  quantityTap: () {
                    context.read<GameBloc>().add(const QuantityTap());
                  },
                  opacity: state.opacity,
                  textOpacity: state.textOpacity,
                  rotationAnimation: state.rotationAnimation,
                  filteredQuestions: filteredQuestions),
              const SizedBox(height: 16),
              state.canScroll
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 59,
                        ),
                        ButtonPaintedOver(
                          text: "Выбрать случайно",
                          onTap: () {
                            context
                                .read<GameBloc>()
                                .add(const SelectRandomBox());
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 43,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Выбери «Правильно», если ответ верный, и «Неправильно», если неверный",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonAnswer(
                                  text: "Неправильно",
                                  onTap: () {
                                    context
                                        .read<GameBloc>()
                                        .add(const NextPlayer());
                                  },
                                  colorsButton: Colors.red.shade400),
                              const SizedBox(width: 10),
                              ButtonAnswer(
                                  text: "Правильно",
                                  onTap: () {
                                    context
                                        .read<GameBloc>()
                                        .add(const PointsIncrement());
                                    context.read<GameBloc>().add(NextPlayer(
                                      onGameEnd: () {
                                        context.pushRoute(RouteEndGame(
                                          players: widget.players,
                                        ));
                                      },
                                    ));
                                  },
                                  colorsButton: Colors.green.shade400),
                            ]),
                      ],
                    ),
              const SizedBox(height: 30),
            ]),
          ],
        ),
      );
    });
  }
}
