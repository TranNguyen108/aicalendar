import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

enum TaskPriority { low, medium, high, urgent }

enum TaskStatus { pending, inProgress, completed, cancelled }

enum TaskRepeat { none, daily, weekly, monthly, yearly, custom }

@JsonSerializable()
class Task {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final TaskRepeat repeat;
  final List<String> tags;
  final String color;
  final String? parentTaskId;
  final List<String> subtaskIds;
  final int estimatedMinutes;
  final int? actualMinutes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.dueDate,
    this.completedAt,
    this.repeat = TaskRepeat.none,
    this.tags = const [],
    this.color = '#2196F3',
    this.parentTaskId,
    this.subtaskIds = const [],
    this.estimatedMinutes = 0,
    this.actualMinutes,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? dueDate,
    DateTime? completedAt,
    TaskRepeat? repeat,
    List<String>? tags,
    String? color,
    String? parentTaskId,
    List<String>? subtaskIds,
    int? estimatedMinutes,
    int? actualMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      repeat: repeat ?? this.repeat,
      tags: tags ?? this.tags,
      color: color ?? this.color,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      subtaskIds: subtaskIds ?? this.subtaskIds,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isCompleted => status == TaskStatus.completed;
  bool get isOverdue =>
      dueDate != null && dueDate!.isBefore(DateTime.now()) && !isCompleted;

  // Database operations
  factory Task.fromDatabaseMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString().split('.').last == (map['priority'] ?? 'medium'),
        orElse: () => TaskPriority.medium,
      ),
      status: TaskStatus.values.firstWhere(
        (e) => e.toString().split('.').last == (map['status'] ?? 'pending'),
        orElse: () => TaskStatus.pending,
      ),
      dueDate: map['due_date'] != null
          ? DateTime.parse(map['due_date'] as String)
          : null,
      completedAt: null, // Will be calculated from status and updated_at
      repeat: TaskRepeat.none, // Default for now
      tags: (map['tags'] as String? ?? '')
          .split(',')
          .where((e) => e.isNotEmpty)
          .toList(),
      color: '#2196F3', // Default color
      parentTaskId: map['parent_task_id'] as String?,
      subtaskIds: [], // Will be loaded separately
      estimatedMinutes: 0, // Default
      actualMinutes: null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate?.toIso8601String(),
      'priority': priority.toString().split('.').last,
      'status': status.toString().split('.').last,
      'tags': tags.join(','),
      'is_completed': isCompleted ? 1 : 0,
      'parent_task_id': parentTaskId,
      'reminder_minutes': null, // Will be implemented later
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
