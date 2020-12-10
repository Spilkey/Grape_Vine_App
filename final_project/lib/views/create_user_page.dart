import 'package:final_project/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/utils/image_utils.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/models/local_storage.dart';
import 'package:final_project/models/local_storage_model.dart';

import '../app_localizations.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CreateUserPageState createState() => CreateUserPageState();
}

class CreateUserPageState extends State<CreateUserPage> {
  final userModel = new UserModel();

  String _username = '';
  String _profilePic;
  User _newUser = new User();

  List<Step> steps;
  bool _stepsCompleted = false;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    Widget imgDisplay = _profilePic == null
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 10),
            ),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.add))
        : Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 10),
              borderRadius: BorderRadius.circular(200),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: ImageUtil.imageFromBase64String(_profilePic)));
    steps = [
      Step(
        title: Text(AppLocalizations.of(context).translate('create_user_title')),
        isActive: _currentStep == 0 ? true : false,
        state: StepState.indexed,
        content: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('enter_username_label')),
                onChanged: (String val) {
                  setState(() {
                    _username = val;
                  });
                },
              ),
              Text(
                  AppLocalizations.of(context).translate('enter_username_description'),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text(AppLocalizations.of(context).translate('upload_picture_label')),
        isActive: _currentStep == 1 ? true : false,
        state: StepState.indexed,
        content: Container(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () async {
                    var pickedImage = await ImageUtil.picker
                        .getImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      var imgBytes = await pickedImage.readAsBytes();
                      print('img bytes is $imgBytes');
                      setState(() {
                        _profilePic = ImageUtil.toBase64String(imgBytes);
                      });
                    }
                  },
                  child: imgDisplay),
              Text(AppLocalizations.of(context).translate('upload_picture_description')),
            ],
          ),
        ),
      ),
    ];

    print('# of steps: ${steps.length}');
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('getting_started_title')),
        ),
        body: _stepsCompleted
            ? Container(
                child: Center(
                  child: AlertDialog(
                    title: Text(AppLocalizations.of(context).translate('profile_created_label')),
                    content: Text(AppLocalizations.of(context).translate('enjoy_label')),
                    actions: [
                      new FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppLocalizations.of(context).translate('close_label'))),
                    ],
                  ),
                ),
              )
            : Stepper(
                steps: steps,
                currentStep: _currentStep,
                onStepTapped: (step) => _goTo(step),
                type: StepperType.vertical,
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      color: Colors.purple,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.of(context).translate('move_on_label'),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onPressed: _nextStep,
                    ),
                    TextButton(
                      child: Text(AppLocalizations.of(context).translate('go_back_label')),
                      onPressed: _goBack,
                    ),
                  ]);
                },
              ));
  }

  _addUserToDatabase() async {
    var logo = await ImageUtil.logoAsBase64String();

    setState(() {
      _newUser.userName = _username;
      // set the profile image to the chosen file or a default if none was provided
      _newUser.profilePic = _profilePic != null ? _profilePic : logo;
      _stepsCompleted = true;
    });
    print('new user created: ${_newUser.toMap()}');
    // insert user into the cloud db
    var docRef = await userModel.insertUser(_newUser);
    if (docRef != null) {
      _newUser.id = docRef.id;
      // add user to the local db
      print(_newUser.id);
      UserData.initUserData(_newUser);
      await LocalStorageModel.updateUserData('user_id').catchError(
        (error) {
          print(error);
        },
      );

      print('user has been added to the firestore');
    }
  }

  _nextStep() {
    _currentStep + 1 != steps.length
        ? _goTo(_currentStep + 1)
        : _addUserToDatabase();
  }

  _goBack() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  _goTo(int step) {
    print('step is $_currentStep. moving to $step');
    setState(() => _currentStep = step);
  }
}
