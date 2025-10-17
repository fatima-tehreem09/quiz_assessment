import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/di/locator.dart';
import '../../../data/quiz/quiz_models.dart';
import '../../../data/quiz/quiz_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(
      {required this.amount,
      required this.categoryId,
      required this.difficulty,
      required this.type})
      : super(const QuizState.loading());

  final int amount;
  final int categoryId;
  final String difficulty;
  final String type;

  final QuizRepository _repo = serviceLocator<QuizRepository>();

  Timer? _timer;

  Future<void> load() async {
    emit(const QuizState.loading());
    try {
      final List<QuestionModel> questions = await _repo.getQuestions(
        amount: amount,
        categoryId: categoryId,
        difficulty: difficulty,
        type: type,
      );
      if (questions.isEmpty) {
        emit(const QuizState.error('No questions found'));
        return;
      }

      final List<List<String>> optionsPerQuestion = questions.map((q) {
        final opts = <String>[...q.incorrectAnswers, q.correctAnswer];
        opts.shuffle();
        return opts;
      }).toList(growable: false);

      emit(QuizState.playing(
        questions: questions,
        currentIndex: 0,
        secondsLeft: 60,
        correctCount: 0,
        selected: null,
        feedback: null,
        optionsPerQuestion: optionsPerQuestion,
      ));
      _startTimer();
    } catch (e) {
      emit(QuizState.error('Failed to load: $e'));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      final QuizState s = state;
      if (s is QuizPlaying) {
        if (s.secondsLeft <= 1) {
          _submit(null);
        } else {
          emit(s.copyWith(secondsLeft: s.secondsLeft - 1));
        }
      }
    });
  }

  void select(String option) {
    final QuizState s = state;
    if (s is QuizPlaying && s.feedback == null) {
      emit(s.copyWith(selected: option));
    }
  }

  void submit() =>
      _submit(state is QuizPlaying ? (state as QuizPlaying).selected : null);

  void _submit(String? selected) {
    final QuizState s = state;
    if (s is! QuizPlaying) return;
    _timer?.cancel();
    final QuestionModel q = s.questions[s.currentIndex];
    final bool isCorrect = selected != null && selected == q.correctAnswer;

    emit(s.copyWith(
      feedback: isCorrect ? 'Correct' : 'Incorrect',
      correctCount: s.correctCount + (isCorrect ? 1 : 0),
      selected: selected,
    ));

    Future<void>.delayed(const Duration(seconds: 1), () {
      final QuizState s2 = state;
      if (s2 is! QuizPlaying) return;
      final int nextIndex = s2.currentIndex + 1;
      if (nextIndex >= s2.questions.length) {
        emit(QuizState.finished(
            correctCount: s2.correctCount, total: s2.questions.length));
      } else {
        final QuizPlaying cleared = s2.copyWith(feedback: null);
        emit(cleared);
        Future<void>.delayed(const Duration(seconds: 1), () {
          final QuizState s3 = state;
          if (s3 is! QuizPlaying) return;
          emit(s3.copyWith(
            currentIndex: nextIndex,
            secondsLeft: 60,
            selected: null,
            feedback: null,
          ));
          _startTimer();
        });
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
