import 'package:flutter/material.dart';

class Habit {
  final String title;
  final String description;
  final String frequency;
  final String goal;
  final int currentStreak;
  final IconData icon;
  final Color color;

  const Habit({
    required this.title,
    required this.description,
    required this.frequency,
    required this.goal,
    required this.currentStreak,
    required this.icon,
    required this.color,
  });
} 