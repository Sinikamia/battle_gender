import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/start_game/data/datasources/firebase_datasource.dart';
import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_bloc.dart';
import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_event.dart';
import 'package:battle_gender/features/start_game/presentation/state/player_choice_bloc/player_choice_state.dart';
import 'package:battle_gender/features/start_game/presentation/ui/widgets/pageview_player.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_game.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenPlayerChoiceContent extends StatefulWidget {
  final List<TemporaryPlayer> players;
  const ScreenPlayerChoiceContent({super.key, required this.players});

  @override
  State<ScreenPlayerChoiceContent> createState() =>
      _ScreenPlayerChoiceContentState();
}

class _ScreenPlayerChoiceContentState extends State<ScreenPlayerChoiceContent> {
  final PageController _pageController = PageController(viewportFraction: 0.45);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.players.length * 100);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _getActualIndex(int index) {
    return index % widget.players.length;
  }

  void _onPageChanged(int index) {
    setState(() {
      context.read<PlayerChoiceBloc>().add(PlayerSelected(index));
    });
  }

  Future<void> _selectRandomBox() async {
    final bloc = context.read<PlayerChoiceBloc>();
    int currentIndex = _pageController.page?.round() ?? 0;
    int randomIndex = currentIndex +
        5 +
        Random().nextInt(widget.players.length * 3) -
        widget.players.length;

    await _pageController.animateToPage(
      randomIndex,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
    bloc.add(PlayerSelected(randomIndex));
  }

  Future<void> startGame() async {
    final bloc = context.read<PlayerChoiceBloc>();
    final selectedIndex = bloc.state.selectedIndex;
    TemporaryPlayer selectedPlayer =
        widget.players[_getActualIndex(selectedIndex)];
    final IFirebaseDatasource firebaseDatasource = FirebaseDatasource();

    final questions = await firebaseDatasource.loadQuestions();
    if (mounted) {
      context.pushRoute(RouteGame(
        players: widget.players,
        startingPlayerId: selectedPlayer.id,
        startingPlayerGender: selectedPlayer.gender,
        questions: questions,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            opacity: 0.03,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background_4.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              BlocBuilder<PlayerChoiceBloc, PlayerChoiceState>(
                  builder: (context, state) {
                return PageViewPlayer(
                  players: widget.players,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  selectedIndex: state.selectedIndex,
                  onPlayerTap: (index) {
                    context.read<PlayerChoiceBloc>().add(PlayerSelected(index));
                  },
                );
              }),
              const SizedBox(height: 16),
              ButtonPaintedOver(
                  text: "Выбрать случайно", onTap: _selectRandomBox),
              const SizedBox(height: 20),
              ButtonPaintedOver(text: "Поехали!", onTap: startGame),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
