// import 'package:Quiz/src/features/quiz/quiz_cubit.dart';
// import 'package:Quiz/src/features/quiz/quiz_screen.dart';
// import 'package:Quiz/src/data/quiz_models.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// class FakeCubit extends QuizCubit {
//   FakeCubit() : super(amount: 1, categoryId: 9, difficulty: 'easy', type: 'multiple');
//   void seedPlaying(QuestionModel q) {
//     emit(QuizState.playing(
//       questions: <QuestionModel>[q],
//       currentIndex: 0,
//       secondsLeft: 60,
//       correctCount: 0,
//       selected: null,
//       feedback: null,
//     ));
//   }
//   @override
//   Future<void> load() async {}
// }
//
// void main() {
//   testWidgets('QuizScreen shows question and reacts to selection', (WidgetTester tester) async {
//     final QuestionModel q = QuestionModel(
//       category: 'General',
//       type: 'multiple',
//       difficulty: 'easy',
//       question: '2 + 2 = ?',
//       correctAnswer: '4',
//       incorrectAnswers: <String>['3', '5', '22'],
//     );
//
//     final FakeCubit cubit = FakeCubit()..seedPlaying(q);
//
//     await tester.pumpWidget(MaterialApp(home: QuizScreen(cubit: cubit)));
//
//     expect(find.text('2 + 2 = ?'), findsOneWidget);
//     await tester.tap(find.text('4'));
//     await tester.pump();
//     await tester.tap(find.text('Submit'));
//     await tester.pump();
//   });
// }
//
//
