// a class for some user settings

class UserSettings {
  //  map of all settings
  static final Map<String, dynamic> settings = {
    // option to select if the main feed would be mixed or seperate
    'mix_feeds': false,
    // option to show most interacted topics as fav topics
    'automatic_topics': true,
    // option to allow app to use the user's location
    'allow_location': false,
    // name to display for user
    'username': '',
    // immutable keypair that is generated upon initalization of app
    'private_key': '',
    'public_key': '',
  };

  setOption(String key, dynamic val) {
    settings[key] = val;
  }

  // converts settings map to text objects
  Map<String, String> toMap() {
    Map<String, dynamic> map;

    settings.forEach((key, value) {
      if (value is String) {
        map[key] = value;
      } else {
        map[key] = value.toString();
      }
    });

    return map;
  }

  // translates <str,str> map from db into user settings
  UserSettings.fromMap(Map<String, dynamic> map) {
    map.forEach((key, value) {
      if (value == 'true' || value == 'false') {
        settings[key] = value == 'true' ? true : false;
      } else {
        settings[key] = value;
      }
    });
  }
}
