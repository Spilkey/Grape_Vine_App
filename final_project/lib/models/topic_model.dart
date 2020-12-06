import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

/**
 * The TopicModel class gathers data from the database such as posts and the topics
 * These methods are called from the feed_discover.dart
 */
class TopicModel {
  /**
   * method is used to get posts from the database under a specific topic id
   * @param topic_id The topic id is a key used to identify the posts under the specific topic
  */
  Stream<QuerySnapshot> getPostsFromTopic(topic_id) {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topic_id)
        .snapshots();

    return results;
  }

  /**
   * method is used to get all posts from the database. Used to initialize the discover feed
   */
  Stream<QuerySnapshot> getAllPosts() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
    return results;
  }

  /**
   * method is used to get all topics from the
   */
  Stream<QuerySnapshot> getAllTopics() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('topics').snapshots();
    return results;
  }
}
