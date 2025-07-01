import 'package:aicalendar/shared/models/calendar/calendar_event.dart';
import 'package:aicalendar/shared/models/tasks/task.dart';
import 'package:aicalendar/shared/models/habits/habit.dart';
import 'package:aicalendar/shared/models/notes/note.dart';
import 'database_helper.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Calendar Events operations
  Future<String> insertEvent(CalendarEvent event) async {
    await _dbHelper.insert('calendar_events', event.toDatabaseMap());
    return event.id;
  }

  Future<List<CalendarEvent>> getAllEvents() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'calendar_events',
      orderBy: 'start_time ASC',
    );
    return maps.map((map) => CalendarEvent.fromDatabaseMap(map)).toList();
  }

  Future<List<CalendarEvent>> getEventsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'calendar_events',
      where: 'start_time >= ? AND start_time <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'start_time ASC',
    );
    return maps.map((map) => CalendarEvent.fromDatabaseMap(map)).toList();
  }

  Future<CalendarEvent?> getEventById(String id) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'calendar_events',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CalendarEvent.fromDatabaseMap(maps.first);
    }
    return null;
  }

  Future<int> updateEvent(CalendarEvent event) async {
    return await _dbHelper.update(
      'calendar_events',
      event.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(String id) async {
    return await _dbHelper.delete(
      'calendar_events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CalendarEvent>> searchEvents(String query) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'calendar_events',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'start_time ASC',
    );
    return maps.map((map) => CalendarEvent.fromDatabaseMap(map)).toList();
  }

  // Tasks operations
  Future<String> insertTask(Task task) async {
    await _dbHelper.insert('tasks', task.toDatabaseMap());
    return task.id;
  }

  Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<List<Task>> getTasksByStatus(bool isCompleted) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'is_completed = ?',
      whereArgs: [isCompleted ? 1 : 0],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<List<Task>> getTasksByCategory(String category) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<List<Task>> getTasksByPriority(String priority) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'priority = ?',
      whereArgs: [priority],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<List<Task>> getTasksDueToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'due_date >= ? AND due_date < ? AND is_completed = 0',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
      orderBy: 'due_date ASC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<List<Task>> getOverdueTasks() async {
    final now = DateTime.now().toIso8601String();
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'due_date < ? AND is_completed = 0',
      whereArgs: [now],
      orderBy: 'due_date ASC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  Future<Task?> getTaskById(String id) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromDatabaseMap(maps.first);
    }
    return null;
  }

  Future<int> updateTask(Task task) async {
    return await _dbHelper.update(
      'tasks',
      task.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(String id) async {
    return await _dbHelper.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> markTaskCompleted(String id, bool isCompleted) async {
    return await _dbHelper.update(
      'tasks',
      {
        'is_completed': isCompleted ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> searchTasks(String query) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'tasks',
      where:
          'title LIKE ? OR description LIKE ? OR category LIKE ? OR tags LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Task.fromDatabaseMap(map)).toList();
  }

  // Habits operations
  Future<String> insertHabit(Habit habit) async {
    await _dbHelper.insert('habits', habit.toDatabaseMap());
    return habit.id;
  }

  Future<List<Habit>> getAllHabits() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'habits',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Habit.fromDatabaseMap(map)).toList();
  }

  Future<List<Habit>> getActiveHabits() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'habits',
      where: 'is_active = 1',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Habit.fromDatabaseMap(map)).toList();
  }

  Future<Habit?> getHabitById(String id) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Habit.fromDatabaseMap(maps.first);
    }
    return null;
  }

  Future<int> updateHabit(Habit habit) async {
    return await _dbHelper.update(
      'habits',
      habit.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  Future<int> deleteHabit(String id) async {
    return await _dbHelper.delete('habits', where: 'id = ?', whereArgs: [id]);
  }

  // Notes operations
  Future<String> insertNote(Note note) async {
    await _dbHelper.insert('notes', note.toDatabaseMap());
    return note.id;
  }

  Future<List<Note>> getAllNotes() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'notes',
      orderBy: 'is_pinned DESC, updated_at DESC',
    );
    return maps.map((map) => Note.fromDatabaseMap(map)).toList();
  }

  Future<Note?> getNoteById(String id) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromDatabaseMap(maps.first);
    }
    return null;
  }

  Future<int> updateNote(Note note) async {
    return await _dbHelper.update(
      'notes',
      note.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    return await _dbHelper.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Note>> searchNotes(String query) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ? OR tags LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'is_pinned DESC, updated_at DESC',
    );
    return maps.map((map) => Note.fromDatabaseMap(map)).toList();
  }

  // Chat Messages operations
  Future<String> insertChatMessage({
    required String message,
    required String response,
    String messageType = 'user',
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _dbHelper.insert('chat_messages', {
      'id': id,
      'message': message,
      'response': response,
      'message_type': messageType,
      'created_at': DateTime.now().toIso8601String(),
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getChatHistory({int? limit}) async {
    return await _dbHelper.query(
      'chat_messages',
      orderBy: 'created_at DESC',
      limit: limit,
    );
  }

  Future<int> clearChatHistory() async {
    return await _dbHelper.delete('chat_messages');
  }

  // Settings operations
  Future<void> setSetting(String key, String value) async {
    final existing = await _dbHelper.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (existing.isNotEmpty) {
      await _dbHelper.update(
        'settings',
        {'value': value, 'updated_at': DateTime.now().toIso8601String()},
        where: 'key = ?',
        whereArgs: [key],
      );
    } else {
      await _dbHelper.insert('settings', {
        'key': key,
        'value': value,
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<String?> getSetting(String key) async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps.isNotEmpty) {
      return maps.first['value'];
    }
    return null;
  }

  Future<Map<String, String>> getAllSettings() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.query('settings');
    return {for (var map in maps) map['key']: map['value']};
  }

  // Utility operations
  Future<void> clearAllData() async {
    await _dbHelper.clearAllData();
  }

  Future<void> close() async {
    await _dbHelper.close();
  }

  Future<Map<String, int>> getStatistics() async {
    final totalEvents = (await _dbHelper.query('calendar_events')).length;
    final totalTasks = (await _dbHelper.query('tasks')).length;
    final completedTasks = (await _dbHelper.query(
      'tasks',
      where: 'is_completed = 1',
    )).length;
    final totalHabits = (await _dbHelper.query('habits')).length;
    final activeHabits = (await _dbHelper.query(
      'habits',
      where: 'is_active = 1',
    )).length;
    final totalNotes = (await _dbHelper.query('notes')).length;

    return {
      'totalEvents': totalEvents,
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'totalHabits': totalHabits,
      'activeHabits': activeHabits,
      'totalNotes': totalNotes,
    };
  }
}
