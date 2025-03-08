import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/models/Note.dart';

class NoteDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Note note) async {
    Database db = await dbHelper.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getAllNotes() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<Note?> getNoteById(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Note>> getNotesByEpicId(int epicId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'epic_id = ?',
      whereArgs: [epicId],
    );
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> update(Note note) async {
    Database db = await dbHelper.database;
    return await db.update('notes', note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}