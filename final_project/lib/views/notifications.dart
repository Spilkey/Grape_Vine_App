// placeholder for friends view if we use it
import 'package:final_project/components/list_notifications.dart';
import 'package:flutter/material.dart';
import '../app_localizations.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context).translate('main_feed_title')),
        ),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.apps), onPressed: () {})],
        leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Scaffold.of(context).openDrawer())),
      ),
      body: ListNotification(),
    );
  }
}
