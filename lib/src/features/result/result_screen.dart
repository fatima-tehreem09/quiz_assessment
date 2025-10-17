import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/locator.dart';
import '../../core/router/app_router.dart';
import '../../core/session/user_session.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        (GoRouterState.of(context).extra as Map<String, dynamic>? ??
            <String, dynamic>{});
    final int correct = args['correct'] as int? ?? 0;
    final int total = args['total'] as int? ?? 0;
    final UserSession session = serviceLocator<UserSession>();
    session.recordQuiz(correct: correct);

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('You scored $correct / $total',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Back to Home'),
            )
          ],
        ),
      ),
    );
  }
}
