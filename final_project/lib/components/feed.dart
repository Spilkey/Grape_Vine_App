import 'package:flutter/material.dart';

import 'feed_card.dart';

//TODO Pass in some parameters so we know what type of Feed we're going to draw

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
  @override
  Widget build(BuildContext context) {
    // returns a ListView builder, specificially seperated listview
    // generates an itemCount length List of Widgets
    // We use an item builder - we can use a promise here to obtain data from our data base
    // We should store our data retrieved from our db in the state here
    return ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(20.0),
        // when we get actual data use an item builder
        itemBuilder: (BuildContext context, int index) {
          // Here we would pass in some parameters to our indiviual cards
          return FeedCard();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        });
  }
}
