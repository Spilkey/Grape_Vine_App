import 'package:flutter/material.dart';
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
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
                  Navigator.pop(context, {'posted': true});
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
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Write Something',
            ),
            maxLines: null,
          )),
    );
  }
}
