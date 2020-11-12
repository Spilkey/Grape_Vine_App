import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;

class LocalDB {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String pathDb = path.join(await getDatabasesPath(), "data.db");
    print("creating table");
    return await openDatabase(pathDb, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE UserData (setting TEXT PRIMARY KEY, val TEXT)");
      });
  }
}
