## Quiz Assessment

### Overview
Responsive Flutter app (Web + Mobile) using clean architecture, DI (`get_it`), state management (`bloc`), and routing (`go_router`). It fetches quiz questions from Open Trivia DB and provides a timed quiz flow with feedback and results.

### Structure
```
lib/
  app.dart                 // App init and router boot
  main.dart                // Entry point
  src/
    core/
      di/locator.dart     // Service locator
      network/dio_client.dart
      router/app_router.dart
      session/user_session.dart
    data/
      quiz_api.dart       // OpenTDB API client
      quiz_models.dart    // Question/Category models
      quiz_repository.dart
    features/
      splash.dart
      home/home_screen.dart
      countdown/countdown_screen.dart
      quiz/
        quiz_cubit.dart
        quiz_state.dart
        quiz_screen.dart
      result/result_screen.dart
```

### Getting Started
- Flutter 3.24+ and Dart 3.4+

Run mobile (iOS/Android):
```bash
flutter pub get
flutter run
```

Run web:
```bash
flutter pub get
flutter run -d chrome
```

### Features
- Home: user header (avatar, name, rank, score) and mock categories.
- Countdown: 3..2..1 animation, then starts quiz.
- Quiz: 1-minute timer per question, progress indicator, immediate feedback, highlight correct/incorrect, auto-advance.
- Result: shows score and updates user session summary, navigates back to Home.

### Tests
Run tests:
```bash
flutter test
```
Included:
- Unit: `QuestionModel` JSON parsing and HTML decode.
- Widget: `QuizScreen` basic rendering and interaction.

### Notes & Decisions
- DI with `get_it`, `dio` for networking.
- `go_router` for declarative routing and passing arguments via `extra`.
- `bloc` for quiz flow state, timer handled with periodic `Timer`.
- HTML entities decoded minimally for OpenTDB content.

# frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
