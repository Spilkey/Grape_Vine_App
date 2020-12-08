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

    return Scaffold(
      // streambuilder populates the listview from the firebase database
      body: StreamBuilder<QuerySnapshot>(
        stream: _model.getAllPosts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemCount: snapshot.data.docs.length,
                padding: const EdgeInsets.all(20.0),
                // when we get actual data use an item builder
                itemBuilder: (BuildContext context, int index) {
                  // Here we would pass in some parameters to our indiviual cards
                  // Example ----------------------
                  var data = snapshot.data.docs[index];
                  var streetName;
                  if (!data.data().keys.contains('street_name')) {
                    // if (snapshot.data.docs[index].containsKey('street_name')== null){
                    streetName = null;
                  } else {
                    streetName = data.get('street_name');
                  }
                  return FeedCard(
                      userId: data.get('owner_id'),
                      ownerProfileImageData: data.get('image_data'),
                      ownerName: data.get('owner_name'),
                      imageData: data.get('post_image_data'),
                      postTitle: data.get('post_title'),
                      postContent: data.get('content'),
                      streetName: streetName);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
