import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/widgets/habit_tile.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual habits from state management
    final List<Map<String, dynamic>> habits = [
      {
        'id': '1',
        'title': 'Morning Exercise',
        'description': '30 minutes of cardio',
        'completed': true,
        'streak': 5,
      },
      {
        'id': '2',
        'title': 'Read a Book',
        'description': 'Read 20 pages',
        'completed': false,
        'streak': 3,
      },
      {
        'id': '3',
        'title': 'Meditation',
        'description': '10 minutes of meditation',
        'completed': false,
        'streak': 7,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: HabitTile(
            title: habit['title'],
            description: habit['description'],
            completed: habit['completed'],
            streak: habit['streak'],
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.habitDetails,
                arguments: habit['id'],
              );
            },
            onComplete: () {
              // TODO: Implement habit completion logic
            },
          ),
        );
      },
    );
  }
} 