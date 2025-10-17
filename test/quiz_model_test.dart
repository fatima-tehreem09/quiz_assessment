import 'package:flutter_test/flutter_test.dart';
import 'package:Quiz/src/data/quiz_models.dart';

void main() {
  test('QuestionModel parses OpenTDB json and decodes html', () {
    final Map<String, dynamic> json = <String, dynamic>{
      'category': 'General Knowledge',
      'type': 'multiple',
      'difficulty': 'easy',
      'question': 'What does &quot;CPU&quot; stand for?',
      'correct_answer': 'Central Processing Unit',
      'incorrect_answers': <String>['Central Process Unit', 'Computer Personal Unit', 'Central Processor Unit'],
    };
    final QuestionModel q = QuestionModel.fromJson(json);
    expect(q.category, 'General Knowledge');
    expect(q.type, 'multiple');
    expect(q.question.contains('"'), true);
    expect(q.correctAnswer, 'Central Processing Unit');
    expect(q.incorrectAnswers.length, 3);
    expect(q.allShuffledOptions.length, 4);
  });
}


