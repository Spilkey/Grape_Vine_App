import 'package:final_project/components/feed.dart';
import 'package:flutter/material.dart';

/// Is the main feed/ Home of the app
///
///

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  // Overrides parent State class's build function with our own
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Main Feed")),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.apps), onPressed: () {}),
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
                Tab(icon: Icon(Icons.public), text: "Public"),
                Tab(icon: Icon(Icons.lock), text: "Private"),
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
        drawer: Drawer(
          child: Container(
            child: Text("I am a drawer child"),
          ),
        ),
        // Our floating action button for creating a post
        // We will need this button
        // to navigate to our create post form IE Navigation.push(... our post form here)
        // the form will either go into views or components
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.menu),
          label: Text("Create"),
          onPressed: () {
            // Add your onPressed code here!
            // Navigate here to create post form handle any returned info here
            // with the promise returned from Navigate
            // Once the form is completed we can return to this function and
            // have a setState() call to refresh UI along with any other user prompts to
            // notify them that they sucessfully create a post
          },
        ),
      ),
    );
  }

}
