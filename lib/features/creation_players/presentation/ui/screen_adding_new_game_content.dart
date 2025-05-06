import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/presentation/state/adding_new_game_bloc/adding_new_game_bloc.dart';
import 'package:battle_gender/features/creation_players/presentation/state/adding_new_game_bloc/adding_new_game_event.dart';
import 'package:battle_gender/features/creation_players/presentation/ui/widgets/card_creation_player.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAddingNewGameContent extends StatefulWidget {
  const ScreenAddingNewGameContent({super.key});

  @override
  State<ScreenAddingNewGameContent> createState() =>
      _ScreenAddingNewGameContentState();
}

class _ScreenAddingNewGameContentState
    extends State<ScreenAddingNewGameContent> {
  bool showSnackBarInsteadOfButton = false;
  String snackBarMessage = "";

  bool get hasSelectedGender {
    final players = context.read<AddingNewGameBloc>().state.players;
    return players.isNotEmpty && players.every((player) => player.gender != -1);
  }

  bool get hasFilledNames {
    final players = context.read<AddingNewGameBloc>().state.players;
    return players.isNotEmpty &&
        players.every((player) => player.name.text.isNotEmpty);
  }

  void showTemporarySnackBar(String message) {
    setState(() {
      showSnackBarInsteadOfButton = true;
      snackBarMessage = message;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showSnackBarInsteadOfButton = false;
      });
    });
  }

  void startGame() {
    final players = context.read<AddingNewGameBloc>().state.players;
    if (players.isEmpty) {
      showTemporarySnackBar("Добавьте хотя бы одного игрока");
    } else if (!hasSelectedGender) {
      showTemporarySnackBar("Выберите пол для всех игроков");
    } else if (!hasFilledNames) {
      showTemporarySnackBar("Заполните поле имени всех игроков");
    } else {
      context.pushRoute(RoutePlayerChoice(players: players));
    }
  }

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white70,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    const myStyle2 = TextStyle(
      color: Colors.white70,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarUniversal(
        text: "Новая игра",
        onTap: () {
          context.router.pop();
        },
        iconSettings: Icons.settings_outlined,
        iconMenu: Icons.menu_book,
        onTapMenu: () {
          context.pushRoute(const RouteRulesGame());
        },
        onTapSettings: () {
          context.pushRoute(const RouteSetting());
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
              Expanded(
                child: context.watch<AddingNewGameBloc>().state.players.isEmpty
                    ? const Center(
                        child: Text(
                          "Пожалуйста, добавьте хотя бы одного игрока",
                          textAlign: TextAlign.center,
                          style: myStyle2,
                        ),
                      )
                    : ListView.builder(
                        itemCount: context
                            .watch<AddingNewGameBloc>()
                            .state
                            .players
                            .length,
                        itemBuilder: (context, index) {
                          return CardCreationPlayer(
                            controller: context
                                .watch<AddingNewGameBloc>()
                                .state
                                .players[index]
                                .name,
                            onPressed: () {
                              context
                                  .read<AddingNewGameBloc>()
                                  .add(DeletePlayer(index));
                            },
                            onTap: () {
                              context
                                  .read<AddingNewGameBloc>()
                                  .add(UpdatePlayerGender(index, 0));
                            },
                            onTap2: () {
                              context
                                  .read<AddingNewGameBloc>()
                                  .add(UpdatePlayerGender(index, 1));
                            },
                            selectedIndex: context
                                .watch<AddingNewGameBloc>()
                                .state
                                .players[index]
                                .gender,
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: showSnackBarInsteadOfButton
                      ? Center(
                          child: Text(
                            snackBarMessage,
                            textAlign: TextAlign.center,
                            style: myStyle2,
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF600010),
                          ),
                          onPressed: () {
                            context.read<AddingNewGameBloc>().add(AddPlayer());
                          },
                          child: const Text("Добавить игроков", style: myStyle),
                        ),
                ),
              ),
              const SizedBox(height: 40),
              ButtonPaintedOver(text: "Начать игру", onTap: startGame),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
