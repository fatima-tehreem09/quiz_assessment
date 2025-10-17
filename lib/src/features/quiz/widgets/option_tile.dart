import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.showFeedback,
    required this.isCorrect,
    required this.onTap,
  });

  final int index;
  final String text;
  final bool isSelected;
  final bool showFeedback;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade300;
    Color backgroundColor = Theme.of(context).colorScheme.surface;

    if (showFeedback) {
      if (isCorrect) {
        borderColor = AppColors.success;
        backgroundColor = AppColors.success.withValues(alpha: 0.1);
      } else if (isSelected) {
        borderColor = AppColors.error;
        backgroundColor = AppColors.error.withValues(alpha: 0.1);
      }
    } else if (isSelected) {
      borderColor = AppColors.primaryPurple;
      backgroundColor = AppColors.primaryPurple.withValues(alpha: 0.1);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: borderColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              String.fromCharCode(65 + index),
              style: TextStyle(
                color: isSelected || showFeedback
                    ? AppColors.lightOnPrimary
                    : Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        onTap: onTap,
      ),
    );
  }
}


