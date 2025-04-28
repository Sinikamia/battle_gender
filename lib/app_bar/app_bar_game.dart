import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/router/app_router.dart';
import 'package:flutter/material.dart';

class AppBarGame extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;

  const AppBarGame({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );
    return AppBar(
      backgroundColor: const Color(0xFF600010),
      elevation: 10,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: const Color(0xFF1E1E1E),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/background_1.jpg"),
                            fit: BoxFit.cover,
                            opacity: 0.01)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.warning,
                                color: Color(0xFFC1BCB6),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Закрыть",
                                  style: TextStyle(
                                      color: Color(0xFFC1BCB6),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Завершить игру?",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFFC1BCB6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.router.pop();
                                },
                                child: const Text("Отменить",
                                    style: TextStyle(
                                        color: Color(0xFFC1BCB6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushRoute(const MyHomeRoute());
                                },
                                child: const Text("OK",
                                    style: TextStyle(
                                        color: Color(0xFFC1BCB6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      title: const Text("Игра", style: myStyle),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu_book, color: Colors.white),
          onPressed: onPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
