import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:flutter/material.dart';

class CardPlayer extends StatelessWidget {
  final TemporaryPlayer player;
  const CardPlayer({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const myStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeInBack,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -0.5),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Padding(
        key: ValueKey(player.id),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            width: width,
            color: const Color(0xFF600010),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      player.name.text,
                      style: myStyle1,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const Text(
                          "Твой результат:",
                          style: myStyle,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${player.points}/20 баллов",
                                style: myStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
