// class for sending data to the database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/post.dart';

class PostEntity {

  // Fields for post:
  String content;
  String imageData;
  bool isPrivate;
  String ownerId;
  String ownerName;
  String postImageData;
  String postTitle;
  String topicId;
  String postId;
  
  PostEntity({this.content, this.imageData, this.isPrivate, this.ownerId, this.ownerName, this.postImageData, this.postTitle, this.topicId, this.postId});

  // map values. Also checks that the values are not null. If they are, set them to blank or false (depending if it's a string or boolean)
  Map<String, dynamic> toMap() {
    return {
      'content': content != null ? content : "",
      'image_data': imageData != null ? imageData : "",
      'is_private': isPrivate != null ? isPrivate : false,
      'owner_id': ownerId != null ? ownerId : "",
      'owner_name': ownerName != null ? ownerName : "",
      'post_image_data': postImageData != null ? postImageData : "",
      'post_title': postTitle != null ? postTitle : "",
      'topic_id': topicId != null ? topicId : ""
    };
  }

  factory PostEntity.fromDB(QueryDocumentSnapshot ref) {
    PostEntity returnPost = new PostEntity();
      returnPost.postId = ref.id;
      returnPost.content = ref.get('content');
      returnPost.imageData = ref.get('image_data');
      returnPost.isPrivate = ref.get('is_private') == "true";
      returnPost.ownerId = ref.get('owner_id');
      returnPost.ownerName= ref.get('owner_name');
      returnPost.postImageData = ref.get('post_image_data');
      returnPost.postTitle = ref.get('post_title');
      returnPost.topicId = ref.get('topic_id');
    return returnPost;
  }
}