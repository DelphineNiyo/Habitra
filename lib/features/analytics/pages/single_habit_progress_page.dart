import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import '../widgets/progress_chart.dart';
import '../widgets/statistics_card.dart';

class SingleHabitProgressPage extends StatelessWidget {
  final String habitId;

  const SingleHabitProgressPage({
    super.key,
    required this.habitId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual habit data
    final String habitTitle = 'Morning Exercise';
    final String habitDescription = '30 minutes of cardio';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habitTitle,
              style: AppText.heading2,
            ),
            const SizedBox(height: 8),
            Text(
              habitDescription,
              style: AppText.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Weekly Progress',
              style: AppText.heading2,
            ),
            const SizedBox(height: 16),
            const ProgressChart(),
            const SizedBox(height: 24),
            Text(
              'Statistics',
              style: AppText.heading2,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                StatisticsCard(
                  title: 'Current Streak',
                  value: '7 days',
                  icon: Icons.local_fire_department,
                  color: AppColors.accent,
                ),
                StatisticsCard(
                  title: 'Best Streak',
                  value: '21 days',
                  icon: Icons.star,
                  color: AppColors.warning,
                ),
                StatisticsCard(
                  title: 'Total Completions',
                  value: '45',
                  icon: Icons.check_circle_outline,
                  color: AppColors.success,
                ),
                StatisticsCard(
                  title: 'Success Rate',
                  value: '85%',
                  icon: Icons.trending_up,
                  color: AppColors.secondary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Monthly Overview',
              style: AppText.heading2,
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'March 2024',
                          style: AppText.heading3,
                        ),
                        Text(
                          '75%',
                          style: AppText.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: 31, // Days in March
                      itemBuilder: (context, index) {
                        final completed = index % 3 != 0; // Dummy data
                        return Container(
                          decoration: BoxDecoration(
                            color: completed
                                ? AppColors.primary
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 