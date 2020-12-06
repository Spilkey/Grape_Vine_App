import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
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
          Spacer(),
          RaisedButton(
              child: Text(
                'Get Started',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              onPressed: null)
        ],
      ),
    );
  }
}
