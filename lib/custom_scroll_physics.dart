import 'package:flutter/widgets.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final bool canScroll;

  const CustomScrollPhysics({ScrollPhysics? parent, required this.canScroll})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      parent: buildParent(ancestor),
      canScroll: canScroll,
    );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true; // разрешаем тянуть
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (canScroll) return offset;
    return offset * 0.1;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if (!canScroll) {
      // Всегда возвращаем на текущее место
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        position.pixels,
        velocity,
        tolerance: tolerance,
      );
    }
    return super.createBallisticSimulation(position, velocity);
  }

  @override
  bool get allowImplicitScrolling => canScroll;
}
