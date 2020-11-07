import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

  // post variables
  final String imageData;
  final String postTitle;
  final String postContent;

  FeedCard(
      {this.imageData,
      this.ownerProfileImageData,
      this.ownerName,
      this.postTitle,
      this.postContent});

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    // Get the data from the db

    Uint8List _bytesPostImage = Base64Codec().decode(widget.imageData);
    Uint8List _bytesOwnerImage =
        Base64Codec().decode(widget.ownerProfileImageData);
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: MemoryImage(_bytesOwnerImage),
              ),
              // Post Title
              title: Text(widget.postTitle),
              subtitle: Text(
                //
                widget.ownerName,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.postContent,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Container(
              child: Image.memory(_bytesPostImage),
            )
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
