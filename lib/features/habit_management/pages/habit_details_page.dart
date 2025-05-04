import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';
import '../models/habit.dart';

class HabitDetailsPage extends StatelessWidget {
  final String habitId;

  const HabitDetailsPage({
    super.key,
    required this.habitId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual habit data from state management
    final habit = Habit(
      title: habitId,
      description: 'Sample description for $habitId',
      frequency: 'Daily',
      goal: '30 days',
      currentStreak: 7,
      icon: Icons.fitness_center,
      color: AppColors.softYellow,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.deepBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.softYellow),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.editHabit,
                arguments: habitId,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.softYellow),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.deepBlue,
              AppColors.tealBlue,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHabitCard(habit),
              const SizedBox(height: 24),
              _buildProgressSection(),
              const SizedBox(height: 24),
              _buildHistorySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitCard(Habit habit) {
    return Card(
      color: AppColors.sageGreen,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      habit.icon,
                      color: habit.color,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      habit.title,
                      style: AppText.heading2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${habit.currentStreak} days',
                  style: AppText.heading3.copyWith(
                    color: AppColors.softYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              habit.description,
              style: AppText.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.85),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.repeat,
                  label: habit.frequency,
                  chipColor: AppColors.olive,
                  textColor: AppColors.deepBlue,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.flag,
                  label: habit.goal,
                  chipColor: AppColors.softYellow,
                  textColor: AppColors.deepBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: AppText.heading3.copyWith(
            color: AppColors.softYellow,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: AppColors.olive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProgressItem(
                  label: 'Current Streak',
                  value: '7 days',
                  icon: Icons.trending_up,
                  color: AppColors.sageGreen,
                ),
                const Divider(color: Colors.white24),
                _buildProgressItem(
                  label: 'Best Streak',
                  value: '21 days',
                  icon: Icons.star,
                  color: AppColors.softYellow,
                ),
                const Divider(color: Colors.white24),
                _buildProgressItem(
                  label: 'Total Days',
                  value: '45 days',
                  icon: Icons.calendar_today,
                  color: AppColors.sageGreen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: AppText.heading3.copyWith(
            color: AppColors.softYellow,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: AppColors.sageGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHistoryItem(
                  date: 'Today',
                  status: 'Completed',
                  color: AppColors.olive,
                ),
                const Divider(color: Colors.white24),
                _buildHistoryItem(
                  date: 'Yesterday',
                  status: 'Missed',
                  color: Colors.redAccent,
                ),
                const Divider(color: Colors.white24),
                _buildHistoryItem(
                  date: '2 days ago',
                  status: 'Completed',
                  color: AppColors.olive,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    Color chipColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppText.bodySmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppText.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          value,
          style: AppText.bodyLarge.copyWith(
            color: AppColors.softYellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String date,
    required String status,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          status == 'Completed' ? Icons.check_circle : Icons.cancel,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            date,
            style: AppText.bodyMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Text(
          status,
          style: AppText.bodyMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.deepBlue,
        title: const Text('Delete Habit', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this habit?', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.softYellow)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
} 