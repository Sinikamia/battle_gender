import 'package:equatable/equatable.dart';

class PlayerChoiceState extends Equatable {
  final int selectedIndex;

  const PlayerChoiceState({
    required this.selectedIndex,
  });
  @override
  List<Object?> get props => [selectedIndex];
}
