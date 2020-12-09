import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

//  The TopicModel class gathers data from the database such as posts and the topics
//  These methods are called from the feed_discover.dart

class TopicModel {
  //  method is used to get posts from the database under a specific topic id
  //  @param topic_id The topic id is a key used to identify the posts under the specific topic

  Stream<QuerySnapshot> getPostsFromTopic(topicId) {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topicId)
        .snapshots();

    return results;
  }

  //  method is used to get all posts from the database. Used to initialize the discover feed
  Stream<QuerySnapshot> getAllPosts() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
    return results;
  }

  //  method is used to get all topics from the database
  Stream<QuerySnapshot> getAllTopics() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('topics').snapshots();
    return results;
  }

  Future getTrendingTopics() async {
    var allTopicsData;
    List<TopicData> topicData = [];

    // Stream will continue to listen from DB, that's why theres a break statement
    await for (var topic in getAllTopics()) {
      allTopicsData = (topic.docs);
      break;
    }

    // get all posts related to the topic
    for (var topic in allTopicsData) {
      await for (var post in getPostsFromTopic(topic.id)) {
        String topicTitle = topic.data()['en_US_topic_name'];
        topicData
            .add(TopicData(numberOfPosts: post.docs.length, topic: topicTitle));
        break;
      }
    }

    // sort in ascending order and grab top 5
    topicData.sort((topic1, topic2) =>
        topic2.numberOfPosts.compareTo(topic1.numberOfPosts));
    List<TopicData> trendingTopic = topicData.sublist(0, 6);

    return trendingTopic;
  }
}

class TopicData {
  TopicData({this.numberOfPosts, this.topic});
  int numberOfPosts;
  String topic;
}
