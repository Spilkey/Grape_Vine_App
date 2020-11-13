// a class for some user settings

class UserSettings {
  //  map of all settings
  static Map<String, dynamic> _settings;

  static Map<String, dynamic> get settings {
    if (_settings == null) {
      _settings = {
        // option to select if the main feed would be mixed or seperate
        'mix_feeds': false,
        // option to show most interacted topics as fav topics
        'automatic_topics': true,
        // option to allow app to use the user's location
        'allow_location': false,
        // name to display for user
        // temp until we get a login page
        'username': '',
        // immutable keypair that is generated upon initalization of app
        // keys are Ed25519 long-term key pair
        // but we'll make it a simple string for now
        'private_key': '1234567890',
        'public_key': '2233445566',
      };
    }
    return _settings;
  }

  static String getValAsString(String key) {
    if (_settings.keys.contains(key)) {
      return _settings[key].toString();
    }
  }

  static setOption(String key, dynamic val) {
    if (_settings.keys.contains(key)) {
      _settings[key] = val;
    } else {
      print('key is not valid');
    }
  }

  // converts settings map to text objects
  static Map<String, String> toMap() {
    Map<String, dynamic> map;

    _settings.forEach((key, value) {
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
      if (_settings.keys.contains(key)) {
        if (value == 'true' || value == 'false') {
          _settings[key] = value == 'true' ? true : false;
        } else {
          _settings[key] = value;
        }
      }
    });
  }
}
