
import 'package:sqflite_test/models/Note.dart';

class NoteData {
  static List<Note> _notes = [];

  static List<Note> getNotesForEpic(int epicId) {
    return _notes.where((note) => note.epicId == epicId).toList();
  }

  static void addNote(Note note) {
    _notes.add(note);
  }
}