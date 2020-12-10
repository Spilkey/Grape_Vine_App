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
          title: Text("Notifcations"), centerTitle: true, leading: Container()),
      body: ListNotification(),
    );
  }
}
