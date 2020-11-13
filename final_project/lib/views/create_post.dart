import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:final_project/models/post-model.dart';
import 'package:final_project/models/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
          title: Text('Keep as draft?'),
          actions: [
            FlatButton(
                onPressed: () => _returnToMainFeed(),
                child: Text('Keep as draft')),
            FlatButton(
                onPressed: () => _returnToMainFeed(), child: Text('Delete')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final confirmPost = AlertDialog(
      title: Text('Confirm Post'),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Go Back')),
        FlatButton(
            onPressed: () {
              // TODO make variables dynamic:
              // imageData (supposed to be profile picture, retrieved from local storage)
              // isPrivate, ownerID, ownerName, topicID
              PostEntity postEntity = new PostEntity(
                  content: _postContent,
                  imageData: _image64,
                  isPrivate: false,
                  ownerId: "temp_new_post_id",
                  ownerName: "temp_new_post_owner_name",
                  postImageData: _image64,
                  postTitle: _titleContent,
                  topicId: "vepbope8IcIIdOZFZgOR");
              PostModel _model = new PostModel();
              _model.insertPost(postEntity).then((result) {
                // popping out of dialgue
                Navigator.of(context).pop();
                // popping back to main feed
                Navigator.pop(context, {'posted': true});
              });
            },
            child: Text('Confirm')),
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
                if (textController.text == '' || textController.text == null) {
                  Navigator.pop(context);
                } else {
                  await _showMyDialog();
                }
              },
              child: Text('Cancel'),
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
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    showDialog<void>(
                        context: context, builder: (context) => confirmPost);
                  }
                },
                child: Text('Post', style: TextStyle(color: Colors.white)),
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
              )
            ]),
          ],
        ),
      ),
      body: Container(
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
                  hintText: 'Write a title',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a title';
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
                  hintText: 'Write Something',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some stuff';
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
    );
  }
}
