enum CardQuestionsType { man, woman }

class CardQuestions {
  final String question;
  final CardQuestionsType type;
  final String answer;

  CardQuestions(
      {required this.question, required this.type, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'type': type.name, // или type.toString().split('.').last
    };
  }

  factory CardQuestions.fromJson(Map<String, dynamic> json) {
    return CardQuestions(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      type: CardQuestionsType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CardQuestionsType.woman,
      ),
    );
  }
}
