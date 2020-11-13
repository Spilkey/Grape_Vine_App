import 'package:flutter/material.dart';
import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserSettingsModel {
  static Future<void> initUserSettings() async {
    var db = await LocalDB.database;
    Batch batch = db.batch();
    var map = UserSettings.toStringMap();
    map.forEach((key, value) {
      batch.insert('UserData', {key: value as dynamic});
    });
    await batch.commit(noResult: true);
    print('database initialized');
  }

  // get all user settings from the database. Returns true on success
  Future<void> getUserSettings() async {
    var db = await LocalDB.database;
    var val = await db.query('UserData');
    print(val);
    for (Map<String, dynamic> item in val) {
      UserSettings.fromMap(item);
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
      batch.update('UserData', {key: value as dynamic},
          where: 'setting = ?', whereArgs: [key]);
    });
    await batch.commit(noResult: true);
  }

  // add all user settings to the database
  Future<void> addUserSettings(String key) async {
    var db = await LocalDB.database;
    await db.insert('UserData', UserSettings().settings[key],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
