import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_data.dart';
import 'package:final_project/models/user_db_notification.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/views/profile_page.dart';
import 'package:flutter/material.dart';

class ListNotification extends StatefulWidget {
  @override
  _ListNotificationState createState() => _ListNotificationState();
}

class _ListNotificationState extends State<ListNotification> {
  bool notificationsLoaded = false;

  List<UserNotifcation> userNotifications = [];

  UserModel _uModel = new UserModel();

  @override
  Widget build(BuildContext context) {
    if (!notificationsLoaded) {
      _uModel.getUser(UserData.userData['user_id']).then((User currentUser) {
        userNotifications = currentUser.notifications;
        print(currentUser.notifications);
        setState(() {
          notificationsLoaded = true;
        });
      });
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (userNotifications.length > 0) {
        return ListView.separated(
            itemCount: userNotifications.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return NotificationWidget(
                  notification:
                      // since we want most recent notifications first, go backwards through list
                      userNotifications[userNotifications.length - 1 - index]);
            });
      } else {
        return Center(
          child: Text("You have no notifications"),
        );
      }
    }
  }
}

class NotificationWidget extends StatelessWidget {
  @override
  NotificationWidget({Key key, this.notification});
  final UserNotifcation notification;

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
                  child: Text(notification.content[0]),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    if (notification.contextUserId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage(
                              userID: notification.contextUserId,
                              isFriend: true,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Text(notification.content),
                ),
              ),
            )
          ],
        ));
  }
}
