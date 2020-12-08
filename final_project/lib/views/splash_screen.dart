import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  // TODO: show a circular progress bar then load main feed, or go through startup process
  Widget build(BuildContext context) {
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
            'GRAPE',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(height: 160),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              padding: EdgeInsets.all(30),
              child: Text(
                'Let\'s Begin',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.white),
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/createUser');
              })
        ],
      ),
    );
  }
}
