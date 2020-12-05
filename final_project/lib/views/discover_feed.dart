import 'package:final_project/components/feed_discover.dart';
import 'package:flutter/material.dart';

/**
 * Discover feed page to display posts when the usedr selects the discover tab
 * has a floating action button the user can tap to subscribe to a topic
 */
class DiscoverFeedPage extends StatefulWidget {
  final String title;

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
            body: Column(children: [
              Expanded(
                child: FeedDiscover())
          ]
        ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Subscribe"), 
          onPressed: () {
            print("subscribe to topic");
          },
        ) 
      )
    );
  }
}
