import 'post.dart';
import 'package:flutter/material.dart';

class User {
  // User keys that are generated on registration
  final String publicKey = '';
  final String privateKey = '';
  // Unique user data
  String username = '';
  String password = '';
  List<Post> userPosts;
  List<Post> _mainFeed;

  List<User> friends;
  List subscriptions;

  set userName(String name) {
    username = name;
  }

  String get userName {
    return username;
  }

  set passWord(String pass) {
    password = pass;
  }

  String get passWord {
    return password;
  }

  void createPost(bool isPrivate, bool hasImg, String data, Image img) {
    PostWidgetBuilder builder =
        new PostWidgetBuilder(isPrivate: isPrivate, hasImg: hasImg);
    var post;

    if (hasImg) {
      post = builder.buildPostWithImg(data, img);
    } else {
      post = builder.buildPostWithString(data);
    }

    userPosts.add(post);
  }

  void updateMainFeed() {}
}
