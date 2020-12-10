import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';
import 'package:final_project/models/user.dart';

class UserModel {
  // insert post data to the database
  Future<DocumentReference> insertUser(User user) async {
    FirebaseFirestore db = DB().database;
    Future<DocumentReference> res = db.collection('users').add(user.toMap());
    return res;
  }

  Future updateUser(User user) {
    FirebaseFirestore db = DB().database;
    Future res = db.collection('users').doc(user.id).set(user.toMap());
    return res;
  }

  updateSubscriptions(User user, String subscription){
    FirebaseFirestore db = DB().database;
    var res = db.collection('users').doc(user.id).
  }

  Future<User> getUser(String id) async {
    FirebaseFirestore db = DB().database;
    DocumentSnapshot res = await db.collection('users').doc(id).get();
    return User.fromDB(res);
  }

  Future<QuerySnapshot> getUserByUsername(String username) async {
    FirebaseFirestore db = DB().database;
    Future<QuerySnapshot> res =
        db.collection('users').where('username', isEqualTo: username).get();
    return res;
  }
}
