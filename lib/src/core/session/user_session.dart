class UserSession {
  String username = 'Tehreem Hashmi';
  String avatarUrl = 'https://i.pravatar.cc/150?img=47';
  int rank = 128;
  int totalQuizzes = 0;
  int totalCorrect = 0;

  double get accuracy => totalQuizzes == 0 ? 0 : totalCorrect / (totalQuizzes * 10);

  void recordQuiz({required int correct}) {
    totalQuizzes += 1;
    totalCorrect += correct;
  }
}


