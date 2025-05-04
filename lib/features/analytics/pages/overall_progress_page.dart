import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import '../widgets/progress_chart.dart';
import '../widgets/statistics_card.dart';

class OverallProgressPage extends StatelessWidget {
  const OverallProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overall Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  title: 'Total Habits',
                  value: '12',
                  icon: Icons.list_alt,
                  color: AppColors.primary,
                ),
                StatisticsCard(
                  title: 'Completed Today',
                  value: '8',
                  icon: Icons.check_circle_outline,
                  color: AppColors.success,
                ),
                StatisticsCard(
                  title: 'Current Streak',
                  value: '7 days',
                  icon: Icons.local_fire_department,
                  color: AppColors.accent,
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
              'Habit Performance',
              style: AppText.heading2,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5, // TODO: Replace with actual habits
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Habit ${index + 1}',
                              style: AppText.heading3,
                            ),
                            Text(
                              '${(index + 1) * 20}%',
                              style: AppText.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: (index + 1) * 0.2,
                          backgroundColor: AppColors.background,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 