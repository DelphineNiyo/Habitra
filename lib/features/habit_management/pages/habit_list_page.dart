import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';
import '../models/habit.dart';

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final List<Habit> _habits = [
    Habit(
      title: 'Morning Exercise',
      description: 'Start your day with exercise',
      frequency: 'Daily',
      goal: '30 minutes',
      currentStreak: 5,
      icon: Icons.fitness_center,
      color: Colors.blue,
    ),
    Habit(
      title: 'Meditation',
      description: 'Take time to clear your mind',
      frequency: 'Daily',
      goal: '10 minutes',
      currentStreak: 3,
      icon: Icons.self_improvement,
      color: Colors.purple,
    ),
    Habit(
      title: 'Reading',
      description: 'Read a book every day',
      frequency: 'Daily',
      goal: '30 minutes',
      currentStreak: 7,
      icon: Icons.menu_book,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Habits'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, Routes.createCustomHabit),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_habits.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No habits yet',
                      style: AppText.titleLarge.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start by creating a new habit',
                      style: AppText.bodyMedium.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  final habit = _habits[index];
                  return _buildHabitCard(habit);
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.createCustomHabit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Customize a Habit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(Habit habit) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.habitDetails,
          arguments: habit.title,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    habit.icon,
                    color: habit.color,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      habit.title,
                      style: AppText.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildInfoChip(
                    icon: Icons.local_fire_department,
                    label: '${habit.currentStreak} days',
                  ),
                ],
              ),
              if (habit.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  habit.description,
                  style: AppText.bodyMedium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
              const SizedBox(height: 8),
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
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppText.labelSmall.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
} 