import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class TimerBar extends StatelessWidget {
  const TimerBar({super.key, required this.secondsLeft});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.timer,
            color:
                secondsLeft <= 10 ? AppColors.error : AppColors.primaryPurple,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: secondsLeft / 60,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                secondsLeft <= 10 ? AppColors.error : AppColors.primaryPurple,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${secondsLeft}s',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondsLeft <= 10 ? AppColors.error : null,
                ),
          ),
        ],
      ),
    );
  }
}
