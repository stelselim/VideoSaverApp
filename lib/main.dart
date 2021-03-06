import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videosaver/screens/home.dart';
import 'package:videosaver/screens/videoDetailScreen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/videoDetail": (context) => VideoDetailScreen(
              video: null,
            ),
      },
    );
  }
}
