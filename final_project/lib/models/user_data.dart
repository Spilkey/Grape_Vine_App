// a class for some user settings
import 'package:final_project/models/user.dart';

class UserData {
  UserData();
  //  map of all settings
  static Map<String, dynamic> _userData;

  static void init() {
    _userData = {
      // option to select if the main feed would be mixed or seperate
      'mix_feeds': false,
      // option to show most interacted topics as fav topics
      'automatic_topics': true,
      // option to allow app to use the user's location
      'allow_location': false,
      // name to display for user
      // temp until we get a login page
      'username': '',
      'user_id': ''
    };
    print('UserData initialized');
  }

  Map<String, dynamic> get userData {
    if (_userData == null) {
      print('Map has not been initalized');
      return {};
    }
    return _userData;
  }

  // converts settings map to text objects
  static Map<String, String> toStringMap() {
    if (_userData == null) {
      print('Map has not been initalized');
      return {};
    }
    return {
      'mix_feeds': _userData['mix_feeds'] ? 'true' : 'false',
      'automatic_topics': _userData['automatic_topics'] ? 'true' : 'false',
      'allow_location': _userData['allow_location'] ? 'true' : 'false',
      'username': _userData['username'],
      'user_id': _userData['user_id'],
    };
  }

  UserData.fromMap(Map<String, dynamic> map) {
    map.forEach((key, value) {
      if (_userData.keys.contains(key)) {
        if (value == 'true' || value == 'false') {
          _userData[key] = value == 'true' ? true : false;
        } else {
          _userData[key] = value;
        }
      }
    });
  }
}
