import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game_over/presentation/ui/widgets/card_winner.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';

class ScreenEndGameContent extends StatefulWidget {
  final List<TemporaryPlayer> players;
  const ScreenEndGameContent({super.key, required this.players});

  @override
  State<ScreenEndGameContent> createState() => _ScreenEndGameContentState();
}

class _ScreenEndGameContentState extends State<ScreenEndGameContent> {
  late List<TemporaryPlayer> sortedPlayers;
  late TemporaryPlayer winner;
  late bool isDraw;
  @override
  void initState() {
    super.initState();
    sortedPlayers = [...widget.players]
      ..sort((a, b) => b.points.compareTo(a.points));
    winner = sortedPlayers.first;

    isDraw = sortedPlayers.length > 1 &&
        sortedPlayers[0].points == sortedPlayers[1].points;
  }

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white70,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: const AppBarUniversal(
        text: "Игра окончена",
      ),
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
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: const Color(0xFF600010),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                isDraw
                                    ? "Настоящая ничья! Силы равны, интрига на высоте. Кто осмелится нарушить этот баланс в следующей игре?"
                                    : "Поздравляем с победой, ${winner.name.text}! Найдется ли тот кто сможет превзойти тебя в следующем игре? Пусть докажет!",
                                style: myStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: width,
                            color: const Color(0xFF600010),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: [
                                ...sortedPlayers.asMap().entries.map(
                                  (entry) {
                                    final index = entry.key;
                                    final player = entry.value;
                                    final position = index + 1;

                                    return CardWinner(
                                      text: player.name.text,
                                      points: player.points.toString(),
                                      position: position.toString(),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: ButtonPaintedOver(
                    text: "Новая игра",
                    onTap: () {
                      context.pushRoute(const RouteAddingNewGame());
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
