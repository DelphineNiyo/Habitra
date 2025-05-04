import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';

class HabitHistoryTile extends StatelessWidget {
  final DateTime date;
  final bool completed;

  const HabitHistoryTile({
    super.key,
    required this.date,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          completed ? Icons.check_circle : Icons.cancel,
          color: completed ? AppColors.primary : AppColors.error,
        ),
        title: Text(
          '${date.day}/${date.month}/${date.year}',
          style: AppText.bodyMedium,
        ),
        subtitle: Text(
          completed ? 'Completed' : 'Missed',
          style: AppText.bodySmall.copyWith(
            color: completed ? AppColors.primary : AppColors.error,
          ),
        ),
      ),
    );
  }
} 