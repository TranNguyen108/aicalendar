import '../database/database_service.dart';
import '../../models/calendar/calendar_event.dart';

class EventRepository {
  final DatabaseService _db = DatabaseService();

  Future<List<CalendarEvent>> getAllEvents() async {
    return await _db.getAllEvents();
  }

  Future<List<CalendarEvent>> getEventsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await _db.getEventsByDateRange(start, end);
  }

  Future<CalendarEvent?> getEventById(String id) async {
    return await _db.getEventById(id);
  }

  Future<String> createEvent(CalendarEvent event) async {
    return await _db.insertEvent(event);
  }

  Future<int> updateEvent(CalendarEvent event) async {
    return await _db.updateEvent(event);
  }

  Future<int> deleteEvent(String id) async {
    return await _db.deleteEvent(id);
  }

  Future<List<CalendarEvent>> searchEvents(String query) async {
    return await _db.searchEvents(query);
  }
}
