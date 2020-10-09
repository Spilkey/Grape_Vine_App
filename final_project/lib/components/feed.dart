import 'package:flutter/material.dart';

import 'feed_card.dart';

/// This will be where we use our models and populate a feed
///
/// Will use our models to grab data from our storage and populate
/// feed_cards,
/// FeedCards will be what we show whether it be private or public
class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(20.0),
        // when we get actual data use an item builder
        itemBuilder: (BuildContext context, int index) {
          return FeedCard();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        });
  }
}
