import 'dart:math';

import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_answer.dart';
import 'package:battle_gender/features/game/presentation/ui/widgets/card_coup_questions.dart';
import 'package:battle_gender/shared/utils/scroll_physics/custom_scroll_physics.dart';
import 'package:flutter/material.dart';

class PageViewCard extends StatelessWidget {
  final PageController pageController;
  final AnimationController controller;
  final Function(int) onPageChanged;
  final int selectedIndex;
  final Function() quantityTap;
  final bool canScroll;
  final double opacity;
  final double textOpacity;
  final Animation<double> rotationAnimation;
  final List<CardQuestions> filteredQuestions;

  const PageViewCard({
    super.key,
    required this.pageController,
    required this.canScroll,
    required this.controller,
    required this.onPageChanged,
    required this.selectedIndex,
    required this.quantityTap,
    required this.opacity,
    required this.textOpacity,
    required this.rotationAnimation,
    required this.filteredQuestions,
  });

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
                                    scale: isSelected ? 0.87 : 0.7,
                                    alignment: isNext == null
                                        ? Alignment.center
                                        : isNext
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: isSelected
                                        ? AnimatedBuilder(
                                            animation: controller,
                                            builder: (context, child) {
                                              final isFlipped =
                                                  rotationAnimation.value > 0.5;
                                              return Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..setEntry(3, 2, 0.0012)
                                                  ..rotateY(pi *
                                                      rotationAnimation.value),
                                                child: isFlipped
                                                    ? CardAnswer(
                                                        text: currentQuestion
                                                            .answer)
                                                    : CardCoupQuestions(
                                                        text: currentQuestion
                                                            .question,
                                                        opacity: opacity,
                                                        textOpacity:
                                                            textOpacity,
                                                      ),
                                              );
                                            })
                                        : CardCoupQuestions(
                                            text: currentQuestion.question,
                                            opacity: opacity,
                                            textOpacity: textOpacity,
                                          ),
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
