import 'package:final_project/models/post_entity.dart';
import 'package:final_project/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_project/models/post_model.dart';
import 'feed_card.dart';

/// This will be where we use our models and populate a feed
///
/// Will use our models to grab data from our storage and populate
/// feed_cards,
/// FeedCards will be what we show whether it be private or public
///
class Feed extends StatefulWidget {
  final bool isPrivate;

  Feed(this.isPrivate);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // instance of post model
  final _model = new PostModel();

  @override
  Widget build(BuildContext context) {
    // returns a ListView builder, specificially seperated listview
    // generates an itemCount length List of Widgets
    // We use an item builder - we can use a promise here to obtain data from our data base
    // We should store our data retrieved from our db in the state here

    String currentUserId = UserData.userData['user_id'];

    return Scaffold(
      // streambuilder populates the listview from the firebase database
      body: FutureBuilder<List<PostEntity>>(
        future: widget.isPrivate
            ? _model.getUserPostsPrivate(currentUserId)
            : _model.getUserPostsPublic(currentUserId),
        builder: (context, AsyncSnapshot<List<PostEntity>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(20.0),
                // when we get actual data use an item builder
                itemBuilder: (BuildContext context, int index) {
                  // Here we would pass in some parameters to our indiviual cards
                  // Example ----------------------
                  var data = snapshot.data[index];
                  if (data != null) {
                    return FeedCard(
                      userId: data.ownerId,
                      ownerProfileImageData: data.imageData,
                      ownerName: data.ownerName,
                      imageData: data.postImageData,
                      postTitle: data.postTitle,
                      postContent: data.content,
                      streetName: data.streetName,
                    );
                  } else {
                    FeedCard();
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                });
          } else {
            return Center(
                child: Text("It looks like you have no friends posts yet"));
          }
        },
      ),
    );
  }
}
