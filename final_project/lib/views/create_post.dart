import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/colors.dart';
import 'package:final_project/models/post_model.dart';
import 'package:final_project/models/post_entity.dart';
import 'package:final_project/models/topic_model.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_data.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter/material.dart';
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

  String dropdownTopicsValueDisplay;
  String dropdownTopicsValueId;
  bool topicsLoaded = false;
  Map<String, String> topics = {};
  List<String> topicNames = [];

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
            onPressed: () async {
              // imageData (supposed to be profile picture, retrieved from local storage)
              // isPrivate, ownerID, ownerName, topicID
              String currentUserId = UserData.userData['user_id'];
              User currentUser = await UserModel().getUser(currentUserId);

              PostEntity postEntity = new PostEntity(
                  content: _postContent,
                  imageData: currentUser.profilePic,
                  isPrivate: false,
                  ownerId: currentUserId,
                  ownerName: currentUser.userName,
                  postImageData: _image64,
                  postTitle: _titleContent,
                  topicId: dropdownTopicsValueId,
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

    if (!topicsLoaded) {
      TopicModel().getAllTopicsFuture().then((QuerySnapshot topicsData) {
        print(topicsData.docs);
        topicsData.docs.forEach((e) {
          print(e.get("topic_name"));
          topics[e.get("topic_name")] = e.id;
          topicNames.add(e.get("topic_name"));
        });
        print(topicNames);
        setState(() {
          topicsLoaded = true;
        });
      }).catchError((error) {
        print(error);
        print("Unable to load topics");
      });
      return Center(child: CircularProgressIndicator());
    } else {
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
                      color: LightColor,
                    ),
                  ),
                  IconButton(
                    onPressed: _addLocation,
                    icon: Icon(
                      Icons.add_location_alt,
                      color: LightColor,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        showDialog<void>(
                            context: context,
                            builder: (context) => confirmPost);
                      }
                    },
                    child: Text(
                        AppLocalizations.of(context).translate('post_label'),
                        style: TextStyle(color: Colors.white)),
                    color: LightColor,
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
                    Row(
                      children: [
                        Text("Topic: "),
                        DropdownButton<String>(
                          value: dropdownTopicsValueDisplay,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownTopicsValueDisplay = newValue;
                              dropdownTopicsValueId = topics[newValue];
                            });
                          },
                          items: topicNames
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Image.memory(
                      _imgBytes,
                      height: 300,
                    ),
                  ])),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: (Alignment.centerLeft),
              child: locationWidget,
            ),
          ]));
    }
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
