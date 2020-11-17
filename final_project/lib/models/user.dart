import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';
import 'package:flutter/material.dart';

class User {
  User() {}

  // User keys that are generated on registration
  final String publicKey = '';
  final String privateKey = '';
  // Unique user data
  String username = '';
  String password = '';

  String bio;
  String profilePic;

  // List of documentId's for friends
  List<String> friends;
  List<String> subscriptions;
  List notifications;

  String id;

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

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'friends': friends,
      'subscriptions': subscriptions,
      'profile_pic': profilePic,
      'bio': bio
    };
  }

  factory User.fromDB(Stream<DocumentSnapshot> ref) {
    User returnUser = new User();
    ref.forEach((element) {
      returnUser.id = element.id;
      returnUser.username = element.get('username');
      returnUser.password = element.get('password');
      returnUser.friends = element.get('friends');
      returnUser.subscriptions = element.get('subscriptions');
      returnUser.profilePic = element.get('profile_pic');
      returnUser.bio = element.get('bio');
    });
    return returnUser;
  }
}
