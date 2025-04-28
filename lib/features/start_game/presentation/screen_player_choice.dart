import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_game.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScreenPlayerChoice extends StatefulWidget {
  final List<TemporaryPlayer> players;

  const ScreenPlayerChoice({super.key, required this.players});

  @override
  State<ScreenPlayerChoice> createState() => _ScreenPlayerChoiceState();
}

class _ScreenPlayerChoiceState extends State<ScreenPlayerChoice> {
  final PageController _pageController = PageController(viewportFraction: 0.45);
  int selectedIndex = 0;

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
    print(index);
    return index % widget.players.length;
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _selectRandomBox() async {
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

    setState(() {
      selectedIndex = randomIndex;
    });
  }

  void startGame() {
    TemporaryPlayer selectedPlayer =
        widget.players[_getActualIndex(selectedIndex)];

    context.pushRoute(RouteGame(
      players: widget.players,
      startingPlayerId: selectedPlayer.id,
      startingPlayerGender: selectedPlayer.gender,
    ));
  }

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white70,
      fontSize: 27,
      fontWeight: FontWeight.w700,
    );

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
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 250,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text("Кто начинает?", style: myStyle),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: _onPageChanged,
                                    itemBuilder: (context, index) {
                                      int actualIndex = index;
                                      TemporaryPlayer player = widget
                                          .players[_getActualIndex(index)];

                                      return AnimatedBuilder(
                                        animation: _pageController,
                                        builder: (context, child) {
                                          double scale = 1.0;
                                          if (_pageController
                                              .position.haveDimensions) {
                                            double pageOffset =
                                                _pageController.page ?? 0;
                                            scale = max(
                                                0.8,
                                                1 -
                                                    (pageOffset - index).abs() +
                                                    0.3);
                                          }

                                          bool isSelected =
                                              actualIndex == selectedIndex;

                                          // actualIndex - индекс билда
                                          // selectedIndex - индекс выбранного

                                          final isNext = switch (actualIndex) {
                                            == 0 => selectedIndex ==
                                                widget.players.length - 1,
                                            _ =>
                                              selectedIndex == actualIndex - 1,
                                          };

                                          // bool isNext = actualIndex ==
                                          //     (selectedIndex + 1) %
                                          //         widget.players.length;
                                          return Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = actualIndex;
                                                });
                                              },
                                              child: Transform.scale(
                                                scale: isSelected ? 1.0 : 0.8,
                                                alignment: isNext
                                                    ? Alignment.centerLeft
                                                    : Alignment.centerRight,
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 6),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? const Color(
                                                            0xFF600010) // основной (тёмный)
                                                        : const Color(
                                                            0xFF9E2A38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      if (isSelected)
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          blurRadius: 10,
                                                          offset: const Offset(
                                                              0, 5),
                                                        ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      player.name.text,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
