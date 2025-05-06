import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/rules/presentation/state/rules_bloc/rules_bloc.dart';
import 'package:battle_gender/features/rules/presentation/ui/screen_rules_game_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenRulesGame extends StatelessWidget {
  const ScreenRulesGame({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RulesBloc(), child: ScreenRulesGameContent());
  }
}
