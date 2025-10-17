import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.feedback});

  final String feedback;

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = feedback == 'Correct';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect ? AppColors.success : AppColors.error,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feedback,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isCorrect ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
