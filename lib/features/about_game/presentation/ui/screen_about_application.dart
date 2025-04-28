import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:battle_gender/shared/widgets/button/button_empty.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScreenAboutApplication extends StatefulWidget {
  const ScreenAboutApplication({super.key});

  @override
  State<ScreenAboutApplication> createState() => _ScreenAboutApplicationState();
}

class _ScreenAboutApplicationState extends State<ScreenAboutApplication> {
  @override
  Widget build(BuildContext context) {
    void onTap() {
      setState(() {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBarUniversal(
        onTap: onTap,
        text: "О приложении",
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.01,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background_1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ButtonEmpty(
                  text: "Оценить приложение",
                  icon: Icons.star,
                  onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              ButtonEmpty(
                  text: "Связаться с нами",
                  icon: Icons.email,
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
