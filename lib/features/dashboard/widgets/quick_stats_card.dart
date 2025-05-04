import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  icon: Icons.check_circle_outline,
                  value: '5',
                  label: 'Completed',
                  color: AppColors.success,
                ),
                _buildStatItem(
                  icon: Icons.pending_actions,
                  value: '3',
                  label: 'Pending',
                  color: AppColors.warning,
                ),
                _buildStatItem(
                  icon: Icons.timer,
                  value: '2',
                  label: 'Missed',
                  color: AppColors.error,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.5, // TODO: Replace with actual progress
              backgroundColor: AppColors.background,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Progress',
                  style: AppText.bodyMedium,
                ),
                Text(
                  '50%', // TODO: Replace with actual percentage
                  style: AppText.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppText.heading3.copyWith(
            color: color,
          ),
        ),
        Text(
          label,
          style: AppText.caption,
        ),
      ],
    );
  }
} 