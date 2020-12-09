import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/topic_model.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final _topicModel = TopicModel();

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
      body: FutureBuilder(
        future: _topicModel.getTrendingTopics(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var topTopic = snapshot.data[0].topic;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  topTopic,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
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
                  child: SizedBox(
                    height: 500,
                    child: charts.BarChart([
                      charts.Series<TopicData, String>(
                        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                            Colors.deepPurpleAccent),
                        id: 'Trending topics',
                        domainFn: (TopicData topic, _) => '${topic.topic}',
                        measureFn: (TopicData topic, _) => topic.numberOfPosts,
                        data: snapshot.data,
                      )
                    ], vertical: true),
                  ),
                )
              ],
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent)),
              ),
            );
          }
        },
      ),
    );
  }
}
