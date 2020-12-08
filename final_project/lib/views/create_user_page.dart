import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/utils/image_utils.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_model.dart';

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
              // borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.add))
        : Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 10),
              borderRadius: BorderRadius.circular(200),
            ),
            // padding: EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: ImageUtil.imageFromBase64String(_profilePic)));
    steps = [
      Step(
        title: const Text('Create a username'),
        isActive: _currentStep == 0 ? true : false,
        state: StepState.indexed,
        content: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter a username'),
                onChanged: (String val) {
                  setState(() {
                    _username = val;
                  });
                },
              ),
              Text(
                  'Make a username - You don\t have to make one, but if you do it can be changed later'),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Upload a profile picture'),
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
              Text('Add a picture - you can click on your image to change it'),
            ],
          ),
        ),
      ),
    ];

    print('# of steps: ${steps.length}');
    return Scaffold(
        appBar: AppBar(
          title: Text('Getting Started'),
        ),
        body: _stepsCompleted
            ? Container(
                child: Center(
                  child: AlertDialog(
                    title: Text('Profile has been created'),
                    content: Text('Enjoy!'),
                    actions: [
                      new FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('close'))
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
                        'Move on',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onPressed: _nextStep,
                    ),
                    TextButton(
                      child: const Text('go back'),
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
    //userModel.insertUser(_newUser);
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
