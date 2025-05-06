import 'package:equatable/equatable.dart';

abstract class AddingNewGameEvent extends Equatable {
  const AddingNewGameEvent();

  @override
  List<Object?> get props => [];
}

class AddPlayer extends AddingNewGameEvent {}

class DeletePlayer extends AddingNewGameEvent {
  final int index;
  const DeletePlayer(this.index);
}

class UpdatePlayerGender extends AddingNewGameEvent {
  final int index;
  final int gender;
  const UpdatePlayerGender(this.index, this.gender);
}

class UpdatePlayerName extends AddingNewGameEvent {
  final int index;
  final String name;
  const UpdatePlayerName(this.index, this.name);
}
