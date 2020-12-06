import 'package:final_project/components/sidebar_userdata.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/models/user_data.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class SideBarFriends extends StatefulWidget {
  @override
  _SideBarFriendsState createState() => _SideBarFriendsState();
}

class _SideBarFriendsState extends State<SideBarFriends> {
  // TODO get all user's friends
  // Get UID from local storage
  // Query DB for User's Friends
  UserModel _uModel = new UserModel();

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
            AppLocalizations.of(context).translate('friends_bar_title'),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        createFriendsListWidget()
      ],
    );
  }

  createFriendsListWidget() {
    return Expanded(
        child: ListView.separated(
            itemCount: 12,
            padding: const EdgeInsets.all(20.0),
            // when we get actual data use an item builder
            itemBuilder: (BuildContext context, int index) {
              // Here we would pass in some parameters to our indiviual cards
              // Example ----------------------
              return SideBarUserRow("", "Bobby");
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            }));
  }
}
