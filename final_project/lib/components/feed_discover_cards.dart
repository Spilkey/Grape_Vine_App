import 'package:final_project/models/post_entity.dart';
import 'package:flutter/material.dart';

import 'feed_card.dart';

/**
 *  The DiscoverFeedCards program utilizes the feed_card to display information from the database onto the discover page
 */
class DiscoverFeedCards extends StatefulWidget {

  PostEntity data;

  DiscoverFeedCards({Key key, @required this.data}) : super(key: key);

  /**
   * method creates a mutable state for this widget
   */
  @override
  _DiscoverFeedCardsState createState() => new _DiscoverFeedCardsState(data);
}

class _DiscoverFeedCardsState extends State<DiscoverFeedCards> {
  /**
   * After the constructor receives data, the widget gets data from feed_discover class and populates the feed cards accordingly
   */
  PostEntity data;
  // constructor
  _DiscoverFeedCardsState(this.data);

  @override
  Widget build(BuildContext context) {
    
    // sample feed card
    Widget mainCard = FeedCard(
      ownerProfileImageData: data.imageData,
      ownerName: data.ownerName,
      imageData: data.postImageData,
      postTitle: data.postTitle,
      postContent: data.content,
    );
    
    return Row(
      children: <Widget>[
        Column(children: <Widget>[
          Row(children: <Widget>[
            Container(padding: EdgeInsets.fromLTRB(40.0, 16.0, 0, 16.0), width: 350, child: mainCard)
          ]),
        ])
      ],
    );
  }
}
