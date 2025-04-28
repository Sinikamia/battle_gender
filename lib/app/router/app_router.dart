import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/about_game/presentation/ui/screen_about_application.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/creation_players/presentation/ui/screen_adding_new_game.dart';
import 'package:battle_gender/features/game/presentation/ui/screen_game.dart';
import 'package:battle_gender/features/game_over/presentation/ui/screen_end_game.dart';
import 'package:battle_gender/features/rules/presentation/ui/screen_rules_game.dart';
import 'package:battle_gender/features/settings/presentation/ui/screen_setting.dart';
import 'package:battle_gender/features/start_game/presentation/screen_player_choice.dart';
import 'package:battle_gender/main.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MyHomeRoute.page, initial: true),
        AutoRoute(page: RouteAddingNewGame.page),
        AutoRoute(page: RouteGame.page),
        AutoRoute(page: RoutePlayerChoice.page),
        AutoRoute(page: RouteEndGame.page),
        AutoRoute(page: RouteSetting.page),
        AutoRoute(page: RouteAboutApplication.page),
        AutoRoute(page: RouteRulesGame.page),
      ];
}
