import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

enum EventType { meeting, reminder, task, habit, personal, work }

enum EventPriority { low, medium, high, urgent }

enum EventRepeat { none, daily, weekly, monthly, yearly, custom }

@JsonSerializable()
class CalendarEvent {
  // Calendar event model
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final EventType type;
  final EventPriority priority;
  final EventRepeat repeat;
  final String? location;
  final List<String> attendees;
  final List<String> tags;
  final String color;
  final bool isAllDay;
  final bool hasReminder;
  final int? reminderMinutes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.type = EventType.personal,
    this.priority = EventPriority.medium,
    this.repeat = EventRepeat.none,
    this.location,
    this.attendees = const [],
    this.tags = const [],
    this.color = '#2196F3',
    this.isAllDay = false,
    this.hasReminder = false,
    this.reminderMinutes,
    required this.createdAt,
    this.updatedAt,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    EventType? type,
    EventPriority? priority,
    EventRepeat? repeat,
    String? location,
    List<String>? attendees,
    List<String>? tags,
    String? color,
    bool? isAllDay,
    bool? hasReminder,
    int? reminderMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
      location: location ?? this.location,
      attendees: attendees ?? this.attendees,
      tags: tags ?? this.tags,
      color: color ?? this.color,
      isAllDay: isAllDay ?? this.isAllDay,
      hasReminder: hasReminder ?? this.hasReminder,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Database operations
  factory CalendarEvent.fromDatabaseMap(Map<String, dynamic> map) {
    return CalendarEvent(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: DateTime.parse(map['end_time'] as String),
      type: EventType.values.firstWhere(
        (e) => e.toString().split('.').last == (map['category'] ?? 'personal'),
        orElse: () => EventType.personal,
      ),
      priority: EventPriority.values.firstWhere(
        (e) => e.toString().split('.').last == (map['priority'] ?? 'medium'),
        orElse: () => EventPriority.medium,
      ),
      repeat: EventRepeat.values.firstWhere(
        (e) =>
            e.toString().split('.').last == (map['recurrence_rule'] ?? 'none'),
        orElse: () => EventRepeat.none,
      ),
      location: map['location'] as String?,
      attendees: [],
      tags: [],
      color: map['color'] as String? ?? '#2196F3',
      isAllDay: (map['is_all_day'] as int) == 1,
      hasReminder: map['reminder_minutes'] != null,
      reminderMinutes: map['reminder_minutes'] as int?,
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
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'location': location,
      'color': color,
      'is_all_day': isAllDay ? 1 : 0,
      'recurrence_rule': repeat.toString().split('.').last,
      'reminder_minutes': reminderMinutes,
      'category': type.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
