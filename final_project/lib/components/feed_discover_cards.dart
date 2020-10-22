import 'package:flutter/material.dart';
import 'feed_card.dart';


// variation of the feed cards for the main feed. This alternates between the
// big sized cards and two small-sized cards

class DiscoverFeedCards extends StatefulWidget {
  @override
  _DiscoverFeedCardsState createState() => _DiscoverFeedCardsState();
}

class _DiscoverFeedCardsState extends State<DiscoverFeedCards> {
  @override
  Widget build(BuildContext context) {
    return Row(
    // return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
          Row(
            children: <Widget> [
              Container(
                padding: EdgeInsets.all(10),
                // height: 50,
                width: 350,
                child: FeedCard()
              )
            ]
          ),
          Row(
            children: <Widget> [
              Column(
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 175,
                      child: FeedCard()
                    )
                  ]
              ),
            Column(
              children: <Widget> [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 175,
                    child: FeedCard()
                  )
                ]
            )
          ]
        )
      ]
        )
      ],
    );
  }
}

/* TEMP

class _DiscoverFeedCardsState extends State<DiscoverFeedCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // children: <Widget>[
      //   Row(
      //     children: <Widget>[
      //       Container(
      //           padding: EdgeInsets.all(10),
      //           height: 50,
      //           child: FeedCard()
      //       )
      //     ]
      //   ),
        Column(
        children: <Widget>[
          Column(
            children: <Widget>[
            Row(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 350,
                  child: FeedCard()
                )
              ]
            ),
            Row(
              children: <Widget> [
                Column(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 175,
                        child: FeedCard()
                      )
                    ]
                ),
              Column(
                children: <Widget> [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 175,
                      child: FeedCard()
                    )
                  ]
              )
            ]
          )
        ]
          )
        ],
      ),
      ],
    );
  }
}
*/