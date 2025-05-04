import 'package:equatable/equatable.dart';

abstract class PlayerChoiceEvent extends Equatable {
  const PlayerChoiceEvent();

  @override
  List<Object> get props => [];
}

class PlayerSelected extends PlayerChoiceEvent {
  final int index;

  const PlayerSelected(this.index);

  @override
  List<Object> get props => [index];
}
