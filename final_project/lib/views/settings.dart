import 'package:final_project/models/local_storage_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/local_storage.dart';
import '../app_localizations.dart';
import './content_preferences.dart';
import 'package:final_project/models/user_data.dart';
import 'package:final_project/app_localizations.dart';

class Settings extends StatefulWidget {
  Settings({this.title});

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formkey = GlobalKey<FormState>();
  String _newUsername = UserData.userData['username'];
  var db = LocalStorageModel();

  @override
  void initState() {
    super.initState();
    db.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              // TODO: make a user display widget
              // showing user display name, profile picture, and  public key
              Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // temp widget for the user display
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.green, child: Text('U')
                                // This line is causing an error
                                // Text(
                                //     UserData.userData['username'].isNotEmpty
                                //         ? UserData.userData['username'][0]
                                //         : '?'),
                                ),
                            Spacer(),
                            Flexible(
                              flex: 5,
                              child: Text('Username'),
                              // this line is causing an error
                              // Text(UserData.userData['username']),
                            ),
                          ],
                        ),
                      ])),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: AppLocalizations.of(context)
                      .translate('change_display_name_prompt'),
                ),
                onChanged: (String val) {
                  setState(() {
                    if (val.isNotEmpty) {
                      _newUsername = val;
                    }
                    UserData.userData['username'] = _newUsername;
                  });
                },
              ),
              SwitchListTile(
                  title: Text(AppLocalizations.of(context)
                      .translate('mixed_feed_option')),
                  value: UserData.userData['mix_feeds'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData.userData['mix_feeds'] = val;
                    });
                  }),
              SwitchListTile(
                  title: Text(AppLocalizations.of(context)
                      .translate('update_fav_topics_option')),
                  value: UserData.userData['automatic_topics'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData.userData['automatic_topics'] = val;
                    });
                  }),
              SwitchListTile(
                  title: Text(AppLocalizations.of(context)
                      .translate('allow_location_option')),
                  value: UserData.userData['allow_location'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData.userData['allow_location'] = val;
                    });
                  }),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContentPreferences())),
                  child: Align(
                    child: Text('Content preferences'),
                    alignment: Alignment.centerLeft,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label:
            Text(AppLocalizations.of(context).translate('save_settings_label')),
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            await db.updateTable();
            Navigator.pop(context);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocalizations.of(context).translate('save_failed'))));
          }
        },
      ),
    );
  }
}
