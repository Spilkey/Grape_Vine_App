import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../components/profile_feed_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/db.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    @required this.userName,
    this.userImage,
    Key key,
  }) : super(key: key);

  // TODO: uncomment once profile page is linked to actual accounts
  final String userName;
  // final String bio;
  final Uint8List userImage;
  // final bool personAdded;
  // final List<?> userPosts;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double avatarRadius = 50, marginTop = 50;
  final double profileContainerSize = 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
            0.4,
            0.4,
            0.2,
            0.7,
            0.1
          ],
              colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xFF6541A5),
            Color(0xFF4D307F),
            Color(0xFF472B75),
            Color(0xFF3D2464),
            Color(0xFF2C1745),
          ])),
      child: Column(
        children: [
          Container(
              child: SizedBox(
                  height:
                      MediaQuery.of(context).size.height * profileContainerSize,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              // TODO: change the appearance once added
                              IconButton(
                                  icon: Icon(
                                    Icons.person_add_alt,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onPressed: () {})
                            ],
                          )),
                      Center(
                          child: widget.userImage == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  radius: avatarRadius,
                                  child: Icon(Icons.person))
                              : CircleAvatar(
                                  radius: avatarRadius,
                                  backgroundImage:
                                      MemoryImage(widget.userImage),
                                )),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              widget.userName,
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )),
                      // TODO: add overflow condition?
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Expanded(
                            child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra et quam eget tempus.')),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('127 ',
                                    style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  'Friends',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))
                    ],
                  )),
              color: Colors.white),
          // TODO: replace this with ListView Builder when integrating DB
          Container(
            child: Expanded(
                child: ListView(
              children: [
                FeedCard(
                  ownerName: 'Owner name',
                  imageData: '',
                  ownerProfileImageData: '',
                  postTitle: 'Title',
                  postContent: 'Content',
                ),
                FeedCard(
                  ownerName: 'Owner name',
                  imageData: '',
                  ownerProfileImageData: '',
                  postTitle: 'Title',
                  postContent: 'Content',
                ),
                FeedCard(
                  ownerName: 'Owner name',
                  imageData: '',
                  ownerProfileImageData: '',
                  postTitle: 'Title',
                  postContent: 'Content',
                ),
                FeedCard(
                  ownerName: 'Owner name',
                  imageData: '',
                  ownerProfileImageData: '',
                  postTitle: 'Title',
                  postContent: 'Content',
                )
              ],
            )),
          ),
        ],
      ),
    ));
  }
}
