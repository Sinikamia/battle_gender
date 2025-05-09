import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/app/router/app_router.dart';
import 'package:battle_gender/features/creation_players/domain/models/player_models.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/button_answer.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_player.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/pageview_card.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_game.dart';
import 'package:battle_gender/shared/widgets/button/button_painted_over.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScreenGame extends StatefulWidget {
  final List<TemporaryPlayer> players;
  final int startingPlayerGender;
  final String startingPlayerId;
  final List<CardQuestions> questions;
  const ScreenGame(
      {super.key,
      required this.players,
      required this.startingPlayerGender,
      required this.startingPlayerId,
      required this.questions});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<CardQuestions> filteredQuestions;
  late Animation<double> _rotationAnimation;
  late int _currentPlayerIndex;
  late Animation<double> _opacityAnimation;
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int selectedIndex = 0;
  bool canScroll = true;
  bool _isFlipped = false;
  double _opacity = 0.8;
  double _textOpacity = 0.1;
  bool _isTapped = false;
  int _previousPage = 0;
  bool _isCardVisible = true;
  TemporaryPlayer? _playerReachedMaxPoints;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _currentPlayerIndex =
        widget.players.indexWhere((p) => p.id == widget.startingPlayerId);

    filteredQuestions = widget.questions
        .where((q) =>
            q.type ==
            (currentPlayer.gender == 0
                ? CardQuestionsType.man
                : CardQuestionsType.woman))
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialPage = filteredQuestions.length * 100;
      _pageController.jumpToPage(initialPage);
      _previousPage = initialPage;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBlur() {
    setState(() {
      _opacity = _opacity == 0.8 ? 0.0 : 0.8;
      _textOpacity = _textOpacity == 0.1 ? 1.0 : 0.1;
      _isTapped = !_isTapped;
      canScroll = !canScroll;
    });
  }

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _quantityTap() {
    if (!_isTapped) {
      _toggleBlur();
    } else {
      _flipCard();
    }
  }

  void _onPageChanged(int index) {
    if (!canScroll) {
      _pageController.animateToPage(
        _previousPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }
    setState(() {
      selectedIndex = index;
      _previousPage = index;
    });
  }

  Future<void> _selectRandomBox() async {
    if (canScroll) {
      int currentIndex = _pageController.page?.round() ?? 0;
      int randomIndex = currentIndex +
          5 +
          Random().nextInt(filteredQuestions.length * 3) -
          filteredQuestions.length;

      await _pageController.animateToPage(
        randomIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      setState(() {
        selectedIndex = randomIndex;
        _previousPage = randomIndex;
      });
    }
  }

  TemporaryPlayer get currentPlayer => widget.players[_currentPlayerIndex];

  void pointsIncrement() {
    setState(() {
      currentPlayer.points++;
      if (currentPlayer.points >= 20 && _playerReachedMaxPoints == null) {
        _playerReachedMaxPoints = currentPlayer;
      }
    });
  }

  void nextPlayer() async {
    setState(() {
      _isCardVisible = false;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % widget.players.length;

      _isFlipped = false;
      _isTapped = false;
      _opacity = 0.8;
      _textOpacity = 0.1;
      canScroll = true;
      _controller.reset();

      final random = Random();
      final randomIndex = filteredQuestions.length * 100 +
          random.nextInt(filteredQuestions.length);
      _pageController.jumpToPage(randomIndex);
      selectedIndex = randomIndex;
      _previousPage = randomIndex;

      filteredQuestions = widget.questions
          .where((q) =>
              q.type ==
              (currentPlayer.gender == 0
                  ? CardQuestionsType.man
                  : CardQuestionsType.woman))
          .toList();

      _isCardVisible = true;
    });

    if (_playerReachedMaxPoints != null &&
        currentPlayer.id == _playerReachedMaxPoints!.id) {
      context.pushRoute(RouteEndGame(
        players: widget.players,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGame(
        onPressed: () {
          context.pushRoute(const RouteRulesGame());
        },
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.01,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background_4.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(children: [
            const SizedBox(height: 20),
            CardPlayer(player: currentPlayer),
            const SizedBox(height: 16),
            PageViewCard(
                pageController: _pageController,
                canScroll: canScroll,
                controller: _controller,
                onPageChanged: _onPageChanged,
                selectedIndex: selectedIndex,
                quantityTap: _quantityTap,
                opacity: _opacity,
                textOpacity: _textOpacity,
                rotationAnimation: _rotationAnimation,
                filteredQuestions: filteredQuestions),
            const SizedBox(height: 16),
            canScroll
                ? Column(
                    children: [
                      const SizedBox(
                        height: 59,
                      ),
                      ButtonPaintedOver(
                          text: "Выбрать случайно", onTap: _selectRandomBox),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 43,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Выбери «Правильно», если ответ верный, и «Неправильно», если неверный",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonAnswer(
                                text: "Неправильно",
                                onTap: () {
                                  nextPlayer();
                                },
                                colorsButton: Colors.red.shade400),
                            const SizedBox(width: 10),
                            ButtonAnswer(
                                text: "Правильно",
                                onTap: () {
                                  pointsIncrement();
                                  nextPlayer();
                                },
                                colorsButton: Colors.green.shade400),
                          ]),
                    ],
                  ),
            const SizedBox(height: 30),
          ]),
        ],
      ),
    );
  }
}
