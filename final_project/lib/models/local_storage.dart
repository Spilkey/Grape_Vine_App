import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;

class LocalDB {
  LocalDB();
  static Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    String pathDb = path.join(await getDatabasesPath(), "data.db");
    return await openDatabase(pathDb, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print("initializing UserData table");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS UserData (userdata TEXT PRIMARY KEY, value TEXT)");
    });
  }
}
