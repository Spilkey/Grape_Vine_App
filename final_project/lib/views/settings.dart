import 'package:final_project/models/local_storage_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/user_data.dart';

class Settings extends StatefulWidget {
  Settings({this.title});

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formkey = GlobalKey<FormState>();
  String _newUsername = UserData().userData['username'];
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
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
                              backgroundColor: Colors.green,
                              child: Text(
                                  UserData().userData['username'].isNotEmpty
                                      ? UserData().userData['username'][0]
                                      : '?'),
                            ),
                            Spacer(),
                            Flexible(
                              flex: 5,
                              child: Text(UserData().userData['username']),
                            ),
                          ],
                        ),
                        Text('@' + UserData().userData['public_key'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          '@' + UserData().userData['private_key'],
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ])),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Change display name',
                ),
                onChanged: (String val) {
                  setState(() {
                    if (val.isNotEmpty) {
                      _newUsername = val;
                    }
                    UserData().userData['username'] = _newUsername;
                  });
                },
              ),
              SwitchListTile(
                  title: const Text('Use mixed feeds'),
                  value: UserData().userData['mix_feeds'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData().userData['mix_feeds'] = val;
                    });
                  }),
              SwitchListTile(
                  title: const Text('Update favourite topics automatically'),
                  value: UserData().userData['automatic_topics'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData().userData['automatic_topics'] = val;
                    });
                  }),
              SwitchListTile(
                  title: const Text('Allow location'),
                  value: UserData().userData['allow_location'],
                  onChanged: (bool val) {
                    setState(() {
                      UserData().userData['allow_location'] = val;
                    });
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Save user settings"),
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            await db.updateTable();
            Navigator.pop(context);
          } else {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: const Text('Unable to save user settings')));
          }
        },
      ),
    );
  }
}
