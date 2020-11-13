import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';
import 'package:flutter/material.dart';

class Post {
  final bool isPrivate;

  final data;
  List<Post> comments;

  Post({this.isPrivate, this.data, this.comments});

  // TODO: add functions to make it play nice with databases

}
