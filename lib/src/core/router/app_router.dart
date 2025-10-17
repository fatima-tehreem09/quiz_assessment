import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash.dart';
import '../../features/home/home_screen.dart';
import '../../features/countdown/countdown_screen.dart';
import '../../features/quiz/quiz_screen.dart';
import '../../features/result/result_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String countdown = '/countdown';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: Splash()),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (BuildContext context, GoRouterState state) => 
          CustomTransitionPage(
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
          ),
      ),
      GoRoute(
        path: AppRoutes.countdown,
        pageBuilder: (BuildContext context, GoRouterState state) => 
          CustomTransitionPage(
            child: const CountdownScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween(begin: const Offset(0.0, 0.3), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOut)),
                  ),
                  child: child,
                ),
              );
            },
          ),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        pageBuilder: (BuildContext context, GoRouterState state) => 
          CustomTransitionPage(
            child: const QuizScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation.drive(
                  Tween(begin: 0.8, end: 1.0)
                      .chain(CurveTween(curve: Curves.elasticOut)),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
      ),
      GoRoute(
        path: AppRoutes.result,
        pageBuilder: (BuildContext context, GoRouterState state) => 
          CustomTransitionPage(
            child: const ResultScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
          ),
      ),
    ],
  );
}


