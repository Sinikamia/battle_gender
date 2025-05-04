import 'dart:math';

import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:flutter/material.dart';

class PageViewPlayer extends StatelessWidget {
  final List<TemporaryPlayer> players;
  final PageController controller;
  final int selectedIndex;
  final Function(int) onPageChanged;
  final Function(int) onPlayerTap;

  const PageViewPlayer(
      {super.key,
      required this.players,
      required this.controller,
      required this.selectedIndex,
      required this.onPageChanged,
      required this.onPlayerTap});
  int _getActualIndex(int index) {
    return index % players.length;
  }

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white70,
      fontSize: 27,
      fontWeight: FontWeight.w700,
    );
    return Expanded(
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("Кто начинает?", style: myStyle),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: PageView.builder(
                          controller: controller,
                          onPageChanged: onPageChanged,
                          itemBuilder: (context, index) {
                            int actualIndex = index;
                            TemporaryPlayer player =
                                players[_getActualIndex(index)];

                            return AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                double scale = 1.0;
                                if (controller.position.haveDimensions) {
                                  double pageOffset = controller.page ?? 0;
                                  scale = max(0.8,
                                      1 - (pageOffset - index).abs() + 0.3);
                                }

                                bool isSelected = actualIndex == selectedIndex;

                                // actualIndex - индекс билда
                                // selectedIndex - индекс выбранного

                                final isNext = switch (actualIndex) {
                                  == 0 => selectedIndex == players.length - 1,
                                  _ => selectedIndex == actualIndex - 1,
                                };

                                // bool isNext = actualIndex ==
                                //     (selectedIndex + 1) %
                                //         widget.players.length;
                                return Center(
                                  child: GestureDetector(
                                    onTap: () => onPlayerTap(actualIndex),
                                    child: Transform.scale(
                                      scale: isSelected ? 1.0 : 0.8,
                                      alignment: isNext
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(
                                                  0xFF600010) // основной (тёмный)
                                              : const Color(0xFF9E2A38),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            if (isSelected)
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                              ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            player.name.text,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
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
    );
  }
}
