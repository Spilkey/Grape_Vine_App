import 'package:final_project/models/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_project/models/topic_model.dart';
import 'package:final_project/models/post_model.dart';

import 'feed_discover_cards.dart';

class FeedDiscover extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<FeedDiscover> {
  var data;
  // instance of topic model
  final _model = new TopicModel();
  // placeholder categories

  // this creates 2 listviews. One horizontal, one vertical
  // in the first iteration of the ListView builder it calls the _horizontalListView() method to build the category slider
  // the rest of the iterations builds the discover feed cards
  // TODO populate the smaller cards with other info
  // TODO make horizontal scroll bar interactable
  // List<PostEntity> _posts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _horizontalListView();
  }

  Widget buildPosts(topicId) {
    Widget content = StreamBuilder<QuerySnapshot>(
      stream: new TopicModel().getPostsFromTopic(topicId),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, index) {
              var data = snapshot.data.docs[index];
              return _discoverContainer(PostEntity.fromDB(data));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    return content;
  }

  Widget _horizontalListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _model.getAllTopics(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Tab> tabs = [];
          List<Widget> tabPanes = [];

          for (QueryDocumentSnapshot doc in snapshot.data.docs) {
            tabs.add(Tab(child: Text(doc.get('topic_name'))));

            tabPanes.add(buildPosts(doc.id));
          }
          return DefaultTabController(
            length: snapshot.data.docs.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(30.0),
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.green,
                      indicatorColor: Colors.green,
                      tabs: tabs),
                ),
              ),
              body: TabBarView(
                children: tabPanes,
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // this widget calls from the class feed_discover_cards.dart
  // passes current instance of data
  Widget _discoverContainer(data) => DiscoverFeedCards(
        data: data,
      );
}
