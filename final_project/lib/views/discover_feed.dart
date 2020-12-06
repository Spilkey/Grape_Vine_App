import 'package:final_project/components/feed_discover.dart';
import 'package:flutter/material.dart';
import '../app_localizations.dart';

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
              title: Center(child: Text(AppLocalizations.of(context).translate('discover_feed_title'))),
              centerTitle: true,
            ),
            body: Column(children: [
              Expanded(
                child: FeedDiscover())
          ]
        ),
      floatingActionButton: FloatingActionButton.extended(
          // label: Text("Subscribe"), 
          label: Text(AppLocalizations.of(context).translate('subscribe_label')),
          onPressed: () {
            // TODO after users model has been implemented, add the topic to user's list of subscribed topics
            print("subscribe to topic");
          },
        ) 
      )
    );
  }
}
