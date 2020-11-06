import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

class PostModel {
  getAllPosts() async {
    FirebaseFirestore db = await DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
  }

  // should go into topic model also should use topic collection
  getPostsFromTopic(topic_id) async {
    FirebaseFirestore db = await DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topic_id)
        .snapshots();
  }

  getAllPostsFromUser(user_id) async {
    FirebaseFirestore db = await DB().database;
    Stream<QuerySnapshot> results =
        db.collection('posts').where('user_id', isEqualTo: user_id).snapshots();
  }

  getAllPostsFromUserPublic(user_id) async {
    FirebaseFirestore db = await DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('user_id', isEqualTo: user_id)
        .where('is_private', isEqualTo: 'true')
        .snapshots();
  }
}
