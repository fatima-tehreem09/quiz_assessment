import 'quiz_api.dart';
import 'quiz_models.dart';

abstract class QuizRepository {
  Future<List<QuestionModel>> getQuestions({
    required int amount,
    required int categoryId,
    String difficulty = 'easy',
    String type = 'multiple',
  });
}

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl(this._api);

  final QuizApi _api;

  @override
  Future<List<QuestionModel>> getQuestions({
    required int amount,
    required int categoryId,
    String difficulty = 'easy',
    String type = 'multiple',
  }) {
    return _api.fetchQuestions(
      amount: amount,
      categoryId: categoryId,
      difficulty: difficulty,
      type: type,
    );
  }
}


