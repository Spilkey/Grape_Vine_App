import 'package:final_project/components/feed.dart';
import 'package:final_project/components/sidebar.dart';
import 'package:final_project/models/notifications.dart';
import 'package:final_project/models/local_storage_model.dart';
import 'package:flutter/material.dart';
import './create_post.dart';
import 'package:flutter/material.dart';
import 'package:final_project/components/feed.dart';
import 'package:final_project/views/settings.dart';
import '../app_localizations.dart';

/// Is the main feed/ Home of the app
///
///

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  // Overrides parent State class's build function with our own
  final snackBar = SnackBar(
    content: Text('Your post has been shared successfully'),
  );

  final _notifications = Notifications();
  var _local_db = LocalStorageModel();
  @override
  Widget build(BuildContext context) {
    _notifications.init();
    _local_db.getUserData();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                  AppLocalizations.of(context).translate('main_feed_title'))),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.apps),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Settings(
                              title: AppLocalizations.of(context)
                                  .translate('settings_label'))));
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)
                          .translate('settings_confirm'))));
                }),
          ],
          leading: Builder(
            // sending correct context to Icon button so I can open drawer with it
            builder: (context) => IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                    icon: Icon(Icons.public),
                    text:
                        AppLocalizations.of(context).translate('public_label')),
                Tab(
                    icon: Icon(Icons.public),
                    text: AppLocalizations.of(context)
                        .translate('private_label')),
              ],
              labelColor: Colors.purple,
              indicatorColor: Colors.purple,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              // height: 200,
              child: Feed(),
            ),
          ],
        ),
        // TODO populate our drawer here with content specific to profile
        // aka settings, profile, prefference etc...
        drawer: Drawer(child: SideBarFriends()),
        // Our floating action button for creating a post
        // We will need this button
        // to navigate to our create post form IE Navigation.push(... our post form here)
        // the form will either go into views or components
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.menu),
          // label: Text("Create"),
          label: Text(AppLocalizations.of(context).translate('create_label')),
          onPressed: () async {
            // Navigate here to create post form handle any returned info here
            // with the promise returned from Navigate
            // Once the form is completed we can return to this function and
            // have a setState() call to refresh UI along with any other user prompts to
            // notify them that they sucessfully create a post
            var result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePost()));
            if (result != null) {
              // TODO: add condition/snackbar for network error and post was unsuccessful
              if (result['posted'] == true) {
                Scaffold.of(context).showSnackBar(snackBar);
                _notifications.sendNotificationNow(
                    "New Post", "You have created a new post", "");
              }
            }
          },
        ),
      ),
    );
  }
}
