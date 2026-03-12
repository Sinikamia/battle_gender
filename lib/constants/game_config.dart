class GameConfig {
  GameConfig._();

  static const int winPoints = 20;
  static const int infiniteScrollMultiplier = 100;
  static const double cardScaleSelected = 0.87;
  static const double cardScaleUnselected = 0.7;
  static const Duration flipAnimationDuration = Duration(seconds: 1);
  static const Duration nextPlayerDelay = Duration(milliseconds: 500);
  static const Duration randomScrollDuration = Duration(milliseconds: 800);
  static const Duration pageReturnDuration = Duration(milliseconds: 300);
  static const double pageViewFraction = 0.8;
}
