import 'dart:math';

import 'package:battle_gender/constants/game_config.dart';
import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/state/game_bloc/card_side.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_answer.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_coup_questions.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_front.dart';
import 'package:battle_gender/shared/utils/scroll_physics/custom_scroll_physics.dart';
import 'package:flutter/material.dart';

class PageViewCard extends StatelessWidget {
  final PageController pageController;
  final AnimationController controller;
  final Function(int) onPageChanged;
  final int selectedIndex;
  final Function() quantityTap;
  final bool canScroll;
  final Animation<double> rotationAnimation;
  final List<CardQuestions> filteredQuestions;
  final CardSide cardSide;
  final CardSide nextCardSide;

  const PageViewCard(
      {super.key,
      required this.pageController,
      required this.canScroll,
      required this.controller,
      required this.onPageChanged,
      required this.selectedIndex,
      required this.quantityTap,
      required this.rotationAnimation,
      required this.filteredQuestions,
      required this.cardSide,
      required this.nextCardSide});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                  ),
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    physics: CustomScrollPhysics(canScroll: canScroll),
                    itemBuilder: (context, index) {
                      int actualIndex = index % filteredQuestions.length;
                      CardQuestions currentQuestion =
                          filteredQuestions[actualIndex];
                      return AnimatedBuilder(
                        animation: pageController,
                        builder: (context, child) {
                          double scale = 1.0;
                          if (pageController.position.haveDimensions) {
                            double pageOffset = pageController.page ?? 0;
                            scale =
                                max(0.8, 1 - (pageOffset - index).abs() + 0.3);
                          }

                          bool isSelected = index == selectedIndex;
                          final isNext = index > selectedIndex
                              ? true
                              : index < selectedIndex
                                  ? false
                                  : null;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: GestureDetector(
                              onTap: quantityTap,
                              child: Stack(
                                children: [
                                  Transform.scale(
                                    scale: isSelected ? GameConfig.cardScaleSelected : GameConfig.cardScaleUnselected,
                                    alignment: isNext == null
                                        ? Alignment.center
                                        : isNext
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: isSelected
                                        ? AnimatedBuilder(
                                            animation: controller,
                                            builder: (context, child) {
                                              Widget frontCard;
                                              Widget backCard;

                                              switch (cardSide) {
                                                case CardSide.front:
                                                  frontCard = const CardFront();
                                                  break;

                                                case CardSide.question:
                                                  frontCard = CardCoupQuestions(
                                                    text: currentQuestion
                                                        .question,
                                                  );
                                                  break;

                                                case CardSide.answer:
                                                  frontCard = CardAnswer(
                                                    text:
                                                        currentQuestion.answer,
                                                  );
                                                  break;
                                              }

                                              switch (nextCardSide) {
                                                case CardSide.front:
                                                  backCard = const CardFront();
                                                  break;

                                                case CardSide.question:
                                                  backCard = CardCoupQuestions(
                                                    text: currentQuestion
                                                        .question,
                                                  );
                                                  break;

                                                case CardSide.answer:
                                                  backCard = CardAnswer(
                                                    text:
                                                        currentQuestion.answer,
                                                  );
                                                  break;
                                              }

                                              final isBack =
                                                  rotationAnimation.value > 0.5;

                                              return Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..setEntry(3, 2, 0.0012)
                                                  ..rotateY(pi *
                                                      rotationAnimation.value),
                                                child: isBack
                                                    ? Transform(
                                                        alignment:
                                                            Alignment.center,
                                                        transform:
                                                            Matrix4.identity()
                                                              ..rotateY(pi),
                                                        child: backCard,
                                                      )
                                                    : frontCard,
                                              );
                                            })
                                        : const CardFront(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
