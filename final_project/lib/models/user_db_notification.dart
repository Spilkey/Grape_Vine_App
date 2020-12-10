class UserNotifcation {
  final String content;
  final String contextUserId;
  final String contextUsername;

  UserNotifcation({this.content, this.contextUserId, this.contextUsername});

  static List<UserNotifcation> fromMapList(List<dynamic> notifications) {
    List<UserNotifcation> userNotif = [];
    if (notifications.length > 0) {
      notifications.forEach((element) {
        userNotif.add(UserNotifcation.fromMap(element));
      });
    }
    return userNotif;
  }

  static List<Map<String, dynamic>> toMapList(
      List<UserNotifcation> notifications) {
      if(notifications != null){
        return notifications.map((element) {
          return element.toMap();
        }).toList();
      }else {
        return [];
      }

  }

  factory UserNotifcation.fromMap(Map<String, dynamic> map) {
    return UserNotifcation(
        content: map['content'],
        contextUserId: map['user_id'],
        contextUsername: map['username']);
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'user_id': contextUserId,
      'username': contextUsername
    };
  }
}
