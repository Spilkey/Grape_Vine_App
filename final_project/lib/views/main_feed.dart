import 'package:final_project/components/feed.dart';
import 'package:flutter/material.dart';

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
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
        drawer: Drawer(
          child: Container(
            child: Text("I am a drawer child"),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.menu),
          label: Text("Create"),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
      ),
    );
  }
}
