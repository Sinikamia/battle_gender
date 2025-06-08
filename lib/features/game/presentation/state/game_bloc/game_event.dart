import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class OnPageChanged extends GameEvent {
  final int index;

  const OnPageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class QuantityTap extends GameEvent {
  const QuantityTap();
}

class SelectRandomBox extends GameEvent {
  const SelectRandomBox();
}

class PointsIncrement extends GameEvent {
  const PointsIncrement();
}

class NextPlayer extends GameEvent {
  final VoidCallback? onGameEnd;
  const NextPlayer({
    this.onGameEnd,
  });
}
