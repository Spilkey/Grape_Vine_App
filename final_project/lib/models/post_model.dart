import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';

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

  Future<QuerySnapshot> getAllPostsFromUser(user_id) async {
    FirebaseFirestore db = DB().database;
    Future<QuerySnapshot> results =
        db.collection('posts').where('owner_id', isEqualTo: user_id).get();
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

  Future<QuerySnapshot> getAllPostsFromUserFriendsList(
      user_id, isPrivate) async {
    FirebaseFirestore db = DB().database;
    User user = await UserModel().getUser(user_id);
    if (user.friends.length != 0) {}
    // Combining all use friends with current user's id into list
    List<dynamic> allUids = new List.from(user.friends)..add(user.id);

    QuerySnapshot friendsPosts = await db
        .collection('posts')
        .where('owner_id', whereIn: allUids)
        .where('is_private', isEqualTo: isPrivate)
        .get();
    return friendsPosts;
  }

  Future<List<PostEntity>> getUserPostsPublic(user_id) async {
    FirebaseFirestore db = DB().database;
    QuerySnapshot friendsList =
        await this.getAllPostsFromUserFriendsList(user_id, false);

    List<PostEntity> returnList = [];
    returnList.addAll(friendsList.docs.map((QueryDocumentSnapshot qds) {
      return PostEntity.fromDB(qds);
    }).toList());

    User user = await UserModel().getUser(user_id);
    QuerySnapshot topicPosts;
    if (user.subscriptions != null) {
      topicPosts = await db
          .collection('posts')
          .where('topic_id', whereIn: user.subscriptions)
          .where('is_private', isEqualTo: false)
          .get();
      returnList.addAll(topicPosts.docs.map((QueryDocumentSnapshot qds) {
        PostEntity.fromDB(qds);
      }).toList());
    }
    return returnList;
  }

  Future<List<PostEntity>> getUserPostsPrivate(user_id) async {
    FirebaseFirestore db = DB().database;
    QuerySnapshot friendsList =
        await this.getAllPostsFromUserFriendsList(user_id, true);
    List<PostEntity> returnList = [];
    returnList.addAll(friendsList.docs.map((QueryDocumentSnapshot qds) {
      return PostEntity.fromDB(qds);
    }).toList());

    return returnList;
  }

  // insert post data to the database
  insertPost(PostEntity post) async {
    FirebaseFirestore db = DB().database;
    var res = db.collection('posts').doc().set(post.toMap());
    return res;
  }
}
