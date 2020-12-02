import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserSettingsModel {
  static Future<void> initUserSettings() async {
    UserSettings.init();
    var db = await LocalDB.database;
    Batch batch = db.batch();
    var map = UserSettings.toStringMap();

    map.forEach((key, value) {
      batch.rawInsert(
          'INSERT INTO UserData (setting, value)'
          'VALUES(?, ?)',
          [key, value]);
    });
    try {
      var res = await batch.commit();
      print('UserData insert result:\n$res');
    } on DatabaseException {
      print('settings have already been inserted');
    }
    print('database initialized');
  }

  // get all user settings from the database. Returns true on success
  Future<void> getUserSettings() async {
    var db = await LocalDB.database;
    var val = await db.query('UserData');
    print('query for UserData returned:\n$val');
    for (Map<String, dynamic> item in val) {
      Map<String, dynamic> setting = {item['setting']: item['value']};
      UserSettings.fromMap(setting);
    }
  }

  // update a specific setting in the database
  Future<void> updateUserSetting(String key) async {
    var db = await LocalDB.database;
    await db.update('UserData', UserSettings().settings[key],
        where: 'setting = ?', whereArgs: [key]);
  }

  // update all user settings
  Future<void> updateAllSettings() async {
    var db = await LocalDB.database;
    Batch batch = db.batch();
    var map = UserSettings.toStringMap();
    map.forEach((key, value) {
      batch.rawUpdate(
          'UPDATE UserData SET value = ? WHERE setting = ?', [value, key]);
    });
    var res = await batch.commit();
    print('UserData update result:\n$res');
  }

  // add all user settings to the database
  Future<void> addUserSettings(String key) async {
    var db = await LocalDB.database;
    await db.insert('UserData', UserSettings().settings[key],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
