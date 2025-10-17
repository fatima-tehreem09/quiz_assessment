class QuestionModel {
  QuestionModel({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  List<String> get allShuffledOptions {
    final List<String> options = <String>[...incorrectAnswers, correctAnswer];
    options.shuffle();
    return options;
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      category: json['category'] as String? ?? '',
      type: json['type'] as String? ?? 'multiple',
      difficulty: json['difficulty'] as String? ?? 'easy',
      question: _decodeHtml(json['question'] as String? ?? ''),
      correctAnswer: _decodeHtml(json['correct_answer'] as String? ?? ''),
      incorrectAnswers:
          (json['incorrect_answers'] as List<dynamic>? ?? <dynamic>[])
              .map((dynamic e) => _decodeHtml(e.toString()))
              .toList(),
    );
  }

  static String _decodeHtml(String input) {
    return input
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }
}
