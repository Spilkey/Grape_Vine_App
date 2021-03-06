import 'dart:convert';
import 'dart:typed_data';
import 'package:final_project/views/profile_page.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

/** 
 * Row element for each user in the friends sidebar
 */
class SideBarUserRow extends StatelessWidget {
  final String imageData;
  final String username;
  final String userId;

  SideBarUserRow(this.imageData, this.username, this.userId);
  @override
  Widget build(BuildContext context) {
    CircleAvatar profileImage;

    Uint8List _bytesOwnerImage;
    if (this.imageData.isNotEmpty) {
      _bytesOwnerImage = Base64Codec().decode(this.imageData);
      profileImage = CircleAvatar(
        backgroundImage: MemoryImage(_bytesOwnerImage),
      );
    } else {
      profileImage = CircleAvatar(child: Icon(Icons.person));
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profileImage,
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text("@" + this.username),
              ),
            ),
          ],
        ),
        // direct to profile page
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                Uint8List userImage = _bytesOwnerImage == null
                    ? null
                    : Base64Codec().decode(this.imageData);
                return ProfilePage(
                  userID: this.userId,
                  userImage: userImage,
                  isFriend: true,
                );
              },
            ),
          );
        },
      ),
    );
  }
}