// class for sending data to the database
class PostEntity {

  // Fields for post:
  final String content;
  final String imageData;
  final bool isPrivate;
  final String ownerId;
  final String ownerName;
  final String postImageData;
  final String postTitle;
  final String topicId;
  
  PostEntity({this.content, this.imageData, this.isPrivate, this.ownerId, this.ownerName, this.postImageData, this.postTitle, this.topicId});

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
}