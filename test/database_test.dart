import 'package:flutter_test/flutter_test.dart';
import 'package:aicalendar/shared/services/database/database_service.dart';
import 'package:aicalendar/shared/models/calendar/calendar_event.dart';
import 'package:aicalendar/shared/models/tasks/task.dart';
import 'package:aicalendar/shared/models/notes/note.dart';
import 'package:aicalendar/shared/models/habits/habit.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Database Service Tests', () {
    late DatabaseService databaseService;
    const uuid = Uuid();

    setUp(() async {
      databaseService = DatabaseService();
      // Clear all data before each test
      await databaseService.clearAllData();
    });

    tearDown(() async {
      await databaseService.close();
    });

    test('Calendar Events CRUD operations', () async {
      // Create a test event
      final event = CalendarEvent(
        id: uuid.v4(),
        title: 'Test Event',
        description: 'This is a test event',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        location: 'Test Location',
        color: '#FF5722',
        isAllDay: false,
        repeat: EventRepeat.none,
        reminderMinutes: 15,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Insert event
      final insertedId = await databaseService.insertEvent(event);
      expect(insertedId, equals(event.id));

      // Get event by ID
      final retrievedEvent = await databaseService.getEventById(event.id);
      expect(retrievedEvent?.title, equals('Test Event'));

      // Get all events
      final allEvents = await databaseService.getAllEvents();
      expect(allEvents.length, equals(1));

      // Update event
      final updatedEvent = event.copyWith(title: 'Updated Test Event');
      await databaseService.updateEvent(updatedEvent);
      final updated = await databaseService.getEventById(event.id);
      expect(updated?.title, equals('Updated Test Event'));

      // Delete event
      await databaseService.deleteEvent(event.id);
      final deleted = await databaseService.getEventById(event.id);
      expect(deleted, isNull);
    });

    test('Tasks CRUD operations', () async {
      // Create a test task
      final task = Task(
        id: uuid.v4(),
        title: 'Test Task',
        description: 'This is a test task',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Insert task
      final insertedId = await databaseService.insertTask(task);
      expect(insertedId, equals(task.id));

      // Get task by ID
      final retrievedTask = await databaseService.getTaskById(task.id);
      expect(retrievedTask?.title, equals('Test Task'));

      // Get all tasks
      final allTasks = await databaseService.getAllTasks();
      expect(allTasks.length, equals(1));

      // Mark task as completed
      await databaseService.markTaskCompleted(task.id, true);
      final completedTask = await databaseService.getTaskById(task.id);
      expect(completedTask != null, isTrue);

      // Delete task
      await databaseService.deleteTask(task.id);
      final deleted = await databaseService.getTaskById(task.id);
      expect(deleted, isNull);
    });

    test('Habits CRUD operations', () async {
      // Create a test habit
      final habit = Habit(
        id: uuid.v4(),
        title: 'Test Habit',
        description: 'This is a test habit',
        type: HabitType.daily,
        frequency: HabitFrequency.once,
        targetCount: 1,
        createdAt: DateTime.now(),
      );

      // Insert habit
      final insertedId = await databaseService.insertHabit(habit);
      expect(insertedId, equals(habit.id));

      // Get habit by ID
      final retrievedHabit = await databaseService.getHabitById(habit.id);
      expect(retrievedHabit?.title, equals('Test Habit'));

      // Get all habits
      final allHabits = await databaseService.getAllHabits();
      expect(allHabits.length, equals(1));

      // Update habit
      final updatedHabit = habit.copyWith(title: 'Updated Test Habit');
      await databaseService.updateHabit(updatedHabit);
      final updated = await databaseService.getHabitById(habit.id);
      expect(updated?.title, equals('Updated Test Habit'));

      // Delete habit
      await databaseService.deleteHabit(habit.id);
      final deleted = await databaseService.getHabitById(habit.id);
      expect(deleted, isNull);
    });

    test('Notes CRUD operations', () async {
      // Create a test note
      final note = Note(
        id: uuid.v4(),
        title: 'Test Note',
        content: 'This is a test note content',
        tags: ['test', 'note'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Insert note
      final insertedId = await databaseService.insertNote(note);
      expect(insertedId, equals(note.id));

      // Get note by ID
      final retrievedNote = await databaseService.getNoteById(note.id);
      expect(retrievedNote?.title, equals('Test Note'));

      // Get all notes
      final allNotes = await databaseService.getAllNotes();
      expect(allNotes.length, equals(1));

      // Update note
      final updatedNote = note.copyWith(title: 'Updated Test Note');
      await databaseService.updateNote(updatedNote);
      final updated = await databaseService.getNoteById(note.id);
      expect(updated?.title, equals('Updated Test Note'));

      // Delete note
      await databaseService.deleteNote(note.id);
      final deleted = await databaseService.getNoteById(note.id);
      expect(deleted, isNull);
    });

    test('Settings operations', () async {
      // Set a setting
      await databaseService.setSetting('test_key', 'test_value');

      // Get setting
      final value = await databaseService.getSetting('test_key');
      expect(value, equals('test_value'));

      // Get all settings
      final allSettings = await databaseService.getAllSettings();
      expect(allSettings.containsKey('test_key'), isTrue);
    });

    test('Statistics operations', () async {
      // Create some test data
      final event = CalendarEvent(
        id: uuid.v4(),
        title: 'Test Event',
        description: 'Test',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await databaseService.insertEvent(event);

      final task = Task(
        id: uuid.v4(),
        title: 'Test Task',
        description: 'Test',
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await databaseService.insertTask(task);

      // Get statistics
      final stats = await databaseService.getStatistics();
      expect(stats['totalEvents'], equals(1));
      expect(stats['totalTasks'], equals(1));
    });
  });
}
