import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';
import 'package:final_project/models/post.dart';
import 'package:final_project/models/post_entity.dart';

class TopicModel {
  // grabs data from firebase under collection 'posts' and the given id
  Future <List<PostEntity>> getPostsFromTopic(topic_id) async {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db
        .collection('posts')
        .where('topic_id', isEqualTo: topic_id)
        .snapshots();

    List <PostEntity> posts = [];

    // await for (var element in results){
      results.forEach((element) {
        element.docs.forEach((post) {
          print("DEBUG: ${post.get('content')}");
          try{ 
            posts.add(PostEntity.fromDB(post));
          }catch (e){
            print("Error: $e");
          }
        });
      });
      print('got here');
      return posts;
    }
    // print("got here");
    // return posts;
  
  Stream<QuerySnapshot> getAllPosts() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('posts').snapshots();
    return results;
  }

  // grabs all topics from database
  Stream<QuerySnapshot> getAllTopics() {
    FirebaseFirestore db = DB().database;
    Stream<QuerySnapshot> results = db.collection('topics').snapshots();
    return results;
  }
}
