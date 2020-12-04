import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

class ProfileModel {
  getUserInfo(user_id) async {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results =
        db.collection('users').where('user_id', isEqualTo: user_id).snapshots();
    return results;
  }
}
