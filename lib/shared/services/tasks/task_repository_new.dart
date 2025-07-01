import '../database/database_service.dart';
import '../../models/tasks/task.dart';

class TaskRepository {
  final DatabaseService _db = DatabaseService();

  Future<List<Task>> getAllTasks() async {
    return await _db.getAllTasks();
  }

  Future<List<Task>> getTasksByStatus(bool isCompleted) async {
    return await _db.getTasksByStatus(isCompleted);
  }

  Future<List<Task>> getTasksByCategory(String category) async {
    return await _db.getTasksByCategory(category);
  }

  Future<List<Task>> getTasksByPriority(String priority) async {
    return await _db.getTasksByPriority(priority);
  }

  Future<List<Task>> getTasksDueToday() async {
    return await _db.getTasksDueToday();
  }

  Future<List<Task>> getOverdueTasks() async {
    return await _db.getOverdueTasks();
  }

  Future<Task?> getTaskById(String id) async {
    return await _db.getTaskById(id);
  }

  Future<String> createTask(Task task) async {
    return await _db.insertTask(task);
  }

  Future<int> updateTask(Task task) async {
    return await _db.updateTask(task);
  }

  Future<int> deleteTask(String id) async {
    return await _db.deleteTask(id);
  }

  Future<int> markTaskCompleted(String id, bool isCompleted) async {
    return await _db.markTaskCompleted(id, isCompleted);
  }

  Future<List<Task>> searchTasks(String query) async {
    return await _db.searchTasks(query);
  }
}
