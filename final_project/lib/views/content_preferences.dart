import 'package:flutter/material.dart';
// import '../models/topic_model.dart'; - get all the topics and display on DataTable

class ContentPreferences extends StatefulWidget {
  @override
  _ContentPreferencesState createState() => _ContentPreferencesState();
}

class _ContentPreferencesState extends State<ContentPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User preferences'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context))),
      body: Text('Hello World'),
    );
  }
}
