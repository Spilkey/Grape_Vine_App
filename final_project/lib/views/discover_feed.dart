import 'package:final_project/components/feed_discover.dart';
import 'package:flutter/material.dart';

class DiscoverFeedPage extends StatefulWidget {
  String title;

  DiscoverFeedPage({Key key, this.title}) : super(key: key);

  @override
  _DiscoverFeedPageState createState() => _DiscoverFeedPageState();
}

class _DiscoverFeedPageState extends State<DiscoverFeedPage> {
  @override 
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Discover")),
          centerTitle: true, 
        ),
        body: Column ( 
          children: [
            Expanded (
              // calls the feed_discover.dart class to populate the horizontal 
              // and vertical list views
              child: FeedDiscover()
            )
          ]
        )
      )
    );
  }
}

