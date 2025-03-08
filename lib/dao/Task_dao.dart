import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/models/Task.dart';

class TaskDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Task task) async {
    Database db = await dbHelper.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<Task?> getTaskById(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Task>> getTasksByUserStoryId(int userStoryId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'UserStoryId = ?',
      whereArgs: [userStoryId],
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<List<Task>> getTasksByEpicId(int epicId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'EpicId = ?',
      whereArgs: [epicId],
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int> update(Task task) async {
    Database db = await dbHelper.database;
    return await db.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.Id]);
  }

  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}