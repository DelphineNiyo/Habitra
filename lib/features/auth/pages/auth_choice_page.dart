import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';

class AuthChoicePage extends StatelessWidget {
  const AuthChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryVariant,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.self_improvement,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to Habitra',
                    style: AppText.heading1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start your journey to better habits',
                    style: AppText.titleMedium.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAuthButton(
                        context,
                        'Login',
                        Icons.login,
                        Routes.login,
                        const Color.fromARGB(255, 166, 155, 5),
                      ),
                      const SizedBox(width: 16),
                      _buildAuthButton(
                        context,
                        'Register',
                        Icons.person_add,
                        Routes.signup,
                        const Color.fromARGB(255, 166, 155, 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(
    BuildContext context,
    String text,
    IconData icon,
    String route,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppText.button.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 