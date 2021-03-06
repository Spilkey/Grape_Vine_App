import 'package:final_project/models/local_storage_model.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/user_data.dart';

import '../app_localizations.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  UserModel _userModel = UserModel();
  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    hasUserData();
    LocalStorageModel.getUserData();
    var userWidget;
    if (_showProgress) {
    } else {
      userWidget = generateLoginContent();
    }
    return Container(
      padding: EdgeInsets.all(80),
      color: Colors.purple,
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/images/grape_vine.png'),
            color: Colors.white,
          ),
          Text(
            AppLocalizations.of(context).translate('splash_screen_title'),
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(height: 160),
          Center(child: userWidget)
        ],
      ),
    );
  }

  Widget generateLoginContent() {
    var userWidget = _showProgress
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        : RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            padding: EdgeInsets.all(30),
            child: Text(
              AppLocalizations.of(context).translate('splash_begin_text'),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Colors.white),
            ),
            onPressed: () async {
              hasUserData();
              await Navigator.pushNamed(context, '/createUser');
              hasUserData();
            });
    return userWidget;
  }

  Future<void> hasUserData() async {
    String id = UserData.userData['user_id'];
    if (id.isNotEmpty) {
      // we have the data so update everything accordingly
      UserData.setUser = await _userModel.getUser(UserData.userData['user_id']);
      Navigator.pushNamed(context, '/homePage');
    }
  }
}
