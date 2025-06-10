import 'dart:async';
import 'dart:math';

import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_event.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(
      {required List<TemporaryPlayer> players,
      required List<CardQuestions> questions,
      required String startingPlayerId,
      required int startingPlayerGender,
      required AnimationController animationController,
      required PageController pageController})
      : super(
          GameState(
            players: players,
            questions: questions,
            currentPlayerIndex:
                players.indexWhere((p) => p.id == startingPlayerId),
            selectedIndex: pageController.initialPage,
            previousPage: pageController.initialPage,
            canScroll: true,
            isTapped: false,
            isFlipped: false,
            isCardVisible: true,
            opacity: 0.8,
            textOpacity: 0.1,
            animationController: animationController,
            pageController: pageController,
            rotationAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInOut),
            ),
            opacityAnimation: Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.easeInOut),
            ),
            playerReachedMaxPoints: null,
          ),
        ) {
    on<OnPageChanged>(_onPageChanged);
    on<QuantityTap>(_onQuantityTap);
    on<SelectRandomBox>(_onSelectRandomBox);
    on<PointsIncrement>(_onPointsIncrement);
    on<NextPlayer>(_onNextPlayer);
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      final newState = state.copyWith(
        selectedIndex: event.index,
        previousPage: event.index,
      );
      emit(newState);
    }
  }

  FutureOr<void> _onQuantityTap(QuantityTap event, Emitter<GameState> emit) {
    if (!state.isTapped) {
      emit(state.copyWith(
        isTapped: !state.isTapped,
        canScroll: !state.canScroll,
        opacity: state.opacity == 0.8 ? 0.0 : 0.8,
        textOpacity: state.textOpacity == 0.1 ? 1.0 : 0.1,
      ));
    } else {
      emit(state.copyWith(isFlipped: !state.isFlipped));
      Future.microtask(() {
        if (state.isFlipped) {
          state.animationController.forward();
        } else {
          state.animationController.reverse();
        }
      });
    }
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
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      final newState = state.copyWith(
        selectedIndex: randomIndex,
        previousPage: randomIndex,
      );
      emit(newState);
    }
  }

  FutureOr<void> _onPointsIncrement(
      PointsIncrement event, Emitter<GameState> emit) {
    final players = List<TemporaryPlayer>.from(state.players);
    final currentPlayer = players[state.currentPlayerIndex];

    currentPlayer.points++;

    TemporaryPlayer? winner;

    if (currentPlayer.points >= 20 && state.playerReachedMaxPoints == null) {
      winner = currentPlayer;
    }
    emit(state.copyWith(players: players, playerReachedMaxPoints: winner));
  }

  FutureOr<void> _onNextPlayer(
      NextPlayer event, Emitter<GameState> emit) async {
    emit(state.copyWith(isCardVisible: false));
    await Future.delayed(const Duration(milliseconds: 500));

    state.animationController.reset();

    int nextIndex = (state.currentPlayerIndex + 1) % state.players.length;

    final gender = state.players[nextIndex].gender;
    final filteredQuestionsForNextPlayer = state.questions
        .where((q) =>
            q.type ==
            (gender == 0 ? CardQuestionsType.man : CardQuestionsType.woman))
        .toList();

    final random = Random();
    final randomIndex = filteredQuestionsForNextPlayer.length * 100 +
        random.nextInt(filteredQuestionsForNextPlayer.length);

    emit(state.copyWith(
      currentPlayerIndex: nextIndex,
      canScroll: true,
      isFlipped: false,
      isTapped: false,
      opacity: 0.8,
      textOpacity: 0.1,
      selectedIndex: randomIndex,
      previousPage: randomIndex,
      isCardVisible: true,
    ));

    if (state.pageController.hasClients) {
      state.pageController.jumpToPage(randomIndex);
    }

    if (state.playerReachedMaxPoints != null &&
        state.players[nextIndex].id == state.playerReachedMaxPoints!.id) {
      event.onGameEnd?.call();
      return;
    }
  }
}
