import 'package:flutter/material.dart';

// TODO add some class variables that get passed into FeedCard so we know what to display
// Is a card that will appear in a feed
class FeedCard extends StatefulWidget {
  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: Row(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey[400], spreadRadius: 3, blurRadius: 10),
        ],
      ),
    );
  }
}
