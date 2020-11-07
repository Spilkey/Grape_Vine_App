import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  static FirebaseFirestore _database;

  FirebaseFirestore get database {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = initDB();
    return _database;
  }

  initDB() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore;
  }
}
