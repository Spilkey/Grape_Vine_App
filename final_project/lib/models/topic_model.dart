import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

class TopicModel {
  // grabs data from firebase under collection 'posts' and the given id
  Stream<QuerySnapshot> getPostsFromTopic(topic_id) {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topic_id)
        .snapshots();
    return results;
  }

  Stream<QuerySnapshot> getAllTopics() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
    return results;
  }
}
