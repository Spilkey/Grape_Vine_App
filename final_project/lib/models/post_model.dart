import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

import 'post_entity.dart';

class PostModel {
  Stream<QuerySnapshot> getAllPosts() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
    return results;
  }

  // should go into topic model also should use topic collection
  getPostsFromTopic(topic_id) async {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topic_id)
        .snapshots();
    return results;
  }

  getAllPostsFromUser(user_id) async {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results =
        db.collection('posts').where('user_id', isEqualTo: user_id).snapshots();
    return results;
  }

  getAllPostsFromUserPublic(user_id) async {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('user_id', isEqualTo: user_id)
        .where('is_private', isEqualTo: 'false')
        .snapshots();
    return results;
  }

  // insert post data to the database
  insertPost(PostEntity post) async {
    FirebaseFirestore db = DB().database;
    var res = db.collection('posts').doc().set(post.toMap());
    return res;
  }
}
