import 'package:dio/dio.dart';

import 'quiz_models.dart';

class QuizApi {
  QuizApi(this._dio);

  final Dio _dio;

  Future<List<QuestionModel>> fetchQuestions({
    required int amount,
    required int categoryId,
    String difficulty = 'easy',
    String type = 'multiple',
  }) async {
    final Response<dynamic> response = await _dio.get(
      'https://opentdb.com/api.php',
      queryParameters: <String, dynamic>{
        'amount': amount,
        'category': categoryId,
        'difficulty': difficulty,
        'type': type,
      },
    );

    final Map<String, dynamic> data = Map<String, dynamic>.from(response.data as Map);
    final List<dynamic> results = data['results'] as List<dynamic>;
    return results.map((dynamic e) => QuestionModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }
}


