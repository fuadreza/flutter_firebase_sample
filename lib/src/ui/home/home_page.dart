import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/src/api/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.auth, this.onSignOut});

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Text("HOME SWEET HOME"),
          )
        ],
      ),
    );
  }
}
