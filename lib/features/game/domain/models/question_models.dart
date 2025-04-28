enum CardQuestionsType { man, woman }

class CardQuestions {
  final String question;
  final CardQuestionsType type;
  final String answer;

  CardQuestions(
      {required this.question, required this.type, required this.answer});
}
