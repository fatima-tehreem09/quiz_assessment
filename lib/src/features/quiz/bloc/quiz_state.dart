part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  const factory QuizState.loading() = QuizLoading;
  const factory QuizState.error(String message) = QuizError;
  const factory QuizState.playing({
    required List<QuestionModel> questions,
    required int currentIndex,
    required int secondsLeft,
    required int correctCount,
    required String? selected,
    required String? feedback,
    required List<List<String>> optionsPerQuestion,
    required bool isFeedbackVisible,
  }) = QuizPlaying;
  const factory QuizState.finished({required int correctCount, required int total}) = QuizFinished;

  @override
  List<Object?> get props => <Object?>[];
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizError extends QuizState {
  const QuizError(this.message);
  final String message;
  @override
  List<Object?> get props => <Object?>[message];
}

class QuizPlaying extends QuizState {
  const QuizPlaying({
    required this.questions,
    required this.currentIndex,
    required this.secondsLeft,
    required this.correctCount,
    required this.selected,
    required this.feedback,
    required this.optionsPerQuestion,
    required this.isFeedbackVisible,
  });

  final List<QuestionModel> questions;
  final int currentIndex;
  final int secondsLeft;
  final int correctCount;
  final String? selected;
  final String? feedback;
  final List<List<String>> optionsPerQuestion;
  final bool isFeedbackVisible;

  QuestionModel get currentQuestion => questions[currentIndex];
  List<String> get currentOptions => optionsPerQuestion[currentIndex];
  double get progress => (currentIndex + 1) / questions.length;

  QuizPlaying copyWith({
    List<QuestionModel>? questions,
    int? currentIndex,
    int? secondsLeft,
    int? correctCount,
    String? selected,
    String? feedback,
    List<List<String>>? optionsPerQuestion,
    bool? isFeedbackVisible,
  }) {
    return QuizPlaying(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      correctCount: correctCount ?? this.correctCount,
      selected: selected ?? this.selected,
      feedback: feedback ?? this.feedback,
      optionsPerQuestion: optionsPerQuestion ?? this.optionsPerQuestion,
      isFeedbackVisible: isFeedbackVisible ?? this.isFeedbackVisible,
    );
  }

  @override
  List<Object?> get props => <Object?>[questions, currentIndex, secondsLeft, correctCount, selected, feedback, optionsPerQuestion, isFeedbackVisible];
}

class QuizFinished extends QuizState {
  const QuizFinished({required this.correctCount, required this.total});
  final int correctCount;
  final int total;
  @override
  List<Object?> get props => <Object?>[correctCount, total];
}


