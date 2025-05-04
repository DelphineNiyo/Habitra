import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habitra.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Habits table
    await db.execute('''
      CREATE TABLE habits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        frequency TEXT NOT NULL, -- daily, weekly, monthly
        reminder_time TEXT,
        streak_count INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Habit logs table
    await db.execute('''
      CREATE TABLE habit_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_id INTEGER NOT NULL,
        completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        notes TEXT,
        FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Habit categories junction table
    await db.execute('''
      CREATE TABLE habit_categories (
        habit_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (habit_id, category_id),
        FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');
  }

  // User queries
  Future<int> createUser(String username, String email, String password) async {
    final db = await database;
    return await db.insert('users', {
      'username': username,
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Habit queries
  Future<int> createHabit(Map<String, dynamic> habit) async {
    final db = await database;
    return await db.insert('habits', habit);
  }

  Future<List<Map<String, dynamic>>> getUserHabits(int userId) async {
    final db = await database;
    return await db.query(
      'habits',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateHabit(int id, Map<String, dynamic> habit) async {
    final db = await database;
    return await db.update(
      'habits',
      habit,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteHabit(int id) async {
    final db = await database;
    return await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Habit log queries
  Future<int> logHabitCompletion(int habitId, {String? notes}) async {
    final db = await database;
    return await db.insert('habit_logs', {
      'habit_id': habitId,
      'notes': notes,
    });
  }

  Future<List<Map<String, dynamic>>> getHabitLogs(int habitId) async {
    final db = await database;
    return await db.query(
      'habit_logs',
      where: 'habit_id = ?',
      whereArgs: [habitId],
      orderBy: 'completed_at DESC',
    );
  }

  // Category queries
  Future<int> createCategory(String name, String color, int userId) async {
    final db = await database;
    return await db.insert('categories', {
      'name': name,
      'color': color,
      'user_id': userId,
    });
  }

  Future<List<Map<String, dynamic>>> getUserCategories(int userId) async {
    final db = await database;
    return await db.query(
      'categories',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // Habit-Category relationship queries
  Future<void> addHabitToCategory(int habitId, int categoryId) async {
    final db = await database;
    await db.insert('habit_categories', {
      'habit_id': habitId,
      'category_id': categoryId,
    });
  }

  Future<List<Map<String, dynamic>>> getHabitCategories(int habitId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT c.* FROM categories c
      JOIN habit_categories hc ON c.id = hc.category_id
      WHERE hc.habit_id = ?
    ''', [habitId]);
  }

  // Analytics queries
  Future<Map<String, dynamic>> getHabitStats(int habitId) async {
    final db = await database;
    final logs = await getHabitLogs(habitId);
    final habit = await db.query(
      'habits',
      where: 'id = ?',
      whereArgs: [habitId],
    );

    if (habit.isEmpty) return {};

    final totalCompletions = logs.length;
    final streak = habit.first['streak_count'] as int;
    final createdAt = DateTime.parse(habit.first['created_at'] as String);
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;

    return {
      'total_completions': totalCompletions,
      'current_streak': streak,
      'completion_rate': daysSinceCreation > 0 
          ? (totalCompletions / daysSinceCreation) * 100 
          : 0,
    };
  }

  Future<List<Map<String, dynamic>>> getDailyCompletionStats(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        date(completed_at) as date,
        COUNT(*) as completions
      FROM habit_logs hl
      JOIN habits h ON hl.habit_id = h.id
      WHERE h.user_id = ?
      GROUP BY date(completed_at)
      ORDER BY date DESC
      LIMIT 30
    ''', [userId]);
  }
} 