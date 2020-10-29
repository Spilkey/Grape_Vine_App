import 'package:flutter/material.dart';

class ListNotification extends StatefulWidget {
  @override
  _ListNotificationState createState() => _ListNotificationState();
}

// TODO: to abstract ListNotification and NotificationWidget to a Card and CardsList, this could potentially have a commonality with other components
// Temporarily only using .separated class, still discerning what would be the more appropriate type

List<String> sampleData = [
  'Notification 1',
  'This is just a sample notification'
];

class _ListNotificationState extends State<ListNotification> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return NotificationWidget(notification: sampleData[index]);
        });
  }
}

class NotificationWidget extends StatelessWidget {
  @override
  NotificationWidget({Key key, this.notification});
  final String notification;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 25, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text('P'),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Expanded(child: Text(notification)),
              ),
            )
          ],
        ));
  }
}
