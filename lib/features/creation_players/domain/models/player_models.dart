import 'package:flutter/material.dart';

class PlayerModel {
  final String id;
  final String name;
  final int gender;
  final int points;

  PlayerModel(
      {required this.name,
      required this.gender,
      this.id = '',
      this.points = 0});
}

class TemporaryPlayer {
  String id;
  final TextEditingController name = TextEditingController();
  int gender = -1;
  int points = 0;

  TemporaryPlayer({String? id})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  PlayerModel toPlayerModel() {
    return PlayerModel(
      id: id,
      name: name.text,
      gender: gender,
      points: points,
    );
  }
}
