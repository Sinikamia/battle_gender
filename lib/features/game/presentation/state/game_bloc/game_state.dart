import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/card_side.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GameState extends Equatable {
  final CardSide cardSide;
  final CardSide nextCardSide;
  final List<TemporaryPlayer> players;
  final List<CardQuestions> questions;
  final int currentPlayerIndex;
  final int selectedIndex;
  final bool canScroll;
  final bool isTapped;
  final bool isFlipped;
  final bool isCardVisible;
  final int previousPage;
  final AnimationController animationController;
  final Animation<double> rotationAnimation;
  final Animation<double> opacityAnimation;
  final PageController pageController;
  final TemporaryPlayer? playerReachedMaxPoints;

  const GameState({
    required this.cardSide,
    required this.nextCardSide,
    required this.players,
    required this.questions,
    required this.currentPlayerIndex,
    required this.selectedIndex,
    required this.canScroll,
    required this.isTapped,
    required this.isFlipped,
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
    CardSide? cardSide,
    CardSide? nextCardSide,
    List<TemporaryPlayer>? players,
    List<CardQuestions>? questions,
    int? currentPlayerIndex,
    int? selectedIndex,
    bool? canScroll,
    bool? isTapped,
    bool? isFlipped,
    bool? isCardVisible,
    int? previousPage,
    AnimationController? animationController,
    Animation<double>? rotationAnimation,
    Animation<double>? opacityAnimation,
    PageController? pageController,
    TemporaryPlayer? playerReachedMaxPoints,
  }) {
    return GameState(
      cardSide: cardSide ?? this.cardSide,
      nextCardSide: nextCardSide ?? this.nextCardSide,
      players: players ?? this.players,
      questions: questions ?? this.questions,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      canScroll: canScroll ?? this.canScroll,
      isTapped: isTapped ?? this.isTapped,
      isFlipped: isFlipped ?? this.isFlipped,
      isCardVisible: isCardVisible ?? this.isCardVisible,
      previousPage: previousPage ?? this.previousPage,
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
        cardSide,
        nextCardSide,
        players,
        questions,
        currentPlayerIndex,
        selectedIndex,
        canScroll,
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
