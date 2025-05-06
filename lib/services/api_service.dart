import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// Only imported on Web:
import 'dart:html' as html;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  static final SupabaseClient supabase = Supabase.instance.client;

  // HABITS CRUD
  Future<List<dynamic>> getHabits() async {
    final userId = supabase.auth.currentUser?.id;
    final response = await supabase
        .from('habits')
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return response;
  }

  Future<void> addHabit(Map<String, dynamic> habitData) async {
    final userId = supabase.auth.currentUser?.id;
    habitData['user_id'] = userId;
    await supabase.from('habits').insert(habitData);
  }

  Future<void> updateHabit(int habitId, Map<String, dynamic> updates) async {
    await supabase.from('habits').update(updates).eq('id', habitId);
  }

  Future<void> deleteHabit(int habitId) async {
    await supabase.from('habits').delete().eq('id', habitId);
  }

  // HABIT LOGS
  Future<void> logHabitCompletion(int habitId, {String? notes}) async {
    await supabase.from('habit_logs').insert({
      'habit_id': habitId,
      'notes': notes ?? '',
    });
  }

  Future<List<dynamic>> getHabitLogs(int habitId) async {
    final response = await supabase
        .from('habit_logs')
        .select()
        .eq('habit_id', habitId)
        .order('completed_at', ascending: false);
    return response;
  }

  // CATEGORIES
  Future<List<dynamic>> getCategories() async {
    final userId = supabase.auth.currentUser?.id;
    final response = await supabase
        .from('categories')
        .select()
        .eq('user_id', userId)
        .order('name');
    return response;
  }

  Future<void> addCategory(Map<String, dynamic> categoryData) async {
    final userId = supabase.auth.currentUser?.id;
    categoryData['user_id'] = userId;
    await supabase.from('categories').insert(categoryData);
  }

  Future<void> deleteCategory(int categoryId) async {
    await supabase.from('categories').delete().eq('id', categoryId);
  }

  // AUTH HELPERS
  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  insertUserProfile({required String userId, required String firstName, required String lastName, required String username, required String email}) {}
  
}
