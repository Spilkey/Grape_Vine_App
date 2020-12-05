import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';
import 'package:final_project/models/user.dart';

class UserModel {
  // insert post data to the database
  insertUser(User user) async {
    FirebaseFirestore db = DB().database;
    var res = db.collection('posts').doc().set(user.toMap());
    return res;
  }

  updateUser(User user) {
    FirebaseFirestore db = DB().database;
    var res = db.collection('posts').doc(user.id).set(user.toMap());
    return res;
  }

  Future<User> getUser(String id) async {
    FirebaseFirestore db = DB().database;
    DocumentSnapshot res = await db.collection('users').doc(id).get();
    return User.fromDB(res);
  }
}
