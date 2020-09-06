import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_sample/src/api/auth.dart';
import 'package:flutter_firebase_sample/src/ui/home/home_page.dart';
import 'package:flutter_firebase_sample/src/ui/login/login_page.dart';

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
  void initState() {
    // widget.auth.initializeApp();
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status){
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          title: 'Flutter Login',
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        return HomePage(
          title: 'Flutter Home',
          auth: widget.auth,
          onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
        );
    }
  }
}
