import 'package:flutter/material.dart';

// TODO: add user posts

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key key,
  }) : super(key: key);

  // TODO: uncomment once profile page is linked to actual accounts
  // final String userName;
  // final String bio;
  // final String pathToProfilePic;
  // final bool personAdded;
  // final List<?> userPosts;
  // final bool isUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double avatarRadius = 50, marginTop = 50;
  final double profileContainerSize = 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            child: SizedBox(
                height:
                    MediaQuery.of(context).size.height * profileContainerSize,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onPressed: () {}),
                            // TODO: change the appearance once added
                            IconButton(
                                icon: Icon(
                                  Icons.person_add_alt,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onPressed: () {})
                          ],
                        )),
                    Center(
                        child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: avatarRadius,
                      child: Text('P'),
                    )),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            'UserName123',
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )),
                    // TODO: add overflow condition?
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Expanded(
                          child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra et quam eget tempus.')),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('127 ',
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'Friends',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            color: Colors.white),
        // TODO: Change this temporary solution for something better
        Container(
          color: const Color(0x80DFDDE0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width, child: Text('')),
        )
      ],
    ));
  }
}
