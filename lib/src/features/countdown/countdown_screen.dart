import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/router/app_router.dart';
import '../../core/constants/colors.dart';
import '../../widgets/app_bar.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with TickerProviderStateMixin {
  late AnimationController _countdownController;
  late AnimationController _pulseController;
  late Animation<double> _countdownAnimation;
  late Animation<double> _pulseAnimation;

  int _currentCount = 3;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _countdownAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.elasticOut),
    );

    _startCountdown();
  }

  void _startCountdown() {
    _countdownController.forward();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentCount--;
        });

        _pulseController.reset();
        _pulseController.forward();

        if (_currentCount < 0) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              final Object? args = GoRouterState.of(context).extra;
              context.go(AppRoutes.quiz, extra: args);
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _pulseController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    final String categoryName = args?['categoryName'] as String? ?? 'Quiz';

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Get Ready!',
        showThemeToggle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPurple.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (BuildContext context, Widget? child) {
                        Widget countdownWidget;

                        if (_currentCount > 0) {
                          countdownWidget =
                              _buildCountdownNumber(_currentCount);
                        } else if (_currentCount == 0) {
                          countdownWidget = _buildGoText();
                        } else {
                          countdownWidget = const SizedBox.shrink();
                        }

                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: countdownWidget,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  'Starting $categoryName Quiz',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: Text(
                  'Get ready to test your knowledge!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                      ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Container(
                  width: 200,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.primaryPurple.withValues(alpha: 0.3),
                  ),
                  child: AnimatedBuilder(
                    animation: _countdownAnimation,
                    builder: (context, child) {
                      final double progress = (3 - _currentCount) / 3;
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColors.primaryGradient,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownNumber(int number) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.lightOnPrimary.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.lightOnPrimary,
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.lightOnPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                fontFamily: 'InterTight',
              ),
        ),
      ),
    );
  }

  Widget _buildGoText() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success,
            AppColors.success.withValues(alpha: 0.8),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Text(
          'GO!',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.lightOnPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 60,
                fontFamily: 'InterTight',
              ),
        ),
      ),
    );
  }
}
