import 'dart:typed_data';
import 'dart:convert';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/utils/image_utils.dart';
import 'package:flutter/material.dart';
import '../views/profile_page.dart';

// Is a card that will appear in a feed

/**
 * Will display a feed card with 
 * - owner profile pic
 * - owner name
 * - post name
 * - post content
 * - post image
 * - reactions(TBD)
 */
class FeedCard extends StatefulWidget {
  // owner variables
  final String ownerName;
  final String ownerProfileImageData;
  final String userId;

  // post variables
  final String imageData;
  final String postTitle;
  final String postContent;
  final String streetName;

  FeedCard(
      {this.imageData,
      this.ownerProfileImageData,
      this.ownerName,
      this.postTitle,
      this.postContent,
      this.streetName,
      this.userId});

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool userDataloaded = false;

  User userData;

  UserModel _uModel = new UserModel();

  @override
  Widget build(BuildContext context) {
    // Get the data from the db
    CircleAvatar profileImage;
    Widget postImage;

    bool useDefaultImage;
    bool postImageGiven = false;

    Widget location;

    if (userData != null) {
      if (userData.profilePic != null) {
        useDefaultImage = false;
        Uint8List _bytesOwnerImage =
            ImageUtil.getDataFromBase64String(userData.profilePic);
        profileImage = CircleAvatar(
          backgroundImage: MemoryImage(_bytesOwnerImage),
        );
      }
    } else if (!widget.ownerProfileImageData.isEmpty) {
      useDefaultImage = false;
      Uint8List _bytesOwnerImage =
          ImageUtil.getDataFromBase64String(widget.ownerProfileImageData);
      profileImage = CircleAvatar(
        backgroundImage: MemoryImage(_bytesOwnerImage),
      );
    } else {
      useDefaultImage = true;
      profileImage = CircleAvatar(child: Icon(Icons.person));
    }
    if (!widget.imageData.isEmpty) {
      Uint8List _bytesPostImage =
          ImageUtil.getDataFromBase64String(widget.imageData);
      postImage = Container(
        height: 200,
        child: Image.memory(
          _bytesPostImage,
          height: 200,
        ),
      );
      postImageGiven = true;
    } else {
      postImage = Container(
          color: Colors.grey[400],
          height: 200,
          child: Center(
            child: Text("No Image"),
          ));
      postImageGiven = false;
    }
    if (widget.streetName != null) {
      location = Row(children: <Widget>[
        Icon(
          Icons.location_on,
        ),
        Flexible(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.streetName,
                )),
          ),
        ),
      ]);
    } else {
      location = Row();
    }
    if (widget.userId != null && !userDataloaded) {
      _uModel.getUser(widget.userId).then((value) {
        userData = value;

        setState(() {
          userDataloaded = !userDataloaded;
        });
      }).catchError((error) {
        print(error);
        setState(() {
          userDataloaded = !userDataloaded;
        });
      });
      return Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[400], spreadRadius: 3, blurRadius: 10),
          ],
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        height: 500,
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: profileImage,
                title: GestureDetector(
                  child: Text(
                      userData != null ? userData.userName : widget.ownerName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          Uint8List userImage = useDefaultImage
                              ? null
                              : Base64Codec()
                                  .decode(widget.ownerProfileImageData);
                          return ProfilePage(
                            userID: widget.userId,
                            userImage: userImage,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                child: Text(widget.postTitle),
              ),
              location,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.postContent,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              postImage
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[400], spreadRadius: 3, blurRadius: 10),
          ],
        ),
      );
    }
  }
}
