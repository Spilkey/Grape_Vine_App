import 'package:final_project/components/feed_discover.dart';
import 'package:flutter/material.dart';
import '../app_localizations.dart';
import './analytics_page.dart';
import '../models/user_data.dart';
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
            leading: Container(),
            title: Center(
              child: Text(AppLocalizations.of(context)
                .translate('discover_feed_title'))),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.analytics_rounded,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnalyticsPage()
                    )
                  );
                }
              )
            ],
          ),
          body: Column(children: [Expanded(child: FeedDiscover())]),
        )
      );
  }
}
