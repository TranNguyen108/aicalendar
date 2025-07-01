class AppConstants {
  // App Info
  static const String appName = 'AI Calendar';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://your-api-url.com';
  static const String openAIBaseUrl = 'https://api.openai.com';
  static const String weatherApiBaseUrl = 'https://api.openweathermap.org';

  // Database
  static const String databaseName = 'aicalendar.db';
  static const int databaseVersion = 1;

  // Notifications
  static const String notificationChannelId = 'aicalendar_notifications';
  static const String notificationChannelName = 'AI Calendar Notifications';

  // Preferences Keys
  static const String prefKeyTheme = 'theme_mode';
  static const String prefKeyLanguage = 'language';
  static const String prefKeyFirstLaunch = 'first_launch';
  static const String prefKeyApiKey = 'api_key';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;

  // Focus Mode
  static const int pomodoroMinutes = 25;
  static const int shortBreakMinutes = 5;
  static const int longBreakMinutes = 15;

  // Weather Update Interval (in hours)
  static const int weatherUpdateInterval = 3;
}
