import 'package:final_project/models/post_entity.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/user_model.dart';

import 'package:final_project/models/topic_model.dart';

import 'feed_discover_cards.dart';

import '../app_localizations.dart';

class FeedDiscover extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

/**
 * this widget creates 2 listviews - one horizontal, one vertical
 * in the first iteration of the listview builder, it calls the _horizontalListView() method to build the category slider
 * the horizontal list view is interactable. selecting one topic will filter the discover feed to topics specific to the selected one
 * ie: selecting sports will filter posts to have only posts under the sports category
 */
class _FeedState extends State<FeedDiscover> {
  var data;
  TabController _tabController;
  List<dynamic> _subscriptions = [];

  final _model = new TopicModel();
  final _userModel = new UserModel();

  @override
  void initState() {
    _userModel.getUser(UserData.userData['user_id']).then( (User currentUser){
      setState( () {
        _subscriptions = currentUser.subscriptions;
      });
    });

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
          print("DEBUG: ${AppLocalizations.of(context).locale}");
          for (QueryDocumentSnapshot doc in snapshot.data.docs) {
            tabs.add(Tab(
                child: Text(
              doc.get((AppLocalizations.of(context).locale).toString() +
                  '_topic_name'),
              style: TextStyle(color: Colors.white),
            )));
            tabPanes.add(buildPosts(doc.id));
          }
          return DefaultTabController(
            length: snapshot.data.docs.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(5.0),
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
              // if user is subscribed to this topic, then
                floatingActionButton: FloatingActionButton.extended(
                  label: Text(
                    AppLocalizations.of(context).translate('subscribe_label')),
                    onPressed: () {
                  // print(UserData.userData['subscriptions']);
                      print("DEBUG: ${UserData.userData['user_id']}");  // put in global



          //         // print(tabIndex);
          //         // print("DEBUG: $getTopicsLength('topics')");
                  
          //         print("DEBUG: Current index: ${DefaultTabController.of(context).index}");
                  // updateSubscriptions(UserData.userData, String subscription){
                },
              )
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<int> getTopicsLength(String documentID) async{
    var test = _model.getAllTopics().length;
    print(test);
  }
  /**
   * This widget passes data to the feed_discover_cards class. 
   * @param data This contains data within the posts such as title, owner, content, etc
   */
  Widget _discoverContainer(data) => DiscoverFeedCards(
        data: data,
      );
}
