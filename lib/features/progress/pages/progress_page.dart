import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';
import '../widgets/quick_stats_card.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const QuickStatsCard(),
            const SizedBox(height: 24),
            _buildProgressCard(
              title: 'Perfect Days',
              count: 12,
              color: Colors.green,
              icon: Icons.check_circle,
            ),
            const SizedBox(height: 16),
            _buildProgressCard(
              title: 'Partial Days',
              count: 5,
              color: Colors.orange,
              icon: Icons.history,
            ),
            const SizedBox(height: 16),
            _buildProgressCard(
              title: 'Missed Days',
              count: 3,
              color: Colors.red,
              icon: Icons.cancel,
            ),
            const SizedBox(height: 24),
            const Text(
              'Weekly Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildWeeklyProgressChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 40,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count days',
                  style: TextStyle(
                    fontSize: 24,
                    color: color,
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

  Widget _buildWeeklyProgressChart() {
    // This is a placeholder for the actual chart implementation
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Weekly Progress Chart',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
} 