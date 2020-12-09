import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';
import 'package:flutter/material.dart';

class User {
  User();

  // Unique user data
  String id;
  String username = '';

  String bio;
  String profilePic;

  // List of documentId's for friends
  List friends;
  List subscriptions;
  List notifications;

  set userName(String name) {
    username = name;
  }

  String get userName {
    return username;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
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
    returnUser.friends = ref.get('friends');
    returnUser.subscriptions = ref.get('subscriptions');
    returnUser.profilePic = ref.get('profile_pic');
    returnUser.bio = ref.get('bio');

    return returnUser;
  }
}
