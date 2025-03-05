import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "project_management.db";
  static const _databaseVersion = 1;

  // Make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper
      ._privateConstructor(); // Added 'static' here

  // Only have a single app-wide reference to the database
  static Database? _database; // Added 'static' here
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the database the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE epics (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            status TEXT NOT NULL,
            priority INTEGER NOT NULL,
            endDate TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE user_stories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            status TEXT NOT NULL,
            priority INTEGER NOT NULL,
            dateTime TEXT,
            EpiId INTEGER,
            FOREIGN KEY (EpiId) REFERENCES epics(id) ON DELETE CASCADE
          )
          ''');
    await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            status TEXT NOT NULL,
            priority INTEGER NOT NULL,
            dateTime TEXT,
            UserStoryId INTEGER,
            EpicId INTEGER,
            FOREIGN KEY (UserStoryId) REFERENCES user_stories(id) ON DELETE CASCADE,
            FOREIGN KEY (EpicId) REFERENCES epics(id) ON DELETE CASCADE
          )
          ''');
    await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT NOT NULL,
            dateTime TEXT,
            epicId INTEGER,
            userStoryId INTEGER,
            taskId INTEGER,
            FOREIGN KEY (epicId) REFERENCES epics(id) ON DELETE CASCADE,
            FOREIGN KEY (userStoryId) REFERENCES user_stories(id) ON DELETE CASCADE,
            FOREIGN KEY (taskId) REFERENCES tasks(id) ON DELETE CASCADE
          )
          ''');
  }
}