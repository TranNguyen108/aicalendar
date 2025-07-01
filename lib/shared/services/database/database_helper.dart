import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'aicalendar.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Calendar Events table
    await db.execute('''
      CREATE TABLE calendar_events (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        location TEXT,
        color TEXT,
        is_all_day INTEGER DEFAULT 0,
        repeat_type TEXT DEFAULT 'none',
        reminder_minutes INTEGER,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Tasks table
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        due_date TEXT,
        priority TEXT DEFAULT 'medium',
        is_completed INTEGER DEFAULT 0,
        category TEXT,
        tags TEXT,
        reminder_time TEXT,
        repeat_type TEXT DEFAULT 'none',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Subtasks table
    await db.execute('''
      CREATE TABLE subtasks (
        id TEXT PRIMARY KEY,
        parent_task_id TEXT NOT NULL,
        title TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        FOREIGN KEY (parent_task_id) REFERENCES tasks (id) ON DELETE CASCADE
      )
    ''');

    // Notes table
    await db.execute('''
      CREATE TABLE notes (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        tags TEXT,
        color TEXT,
        is_pinned INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Habits table
    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        icon TEXT,
        color TEXT,
        frequency TEXT NOT NULL,
        target_value INTEGER DEFAULT 1,
        unit TEXT DEFAULT 'times',
        start_date TEXT NOT NULL,
        end_date TEXT,
        is_active INTEGER DEFAULT 1,
        tags TEXT,
        reminder_time TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Habit Progress table
    await db.execute('''
      CREATE TABLE habit_progress (
        id TEXT PRIMARY KEY,
        habit_id TEXT NOT NULL,
        date TEXT NOT NULL,
        value INTEGER DEFAULT 0,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE,
        UNIQUE(habit_id, date)
      )
    ''');

    // Settings table
    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Chat Messages table (for AI chat history)
    await db.execute('''
      CREATE TABLE chat_messages (
        id TEXT PRIMARY KEY,
        message TEXT NOT NULL,
        response TEXT NOT NULL,
        message_type TEXT DEFAULT 'user',
        created_at TEXT NOT NULL
      )
    ''');

    // Insert default settings
    await _insertDefaultSettings(db);
  }

  Future<void> _insertDefaultSettings(Database db) async {
    final now = DateTime.now().toIso8601String();
    final defaultSettings = [
      {'key': 'theme_mode', 'value': 'system', 'updated_at': now},
      {'key': 'notification_enabled', 'value': 'true', 'updated_at': now},
      {'key': 'default_reminder_time', 'value': '15', 'updated_at': now},
      {'key': 'week_start_day', 'value': '1', 'updated_at': now}, // Monday
      {'key': 'language', 'value': 'vi', 'updated_at': now},
      {'key': 'first_launch', 'value': 'true', 'updated_at': now},
    ];

    for (final setting in defaultSettings) {
      await db.insert('settings', setting);
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < newVersion) {
      // Add migration logic for future versions
    }
  }

  // Generic database operations
  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // Batch operations for better performance
  Future<void> batch(Function(Batch batch) operations) async {
    final db = await database;
    final batch = db.batch();
    operations(batch);
    await batch.commit();
  }

  // Clear all data (for testing or reset)
  Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('calendar_events');
      await txn.delete('tasks');
      await txn.delete('subtasks');
      await txn.delete('notes');
      await txn.delete('habits');
      await txn.delete('habit_progress');
      await txn.delete('chat_messages');
    });
  }
}
