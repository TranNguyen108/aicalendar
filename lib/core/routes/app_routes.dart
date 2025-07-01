import 'package:flutter/material.dart';
import '../../modules/homepage/homepage_screen.dart';
import '../../modules/calendar/calendar_screen.dart';
import '../../modules/tasks/tasks_screen.dart';
import '../../modules/habits/habits_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/chat_ai/chat_ai_screen.dart';
import '../../modules/focus_mode/focus_mode_screen.dart';
import '../../modules/statistics/statistics_screen.dart';
import '../../modules/goal_scheduling/goal_scheduling_screen.dart';
import '../../modules/reminder/reminder_screen.dart';
import '../../modules/weather/weather_screen.dart';

class AppRoutes {
  static const String homepage = '/';
  static const String calendar = '/calendar';
  static const String tasks = '/tasks';
  static const String habits = '/habits';
  static const String settings = '/settings';
  static const String chatAI = '/chat-ai';
  static const String focusMode = '/focus-mode';
  static const String statistics = '/statistics';
  static const String goalScheduling = '/goal-scheduling';
  static const String reminder = '/reminder';
  static const String weather = '/weather';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      homepage: (context) => const HomepageScreen(),
      calendar: (context) => const CalendarScreen(),
      tasks: (context) => const TasksScreen(),
      habits: (context) => const HabitsScreen(),
      settings: (context) => const SettingsScreen(),
      chatAI: (context) => const ChatAIScreen(),
      focusMode: (context) => const FocusModeScreen(),
      statistics: (context) => const StatisticsScreen(),
      goalScheduling: (context) => const GoalSchedulingScreen(),
      reminder: (context) => const ReminderScreen(),
      weather: (context) => const WeatherScreen(),
    };
  }
}
