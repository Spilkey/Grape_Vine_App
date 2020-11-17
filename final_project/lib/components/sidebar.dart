import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:flutter/material.dart';

class SideBarFriends extends StatefulWidget {
  @override
  _SideBarFriendsState createState() => _SideBarFriendsState();
}

class _SideBarFriendsState extends State<SideBarFriends> {
  // TODO get all user's friends
  // Get UID from local storage
  // Query DB for User's Friends
  UserModel _uModel = new UserModel();
  UserSettings _usModel = new UserSettings();

  String _uid = '';

  User currentUser;

  List<User> friendsList = [];

  getUserFriends() {
    List<User> friends = [];
    currentUser.friends.forEach((idString) {
      friends.add(_uModel.getUser(idString));
    });
    this.setState(() {
      friendsList = friends;
    });
  }

  @override
  void initState() {
    super.initState();
    // currentUser = _uModel.getUser(_uid);
  }

  @override
  Widget build(BuildContext context) {
    // getUserFriends();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.purple[800],
              Colors.purple[700],
              Colors.purple[600],
              Colors.purple[400],
            ],
          )),
          child: Text(
            "My Friends",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
