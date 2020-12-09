import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

/** 
 * Row element for each user in the friends sidebar
 */
class SideBarUserRow extends StatelessWidget {
  final String imageData;
  final String username;
  final String user_id;

  SideBarUserRow(this.imageData, this.username, this.user_id);
  @override
  Widget build(BuildContext context) {
    CircleAvatar profileImage;

    if (this.imageData.isNotEmpty) {
      Uint8List _bytesOwnerImage = Base64Codec().decode(this.imageData);
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
            Container(
                padding: EdgeInsets.all(10), child: Text("@" + this.username))
          ],
        ),
        // direct to profile page
        onTap: () {},
      ),
    );
  }
}