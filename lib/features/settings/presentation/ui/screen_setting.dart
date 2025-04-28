import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:battle_gender/shared/widgets/button/button_empty.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScreenSetting extends StatefulWidget {
  const ScreenSetting({super.key});

  @override
  State<ScreenSetting> createState() => _ScreenSettingState();
}

class _ScreenSettingState extends State<ScreenSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(
        onTap: () {
          context.router.pop();
        },
        text: "Настройки",
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.01,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background_1.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Column(children: [
            const SizedBox(
              height: 20,
            ),
            ButtonEmpty(
                text: "Правила",
                icon: Icons.menu_book,
                onPressed: () {
                  context.pushRoute(const RouteRulesGame());
                }),
            const SizedBox(
              height: 20,
            ),
            ButtonEmpty(
                text: "О приложении",
                icon: Icons.info_outline_rounded,
                onPressed: () {
                  context.pushRoute(const RouteAboutApplication());
                }),
            const SizedBox(
              height: 20,
            ),
          ]),
        ],
      ),
    );
  }
}
