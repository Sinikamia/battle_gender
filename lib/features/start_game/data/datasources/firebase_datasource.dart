import 'package:battle_gender/features/game/domain/models/question_models.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IFirebaseDatasource {
  Future<List<CardQuestions>> loadQuestions();
}

class FirebaseDatasource implements IFirebaseDatasource {
  @override
  Future<List<CardQuestions>> loadQuestions() async {
    final dbRef = FirebaseDatabase.instance.ref("questions");
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;

      return data.entries.map((entry) {
        final value = entry.value;
        final typeString = value['type'] as String;
        final type = typeString == 'man'
            ? CardQuestionsType.man
            : CardQuestionsType.woman;

        return CardQuestions(
          question: value['question'] ?? '',
          answer: value['answer'] ?? '',
          type: type,
        );
      }).toList();
    } else {
      return [];
    }
  }
}
