import 'package:flutter/material.dart';
import 'package:final_project/models/post.dart';

class PostWidgetBuilder {
  bool isPrivate;
  bool hasImg;

  PostWidgetBuilder({this.isPrivate, this.hasImg});

  //
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
