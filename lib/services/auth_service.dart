import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();

  /// Registers a new user via register.php
  Future<User> register(
    String firstName,
    String lastName,
    String username,
    String email,
    String password,
  ) async {
    final data = await _api.post('register.php', {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'password': password,
    });
    final user = User.fromJson(data);
    await _saveUser(user);
    return user;
  }

  /// Logs in an existing user via login_user.php
  Future<User> login(String email, String password) async {
    final data = await _api.post('login_user.php', {
      'email': email,
      'password': password,
    });
    final user = User.fromJson(data);
    await _saveUser(user);
    return user;
  }

  Future<void> _saveUser(User u) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', u.id);
    await prefs.setString('username', u.username);
    await prefs.setString('email', u.email);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}