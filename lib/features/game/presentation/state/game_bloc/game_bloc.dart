import 'dart:async';
import 'dart:math';

import 'package:battle_gender/constants/game_config.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/card_side.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_event.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late final void Function(AnimationStatus) _animationStatusListener;

  GameBloc({
    required List<TemporaryPlayer> players,
    required List<CardQuestions> questions,
    required String startingPlayerId,
    required int startingPlayerGender,
    required AnimationController animationController,
    required PageController pageController,
  }) : super(
          GameState(
            cardSide: CardSide.front,
            nextCardSide: CardSide.front,
            players: players,
            questions: questions,
            currentPlayerIndex: () {
              final index =
                  players.indexWhere((p) => p.id == startingPlayerId);
              return index == -1 ? 0 : index;
            }(),
            selectedIndex: pageController.initialPage,
            previousPage: pageController.initialPage,
            canScroll: true,
            isTapped: false,
            isFlipped: false,
            isCardVisible: true,
            animationController: animationController,
            pageController: pageController,
            rotationAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeInOut,
              ),
            ),
            opacityAnimation: Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeInOut,
              ),
            ),
            playerReachedMaxPoints: null,
          ),
        ) {
    on<OnPageChanged>(_onPageChanged);
    on<QuantityTap>(_onQuantityTap);
    on<FlipCompleted>(_onFlipCompleted);
    on<SelectRandomBox>(_onSelectRandomBox);
    on<PointsIncrement>(_onPointsIncrement);
    on<NextPlayer>(_onNextPlayer);

    _animationStatusListener = (status) {
      if (status == AnimationStatus.completed) {
        add(FlipCompleted());
      }
    };
    animationController.addStatusListener(_animationStatusListener);
  }

  @override
  Future<void> close() {
    state.animationController.removeStatusListener(_animationStatusListener);
    return super.close();
  }

  TemporaryPlayer get _currentPlayer => state.players[state.currentPlayerIndex];

  List<CardQuestions> get _filteredQuestions => state.questions
      .where((q) =>
          q.type ==
          (_currentPlayer.gender == 0
              ? CardQuestionsType.man
              : CardQuestionsType.woman))
      .toList();

  FutureOr<void> _onPageChanged(OnPageChanged event, Emitter<GameState> emit) {
    if (!state.canScroll) {
      state.pageController.animateToPage(
        state.previousPage,
        duration: GameConfig.pageReturnDuration,
        curve: Curves.easeOut,
      );
    } else {
      emit(state.copyWith(
        selectedIndex: event.index,
        previousPage: event.index,
      ));
    }
  }

  FutureOr<void> _onQuantityTap(
    QuantityTap event,
    Emitter<GameState> emit,
  ) {
    /// защита от быстрого тапа
    if (state.animationController.isAnimating) return null;

    CardSide next;

    switch (state.cardSide) {
      case CardSide.front:
        next = CardSide.question;
        break;

      case CardSide.question:
        next = CardSide.answer;
        break;

      case CardSide.answer:
        next = CardSide.question;
        break;
    }

    emit(state.copyWith(
      nextCardSide: next,
      canScroll: false,
    ));

    state.animationController.forward(from: 0);
  }

  FutureOr<void> _onFlipCompleted(
    FlipCompleted event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      cardSide: state.nextCardSide,
      nextCardSide: state.nextCardSide,
      canScroll: state.nextCardSide == CardSide.front,
    ));
  }

  FutureOr<void> _onSelectRandomBox(
      SelectRandomBox event, Emitter<GameState> emit) async {
    if (state.canScroll) {
      final currentIndex = state.pageController.page?.round() ?? 0;

      final randomIndex = currentIndex +
          5 +
          Random().nextInt(_filteredQuestions.length * 3) -
          _filteredQuestions.length;

      await state.pageController.animateToPage(
        randomIndex,
        duration: GameConfig.randomScrollDuration,
        curve: Curves.easeInOut,
      );

      emit(state.copyWith(
        selectedIndex: randomIndex,
        previousPage: randomIndex,
      ));
    }
  }

  FutureOr<void> _onPointsIncrement(
      PointsIncrement event, Emitter<GameState> emit) {
    final players = List<TemporaryPlayer>.from(state.players);
    final currentPlayer = players[state.currentPlayerIndex];

    currentPlayer.points++;

    TemporaryPlayer? winner;

    if (currentPlayer.points >= GameConfig.winPoints && state.playerReachedMaxPoints == null) {
      winner = currentPlayer;
    }

    emit(state.copyWith(
      players: players,
      playerReachedMaxPoints: winner,
    ));
  }

  FutureOr<void> _onNextPlayer(
      NextPlayer event, Emitter<GameState> emit) async {
    emit(state.copyWith(isCardVisible: false));

    await Future.delayed(GameConfig.nextPlayerDelay);

    state.animationController.reset();

    int nextIndex = (state.currentPlayerIndex + 1) % state.players.length;

    final gender = state.players[nextIndex].gender;

    final filteredQuestionsForNextPlayer = state.questions
        .where((q) =>
            q.type ==
            (gender == 0 ? CardQuestionsType.man : CardQuestionsType.woman))
        .toList();

    final random = Random();

    final randomIndex = filteredQuestionsForNextPlayer.length * GameConfig.infiniteScrollMultiplier +
        random.nextInt(filteredQuestionsForNextPlayer.length);

    emit(state.copyWith(
      currentPlayerIndex: nextIndex,
      canScroll: true,
      isFlipped: false,
      isTapped: false,
      selectedIndex: randomIndex,
      previousPage: randomIndex,
      isCardVisible: true,
      cardSide: CardSide.front,
      nextCardSide: CardSide.front,
    ));

    if (state.pageController.hasClients) {
      state.pageController.jumpToPage(randomIndex);
    }

    if (state.playerReachedMaxPoints != null &&
        state.players[nextIndex].id == state.playerReachedMaxPoints!.id) {
      event.onGameEnd?.call();
    }
  }
}
