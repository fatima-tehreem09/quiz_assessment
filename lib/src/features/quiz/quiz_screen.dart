import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/router/app_router.dart';
import '../../core/constants/colors.dart';
import '../../widgets/app_bar.dart';
import 'bloc/quiz_cubit.dart';
import 'widgets/question_text.dart';
import 'widgets/option_tile.dart';
import 'widgets/timer_bar.dart';
import 'widgets/feedback_banner.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, this.cubit});

  final QuizCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        (GoRouterState.of(context).extra as Map<String, dynamic>? ??
            <String, dynamic>{});
    final int amount = args['amount'] as int? ?? 10;
    final int categoryId = args['categoryId'] as int? ?? 9;
    final String difficulty = args['difficulty'] as String? ?? 'easy';
    final String type = args['type'] as String? ?? 'multiple';

    return BlocProvider<QuizCubit>(
      create: (_) => (cubit ??
          QuizCubit(
              amount: amount,
              categoryId: categoryId,
              difficulty: difficulty,
              type: type))
        ..load(),
      child: BlocConsumer<QuizCubit, QuizState>(
        listener: (BuildContext context, QuizState state) {
          if (state is QuizFinished) {
            context.go(AppRoutes.result, extra: <String, dynamic>{
              'correct': state.correctCount,
              'total': state.total
            });
          }
        },
        builder: (BuildContext context, QuizState state) {
          if (state is QuizLoading) {
            return Scaffold(
              appBar: const AppBarWidget(
                title: 'Loading Quiz...',
                showThemeToggle: false,
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context)
                          .colorScheme
                          .surface
                          .withValues(alpha: 0.8),
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
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColors.primaryGradient,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.quiz,
                            size: 40,
                            color: AppColors.lightOnPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          'Preparing your quiz...',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryPurple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is QuizError) {
            return Scaffold(
              appBar: const AppBarWidget(
                title: 'Error',
                showThemeToggle: false,
              ),
              body: Center(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Oops! Something went wrong',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.7),
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () => context.go(AppRoutes.home),
                        icon: const Icon(Icons.home),
                        label: const Text('Go Home'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is QuizPlaying) {
            final options = state.currentOptions;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Question ${state.currentIndex + 1}/${state.questions.length}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.primaryGradient,
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(8),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: state.progress,
                        backgroundColor:
                            AppColors.lightOnPrimary.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.lightOnPrimary),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context)
                          .colorScheme
                          .surface
                          .withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            child: QuestionText(text: state.currentQuestion.question),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...options.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final String opt = entry.value;
                        final bool isSelected = state.selected == opt;
                        final bool showFeedback = state.feedback != null;
                        final bool isCorrect =
                            opt == state.currentQuestion.correctAnswer;

                        Color borderColor = Colors.grey.shade300;
                        Color backgroundColor =
                            Theme.of(context).colorScheme.surface;

                        if (showFeedback) {
                          if (isCorrect) {
                            borderColor = AppColors.success;
                            backgroundColor =
                                AppColors.success.withValues(alpha: 0.1);
                          } else if (isSelected) {
                            borderColor = AppColors.error;
                            backgroundColor =
                                AppColors.error.withValues(alpha: 0.1);
                          }
                        } else if (isSelected) {
                          borderColor = AppColors.primaryPurple;
                          backgroundColor =
                              AppColors.primaryPurple.withValues(alpha: 0.1);
                        }

                        return OptionTile(
                          index: index,
                          text: opt,
                          isSelected: isSelected,
                          showFeedback: showFeedback,
                          isCorrect: isCorrect,
                          onTap: showFeedback ? null : () => context.read<QuizCubit>().select(opt),
                        );
                      }),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: TimerBar(secondsLeft: state.secondsLeft)),
                          const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: state.feedback != null ||
                                      state.selected == null
                                  ? null
                                  : () => context.read<QuizCubit>().submit(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              child: const Text('Submit'),
                          ),
                        ],
                      ),
                      if (state.feedback != null) ...[
                        const SizedBox(height: 16),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          child: FeedbackBanner(feedback: state.feedback!),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
