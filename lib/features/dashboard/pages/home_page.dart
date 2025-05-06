import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';
import '../../habit_management/widgets/habit_suggestion_grid.dart';
import '../../habit_management/models/habit_suggestion.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _handleHabitSelected(HabitSuggestion suggestion) {
    Navigator.pushNamed(
      context,
      Routes.createCustomHabit,
      arguments: suggestion,
    );
  }

  void _showProfileMenu() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delph',
                style: AppText.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'delphn@gm.cm',
                style: AppText.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'account_settings',
          child: Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 12),
              const Text('Account Settings', style: TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'app_settings',
          child: Row(
            children: [
              const Icon(Icons.settings_outlined, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 12),
              const Text('App Settings', style: TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              const Icon(Icons.logout, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 12),
              const Text('Logout', style: TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ],
      color: AppColors.surface,
    ).then((value) {
      if (value == null) return;
      
      switch (value) {
        case 'account_settings':
          Navigator.pushNamed(context, Routes.accountSettings);
          break;
        case 'app_settings':
          Navigator.pushNamed(context, Routes.appSettings);
          break;
        case 'logout':
          _showLogoutConfirmation();
          break;
      }
    });
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Logout', style: TextStyle(color: AppColors.textPrimary)),
        content: const Text('Are you sure you want to logout?', style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.onboarding);
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.habitList);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.progress);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.appSettings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Habitra'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: _showProfileMenu,
          ),
        ],
      ),
      body: Container(
        color: AppColors.surface,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Suggested Habits',
                style: AppText.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: HabitSuggestionGrid(
                onHabitSelected: _handleHabitSelected,
                onCreateCustomHabit: () {
                  Navigator.pushNamed(context, Routes.createCustomHabit);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.createCustomHabit);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Customize a Habit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(HabitSuggestion suggestion) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.createCustomHabit,
            arguments: suggestion,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                suggestion.icon,
                color: suggestion.color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                suggestion.title,
                style: AppText.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sample data
  final List<HabitSuggestion> _suggestions = [
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
} 