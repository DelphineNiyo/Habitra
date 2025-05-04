import 'package:flutter/material.dart';
import '../features/auth/pages/auth_choice_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/signup_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/profile_page.dart';
import '../features/auth/pages/account_settings_page.dart';
import '../features/dashboard/pages/home_page.dart';
import '../features/habit_management/pages/habit_list_page.dart';
import '../features/habit_management/pages/create_custom_habit_page.dart';
import '../features/habit_management/pages/habit_details_page.dart';
import '../features/habit_management/pages/edit_habit_page.dart';
// import '../features/habit_management/models/habit_suggestion.dart';
import '../features/progress/pages/progress_page.dart';
import '../features/settings/pages/app_settings_page.dart';
import '../features/startup/pages/splash_screen.dart';
import '../features/startup/pages/onboarding_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String authChoice = '/auth-choice';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String accountSettings = '/account-settings';
  static const String appSettings = '/app-settings';
  static const String habitList = '/habit-list';
  static const String createCustomHabit = '/create-custom-habit';
  static const String habitDetails = '/habit-details';
  static const String editHabit = '/edit-habit';
  static const String progress = '/progress';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case authChoice:
        return MaterialPageRoute(builder: (_) => const AuthChoicePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case accountSettings:
        return MaterialPageRoute(builder: (_) => const AccountSettingsPage());
      case appSettings:
        return MaterialPageRoute(builder: (_) => const AppSettingsPage());
      case habitList:
        return MaterialPageRoute(builder: (_) => const HabitListPage());
      case createCustomHabit:
        final suggestion = settings.arguments as dynamic;
        return MaterialPageRoute(
          builder: (_) => CreateCustomHabitPage(suggestion: suggestion),
        );
      case habitDetails:
        final habitId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HabitDetailsPage(habitId: habitId),
        );
      case editHabit:
        final habitId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EditHabitPage(habitId: habitId),
        );
      case progress:
        return MaterialPageRoute(builder: (_) => const ProgressPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 