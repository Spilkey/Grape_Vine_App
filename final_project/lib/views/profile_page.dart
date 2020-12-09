import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/profile_feed_card.dart';

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
    ]
  );
}

class NavBar extends StatefulWidget {
  NavBar({@required this.userName, Key key}) : super(key: key);

  final String userName;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Icon friendStatus = Icon(
    Icons.person_add_alt,
    color: Colors.deepPurpleAccent,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: friendStatus,
                onPressed: () {
                  final addFriendMessage =
                      SnackBar(content: Text('Added ${widget.userName}'));
                  setState(() {
                    friendStatus = Icon(
                      Icons.person,
                      color: Colors.deepPurpleAccent,
                    );
                  });
                  Scaffold.of(context).showSnackBar(addFriendMessage);
                })
          ],
        ));
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({
    @required this.userName,
    this.userID,
    // @required this.userID,
    this.userImage,
    Key key,
  }) : super(key: key);

  final String userName;
  final String userID;
  final Uint8List userImage;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double avatarRadius = 50, marginTop = 50;
  final double profileContainerSize = 0.4;

  Future profileData() async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('users');

    CollectionReference userPosts =
        FirebaseFirestore.instance.collection('posts');

    var getUserData =
        await userProfile.where('username', isEqualTo: widget.userName).get();

    var getPosts =
        await userPosts.where('owner_name', isEqualTo: widget.userName).get();

    return {'userDataSnapshot': getUserData, 'postDataSnapshot': getPosts};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(gradient: backgroundGradient()),
            child: FutureBuilder(
                future: profileData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userProfileData =
                        snapshot.data['userDataSnapshot'].docs[0].data();
                    return Column(
                      children: [
                        Container(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    profileContainerSize,
                                child: Column(
                                  children: [
                                    // ACTION BUTTONS
                                    NavBar(userName: widget.userName),
                                    // USER AVATAR
                                    Center(
                                        child: widget.userImage == null
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                radius: avatarRadius,
                                                child: Icon(Icons.person))
                                            : CircleAvatar(
                                                radius: avatarRadius,
                                                backgroundImage: MemoryImage(
                                                    widget.userImage),
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
                                      child: Expanded(
                                          child: Text(userProfileData['bio'])),
                                    ),
                                    // USER FRIEND COUNT
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${userProfileData['friends'].length} ',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                'Friends',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                            color: Colors.white),
                        // POSTS
                        Container(
                          child: Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data['postDataSnapshot']
                                      .documents.length,
                                  itemBuilder: (context, index) {
                                    var postData = snapshot
                                        .data['postDataSnapshot'].docs[index]
                                        .data();
                                    return FeedCard(
                                      ownerName: widget.userName,
                                      imageData: postData['post_image_data'],
                                      ownerProfileImageData:
                                          postData['image_data'],
                                      postTitle: postData['post_title'],
                                      postContent: postData['content'],
                                    );
                                  })),
                        )
                      ],
                    );
                  } else {
                    return Container(
                        child: Column(children: [
                      Container(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  profileContainerSize,
                              child: Column(children: [
                                // USER AVATAR
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: widget.userImage == null
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: avatarRadius,
                                              child: Icon(Icons.person))
                                          : CircleAvatar(
                                              radius: avatarRadius,
                                              backgroundImage:
                                                  MemoryImage(widget.userImage),
                                            )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              ])))
                    ]));
                  }
                })));
  }
}
