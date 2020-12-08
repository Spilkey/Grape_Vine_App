import 'package:final_project/components/sidebar_userdata.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:flutter/material.dart';
import '../app_localizations.dart';

/**
 * Side bar widget for showing User's friends
 */

class SideBarFriends extends StatefulWidget {
  @override
  _SideBarFriendsState createState() => _SideBarFriendsState();
}

class _SideBarFriendsState extends State<SideBarFriends> {
  UserModel _uModel = new UserModel();

  User currentUser;

  List<User> friendsList = [];

  @override
  Widget build(BuildContext context) {
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

  /**
   * Grabs the current User's Id, then grab its friends and grabs detail about each friend
   */
  Future<List<User>> getFriends() async {
    // Get current user's friends

    // String currentUuid = UserSettings().settings['user_id'];
    String currentUuid = "x3NbwdluXTcUQIqpSCho";
    User currentUser = await _uModel.getUser(currentUuid);
    List friends = currentUser.friends;
    List<Future<User>> futureFriendsObjects = [];
    friends.forEach((e) {
      futureFriendsObjects.add(_uModel.getUser(e));
    });
    List<User> friendsObjects =
        await Future.wait(futureFriendsObjects).catchError((error) {
      print(error);
    });
    print(friendsObjects);
    return friendsObjects;
  }

  createFriendsListWidget() {
    return FutureBuilder(
        future: getFriends(),
        builder: (context, AsyncSnapshot<List<User>> friends) {
          if (friends.hasData) {
            return Expanded(
                child: ListView.separated(
                    itemCount: friends.data.length,
                    padding: const EdgeInsets.all(20.0),
                    // when we get actual data use an item builder
                    itemBuilder: (BuildContext context, int index) {
                      // Here we would pass in some parameters to our indiviual cards
                      // Example ----------------------
                      User currentFriend = friends.data[index];
                      return SideBarUserRow(currentFriend.profilePic,
                          currentFriend.username, currentFriend.id);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    }));
          } else {
            return Text('No Friends');
          }
        });
  }
}
