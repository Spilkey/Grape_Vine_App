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
  List friends;
  List subscriptions;
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

  factory User.fromDB(DocumentSnapshot ref) {
    User returnUser = new User();
    returnUser.id = ref.id;
    returnUser.username = ref.get('username');
    returnUser.password =
        ref.data().containsKey('password') ? ref.get('password') : null;
    returnUser.friends = ref.get('friends');
    returnUser.subscriptions = ref.get('subscriptions');
    returnUser.profilePic = ref.get('profile_pic');
    returnUser.bio = ref.get('bio');

    return returnUser;
  }
}
