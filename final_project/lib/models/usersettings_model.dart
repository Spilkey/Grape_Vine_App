import 'package:flutter/material.dart';
import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserSettingsModel {
  LocalDB _db;
  // get all user settings from the database. Returns true on success
  Future<void> getUserSettings() async {
    var db = await _db.database;
    var val = await db.query('UserData');
    for (Map<String, dynamic> item in val) {
      UserSettings.fromMap(item);
    }
  }

  // update a specific setting in the database
  Future<void> updateUserSetting(String key) async {
    var db = await _db.database;
    await db.update('UserData', UserSettings.settings[key],
        where: 'setting = ?', whereArgs: [key]);
  }

  // add all user settings to the database
  Future<void> addUserSettings(String key) async {
    var db = await _db.database;
    var val = db.insert('UserData', UserSettings.settings[key],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
