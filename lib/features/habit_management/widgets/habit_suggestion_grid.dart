import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../models/habit_suggestion.dart';

class HabitSuggestionGrid extends StatelessWidget {
  final Function(HabitSuggestion) onHabitSelected;
  final Function() onCreateCustomHabit;

  const HabitSuggestionGrid({
    super.key,
    required this.onHabitSelected,
    required this.onCreateCustomHabit,
  });

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      HabitSuggestion(
        title: 'Morning Exercise',
        icon: Icons.fitness_center,
        color: Colors.blue,
      ),
      HabitSuggestion(
        title: 'Meditation',
        icon: Icons.self_improvement,
        color: Colors.purple,
      ),
      HabitSuggestion(
        title: 'Reading',
        icon: Icons.menu_book,
        color: Colors.green,
      ),
      HabitSuggestion(
        title: 'Water Intake',
        icon: Icons.water_drop,
        color: Colors.cyan,
      ),
    ];

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return _HabitSuggestionCard(
                suggestion: suggestion,
                onTap: () => onHabitSelected(suggestion),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onCreateCustomHabit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add),
                const SizedBox(width: 4),
                Text(
                  'Customize a Habit',
                  style: AppText.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onPrimary
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HabitSuggestionCard extends StatelessWidget {
  final HabitSuggestion suggestion;
  final VoidCallback onTap;

  const _HabitSuggestionCard({
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                suggestion.icon,
                color: suggestion.color,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                suggestion.title,
                style: AppText.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 