import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

enum HabitType { daily, weekly, monthly }

enum HabitFrequency { once, twice, thrice, custom }

@JsonSerializable()
class Habit {
  final String id;
  final String title;
  final String? description;
  final HabitType type;
  final HabitFrequency frequency;
  final int targetCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final List<String> tags;
  final String color;

  Habit({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.frequency,
    required this.targetCount,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.tags = const [],
    this.color = '#2196F3',
  });

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
  Map<String, dynamic> toJson() => _$HabitToJson(this);

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    HabitType? type,
    HabitFrequency? frequency,
    int? targetCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    List<String>? tags,
    String? color,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      targetCount: targetCount ?? this.targetCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      color: color ?? this.color,
    );
  }
}

@JsonSerializable()
class HabitEntry {
  final String id;
  final String habitId;
  final DateTime date;
  final int completedCount;
  final String? notes;

  HabitEntry({
    required this.id,
    required this.habitId,
    required this.date,
    required this.completedCount,
    this.notes,
  });

  factory HabitEntry.fromJson(Map<String, dynamic> json) =>
      _$HabitEntryFromJson(json);
  Map<String, dynamic> toJson() => _$HabitEntryToJson(this);
}
