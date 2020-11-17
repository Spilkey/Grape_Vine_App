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

  User getUser(String id) {
    FirebaseFirestore db = DB().database;
    Stream<DocumentSnapshot> res = db.collection('posts').doc(id).snapshots();
    return User.fromDB(res);
  }
}
