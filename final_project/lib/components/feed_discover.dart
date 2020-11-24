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
  var topics = [
    'All',
    'Gaming',
    'Sports',
    'Travel',
    'Music',
    'Food',
    'Technology',
    'Celebrities',
    'Art',
    'Movies',
    'Politics'
  ];

  var _selectedTopic = "1ihGwRddvqLDCaIbiFBg";
  // this creates 2 listviews. One horizontal, one vertical
  // in the first iteration of the ListView builder it calls the _horizontalListView() method to build the category slider
  // the rest of the iterations builds the discover feed cards
  // TODO populate the smaller cards with other info
  // TODO make horizontal scroll bar interactable
  // List<PostEntity> _posts = [];

  Future<List<PostEntity>> _posts;
  
  @override
  void initState() {
    super.initState();
    // setState(() {
    _posts = _model.getPostsFromTopic(_selectedTopic);
    // });
  }
 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: FutureBuilder<List<PostEntity>>(
        // future: _model.getPostsFromTopic(_selectedTopic),
        future: _posts,
        builder: (context, AsyncSnapshot <List<PostEntity>> snapshot){
          // builder: (BuildContext context, snapshot){
          print("DEBUG snapshot: ${snapshot.toString()}");
          if (snapshot.hasData){
            print("DEBUG snapshot: $snapshot");
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (BuildContext context, index) {
                if (index == 0) {
                  return _horizontalListView();
                } else {
                // var data = snapshot.data.docs[index - 1];
                var data = snapshot.data[index - 1];
                return _discoverContainer(data);
              }
            }
          );
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    )
  );
}

Widget _horizontalListView(){
  return StreamBuilder<QuerySnapshot>(
    stream: _model.getAllTopics(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
      if (snapshot.hasData){
          return Row(
            children:[
              Container(
              child: Expanded(
                child: SizedBox(
                  height: 50.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, index){
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTopic = snapshot.data.docs[index].id;
                        // _posts = [];
                        _posts = _model.getPostsFromTopic(_selectedTopic);
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: new EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: Text(snapshot.data.docs[index].get('topic_name')),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: _selectedTopic == snapshot.data.docs[index].id ? Colors.purple : Colors.green
                        )
                          ),
                        )
                      );
                    }    
                  )
                )
              )
            )
          ]
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
