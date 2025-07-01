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
}
