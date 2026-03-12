import 'package:flutter/material.dart';

class TemporaryPlayer {
  String id;
  final TextEditingController name;
  int gender = -1;
  int points = 0;

  TemporaryPlayer({
    String? id,
    TextEditingController? name,
    this.gender = -1,
    this.points = 0,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name = name ?? TextEditingController();

  TemporaryPlayer copyWith({
    String? id,
    TextEditingController? name,
    int? gender,
    int? points,
  }) {
    return TemporaryPlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      points: points ?? this.points,
    );
  }
}
