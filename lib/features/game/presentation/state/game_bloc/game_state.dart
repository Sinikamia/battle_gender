import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GameState extends Equatable {
  final List<TemporaryPlayer> players;
  final List<CardQuestions> questions;
  final int currentPlayerIndex;
  final int selectedIndex;
  final bool canScroll;
  final bool isTapped;
  final bool isFlipped;
  final bool isCardVisible;
  final double opacity;
  final double textOpacity;
  final int previousPage;
  final AnimationController animationController;
  final Animation<double> rotationAnimation;
  final Animation<double> opacityAnimation;
  final PageController pageController;
  final TemporaryPlayer? playerReachedMaxPoints;

  const GameState({
    required this.players,
    required this.questions,
    required this.currentPlayerIndex,
    required this.selectedIndex,
    required this.canScroll,
    required this.opacity,
    required this.isTapped,
    required this.isFlipped,
    required this.textOpacity,
    required this.animationController,
    required this.rotationAnimation,
    required this.pageController,
    this.playerReachedMaxPoints,
    required this.isCardVisible,
    required this.previousPage,
    required this.opacityAnimation,
  });

  TemporaryPlayer get currentPlayer => players[currentPlayerIndex];

  GameState copyWith({
    List<TemporaryPlayer>? players,
    List<CardQuestions>? questions,
    int? currentPlayerIndex,
    int? selectedIndex,
    bool? canScroll,
    bool? isTapped,
    bool? isFlipped,
    bool? isCardVisible,
    double? opacity,
    double? textOpacity,
    int? previousPage,
    AnimationController? animationController,
    Animation<double>? rotationAnimation,
    Animation<double>? opacityAnimation,
    PageController? pageController,
    TemporaryPlayer? playerReachedMaxPoints,
  }) {
    return GameState(
      players: players ?? this.players,
      questions: questions ?? this.questions,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      canScroll: canScroll ?? this.canScroll,
      isTapped: isTapped ?? this.isTapped,
      isFlipped: isFlipped ?? this.isFlipped,
      isCardVisible: isCardVisible ?? this.isCardVisible,
      previousPage: previousPage ?? this.previousPage,
      opacity: opacity ?? this.opacity,
      textOpacity: textOpacity ?? this.textOpacity,
      animationController: animationController ?? this.animationController,
      rotationAnimation: rotationAnimation ?? this.rotationAnimation,
      opacityAnimation: opacityAnimation ?? this.opacityAnimation,
      pageController: pageController ?? this.pageController,
      playerReachedMaxPoints:
          playerReachedMaxPoints ?? this.playerReachedMaxPoints,
    );
  }

  @override
  List<Object?> get props => [
        players,
        questions,
        currentPlayerIndex,
        selectedIndex,
        canScroll,
        opacity,
        textOpacity,
        animationController,
        rotationAnimation,
        pageController,
        playerReachedMaxPoints,
        isTapped,
        isFlipped,
        isCardVisible,
        previousPage,
        opacityAnimation
      ];
}
