import 'package:flutter/material.dart';
import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/user_settings.dart';

class Settings extends StatefulWidget {
  Settings({this.title});

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formkey = GlobalKey<FormState>();
  String newUsername = '';
  bool mixFeeds, allowLocation, automaticTopics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // TODO: make a user display widget
              // showing user display name, profile picture, and  public key
              Container(
                  padding: EdgeInsets.all(8),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // temp widget for the user display
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(
                              UserSettings.getValAsString('username').isNotEmpty
                                  ? UserSettings().settings['username']
                                  : '?'),
                        ),
                        Spacer(),
                        Text(UserSettings.getValAsString('username')),
                      ],
                    ),
                    Text('@' + UserSettings.getValAsString('public_key'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10)),
                    Text(
                      '@' + UserSettings.getValAsString('private_key'),
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                  ])),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Change display name',
                ),
                onSaved: (String val) {
                  setState(() {
                    newUsername = val;
                  });
                },
                validator: (String val) {
                  return val.isEmpty || val.trim().isEmpty
                      ? 'Please enter a valid name'
                      : null;
                },
              ),
              // SwitchListTile(value: null, onChanged: null)
            ],
          ),
        ),
      ),
    );
  }
}
