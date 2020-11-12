// a class for some user settings

class UserData {
  // private user key
  static String _privateUserKey;
  // list of the user's favourite topics to show in discover
  static List<String> _favTopics = [];
  // option to select if the main feed would be mixed or seperate
  static bool _mixFeeds;
  // option to show most interacted topics as fav topics
  static bool _automaticTopics;
  // option to allow app to use the user's location
  static bool _allowLocation;

  Map<String, dynamic> toMap() {
    return {
    };
  }

  UserData.fromMap(Map<String, dynamic> map) {
    UserData._privateUserKey = map['private_user_key'];

    UserData._mixFeeds = settings[0] == '1' ? true : false;
    UserData._automaticTopics = settings[1] == '1' ? true : false;
    UserData._allowLocation = settings[2] == '1' ? true : false;

    String topics = map['fav_topics'];
    UserData._favTopics = topics.split(',');
  }

}
