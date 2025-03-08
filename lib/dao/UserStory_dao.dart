import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/models/UserStory.dart';

class UserStoryDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(UserStory userStory) async {
    Database db = await dbHelper.database;
    return await db.insert('user_stories', userStory.toMap());
  }

  Future<List<UserStory>> getAllUserStories() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('user_stories');
    return List.generate(maps.length, (i) {
      return UserStory.fromMap(maps[i]);
    });
  }

  Future<UserStory?> getUserStoryById(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_stories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserStory.fromMap(maps.first);
    }
    return null;
  }

  Future<List<UserStory>> getUserStoriesByEpicId(int epicId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_stories',
      where: 'EpiId = ?',
      whereArgs: [epicId],
    );
    return List.generate(maps.length, (i) {
      return UserStory.fromMap(maps[i]);
    });
  }

  Future<int> update(UserStory userStory) async {
    Database db = await dbHelper.database;
    return await db.update('user_stories', userStory.toMap(),
        where: 'id = ?', whereArgs: [userStory.Id]);
  }

  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('user_stories', where: 'id = ?', whereArgs: [id]);
  }
}