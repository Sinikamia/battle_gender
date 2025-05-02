// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<void> {
  const MyHomeRoute({List<PageRouteInfo>? children})
    : super(MyHomeRoute.name, initialChildren: children);

  static const String name = 'MyHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyHomePage();
    },
  );
}

/// generated route for
/// [ScreenAboutApplication]
class RouteAboutApplication extends PageRouteInfo<void> {
  const RouteAboutApplication({List<PageRouteInfo>? children})
    : super(RouteAboutApplication.name, initialChildren: children);

  static const String name = 'RouteAboutApplication';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScreenAboutApplication();
    },
  );
}

/// generated route for
/// [ScreenAddingNewGame]
class RouteAddingNewGame extends PageRouteInfo<void> {
  const RouteAddingNewGame({List<PageRouteInfo>? children})
    : super(RouteAddingNewGame.name, initialChildren: children);

  static const String name = 'RouteAddingNewGame';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScreenAddingNewGame();
    },
  );
}

/// generated route for
/// [ScreenEndGame]
class RouteEndGame extends PageRouteInfo<RouteEndGameArgs> {
  RouteEndGame({
    Key? key,
    required List<TemporaryPlayer> players,
    List<PageRouteInfo>? children,
  }) : super(
         RouteEndGame.name,
         args: RouteEndGameArgs(key: key, players: players),
         initialChildren: children,
       );

  static const String name = 'RouteEndGame';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteEndGameArgs>();
      return ScreenEndGame(key: args.key, players: args.players);
    },
  );
}

class RouteEndGameArgs {
  const RouteEndGameArgs({this.key, required this.players});

  final Key? key;

  final List<TemporaryPlayer> players;

  @override
  String toString() {
    return 'RouteEndGameArgs{key: $key, players: $players}';
  }
}

/// generated route for
/// [ScreenGame]
class RouteGame extends PageRouteInfo<RouteGameArgs> {
  RouteGame({
    Key? key,
    required List<TemporaryPlayer> players,
    required int startingPlayerGender,
    required String startingPlayerId,
    required List<CardQuestions> questions,
    List<PageRouteInfo>? children,
  }) : super(
         RouteGame.name,
         args: RouteGameArgs(
           key: key,
           players: players,
           startingPlayerGender: startingPlayerGender,
           startingPlayerId: startingPlayerId,
           questions: questions,
         ),
         initialChildren: children,
       );

  static const String name = 'RouteGame';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteGameArgs>();
      return ScreenGame(
        key: args.key,
        players: args.players,
        startingPlayerGender: args.startingPlayerGender,
        startingPlayerId: args.startingPlayerId,
        questions: args.questions,
      );
    },
  );
}

class RouteGameArgs {
  const RouteGameArgs({
    this.key,
    required this.players,
    required this.startingPlayerGender,
    required this.startingPlayerId,
    required this.questions,
  });

  final Key? key;

  final List<TemporaryPlayer> players;

  final int startingPlayerGender;

  final String startingPlayerId;

  final List<CardQuestions> questions;

  @override
  String toString() {
    return 'RouteGameArgs{key: $key, players: $players, startingPlayerGender: $startingPlayerGender, startingPlayerId: $startingPlayerId, questions: $questions}';
  }
}

/// generated route for
/// [ScreenPlayerChoice]
class RoutePlayerChoice extends PageRouteInfo<RoutePlayerChoiceArgs> {
  RoutePlayerChoice({
    Key? key,
    required List<TemporaryPlayer> players,
    List<PageRouteInfo>? children,
  }) : super(
         RoutePlayerChoice.name,
         args: RoutePlayerChoiceArgs(key: key, players: players),
         initialChildren: children,
       );

  static const String name = 'RoutePlayerChoice';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RoutePlayerChoiceArgs>();
      return ScreenPlayerChoice(key: args.key, players: args.players);
    },
  );
}

class RoutePlayerChoiceArgs {
  const RoutePlayerChoiceArgs({this.key, required this.players});

  final Key? key;

  final List<TemporaryPlayer> players;

  @override
  String toString() {
    return 'RoutePlayerChoiceArgs{key: $key, players: $players}';
  }
}

/// generated route for
/// [ScreenRulesGame]
class RouteRulesGame extends PageRouteInfo<void> {
  const RouteRulesGame({List<PageRouteInfo>? children})
    : super(RouteRulesGame.name, initialChildren: children);

  static const String name = 'RouteRulesGame';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScreenRulesGame();
    },
  );
}

/// generated route for
/// [ScreenSetting]
class RouteSetting extends PageRouteInfo<void> {
  const RouteSetting({List<PageRouteInfo>? children})
    : super(RouteSetting.name, initialChildren: children);

  static const String name = 'RouteSetting';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScreenSetting();
    },
  );
}
