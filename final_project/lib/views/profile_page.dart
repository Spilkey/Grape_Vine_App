import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/colors.dart';
import 'package:final_project/models/post_model.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter/material.dart';
import '../components/profile_feed_card.dart';

LinearGradient backgroundGradient() {
  return GradientBackground;
}

/**
 * Top part of profile page incharge of displaying add user as friend and go back buttons
 * Will also show username and amount of friends
 */
class NavBar extends StatefulWidget {
  NavBar({@required this.userName, this.isFriend, Key key}) : super(key: key);

  final String userName;
  final bool isFriend;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Icon friendStatus = Icon(
    Icons.person_add_alt,
    color: LightColor,
  );
  @override
  Widget build(BuildContext context) {
    Widget addFriendButton;
    if (!widget.isFriend) {
      addFriendButton = IconButton(
        icon: friendStatus,
        onPressed: () {
          final addFriendMessage =
              SnackBar(content: Text('Added ${widget.userName}'));
          setState(
            () {
              friendStatus = Icon(
                Icons.person,
                color: LightColor,
              );
            },
          );
          Scaffold.of(context).showSnackBar(addFriendMessage);
        },
      );
    } else {
      addFriendButton = Container();
    }

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: LightColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            addFriendButton
          ],
        ));
  }
}

/** 
 * Parent container for entire profile page
 * Will combine navbar top widget with list of user's posts
 */
class ProfilePage extends StatefulWidget {
  ProfilePage({
    @required this.userID,
    this.userImage,
    this.isFriend = false,
    Key key,
  }) : super(key: key);

  final String userID;
  final Uint8List userImage;
  final bool isFriend;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double avatarRadius = 50, marginTop = 50;
  final double profileContainerSize = 0.4;

  final _uModel = new UserModel();
  final _postsModel = new PostModel();

  Future profileData() async {
    User getUserData = await _uModel.getUser(widget.userID);

    QuerySnapshot getPosts =
        await _postsModel.getAllPostsFromUser(widget.userID);

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
              var userProfileData = snapshot.data['userDataSnapshot'];
              return Column(
                children: [
                  Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            profileContainerSize,
                        child: Column(
                          children: [
                            // ACTION BUTTONS
                            NavBar(
                              userName: userProfileData.username,
                              isFriend: widget.isFriend,
                            ),
                            // USER AVATAR
                            Center(
                                child: widget.userImage == null
                                    ? CircleAvatar(
                                        backgroundColor: LightColor,
                                        radius: avatarRadius,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ))
                                    : CircleAvatar(
                                        radius: avatarRadius,
                                        backgroundImage:
                                            MemoryImage(widget.userImage),
                                      )),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Text(
                                  userProfileData.username,
                                  style: TextStyle(
                                      color: SecondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            // USER BIO
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Expanded(child: Text(userProfileData.bio)),
                            ),
                            // USER FRIEND COUNT
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${userProfileData.friends.length} ',
                                        style: TextStyle(
                                            color: SecondaryColor,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      'Friends',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white),
                  // POSTS
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemCount:
                            snapshot.data['postDataSnapshot'].documents.length,
                        itemBuilder: (context, index) {
                          var postData = snapshot
                              .data['postDataSnapshot'].docs[index]
                              .data();
                          print(postData);
                          return FeedCard(
                            ownerName: userProfileData.username,
                            imageData: postData['post_image_data'],
                            ownerProfileImageData: postData['image_data'],
                            postTitle: postData['post_title'],
                            postContent: postData['content'],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            profileContainerSize,
                        child: Column(
                          children: [
                            // USER AVATAR
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
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
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
