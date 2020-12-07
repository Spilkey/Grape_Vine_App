import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TrendingTopic {
  TrendingTopic({@required this.numberOfPosts, @required this.topic});
  int numberOfPosts;
  String topic;
}

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  //TODO: replace with db query
  // Show the top 5 topic
  List<TrendingTopic> topTopics = [
    TrendingTopic(numberOfPosts: 100, topic: 'Food'),
    TrendingTopic(numberOfPosts: 30, topic: 'Photography'),
    TrendingTopic(numberOfPosts: 40, topic: 'Sports'),
    TrendingTopic(numberOfPosts: 20, topic: 'Music'),
    TrendingTopic(numberOfPosts: 10, topic: 'Movies'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trending'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Trending topic of the week - TODO: abstract as a widget
          Container(
            margin: EdgeInsets.only(top: 30),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    // TODO: replace with the trending topic of the week - from db
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Food',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.trending_up,
                            color: Colors.red,
                            size: 40.0,
                          )
                        ],
                      ),
                      Text('is the current top trending!')
                    ],
                  ),
                )),
          ),
          // DATATABLE
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 500,
              child: charts.BarChart([
                charts.Series<TrendingTopic, String>(
                  colorFn: (_, __) =>
                      charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
                  id: 'Trending topics',
                  domainFn: (TrendingTopic topic, _) => '${topic.topic}',
                  measureFn: (TrendingTopic topic, _) => topic.numberOfPosts,
                  data: topTopics,
                )
              ], vertical: true),
            ),
          )
        ],
      ),
    );
  }
}
