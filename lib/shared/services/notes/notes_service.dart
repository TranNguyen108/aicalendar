import '../database/database_service.dart';
import '../../models/notes/note.dart';

class NotesService {
  final DatabaseService _db = DatabaseService();

  Future<List<Note>> getAllNotes() async {
    return await _db.getAllNotes();
  }

  Future<Note?> getNoteById(String id) async {
    return await _db.getNoteById(id);
  }

  Future<String> createNote(Note note) async {
    return await _db.insertNote(note);
  }

  Future<int> updateNote(Note note) async {
    return await _db.updateNote(note);
  }

  Future<int> deleteNote(String id) async {
    return await _db.deleteNote(id);
  }

  Future<List<Note>> searchNotes(String query) async {
    return await _db.searchNotes(query);
  }

  Future<List<String>> getAllTags() async {
    final notes = await _db.getAllNotes();
    final allTags = <String>{};
    for (final note in notes) {
      allTags.addAll(note.tags);
    }
    return allTags.toList()..sort();
  }

  Future<int> togglePin(String id) async {
    final note = await _db.getNoteById(id);
    if (note != null) {
      final updatedNote = note.copyWith(isPinned: !note.isPinned);
      return await _db.updateNote(updatedNote);
    }
    return 0;
  }
}
