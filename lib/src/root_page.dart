import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_sample/src/api/auth.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  Widget build(BuildContext context) {
    //TODO SAMPE SINI CUY
  }
}
