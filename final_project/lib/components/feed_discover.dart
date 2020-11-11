import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/topic-model.dart';
import '../models/post-model.dart';

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
  var categories = ['Sports', 'asdf', 'Travel', 'Music', 'Food', 'Technology', 'Celebrities', 'Art', 'Movies', 'Music', 'Politics'];

  // this creates 2 listviews. One horizontal, one vertical
  // in the first iteration of the ListView builder it calls the _horizontalListView() method to build the category slider
  // the rest of the iterations builds the discover feed cards
  // TODO populate the smaller cards with other info
  // TODO make horizontal scroll bar interactable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // temporary placeholder for topic. Currently grabs posts under this topic id
        stream: _model.getPostsFromTopic('Xiah3Ml0x5nqCOTRCs1e'),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data.docs.length + 1,
              itemBuilder: (BuildContext context, index){
            if (index == 0){
              return _horizontalListView();
          }else{ 
              var data = snapshot.data.docs[index-1];
              return _discoverContainer(data);
            }
          });
          } else {
             return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

// this widget contains elements in the "categories" list
  Widget _horizontalListView(){
    return Container(
      height: 75,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, i) => 
          Container(
            width: 100,
            margin: new EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child:Text(categories[i], textAlign: TextAlign.center),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey[400], spreadRadius: 3, blurRadius: 10)
                ]
          )
        )
      )
    );
  }
  
  // this widget calls from the class feed_discover_cards.dart
  // passes current instance of data
  Widget _discoverContainer(data) => DiscoverFeedCards(data: data,);
}
