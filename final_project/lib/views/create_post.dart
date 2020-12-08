import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:final_project/models/post_model.dart';
import 'package:final_project/models/post_entity.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../app_localizations.dart';

import 'dart:io';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // TODO: Save image to database - is that efficient?
  File _image;
  final picker = ImagePicker();
  final textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _image64 = "";
  String _postContent = "";
  String _titleContent = "";
  // for UInt8 type
  Uint8List _imgBytes = Uint8List(10);

  String _streetName = "";
  Widget locationWidget;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    var temp = File(pickedFile.path);
    var temp_1 = temp.readAsBytesSync();
    String temp_2 = base64.encode(temp_1);

    setState(() {
      if (pickedFile != null) {
        _image64 = temp_2;
        _imgBytes = temp_1;
      } else {
        print('No image selected');
      }
    });
  }

  _returnToMainFeed() {
    // TODO: replace with named with named routes
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Keep as draft?'),
          title:
              Text(AppLocalizations.of(context).translate('keep_draft_alert')),
          actions: [
            FlatButton(
              onPressed: () => _returnToMainFeed(),
              child: Text(
                  AppLocalizations.of(context).translate('keep_draft_option')),
            ),
            FlatButton(
              onPressed: () => _returnToMainFeed(),
              child:
                  Text(AppLocalizations.of(context).translate('delete_option')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_streetName != "") {
      locationWidget = Text("Location:  $_streetName");
    } else {
      locationWidget = Text("");
    }
    final confirmPost = AlertDialog(
      title: Text(AppLocalizations.of(context).translate('confirm_post_label')),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:
                Text(AppLocalizations.of(context).translate('go_back_label'))),
        FlatButton(
            onPressed: () {
              // TODO make variables dynamic:
              // imageData (supposed to be profile picture, retrieved from local storage)
              // isPrivate, ownerID, ownerName, topicID

              //TODO uncomment when user settings are functional
              // String currentUserId = UserSettings().settings['user_id'];
              // String currentUsername = UserSettings().settings['username'];

              PostEntity postEntity = new PostEntity(
                  content: _postContent,
                  imageData: _image64,
                  isPrivate: false,
                  ownerId: "temp_new_post_id",
                  ownerName: "temp_new_post_owner_name",
                  postImageData: _image64,
                  postTitle: _titleContent,
                  topicId: "vepbope8IcIIdOZFZgOR",
                  streetName: _streetName);
              PostModel _model = new PostModel();
              _model.insertPost(postEntity).then((result) {
                // popping out of dialgue
                Navigator.of(context).pop();
                // popping back to main feed
                Navigator.pop(context, {'posted': true});
              });
            },
            child:
                Text(AppLocalizations.of(context).translate('confirm_label'))),
      ],
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: TextButton(
                onPressed: () async {
                  if (textController.text == '' ||
                      textController.text == null) {
                    Navigator.pop(context);
                  } else {
                    await _showMyDialog();
                  }
                },
                child: Text(
                    AppLocalizations.of(context).translate('cancel_label')),
              )),
              // TODO: add state where the post button is unpressable if there's no content
              Row(children: [
                IconButton(
                  onPressed: () async {
                    await getImage();
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.purple,
                  ),
                ),
                IconButton(
                  onPressed: _addLocation,
                  icon: Icon(
                    Icons.add_location_alt,
                    color: Colors.purple,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      showDialog<void>(
                          context: context, builder: (context) => confirmPost);
                    }
                  },
                  child: Text(
                      AppLocalizations.of(context).translate('post_label'),
                      style: TextStyle(color: Colors.white)),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                )
              ]),
            ],
          ),
        ),
        body: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context)
                          .translate('title_prompt'),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('title_validator');
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      _titleContent = value;
                    },
                    maxLines: null,
                  ),
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context)
                          .translate('content_prompt'),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('content_validator');
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      _postContent = value;
                    },
                    maxLines: null,
                  ),
                  Image.memory(_imgBytes)
                ])),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            alignment: (Alignment.centerLeft),
            child: locationWidget,
          ),
        ]));
  }

  Future<void> _addLocation() async {
    var location = await Navigator.pushNamed(context, '/mapPage');

    var temp = location.toString();

    _streetName = "";

    for (int i = 1; i < temp.length - 1; i++) {
      _streetName += temp[i];
    }
    setState(() {});
  }
}
