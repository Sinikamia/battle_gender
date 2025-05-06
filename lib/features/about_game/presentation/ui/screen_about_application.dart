import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/about_game/presentation/state/about_application_bloc/about_application_bloc.dart';
import 'package:battle_gender/features/about_game/presentation/ui/screen_about_application_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenAboutApplication extends StatelessWidget {
  const ScreenAboutApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AboutApplicationBloc(),
        child: const ScreenAboutApplicationContent());
  }
}
