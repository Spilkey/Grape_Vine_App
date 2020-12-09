import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/user_data.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageModel {
  static Future<void> initUserData() async {
    UserData.init();
    var db = await LocalDB.database;
    Batch batch = db.batch();
    var map = UserData.toStringMap();

    map.forEach((key, value) {
      batch.rawInsert(
          'INSERT INTO UserData (userdata, value)'
          'VALUES(?, ?)',
          [key, value]);
    });
    try {
      var res = await batch.commit();
      print('UserData insert result:\n$res');
    } on DatabaseException {
      print('values have already been inserted');
    }
    print('database initialized');
  }

  // get all user settings from the database. Returns true on success
  Future<void> getUserData() async {
    var db = await LocalDB.database;
    var val = await db.query('UserData');
    print('query for UserData returned:\n$val');
    for (Map<String, dynamic> item in val) {
      Map<String, dynamic> data = {item['userdata']: item['value']};
      UserData.fromMap(data);
    }
  }

  // update a specific setting in the database
  Future<void> updateUserData(String key) async {
    var db = await LocalDB.database;
    await db.update('UserData', UserData.userData[key],
        where: 'userdata = ?', whereArgs: [key]);
  }

  // update all user settings
  Future<void> updateTable() async {
    var db = await LocalDB.database;
    Batch batch = db.batch();
    var map = UserData.toStringMap();
    map.forEach((key, value) {
      batch.rawUpdate(
          'UPDATE UserData SET value = ? WHERE userdata = ?', [value, key]);
    });
    var res = await batch.commit();
    print('UserData update result:\n$res');
  }

  // add all user settings to the database
  Future<void> addUserData(String key) async {
    var db = await LocalDB.database;
    await db.insert('UserData', UserData.userData[key],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
