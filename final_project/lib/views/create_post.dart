import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            )),
            // TODO: add state where the post button is unpressable if there's no content
            MaterialButton(
              onPressed: () {
                print('Post has been shared succsessfully');
              },
              child: Text('Post', style: TextStyle(color: Colors.white)),
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
            )
            // ElevatedButton(
            //     onPressed: () {
            //       print('Post has been shared succsessfully');
            //     },
            //     child: Text('Post'),
            //     style: ElevatedButton.styleFrom(shape: CircleBorder()))
          ],
        ),
      ),
      body: TextField(
        decoration: InputDecoration(),
        maxLines: null,
      ),
    );
  }
}
