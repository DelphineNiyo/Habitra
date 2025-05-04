import 'package:flutter/material.dart';
import '../../../app/colors.dart';
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
      color: Colors.blue,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.editHabit,
                arguments: habitId,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
    );
  }

  Widget _buildHabitCard(Habit habit) {
    return Card(
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
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${habit.currentStreak} days',
                  style: AppText.heading3.copyWith(
                    color: habit.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              habit.description,
              style: AppText.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.repeat,
                  label: habit.frequency,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.flag,
                  label: habit.goal,
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
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProgressItem(
                  label: 'Current Streak',
                  value: '7 days',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
                const Divider(),
                _buildProgressItem(
                  label: 'Best Streak',
                  value: '21 days',
                  icon: Icons.star,
                  color: Colors.amber,
                ),
                const Divider(),
                _buildProgressItem(
                  label: 'Total Days',
                  value: '45 days',
                  icon: Icons.calendar_today,
                  color: Colors.blue,
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
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHistoryItem(
                  date: 'Today',
                  status: 'Completed',
                  color: Colors.green,
                ),
                const Divider(),
                _buildHistoryItem(
                  date: 'Yesterday',
                  status: 'Completed',
                  color: Colors.green,
                ),
                const Divider(),
                _buildHistoryItem(
                  date: '2 days ago',
                  status: 'Missed',
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: AppText.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppText.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String date,
    required String status,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: AppText.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: AppText.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: AppColors.primary,
      ),
      label: Text(
        label,
        style: AppText.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.1),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete functionality
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
} 