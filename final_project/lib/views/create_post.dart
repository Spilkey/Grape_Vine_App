import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final textController = TextEditingController();
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
            MaterialButton(
              onPressed: () {
                Navigator.pop(context, {'posted': true});
              },
              child: Text('Post', style: TextStyle(color: Colors.white)),
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
            )
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
