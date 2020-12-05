import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/profile_feed_card.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    @required this.userName,
    this.userImage,
    Key key,
  }) : super(key: key);

  final String userName;
  final Uint8List userImage;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double avatarRadius = 50, marginTop = 50;
  final double profileContainerSize = 0.4;

  CollectionReference userProfile =
      FirebaseFirestore.instance.collection('users');

  CollectionReference userPosts =
      FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: FutureBuilder(
          // TODO: to replace with widget.username
          future:
              userProfile.where('user_id', isEqualTo: 'temp_new_post_id').get(),
          builder: (context, snapshot) {
            var userProfileData = snapshot.data.docs[0].data();

            return Column(
              children: [
                Container(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            profileContainerSize,
                        child: Column(
                          children: [
                            // ACTION BUTTONS
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            // USER AVATAR
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
                            // USER BIO
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child:
                                  Expanded(child: Text(userProfileData['bio'])),
                            ),
                            // USER FRIEND COUNT
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${userProfileData['friends'].length} ',
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Friends',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        )),
                    color: Colors.white),
                // POSTS
                FutureBuilder(
                    future: userPosts
                        .where('owner_id', isEqualTo: 'temp_new_post_id')
                        .get(),
                    builder: (context, snapshot) {
                      return Container(
                        child: Expanded(child:
                            ListView.builder(itemBuilder: (context, index) {
                          var postData = snapshot.data.docs[index].data();
                          return FeedCard(
                            ownerName: 'temp_new_post_id',
                            imageData: postData['image_data'],
                            ownerProfileImageData: postData['post_image_data'],
                            postTitle: postData['post_title'],
                            postContent: postData['content'],
                          );
                        })),
                      );
                    }),
              ],
            );
          }),
    ));
  }
}

LinearGradient backgroundGradient() {
  return LinearGradient(
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
        Color(0xFF6541A5),
        Color(0xFF4D307F),
        Color(0xFF472B75),
        Color(0xFF3D2464),
        Color(0xFF2C1745),
      ]);
}
