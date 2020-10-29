import 'package:flutter/material.dart';

class Post {
  final bool isPrivate;

  final data;
  List<Post> comments;

  Post({this.isPrivate, this.data, this.comments});

  
  // TODO: add functions to make it play nice with databases

}

class PostWidgetBuilder {
  bool isPrivate;
  bool hasImg;

  PostWidgetBuilder({this.isPrivate, this.hasImg});

  Post buildPostWithString(String data) {
    return Post(
        isPrivate: isPrivate,
        data: Row(
          children: <Widget>[Text(data)],
        ),
        comments: []);
  }

  Post buildPostWithImg(String data, Image img) {
    return Post(
        isPrivate: isPrivate,
        data: Row(
          children: <Widget>[
            Text(data),
            img,
          ],
        ),
        comments: []);
  }
}
