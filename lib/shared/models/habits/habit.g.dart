// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  type: $enumDecode(_$HabitTypeEnumMap, json['type']),
  frequency: $enumDecode(_$HabitFrequencyEnumMap, json['frequency']),
  targetCount: (json['targetCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isActive: json['isActive'] as bool? ?? true,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  color: json['color'] as String? ?? '#2196F3',
);

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$HabitTypeEnumMap[instance.type]!,
  'frequency': _$HabitFrequencyEnumMap[instance.frequency]!,
  'targetCount': instance.targetCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'isActive': instance.isActive,
  'tags': instance.tags,
  'color': instance.color,
};

const _$HabitTypeEnumMap = {
  HabitType.daily: 'daily',
  HabitType.weekly: 'weekly',
  HabitType.monthly: 'monthly',
};

const _$HabitFrequencyEnumMap = {
  HabitFrequency.once: 'once',
  HabitFrequency.twice: 'twice',
  HabitFrequency.thrice: 'thrice',
  HabitFrequency.custom: 'custom',
};

HabitEntry _$HabitEntryFromJson(Map<String, dynamic> json) => HabitEntry(
  id: json['id'] as String,
  habitId: json['habitId'] as String,
  date: DateTime.parse(json['date'] as String),
  completedCount: (json['completedCount'] as num).toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$HabitEntryToJson(HabitEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
      'completedCount': instance.completedCount,
      'notes': instance.notes,
    };
