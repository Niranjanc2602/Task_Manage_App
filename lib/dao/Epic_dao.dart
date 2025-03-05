import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/database/database_helper.dart';
import 'package:sqflite_test/models/Epic.dart';
// import 'package:sqflite_test/utils/database_helper.dart';

class EpicDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Epic epic) async {
    Database db = await dbHelper.database;
    return await db.insert('epics', epic.toMap());
  }

  Future<List<Epic>> getAllEpics() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('epics');
    return List.generate(maps.length, (i) {
      return Epic.fromMap(maps[i]);
    });
  }

  Future<Epic?> getEpicById(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'epics',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Epic.fromMap(maps.first);
    }
    return null;
  }

  Future<int> update(Epic epic) async {
    Database db = await dbHelper.database;
    return await db.update('epics', epic.toMap(),
        where: 'id = ?', whereArgs: [epic.id]);
  }

  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('epics', where: 'id = ?', whereArgs: [id]);
  }
}