// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      type:
          $enumDecodeNullable(_$EventTypeEnumMap, json['type']) ??
          EventType.personal,
      priority:
          $enumDecodeNullable(_$EventPriorityEnumMap, json['priority']) ??
          EventPriority.medium,
      repeat:
          $enumDecodeNullable(_$EventRepeatEnumMap, json['repeat']) ??
          EventRepeat.none,
      location: json['location'] as String?,
      attendees:
          (json['attendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      color: json['color'] as String? ?? '#2196F3',
      isAllDay: json['isAllDay'] as bool? ?? false,
      hasReminder: json['hasReminder'] as bool? ?? false,
      reminderMinutes: (json['reminderMinutes'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'type': _$EventTypeEnumMap[instance.type]!,
      'priority': _$EventPriorityEnumMap[instance.priority]!,
      'repeat': _$EventRepeatEnumMap[instance.repeat]!,
      'location': instance.location,
      'attendees': instance.attendees,
      'tags': instance.tags,
      'color': instance.color,
      'isAllDay': instance.isAllDay,
      'hasReminder': instance.hasReminder,
      'reminderMinutes': instance.reminderMinutes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.meeting: 'meeting',
  EventType.reminder: 'reminder',
  EventType.task: 'task',
  EventType.habit: 'habit',
  EventType.personal: 'personal',
  EventType.work: 'work',
};

const _$EventPriorityEnumMap = {
  EventPriority.low: 'low',
  EventPriority.medium: 'medium',
  EventPriority.high: 'high',
  EventPriority.urgent: 'urgent',
};

const _$EventRepeatEnumMap = {
  EventRepeat.none: 'none',
  EventRepeat.daily: 'daily',
  EventRepeat.weekly: 'weekly',
  EventRepeat.monthly: 'monthly',
  EventRepeat.yearly: 'yearly',
  EventRepeat.custom: 'custom',
};
