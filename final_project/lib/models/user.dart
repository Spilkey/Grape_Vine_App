import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/user_db_notification.dart';

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
  List<UserNotifcation> notifications;

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
      'notifications': UserNotifcation.toMapList(notifications),
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
    // not all user's will have notifications
    returnUser.notifications = ref.data().containsKey('notifications')
        ? UserNotifcation.fromMapList(ref.get('notifications'))
        : [];
    returnUser.bio = ref.get('bio');

    return returnUser;
  }
}
