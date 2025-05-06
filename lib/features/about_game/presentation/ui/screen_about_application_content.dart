import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/settings/presentation/state/settings_bloc/settings_bloc.dart';
import 'package:battle_gender/features/settings/presentation/state/settings_bloc/settings_state.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:battle_gender/shared/widgets/button/button_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAboutApplicationContent extends StatelessWidget {
  const ScreenAboutApplicationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(
        onTap: () {
          context.router.pop();
        },
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
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
            return Column(
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
            );
          }),
        ],
      ),
    );
  }
}
