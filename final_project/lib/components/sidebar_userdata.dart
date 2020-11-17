import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class SideBarUserRow extends StatelessWidget {
  final String imageData;
  final String username;

  SideBarUserRow(this.imageData, this.username);
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [profileImage, Text("@" + this.username)],
      ),
    );
  }
}
